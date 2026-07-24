import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stranger_confide/core/token_storage.dart';
import 'package:stranger_confide/data/models/response/active_room_response.dart';
import 'package:stranger_confide/domain/repositories/moderation_repository.dart';
import 'package:stranger_confide/domain/repositories/room_repository.dart';
import 'package:stranger_confide/domain/usecases/block_room_usecase.dart';
import 'package:stranger_confide/domain/usecases/leave_room_usecase.dart';
import 'package:stranger_confide/domain/usecases/report_user_usecase.dart';
import 'package:stranger_confide/features/chat/bloc/chat_bloc.dart';
import 'package:stranger_confide/features/chat/bloc/chat_event.dart';
import 'package:stranger_confide/features/chat/bloc/chat_state.dart';

void main() {
  late ChatBloc bloc;

  setUp(() {
    final roomRepository = _SuccessfulRoomRepository();
    bloc = ChatBloc(
      TokenStorage(),
      LeaveRoomUseCase(roomRepository),
      BlockRoomUseCase(roomRepository),
      ReportUserUseCase(_SuccessfulModerationRepository()),
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
        'session': {
          'partnerOnline': true,
        },
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
}

class _SuccessfulRoomRepository implements RoomRepository {
  @override
  Future<AppResult<void>> blockRoom(String roomId, String targetUserId) async {
    return const AppSuccess<void>(null);
  }

  @override
  Future<AppResult<ActiveRoomResponse>> getActiveRoom() async {
    return const AppSuccess(ActiveRoomResponse());
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
