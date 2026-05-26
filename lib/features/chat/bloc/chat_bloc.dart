import 'dart:async';
import 'dart:developer';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/token_storage.dart';
import '../../../domain/usecases/leave_room_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

const _defaultBaseUrl = 'https://c44e-1-54-23-149.ngrok-free.app';

@injectable
class ChatBloc extends AppBloc<ChatEvent, ChatState> {
  ChatBloc(this._tokenStorage, this._leaveRoomUseCase) : super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatSendImage>(_onSendImage);
    on<ChatTyping>(_onTyping);
    on<ChatLeaveRoom>(_onLeaveRoom);
    on<ChatBlockPartner>(_onBlockPartner);
    on<ChatReportPartner>(_onReportPartner);

    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatPartnerTyping>(_onPartnerTyping);
    on<ChatPartnerLeft>(_onPartnerLeft);
    on<ChatRoomClosed>(_onRoomClosed);
    on<ChatSocketConnected>(_onSocketConnected);
    on<ChatSocketError>(_onSocketError);
    on<ChatRoomReady>(_onRoomReady);
    on<ChatPartnerOnlineChanged>(_onPartnerOnlineChanged);
  }

  final TokenStorage _tokenStorage;
  final LeaveRoomUseCase _leaveRoomUseCase;
  io.Socket? _socket;
  Timer? _typingDebounce;
  int _msgSeq = 0;

  void _onStarted(ChatStarted event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      roomId: event.roomId,
      status: ChatStatus.connecting,
    ));
    _connectSocket(event.roomId);
  }

  void _onSendMessage(ChatSendMessage event, Emitter<ChatState> emit) {
    if (event.text.trim().isEmpty || state.status != ChatStatus.active) return;

    final msg = ChatMessage(
      id: 'local_${_msgSeq++}',
      type: MessageType.text,
      content: event.text.trim(),
      isMine: true,
      timestamp: DateTime.now(),
    );

    emit(state.copyWith(messages: [...state.messages, msg]));
    _socket?.emit('message:send', {
      'roomId': state.roomId,
      'type': 'text',
      'content': event.text.trim(),
    });
  }

  void _onSendImage(ChatSendImage event, Emitter<ChatState> emit) {
    if (state.status != ChatStatus.active) return;

    final placeholder = ChatMessage(
      id: 'upload_${_msgSeq++}',
      type: MessageType.image,
      content: event.filePath,
      isMine: true,
      timestamp: DateTime.now(),
      isUploading: true,
    );

    emit(state.copyWith(
      messages: [...state.messages, placeholder],
      isUploading: true,
    ));

    // TODO: upload image via REST, then emit socket event with URL
    // For now emit as text placeholder
    _socket?.emit('message:send', {
      'roomId': state.roomId,
      'type': 'image',
      'content': event.filePath,
    });
  }

  void _onTyping(ChatTyping event, Emitter<ChatState> emit) {
    _typingDebounce?.cancel();
    _socket?.emit('typing:start', {'roomId': state.roomId});
    _typingDebounce = Timer(const Duration(seconds: 2), () {
      _socket?.emit('typing:stop', {'roomId': state.roomId});
    });
  }

  Future<void> _onLeaveRoom(
    ChatLeaveRoom event,
    Emitter<ChatState> emit,
  ) =>
      guard(() async {
        final result = await _leaveRoomUseCase(state.roomId);
        if (result.isSuccess) {
          _socket?.emit('room:leave', {'roomId': state.roomId});
          _disconnectSocket();
          emit(state.copyWith(
            status: ChatStatus.closed,
            closedReason: 'left',
          ));
        } else {
          throw result.errorOrNull!;
        }
      });

  void _onBlockPartner(ChatBlockPartner event, Emitter<ChatState> emit) {
    _socket?.emit('room:block', {'roomId': state.roomId});
    _disconnectSocket();
    emit(state.copyWith(
      status: ChatStatus.closed,
      closedReason: 'blocked',
    ));
  }

  void _onReportPartner(ChatReportPartner event, Emitter<ChatState> emit) {
    _socket?.emit('room:report', {
      'roomId': state.roomId,
      'reason': event.reason,
      'description': event.description,
    });
  }

  // ── Socket-driven handlers ──

  void _onSocketConnected(
    ChatSocketConnected event,
    Emitter<ChatState> emit,
  ) {
    _socket?.emit('room:join', {'roomId': state.roomId});
  }

  void _onMessageReceived(
    ChatMessageReceived event,
    Emitter<ChatState> emit,
  ) {
    final data = event.data;
    final type = switch (data['type']?.toString()) {
      'image' => MessageType.image,
      'system' => MessageType.system,
      _ => MessageType.text,
    };
    final isMine = data['isMine'] == true;

    final msg = ChatMessage(
      id: data['id']?.toString() ?? 'srv_${_msgSeq++}',
      type: type,
      content: (data['content'] ?? '').toString(),
      isMine: isMine,
      timestamp: DateTime.tryParse(data['timestamp']?.toString() ?? '') ??
          DateTime.now(),
    );

    // For image uploads that complete, replace placeholder
    if (isMine && type == MessageType.image) {
      final updated = state.messages.map((m) {
        if (m.isUploading && m.type == MessageType.image) {
          return msg;
        }
        return m;
      }).toList();
      emit(state.copyWith(messages: updated, isUploading: false));
      return;
    }

    emit(state.copyWith(
      messages: [...state.messages, msg],
      partnerTyping: false,
    ));
  }

  void _onPartnerTyping(ChatPartnerTyping event, Emitter<ChatState> emit) {
    emit(state.copyWith(partnerTyping: event.isTyping));
  }

  void _onPartnerLeft(ChatPartnerLeft event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(state.copyWith(
      status: ChatStatus.closed,
      closedReason: 'partner_left',
    ));
  }

  void _onRoomClosed(ChatRoomClosed event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(state.copyWith(
      status: ChatStatus.closed,
      closedReason: event.reason,
    ));
  }

  void _onSocketError(ChatSocketError event, Emitter<ChatState> emit) {
    if (state.status == ChatStatus.active) return;
    emit(state.copyWith(
      status: ChatStatus.error,
      errorMessage: event.message,
    ));
  }

  void _onRoomReady(ChatRoomReady event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      status: ChatStatus.active,
      partnerAlias: event.partnerAlias,
      partnerOnline: true,
    ));
  }

  void _onPartnerOnlineChanged(
    ChatPartnerOnlineChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(partnerOnline: event.online));
  }

  // ── Socket management ──

  void _connectSocket(String roomId) {
    final rawBaseUrl = dotenv.env['API_BASE_URL'] ?? '$_defaultBaseUrl/api';
    final serverUrl = rawBaseUrl.replaceAll(RegExp(r'/api/?$'), '');
    final token = _tokenStorage.accessToken ?? '';

    log('ChatSocket: connecting to $serverUrl/chat', name: 'Socket');

    _socket = io.io(
      '$serverUrl/chat',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': token})
          .disableAutoConnect()
          .enableReconnection()
          .setReconnectionAttempts(10)
          .setReconnectionDelay(2000)
          .setReconnectionDelayMax(10000)
          .build(),
    );

    _socket!
      ..onConnect((_) {
        log('ChatSocket: connected', name: 'Socket');
        add(const ChatSocketConnected());
      })
      ..onConnectError((error) {
        log('ChatSocket: connect error $error', name: 'Socket');
        add(ChatSocketError(error.toString()));
      })
      ..on('room:ready', (data) {
        final map = data is Map<String, dynamic> ? data : <String, dynamic>{};
        final alias = map['partnerAlias']?.toString() ?? 'Stranger';
        add(ChatRoomReady(alias));
      })
      ..on('message:new', (data) {
        if (data is Map<String, dynamic>) {
          add(ChatMessageReceived(data));
        }
      })
      ..on('typing:start', (_) => add(const ChatPartnerTyping(true)))
      ..on('typing:stop', (_) => add(const ChatPartnerTyping(false)))
      ..on('partner:left', (_) => add(const ChatPartnerLeft()))
      ..on('room:closed', (data) {
        final reason =
            data is Map ? (data['reason'] ?? 'closed').toString() : 'closed';
        add(ChatRoomClosed(reason));
      })
      ..on('partner:online', (_) {
        add(const ChatPartnerOnlineChanged(true));
      })
      ..on('partner:offline', (_) {
        add(const ChatPartnerOnlineChanged(false));
      })
      ..on('error', (data) {
        final msg =
            data is Map ? (data['message'] ?? data.toString()) : '$data';
        add(ChatSocketError(msg.toString()));
      });

    _socket!.connect();
  }

  void _disconnectSocket() {
    _typingDebounce?.cancel();
    _socket?.dispose();
    _socket = null;
  }

  @override
  Future<void> close() {
    _disconnectSocket();
    return super.close();
  }
}
