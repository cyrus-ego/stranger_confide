import 'dart:async';
import 'dart:developer';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:cyr_app_kit/cyr_app_kit.dart';
import '../../../domain/usecases/get_active_room_usecase.dart';
import '../../../domain/usecases/get_chat_messages_usecase.dart';
import '../../../domain/usecases/leave_room_usecase.dart';
import '../../../domain/usecases/report_user_usecase.dart';
import '../../../domain/usecases/upload_chat_image_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

const _defaultBaseUrl = 'https://api.chatvn.online';

@injectable
class ChatBloc extends AppBloc<ChatEvent, ChatState> {
  ChatBloc(
    this._tokenStorage,
    this._getActiveRoomUseCase,
    this._leaveRoomUseCase,
    this._reportUserUseCase,
    this._getChatMessagesUseCase,
    this._uploadChatImageUseCase,
  ) : super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<ChatSendMessage>(_onSendMessage);
    on<ChatSendImage>(_onSendImage);
    on<ChatLoadOlderMessages>(_onLoadOlderMessages);
    on<ChatTyping>(_onTyping);
    on<ChatAppResumed>(_onAppResumed);
    on<ChatVisibilityChanged>(_onVisibilityChanged);
    on<ChatLeaveRoom>(_onLeaveRoom);
    on<ChatBlockPartner>(_onBlockPartner);
    on<ChatReportPartner>(_onReportPartner);

    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatPartnerTyping>(_onPartnerTyping);
    on<ChatRoomClosed>(_onRoomClosed);
    on<ChatSocketConnected>(_onSocketConnected);
    on<ChatSocketDisconnected>(_onSocketDisconnected);
    on<ChatSocketError>(_onSocketError);
    on<ChatErrorCleared>(_onErrorCleared);
    on<ChatRoomJoined>(_onRoomJoined);
    on<ChatPartnerOnlineChanged>(_onPartnerOnlineChanged);
    on<ChatAccessDenied>(_onAccessDenied);
  }

  final TokenStorage _tokenStorage;
  final GetActiveRoomUseCase _getActiveRoomUseCase;
  final LeaveRoomUseCase _leaveRoomUseCase;
  final ReportUserUseCase _reportUserUseCase;
  final GetChatMessagesUseCase _getChatMessagesUseCase;
  final UploadChatImageUseCase _uploadChatImageUseCase;
  io.Socket? _socket;
  Timer? _typingDebounce;
  Timer? _errorClearTimer;
  bool _isTypingEmitted = false;
  bool _isAppForeground = true;

  // ── User action handlers ──

  void _onStarted(ChatStarted event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(
      state.copyWith(
        roomId: event.roomId,
        status: ChatStatus.connecting,
        isLoadingOlderMessages: false,
        hasMoreOlderMessages: false,
        oldestMessageId: null,
      ),
    );
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
    _errorClearTimer?.cancel();
    emit(
      state.copyWith(
        isSending: true,
        errorMessage: null,
        lastAction: ChatAction.none,
      ),
    );
  }

  Future<void> _onSendImage(
    ChatSendImage event,
    Emitter<ChatState> emit,
  ) async {
    if (state.status != ChatStatus.active) return;

    final pendingMessage = ChatMessage(
      id: 'upload_${DateTime.now().microsecondsSinceEpoch}',
      senderAlias: state.myAlias,
      type: MessageType.image,
      content: '',
      createdAt: DateTime.now(),
      isMine: true,
      isUploading: true,
    );
    emit(
      state.copyWith(
        messages: [...state.messages, pendingMessage],
        isUploading: true,
        errorMessage: null,
        lastAction: ChatAction.none,
      ),
    );

    final result = await _uploadChatImageUseCase(
      roomId: state.roomId,
      filePath: event.filePath,
    );

    switch (result) {
      case AppSuccess(:final value):
        final uploaded = _parseMessage(value.message.toJson(), state.myAlias);
        emit(
          state.copyWith(
            messages: _mergeMessages([uploaded]),
            isUploading: false,
          ),
        );
      case AppFailure(:final error):
        final messages = state.messages
            .where((message) => message.id != pendingMessage.id)
            .toList();
        emit(
          state.copyWith(
            messages: messages,
            isUploading: false,
            errorMessage: error.message,
            lastAction: _chatActionForCode(error.code),
          ),
        );
    }
  }

  Future<void> _onLoadOlderMessages(
    ChatLoadOlderMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (state.status != ChatStatus.active ||
        state.isLoadingOlderMessages ||
        !state.hasMoreOlderMessages ||
        state.roomId.isEmpty) {
      return;
    }

    final beforeMessageId = state.oldestMessageId;
    if (beforeMessageId == null || beforeMessageId.isEmpty) return;

    emit(state.copyWith(isLoadingOlderMessages: true, errorMessage: null));

    final result = await _getChatMessagesUseCase(
      roomId: state.roomId,
      beforeMessageId: beforeMessageId,
      limit: event.limit,
    );

    switch (result) {
      case AppSuccess(:final value):
        final olderMessages = value.messages
            .map((message) => _parseMessage(message.toJson(), state.myAlias))
            .toList();
        final mergedMessages = _mergeMessages(olderMessages);

        emit(
          state.copyWith(
            messages: mergedMessages,
            oldestMessageId: value.nextBeforeMessageId,
            hasMoreOlderMessages: value.hasMore,
            isLoadingOlderMessages: false,
          ),
        );
      case AppFailure(:final error):
        emit(
          state.copyWith(
            isLoadingOlderMessages: false,
            errorMessage: error.message,
          ),
        );
    }
  }

  void _onTyping(ChatTyping event, Emitter<ChatState> emit) {
    if (state.status != ChatStatus.active) return;

    if (!_isTypingEmitted) {
      _isTypingEmitted = true;
      _socket?.emit('chat:typing', {'roomId': state.roomId, 'isTyping': true});
    }

    _typingDebounce?.cancel();
    _typingDebounce = Timer(const Duration(seconds: 2), _cancelTyping);
  }

  Future<void> _onAppResumed(
    ChatAppResumed event,
    Emitter<ChatState> emit,
  ) async {
    if (state.roomId.isEmpty || state.closureInitiatedByMe) return;

    final result = await _getActiveRoomUseCase();
    if (result case AppSuccess(:final value)) {
      final activeRoomId = value.roomId;
      if (!value.hasActiveRoom || activeRoomId == null) {
        _disconnectSocket();
        emit(_terminalState(reason: 'closed', initiatedByMe: false));
        return;
      }

      final roomChanged = activeRoomId != state.roomId;
      final shouldRestartSocket = roomChanged || _socket?.connected != true;
      if (shouldRestartSocket) {
        _disconnectSocket();
      }

      emit(
        state.copyWith(
          roomId: activeRoomId,
          status: ChatStatus.connecting,
          messages: roomChanged ? const [] : state.messages,
          closedReason: null,
          errorMessage: null,
          closureInitiatedByMe: false,
          partnerTyping: false,
          isUploading: false,
          isSending: false,
          isLoadingOlderMessages: false,
          hasMoreOlderMessages: roomChanged
              ? false
              : state.hasMoreOlderMessages,
          oldestMessageId: roomChanged ? null : state.oldestMessageId,
        ),
      );

      if (!shouldRestartSocket) {
        _joinRoom();
        return;
      }

      _connectSocket(activeRoomId);
      return;
    }

    if (state.status == ChatStatus.connecting || state.messages.isEmpty) {
      emit(
        state.copyWith(
          status: ChatStatus.error,
          isSending: false,
          isUploading: false,
          isLoadingOlderMessages: false,
          partnerTyping: false,
          errorMessage: 'Không kết nối được. Thử lại.',
        ),
      );
    }
  }

  void _onVisibilityChanged(
    ChatVisibilityChanged event,
    Emitter<ChatState> emit,
  ) {
    _isAppForeground = event.visible;
    _emitChatVisibility(event.visible);
  }

  void _cancelTyping() {
    if (_isTypingEmitted) {
      _isTypingEmitted = false;
      _socket?.emit('chat:typing', {'roomId': state.roomId, 'isTyping': false});
    }
    _typingDebounce?.cancel();
  }

  Future<void> _onLeaveRoom(ChatLeaveRoom event, Emitter<ChatState> emit) {
    emit(state.copyWith(closureInitiatedByMe: true));

    if (_socket?.connected == true) {
      _socket!.emit('room:leave', {'roomId': state.roomId});
      return Future.value();
    }

    return guard(
      () async {
        final result = await _leaveRoomUseCase(state.roomId);
        if (result.isSuccess) {
          _disconnectSocket();
          emit(_terminalState(reason: 'left', initiatedByMe: true));
        } else {
          throw result.errorOrNull!;
        }
      },
      onError: (_) {
        emit(state.copyWith(closureInitiatedByMe: false));
      },
    );
  }

  Future<void> _onBlockPartner(
    ChatBlockPartner event,
    Emitter<ChatState> emit,
  ) {
    if (state.partnerUserId.isEmpty) return Future.value();
    emit(state.copyWith(closureInitiatedByMe: true));

    if (_socket?.connected != true) {
      emit(
        state.copyWith(
          closureInitiatedByMe: false,
          errorMessage: 'Mất kết nối. Vui lòng thử lại.',
        ),
      );
      return Future.value();
    }

    _socket!.emit('room:block', {
      'roomId': state.roomId,
      'targetUserId': state.partnerUserId,
    });
    return Future.value();
  }

  Future<void> _onReportPartner(
    ChatReportPartner event,
    Emitter<ChatState> emit,
  ) => guard(() async {
    if (state.partnerUserId.isEmpty) return;

    final result = await _reportUserUseCase(
      reportedUserId: state.partnerUserId,
      roomId: state.roomId,
      reason: event.reason,
      description: event.description,
    );
    emit(
      state.copyWith(
        lastAction: result.isSuccess
            ? ChatAction.reportSuccess
            : ChatAction.reportFailed,
      ),
    );
  });

  // ── Socket-driven handlers ──

  void _onSocketConnected(ChatSocketConnected event, Emitter<ChatState> emit) {
    _joinRoom();
  }

  void _onRoomJoined(ChatRoomJoined event, Emitter<ChatState> emit) {
    final data = event.data;
    final session = data['session'] as Map<String, dynamic>? ?? {};
    final partnerUserId = data['partnerUserId']?.toString() ?? '';
    final rawMessages = data['messages'] as List<dynamic>? ?? [];

    final myAlias = session['myAlias']?.toString() ?? '';
    final myAvatar = session['myAvatar']?.toString() ?? '';
    final partnerAlias = session['partnerAlias']?.toString() ?? 'Member';
    final partnerAvatar = session['partnerAvatar']?.toString() ?? '';
    final partnerOnline = session['partnerOnline'] == true;

    final joinedRoomId = session['roomId']?.toString();
    final roomId = joinedRoomId == null || joinedRoomId.isEmpty
        ? state.roomId
        : joinedRoomId;
    final messages = rawMessages
        .whereType<Map<String, dynamic>>()
        .map((m) => _parseMessage(m, myAlias))
        .toList();
    final mergedMessages = _mergeMessages(
      messages,
      shouldMerge: roomId == state.roomId,
    );
    final isSameRoom = roomId == state.roomId;
    final hasExistingHistoryCursor =
        isSameRoom && state.oldestMessageId != null;
    final oldestMessageId = mergedMessages.isEmpty
        ? null
        : mergedMessages.first.id;

    emit(
      state.copyWith(
        roomId: roomId,
        status: ChatStatus.active,
        myAlias: myAlias,
        myAvatar: myAvatar,
        partnerAlias: partnerAlias,
        partnerAvatar: partnerAvatar,
        partnerUserId: partnerUserId,
        partnerOnline: partnerOnline,
        messages: mergedMessages,
        oldestMessageId: oldestMessageId,
        hasMoreOlderMessages: hasExistingHistoryCursor
            ? state.hasMoreOlderMessages
            : rawMessages.length >= 100,
        isLoadingOlderMessages: false,
        closureInitiatedByMe: false,
        closedReason: null,
      ),
    );

    _emitChatVisibility(_isAppForeground);
  }

  void _onMessageReceived(ChatMessageReceived event, Emitter<ChatState> emit) {
    final msg = _parseMessage(event.data, state.myAlias);

    if (msg.isMine && msg.type == MessageType.image) {
      final updated = state.messages.map((m) {
        if (m.isUploading && m.type == MessageType.image) return msg;
        return m;
      }).toList();
      emit(
        state.copyWith(messages: updated, isUploading: false, isSending: false),
      );
      return;
    }

    emit(
      state.copyWith(
        messages: _mergeMessages([msg]),
        partnerTyping: false,
        isSending: msg.isMine ? false : state.isSending,
      ),
    );
  }

  void _onPartnerTyping(ChatPartnerTyping event, Emitter<ChatState> emit) {
    emit(state.copyWith(partnerTyping: event.isTyping));
  }

  void _onRoomClosed(ChatRoomClosed event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(
      _terminalState(
        reason: event.reason,
        initiatedByMe: state.closureInitiatedByMe,
      ),
    );
  }

  void _onSocketError(ChatSocketError event, Emitter<ChatState> emit) {
    switch (event.code) {
      case 'MODERATION_BLOCKED' || 'CHAT_MODERATION_BLOCKED':
        emit(
          state.copyWith(
            isSending: false,
            lastAction: ChatAction.moderationBlocked,
          ),
        );
        return;
      case 'SPAM_DETECTED' || 'CHAT_SPAM_DETECTED':
        emit(
          state.copyWith(isSending: false, lastAction: ChatAction.spamDetected),
        );
        return;
      case 'ROOM_CLOSED':
        _disconnectSocket();
        emit(_terminalState(reason: 'ROOM_CLOSED', initiatedByMe: false));
        return;
      case 'ACCESS_DENIED' || 'MESSAGE_SEND_FAILED' || null:
        break;
      default:
        break;
    }

    if (state.status == ChatStatus.active) {
      _errorClearTimer?.cancel();
      emit(
        state.copyWith(isSending: false, errorMessage: event.message.trim()),
      );
      _errorClearTimer = Timer(const Duration(seconds: 5), () {
        if (!isClosed) add(const ChatErrorCleared());
      });
      return;
    }

    emit(
      state.copyWith(
        status: ChatStatus.error,
        isSending: false,
        errorMessage: event.message,
      ),
    );
  }

  void _onErrorCleared(ChatErrorCleared event, Emitter<ChatState> emit) {
    _errorClearTimer = null;
    emit(state.copyWith(errorMessage: null));
  }

  void _onPartnerOnlineChanged(
    ChatPartnerOnlineChanged event,
    Emitter<ChatState> emit,
  ) {
    if (event.userId == null || event.userId != state.partnerUserId) return;
    emit(state.copyWith(partnerOnline: event.online));
  }

  void _onAccessDenied(ChatAccessDenied event, Emitter<ChatState> emit) {
    _disconnectSocket();
    emit(
      _terminalState(
        reason: 'access_denied',
        errorMessage: event.message,
        initiatedByMe: false,
      ),
    );
  }

  void _onSocketDisconnected(
    ChatSocketDisconnected event,
    Emitter<ChatState> emit,
  ) {
    if (state.status == ChatStatus.closed || state.roomId.isEmpty) return;
    _cancelTyping();
    emit(
      state.copyWith(
        status: ChatStatus.connecting,
        partnerTyping: false,
        isSending: false,
        errorMessage: null,
      ),
    );
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
      ..onDisconnect((reason) {
        log('ChatSocket: disconnected ($reason)', name: 'Socket');
        if (!isClosed) add(ChatSocketDisconnected(reason.toString()));
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
          add(
            ChatPartnerOnlineChanged(
              online,
              userId: data['userId']?.toString(),
            ),
          );
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
          final rawMessage = data is Map ? data['message'] : data;
          final code = data is Map ? data['code']?.toString() : null;
          add(ChatSocketError(rawMessage?.toString() ?? '', code: code));
        }
      });

    _socket!.connect();
  }

  void _joinRoom() {
    _socket?.emit('room:join', {'roomId': state.roomId});
  }

  void _emitChatVisibility(bool visible) {
    if (state.roomId.isEmpty || _socket?.connected != true) return;
    _socket?.emit('chat:visibility', {
      'roomId': state.roomId,
      'visible': visible,
    });
  }

  List<ChatMessage> _mergeMessages(
    List<ChatMessage> incoming, {
    bool shouldMerge = true,
  }) {
    final byId = <String, ChatMessage>{
      if (shouldMerge)
        for (final message in state.messages)
          if (!message.isUploading) message.id: message,
    };

    for (final message in incoming) {
      byId[message.id] = message;
    }

    return byId.values.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
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
      id:
          data['id']?.toString() ??
          'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderAlias: senderAlias,
      type: type,
      content: (data['content'] ?? '').toString(),
      imageUrl: data['imageUrl']?.toString(),
      createdAt:
          DateTime.tryParse(data['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      isMine: isMine,
    );
  }

  ChatState _terminalState({
    required String reason,
    required bool initiatedByMe,
    String? errorMessage,
  }) {
    return state.copyWith(
      status: ChatStatus.closed,
      messages: const [],
      roomId: '',
      myAlias: '',
      myAvatar: '',
      partnerAlias: 'Member',
      partnerAvatar: '',
      partnerUserId: '',
      partnerOnline: false,
      partnerTyping: false,
      isUploading: false,
      isSending: false,
      isLoadingOlderMessages: false,
      hasMoreOlderMessages: false,
      oldestMessageId: null,
      closedReason: reason,
      errorMessage: errorMessage,
      closureInitiatedByMe: initiatedByMe,
      lastAction: ChatAction.none,
    );
  }

  ChatAction _chatActionForCode(String? code) {
    return switch (code) {
      'MODERATION_BLOCKED' ||
      'CHAT_MODERATION_BLOCKED' => ChatAction.moderationBlocked,
      'SPAM_DETECTED' || 'CHAT_SPAM_DETECTED' => ChatAction.spamDetected,
      _ => ChatAction.none,
    };
  }

  void _disconnectSocket() {
    _cancelTyping();
    _errorClearTimer?.cancel();
    _errorClearTimer = null;
    _emitChatVisibility(false);
    _socket?.dispose();
    _socket = null;
  }

  @override
  Future<void> close() {
    _disconnectSocket();
    return super.close();
  }
}
