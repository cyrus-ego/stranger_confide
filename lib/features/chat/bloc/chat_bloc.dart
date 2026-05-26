import 'dart:async';
import 'dart:developer';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../core/token_storage.dart';
import '../../../domain/usecases/block_room_usecase.dart';
import '../../../domain/usecases/leave_room_usecase.dart';
import '../../../domain/usecases/report_user_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

const _defaultBaseUrl = 'https://c44e-1-54-23-149.ngrok-free.app';

@injectable
class ChatBloc extends AppBloc<ChatEvent, ChatState> {
  ChatBloc(
    this._tokenStorage,
    this._leaveRoomUseCase,
    this._blockRoomUseCase,
    this._reportUserUseCase,
  ) : super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatSendImage>(_onSendImage);
    on<ChatTyping>(_onTyping);
    on<ChatLeaveRoom>(_onLeaveRoom);
    on<ChatBlockPartner>(_onBlockPartner);
    on<ChatReportPartner>(_onReportPartner);

    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatPartnerTyping>(_onPartnerTyping);
    on<ChatRoomClosed>(_onRoomClosed);
    on<ChatSocketConnected>(_onSocketConnected);
    on<ChatSocketError>(_onSocketError);
    on<ChatRoomJoined>(_onRoomJoined);
    on<ChatPartnerOnlineChanged>(_onPartnerOnlineChanged);
    on<ChatAccessDenied>(_onAccessDenied);
  }

  final TokenStorage _tokenStorage;
  final LeaveRoomUseCase _leaveRoomUseCase;
  final BlockRoomUseCase _blockRoomUseCase;
  final ReportUserUseCase _reportUserUseCase;
  io.Socket? _socket;
  Timer? _typingDebounce;
  bool _isTypingEmitted = false;

  // ── User action handlers ──

  void _onStarted(ChatStarted event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      roomId: event.roomId,
      status: ChatStatus.connecting,
    ));
    _connectSocket(event.roomId);
  }

  void _onSendMessage(ChatSendMessage event, Emitter<ChatState> emit) {
    if (event.text.trim().isEmpty || state.status != ChatStatus.active) return;

    _socket?.emit('chat:send', {
      'roomId': state.roomId,
      'type': 'text',
      'content': event.text.trim(),
    });

    _cancelTyping();
    emit(state.copyWith(isSending: true));
  }

  void _onSendImage(ChatSendImage event, Emitter<ChatState> emit) {
    if (state.status != ChatStatus.active) return;
    // TODO: POST /chat/:roomId/image multipart upload (phase sau)
    emit(state.copyWith(isUploading: true));
  }

  void _onTyping(ChatTyping event, Emitter<ChatState> emit) {
    if (!_isTypingEmitted) {
      _isTypingEmitted = true;
      _socket?.emit('chat:typing', {
        'roomId': state.roomId,
        'isTyping': true,
      });
    }

    _typingDebounce?.cancel();
    _typingDebounce = Timer(const Duration(seconds: 2), _cancelTyping);
  }

  void _cancelTyping() {
    if (_isTypingEmitted) {
      _isTypingEmitted = false;
      _socket?.emit('chat:typing', {
        'roomId': state.roomId,
        'isTyping': false,
      });
    }
    _typingDebounce?.cancel();
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

  Future<void> _onBlockPartner(
    ChatBlockPartner event,
    Emitter<ChatState> emit,
  ) =>
      guard(() async {
        if (state.partnerUserId.isEmpty) return;

        final result = await _blockRoomUseCase(
          state.roomId,
          state.partnerUserId,
        );
        if (result.isSuccess) {
          _socket?.emit('room:block', {
            'roomId': state.roomId,
            'targetUserId': state.partnerUserId,
          });
          _disconnectSocket();
          emit(state.copyWith(
            status: ChatStatus.closed,
            closedReason: 'blocked',
          ));
        } else {
          throw result.errorOrNull!;
        }
      });

  Future<void> _onReportPartner(
    ChatReportPartner event,
    Emitter<ChatState> emit,
  ) =>
      guard(() async {
        if (state.partnerUserId.isEmpty) return;

        final result = await _reportUserUseCase(
          reportedUserId: state.partnerUserId,
          roomId: state.roomId,
          reason: event.reason,
          description: event.description,
        );
        emit(state.copyWith(
          lastAction: result.isSuccess
              ? ChatAction.reportSuccess
              : ChatAction.reportFailed,
        ));
      });

  // ── Socket-driven handlers ──

  void _onSocketConnected(
    ChatSocketConnected event,
    Emitter<ChatState> emit,
  ) {
    _socket?.emit('room:join', {'roomId': state.roomId});
  }

  void _onRoomJoined(ChatRoomJoined event, Emitter<ChatState> emit) {
    final data = event.data;
    final session = data['session'] as Map<String, dynamic>? ?? {};
    final partnerUserId = data['partnerUserId']?.toString() ?? '';
    final rawMessages = data['messages'] as List<dynamic>? ?? [];

    final myAlias = session['myAlias']?.toString() ?? '';
    final myAvatar = session['myAvatar']?.toString() ?? '';
    final partnerAlias = session['partnerAlias']?.toString() ?? 'Stranger';
    final partnerAvatar = session['partnerAvatar']?.toString() ?? '';
    final partnerOnline = session['partnerOnline'] == true;

    final messages = rawMessages
        .whereType<Map<String, dynamic>>()
        .map((m) => _parseMessage(m, myAlias))
        .toList();

    emit(state.copyWith(
      status: ChatStatus.active,
      myAlias: myAlias,
      myAvatar: myAvatar,
      partnerAlias: partnerAlias,
      partnerAvatar: partnerAvatar,
      partnerUserId: partnerUserId,
      partnerOnline: partnerOnline,
      messages: messages,
    ));
  }

  void _onMessageReceived(
    ChatMessageReceived event,
    Emitter<ChatState> emit,
  ) {
    final msg = _parseMessage(event.data, state.myAlias);

    if (msg.isMine && msg.type == MessageType.image) {
      final updated = state.messages.map((m) {
        if (m.isUploading && m.type == MessageType.image) return msg;
        return m;
      }).toList();
      emit(state.copyWith(
        messages: updated,
        isUploading: false,
        isSending: false,
      ));
      return;
    }

    emit(state.copyWith(
      messages: [...state.messages, msg],
      partnerTyping: false,
      isSending: msg.isMine ? false : state.isSending,
    ));
  }

  void _onPartnerTyping(ChatPartnerTyping event, Emitter<ChatState> emit) {
    emit(state.copyWith(partnerTyping: event.isTyping));
  }

  void _onRoomClosed(ChatRoomClosed event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(state.copyWith(
      status: ChatStatus.closed,
      closedReason: event.reason,
    ));
  }

  void _onSocketError(ChatSocketError event, Emitter<ChatState> emit) {
    final msg = event.message.toLowerCase();

    if (msg.contains('vi phạm') || msg.contains('nội quy')) {
      emit(state.copyWith(
        isSending: false,
        lastAction: ChatAction.moderationBlocked,
      ));
      return;
    }

    if (msg.contains('quá nhanh') || msg.contains('spam')) {
      emit(state.copyWith(
        isSending: false,
        lastAction: ChatAction.spamDetected,
      ));
      return;
    }

    if (msg.contains('không thể gửi')) {
      _disconnectSocket();
      emit(state.copyWith(
        status: ChatStatus.closed,
        closedReason: 'blocked',
      ));
      return;
    }

    if (state.status != ChatStatus.active) {
      emit(state.copyWith(
        status: ChatStatus.error,
        errorMessage: event.message,
      ));
    }
  }

  void _onPartnerOnlineChanged(
    ChatPartnerOnlineChanged event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(partnerOnline: event.online));
  }

  void _onAccessDenied(ChatAccessDenied event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(state.copyWith(
      status: ChatStatus.error,
      errorMessage: event.message,
      closedReason: 'access_denied',
    ));
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
        if (!isClosed) add(const ChatSocketConnected());
      })
      ..onConnectError((error) {
        log('ChatSocket: connect error $error', name: 'Socket');
        if (!isClosed) add(ChatSocketError(error.toString()));
      })
      ..on('room:joined', (data) {
        if (data is Map<String, dynamic> && !isClosed) {
          add(ChatRoomJoined(data));
        }
      })
      ..on('chat:message', (data) {
        if (data is Map<String, dynamic> && !isClosed) {
          add(ChatMessageReceived(data));
        }
      })
      ..on('chat:typing', (data) {
        if (!isClosed) {
          final isTyping = data is Map ? data['isTyping'] == true : false;
          add(ChatPartnerTyping(isTyping));
        }
      })
      ..on('room:presence', (data) {
        if (data is Map && !isClosed) {
          final online = data['online'] == true;
          add(ChatPartnerOnlineChanged(online));
        }
      })
      ..on('room:closed', (data) {
        if (!isClosed) {
          final reason = data is Map
              ? (data['reason'] ?? 'closed').toString()
              : 'closed';
          add(ChatRoomClosed(reason));
        }
      })
      ..on('room:access_denied', (data) {
        if (!isClosed) {
          final message = data is Map
              ? (data['message'] ?? 'Không có quyền truy cập').toString()
              : 'Không có quyền truy cập';
          add(ChatAccessDenied(message));
        }
      })
      ..on('error', (data) {
        if (!isClosed) {
          final msg =
              data is Map ? (data['message'] ?? data.toString()) : '$data';
          add(ChatSocketError(msg.toString()));
        }
      });

    _socket!.connect();
  }

  ChatMessage _parseMessage(Map<String, dynamic> data, String myAlias) {
    final type = switch (data['type']?.toString()) {
      'image' => MessageType.image,
      'system' => MessageType.system,
      _ => MessageType.text,
    };
    final senderAlias = data['senderAlias']?.toString() ?? '';
    final isMine = senderAlias == myAlias;

    return ChatMessage(
      id: data['id']?.toString() ?? 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderAlias: senderAlias,
      type: type,
      content: (data['content'] ?? '').toString(),
      imageUrl: data['imageUrl']?.toString(),
      createdAt: DateTime.tryParse(data['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      isMine: isMine,
    );
  }

  void _disconnectSocket() {
    _cancelTyping();
    _socket?.dispose();
    _socket = null;
  }

  @override
  Future<void> close() {
    _disconnectSocket();
    return super.close();
  }
}
