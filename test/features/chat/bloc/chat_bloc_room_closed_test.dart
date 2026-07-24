import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stranger_confide/core/token_storage.dart';
import 'package:stranger_confide/data/models/response/active_room_response.dart';
import 'package:stranger_confide/data/models/response/chat_message_dto.dart';
import 'package:stranger_confide/data/models/response/chat_messages_response.dart';
import 'package:stranger_confide/domain/repositories/chat_repository.dart';
import 'package:stranger_confide/domain/repositories/moderation_repository.dart';
import 'package:stranger_confide/domain/repositories/room_repository.dart';
import 'package:stranger_confide/domain/usecases/block_room_usecase.dart';
import 'package:stranger_confide/domain/usecases/get_active_room_usecase.dart';
import 'package:stranger_confide/domain/usecases/get_chat_messages_usecase.dart';
import 'package:stranger_confide/domain/usecases/leave_room_usecase.dart';
import 'package:stranger_confide/domain/usecases/report_user_usecase.dart';
import 'package:stranger_confide/features/chat/bloc/chat_bloc.dart';
import 'package:stranger_confide/features/chat/bloc/chat_event.dart';
import 'package:stranger_confide/features/chat/bloc/chat_state.dart';

void main() {
  late ChatBloc bloc;
  late _SuccessfulRoomRepository roomRepository;
  late _SuccessfulChatRepository chatRepository;

  setUp(() {
    roomRepository = _SuccessfulRoomRepository();
    chatRepository = _SuccessfulChatRepository();
    bloc = ChatBloc(
      TokenStorage(),
      GetActiveRoomUseCase(roomRepository),
      LeaveRoomUseCase(roomRepository),
      BlockRoomUseCase(roomRepository),
      ReportUserUseCase(_SuccessfulModerationRepository()),
      GetChatMessagesUseCase(chatRepository),
    );
  });

  tearDown(() => bloc.close());

  test('local leave marks the room closure as initiated by me', () async {
    final closedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.closed,
    );

    bloc.add(const ChatLeaveRoom());

    expect(
      await closedState,
      isA<ChatState>()
          .having(
            (state) => state.closureInitiatedByMe,
            'closureInitiatedByMe',
            isTrue,
          )
          .having((state) => state.closedReason, 'closedReason', 'left'),
    );
  });

  test('socket room closure is attributed to the partner', () async {
    final joinedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.active,
    );
    bloc.add(
      const ChatRoomJoined({
        'session': {'partnerOnline': true},
      }),
    );
    await joinedState;

    final typingState = bloc.stream.firstWhere((state) => state.partnerTyping);
    bloc.add(const ChatPartnerTyping(true));
    await typingState;

    final closedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.closed,
    );
    bloc.add(const ChatRoomClosed('partner_left'));
    final state = await closedState;

    expect(state.closureInitiatedByMe, isFalse);
    expect(state.closedReason, 'partner_left');
    expect(state.partnerOnline, isFalse);
    expect(state.partnerTyping, isFalse);
    expect(state.isSending, isFalse);
  });

  test(
    'send error stops loading and clears itself after five seconds',
    () async {
      final joinedState = bloc.stream.firstWhere(
        (state) => state.status == ChatStatus.active,
      );
      bloc.add(const ChatRoomJoined({'session': <String, dynamic>{}}));
      await joinedState;

      final sendingState = bloc.stream.firstWhere((state) => state.isSending);
      bloc.add(const ChatSendMessage('Hello'));
      await sendingState;

      final errorState = bloc.stream.firstWhere(
        (state) => state.errorMessage == 'Không thể kết nối',
      );
      bloc.add(const ChatSocketError('Không thể kết nối'));
      final state = await errorState;

      expect(state.status, ChatStatus.active);
      expect(state.isSending, isFalse);

      final clearedState = bloc.stream.firstWhere(
        (state) => state.errorMessage == null,
      );
      expect(
        await clearedState.timeout(const Duration(seconds: 6)),
        isA<ChatState>().having(
          (state) => state.errorMessage,
          'errorMessage',
          isNull,
        ),
      );
    },
  );

  test('room joined merges and dedupes recovered messages', () async {
    final firstJoin = bloc.stream.firstWhere(
      (state) => state.messages.length == 1,
    );
    bloc.add(
      const ChatRoomJoined({
        'session': {'roomId': 'room-1', 'myAlias': 'Me'},
        'messages': [
          {
            'id': 'msg-1',
            'senderAlias': 'Me',
            'type': 'text',
            'content': 'Old',
            'createdAt': '2026-07-24T10:00:00.000Z',
          },
        ],
      }),
    );
    await firstJoin;

    final recoveredState = bloc.stream.firstWhere(
      (state) => state.messages.length == 2,
    );
    bloc.add(
      const ChatRoomJoined({
        'session': {'roomId': 'room-1', 'myAlias': 'Me'},
        'messages': [
          {
            'id': 'msg-1',
            'senderAlias': 'Me',
            'type': 'text',
            'content': 'Old from server',
            'createdAt': '2026-07-24T10:00:00.000Z',
          },
          {
            'id': 'msg-2',
            'senderAlias': 'Stranger',
            'type': 'text',
            'content': 'Missed',
            'createdAt': '2026-07-24T10:01:00.000Z',
          },
        ],
      }),
    );
    final state = await recoveredState;

    expect(state.messages.map((message) => message.id), ['msg-1', 'msg-2']);
    expect(state.messages.first.content, 'Old from server');
  });

  test('app resume closes chat when backend reports no active room', () async {
    roomRepository.activeRoomResponse = const ActiveRoomResponse(
      hasActiveRoom: false,
    );

    final joinedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.active,
    );
    bloc.add(
      const ChatRoomJoined({
        'session': {'roomId': 'room-1'},
      }),
    );
    await joinedState;

    final closedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.closed,
    );
    bloc.add(const ChatAppResumed());
    final state = await closedState;

    expect(state.closedReason, 'closed');
    expect(state.closureInitiatedByMe, isFalse);
    expect(state.isSending, isFalse);
  });

  test('access denied is treated as a closed room for UI navigation', () async {
    final deniedState = bloc.stream.firstWhere(
      (state) =>
          state.status == ChatStatus.closed &&
          state.closedReason == 'access_denied',
    );
    bloc.add(const ChatAccessDenied('Không có quyền truy cập'));
    final state = await deniedState;

    expect(state.errorMessage, 'Không có quyền truy cập');
  });

  test('load older messages prepends, dedupes, and updates cursor', () async {
    final joinedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.active,
    );
    bloc.add(
      ChatRoomJoined({
        'session': {'roomId': 'room-1', 'myAlias': 'Me'},
        'messages': List.generate(
          100,
          (i) => {
            'id': 'msg-${i + 100}',
            'senderAlias': i.isEven ? 'Me' : 'Stranger',
            'type': 'text',
            'content': 'Message ${i + 100}',
            'createdAt': DateTime.utc(
              2026,
              7,
              24,
              10,
            ).add(Duration(seconds: i)).toIso8601String(),
          },
        ),
      }),
    );
    await joinedState;

    chatRepository.response = const ChatMessagesResponse(
      messages: [
        ChatMessageDto(
          id: 'msg-98',
          senderAlias: 'Stranger',
          type: 'text',
          content: 'Older',
          createdAt: '2026-07-24T09:58:00.000Z',
        ),
        ChatMessageDto(
          id: 'msg-100',
          senderAlias: 'Me',
          type: 'text',
          content: 'Duplicate from history',
          createdAt: '2026-07-24T10:00:00.000Z',
        ),
      ],
      nextBeforeMessageId: 'msg-98',
      hasMore: true,
    );

    final loadedState = bloc.stream.firstWhere(
      (state) => !state.isLoadingOlderMessages && state.messages.length == 101,
    );
    bloc.add(const ChatLoadOlderMessages());
    final state = await loadedState;

    expect(chatRepository.beforeMessageId, 'msg-100');
    expect(chatRepository.limit, 50);
    expect(state.messages.first.id, 'msg-98');
    expect(
      state.messages
          .map((message) => message.id)
          .where((id) => id == 'msg-100'),
      hasLength(1),
    );
    expect(state.oldestMessageId, 'msg-98');
    expect(state.hasMoreOlderMessages, isTrue);
  });

  test('load older stops when backend returns an empty final page', () async {
    final joinedState = bloc.stream.firstWhere(
      (state) => state.status == ChatStatus.active,
    );
    bloc.add(
      ChatRoomJoined({
        'session': {'roomId': 'room-1', 'myAlias': 'Me'},
        'messages': List.generate(
          100,
          (i) => {
            'id': 'msg-$i',
            'senderAlias': 'Me',
            'type': 'text',
            'content': 'Message $i',
            'createdAt': DateTime.utc(
              2026,
              7,
              24,
              10,
            ).add(Duration(seconds: i)).toIso8601String(),
          },
        ),
      }),
    );
    await joinedState;

    chatRepository.response = const ChatMessagesResponse();

    final loadedState = bloc.stream.firstWhere(
      (state) => !state.isLoadingOlderMessages && !state.hasMoreOlderMessages,
    );
    bloc.add(const ChatLoadOlderMessages());
    final state = await loadedState;

    expect(state.messages, hasLength(100));
    expect(state.oldestMessageId, isNull);
    expect(state.hasMoreOlderMessages, isFalse);
  });
}

class _SuccessfulRoomRepository implements RoomRepository {
  ActiveRoomResponse activeRoomResponse = const ActiveRoomResponse();

  @override
  Future<AppResult<void>> blockRoom(String roomId, String targetUserId) async {
    return const AppSuccess<void>(null);
  }

  @override
  Future<AppResult<ActiveRoomResponse>> getActiveRoom() async {
    return AppSuccess(activeRoomResponse);
  }

  @override
  Future<AppResult<void>> leaveRoom(String roomId) async {
    return const AppSuccess<void>(null);
  }
}

class _SuccessfulModerationRepository implements ModerationRepository {
  @override
  Future<AppResult<void>> reportUser({
    required String reportedUserId,
    required String roomId,
    required String reason,
    String? description,
  }) async {
    return const AppSuccess<void>(null);
  }
}

class _SuccessfulChatRepository implements ChatRepository {
  ChatMessagesResponse response = const ChatMessagesResponse();
  String? roomId;
  String? beforeMessageId;
  int? limit;

  @override
  Future<AppResult<ChatMessagesResponse>> getMessages({
    required String roomId,
    required String beforeMessageId,
    int limit = 50,
  }) async {
    this.roomId = roomId;
    this.beforeMessageId = beforeMessageId;
    this.limit = limit;
    return AppSuccess(response);
  }
}
