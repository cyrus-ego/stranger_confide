import 'dart:async';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stranger_confide/data/datasources/matchmaking_socket_service.dart';
import 'package:stranger_confide/data/models/request/join_queue_request.dart';
import 'package:stranger_confide/data/models/request/update_profile_request.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';
import 'package:stranger_confide/data/models/response/profile_dto.dart';
import 'package:stranger_confide/data/models/response/queue_status_response.dart';
import 'package:stranger_confide/data/models/response/active_room_response.dart';
import 'package:stranger_confide/domain/repositories/matchmaking_repository.dart';
import 'package:stranger_confide/domain/repositories/profile_repository.dart';
import 'package:stranger_confide/domain/repositories/room_repository.dart';
import 'package:stranger_confide/domain/usecases/get_active_room_usecase.dart';
import 'package:stranger_confide/domain/usecases/get_profile_usecase.dart';
import 'package:stranger_confide/domain/usecases/get_queue_status_usecase.dart';
import 'package:stranger_confide/domain/usecases/join_queue_usecase.dart';
import 'package:stranger_confide/domain/usecases/leave_queue_usecase.dart';
import 'package:stranger_confide/domain/usecases/patch_profile_usecase.dart';
import 'package:stranger_confide/features/matchmaking/bloc/matchmaking_bloc.dart';
import 'package:stranger_confide/features/matchmaking/bloc/matchmaking_event.dart';
import 'package:stranger_confide/features/matchmaking/bloc/matchmaking_state.dart';

void main() {
  late _FakeMatchmakingRepository matchmakingRepository;
  late _FakeSocketService socketService;
  late _FakeRoomRepository roomRepository;
  late _FakeProfileRepository profileRepository;
  late MatchmakingBloc bloc;

  setUp(() {
    matchmakingRepository = _FakeMatchmakingRepository();
    socketService = _FakeSocketService();
    roomRepository = _FakeRoomRepository();
    profileRepository = _FakeProfileRepository();
    bloc = MatchmakingBloc(
      JoinQueueUseCase(matchmakingRepository),
      LeaveQueueUseCase(matchmakingRepository),
      GetProfileUseCase(profileRepository),
      GetActiveRoomUseCase(roomRepository),
      GetQueueStatusUseCase(matchmakingRepository),
      PatchProfileUseCase(profileRepository),
      socketService,
    );
  });

  tearDown(() async {
    await bloc.close();
    socketService.dispose();
  });

  test('ticks local queue countdown between server updates', () async {
    matchmakingRepository.joinResponse = const QueueStatusResponse(
      inQueue: true,
      position: 1,
      queueSize: 2,
      waitSeconds: 10,
      expiresInSeconds: 3,
      preference: 'female',
      timedOut: false,
    );

    final expectation = expectLater(
      bloc.stream,
      emitsThrough(
        isA<MatchmakingState>()
            .having((state) => state.localWaitSeconds, 'localWaitSeconds', 11)
            .having(
              (state) => state.localExpiresInSeconds,
              'localExpiresInSeconds',
              2,
            ),
      ),
    );

    bloc.add(const MatchmakingJoinQueue());

    await expectation.timeout(const Duration(seconds: 3));
    expect(socketService.connectCount, 1);
  });

  test(
    'confirms timeout with backend when local countdown reaches zero',
    () async {
      matchmakingRepository.joinResponse = const QueueStatusResponse(
        inQueue: true,
        position: 1,
        queueSize: 1,
        waitSeconds: 299,
        expiresInSeconds: 1,
        preference: 'female',
        timedOut: false,
      );
      matchmakingRepository.statusResponse = const QueueStatusResponse(
        inQueue: false,
        position: 0,
        queueSize: 0,
        waitSeconds: 300,
        expiresInSeconds: 0,
        preference: 'female',
        timedOut: true,
      );

      final expectation = expectLater(
        bloc.stream,
        emitsThrough(
          isA<MatchmakingState>()
              .having(
                (state) => state.status,
                'status',
                MatchmakingStatus.timedOut,
              )
              .having(
                (state) => state.localExpiresInSeconds,
                'localExpiresInSeconds',
                0,
              ),
        ),
      );

      bloc.add(const MatchmakingJoinQueue());

      await expectation.timeout(const Duration(seconds: 3));
      expect(matchmakingRepository.getStatusCount, 1);
      expect(socketService.disconnectCount, 1);
    },
  );

  test(
    'disconnect stops searching because backend removes the queue entry',
    () async {
      matchmakingRepository.joinResponse = const QueueStatusResponse(
        inQueue: true,
        waitSeconds: 5,
        expiresInSeconds: 295,
      );

      final searchingState = bloc.stream.firstWhere(
        (state) => state.status == MatchmakingStatus.searching,
      );
      bloc.add(const MatchmakingJoinQueue());
      await searchingState;

      final idleState = bloc.stream.firstWhere(
        (state) => state.status == MatchmakingStatus.idle,
      );
      socketService.addEvent(SocketDisconnected('transport close'));
      final state = await idleState;

      expect(state.queueData, isNull);
      expect(state.localExpiresInSeconds, 0);
      expect(socketService.connectCount, 1);
    },
  );

  test('resume restores an active room before touching the queue', () async {
    roomRepository.activeRoomResponse = const ActiveRoomResponse(
      hasActiveRoom: true,
      roomId: 'room-restored',
    );

    final matchedState = bloc.stream.firstWhere(
      (state) => state.status == MatchmakingStatus.matched,
    );
    bloc.add(const MatchmakingAppResumed());
    final state = await matchedState;

    expect(state.roomId, 'room-restored');
    expect(matchmakingRepository.getStatusCount, 0);
    expect(socketService.connectCount, 0);
  });

  test('updates offline matching preference through the profile API', () async {
    final updatedState = bloc.stream.firstWhere(
      (state) =>
          !state.offlineMatchingEnabled && !state.isUpdatingOfflineMatching,
    );

    bloc.add(const MatchmakingOfflineMatchingChanged(false));
    final state = await updatedState;

    expect(state.offlineMatchingEnabled, isFalse);
    expect(profileRepository.lastPatchedFields, {
      'offlineMatchingEnabled': false,
    });
  });
}

class _FakeRoomRepository implements RoomRepository {
  ActiveRoomResponse activeRoomResponse = const ActiveRoomResponse();

  @override
  Future<AppResult<ActiveRoomResponse>> getActiveRoom() async {
    return AppSuccess(activeRoomResponse);
  }

  @override
  Future<AppResult<void>> leaveRoom(String roomId) async {
    return const AppSuccess(null);
  }
}

class _FakeMatchmakingRepository implements MatchmakingRepository {
  QueueStatusResponse joinResponse = const QueueStatusResponse();
  QueueStatusResponse statusResponse = const QueueStatusResponse();
  int getStatusCount = 0;

  @override
  Future<AppResult<QueueStatusResponse>> joinQueue(
    JoinQueueRequest request,
  ) async {
    return AppSuccess(joinResponse);
  }

  @override
  Future<AppResult<void>> leaveQueue() async {
    return AppSuccess(null);
  }

  @override
  Future<AppResult<QueueStatusResponse>> getStatus() async {
    getStatusCount++;
    return AppSuccess(statusResponse);
  }
}

class _FakeProfileRepository implements ProfileRepository {
  Map<String, dynamic>? lastPatchedFields;

  @override
  Future<AppResult<ProfileResponse>> getProfile() async {
    return const AppSuccess(ProfileResponse());
  }

  @override
  Future<AppResult<ProfileResponse>> createProfile(
    UpdateProfileRequest request,
  ) async {
    return const AppSuccess(ProfileResponse());
  }

  @override
  Future<AppResult<ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    return const AppSuccess(ProfileResponse());
  }

  @override
  Future<AppResult<ProfileResponse>> patchProfile(
    Map<String, dynamic> fields,
  ) async {
    lastPatchedFields = fields;
    return AppSuccess(
      ProfileResponse(
        profile: ProfileDto(
          offlineMatchingEnabled:
              fields['offlineMatchingEnabled'] as bool? ?? true,
        ),
      ),
    );
  }
}

class _FakeSocketService implements MatchmakingSocketService {
  final _events = StreamController<MatchmakingSocketEvent>.broadcast();
  int connectCount = 0;
  int disconnectCount = 0;
  int emitQueueLeaveCount = 0;
  int emitQueueSyncCount = 0;
  int emitQueueVisibilityCount = 0;

  @override
  Stream<MatchmakingSocketEvent> get events => _events.stream;

  void addEvent(MatchmakingSocketEvent event) => _events.add(event);

  @override
  bool get isConnected => connectCount > disconnectCount;

  @override
  void connect() {
    connectCount++;
    _events.add(SocketConnected());
  }

  @override
  void disconnect() {
    disconnectCount++;
  }

  @override
  void emitQueueLeave() {
    emitQueueLeaveCount++;
  }

  @override
  void emitQueueSync() {
    emitQueueSyncCount++;
  }

  @override
  void emitQueueVisibility(bool visible) {
    emitQueueVisibilityCount++;
  }

  @override
  void dispose() {
    _events.close();
  }
}
