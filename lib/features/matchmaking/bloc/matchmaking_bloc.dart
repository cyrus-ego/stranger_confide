import 'dart:async';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/matchmaking_socket_service.dart';
import '../../../data/models/request/join_queue_request.dart';
import '../../../domain/enums/chat_preference.dart';
import '../../../domain/usecases/get_active_room_usecase.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
import '../../../domain/usecases/get_queue_status_usecase.dart';
import '../../../domain/usecases/join_queue_usecase.dart';
import '../../../domain/usecases/leave_queue_usecase.dart';
import 'matchmaking_event.dart';
import 'matchmaking_state.dart';

@injectable
class MatchmakingBloc extends AppBloc<MatchmakingEvent, MatchmakingState> {
  MatchmakingBloc(
    this._joinQueueUseCase,
    this._leaveQueueUseCase,
    this._getProfileUseCase,
    this._getActiveRoomUseCase,
    this._getQueueStatusUseCase,
    this._socketService,
  ) : super(const MatchmakingState()) {
    on<MatchmakingStarted>(_onStarted);
    on<MatchmakingJoinQueue>(_onJoinQueue);
    on<MatchmakingLeaveQueue>(_onLeaveQueue);
    on<MatchmakingUpdatePreference>(_onUpdatePreference);
    on<MatchmakingRestartSearch>(_onRestartSearch);
    on<MatchmakingQueueTimerTick>(_onQueueTimerTick);
    on<MatchmakingAppResumed>(_onAppResumed);
    on<MatchmakingVisibilityChanged>(_onVisibilityChanged);

    on<MatchmakingSocketConnected>(_onSocketConnected);
    on<MatchmakingQueueJoined>(_onQueueJoined);
    on<MatchmakingPositionUpdated>(_onPositionUpdated);
    on<MatchmakingMatchFound>(_onMatchFound);
    on<MatchmakingQueueTimeout>(_onQueueTimeout);
    on<MatchmakingQueueLeft>(_onQueueLeft);
    on<MatchmakingSocketError>(_onSocketError);
    on<MatchmakingSocketDisconnected>(_onSocketDisconnected);
  }

  final JoinQueueUseCase _joinQueueUseCase;
  final LeaveQueueUseCase _leaveQueueUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final GetActiveRoomUseCase _getActiveRoomUseCase;
  final GetQueueStatusUseCase _getQueueStatusUseCase;
  final MatchmakingSocketService _socketService;

  StreamSubscription<MatchmakingSocketEvent>? _socketSub;
  Timer? _queueTimer;
  bool _isAppForeground = true;

  Future<void> _onStarted(
    MatchmakingStarted event,
    Emitter<MatchmakingState> emit,
  ) => guard(() async {
    emit(state.copyWith(status: MatchmakingStatus.loadingProfile));

    if (await _restoreActiveRoom(emit)) return;

    final profile = (await _getProfileUseCase()).orThrow(
      (_) => emit(state.copyWith(status: MatchmakingStatus.error)),
    );

    emit(
      state.copyWith(
        selectedPreference: ChatPreference.tryParse(
          profile.profile?.chatPreference,
        ),
      ),
    );

    add(const MatchmakingJoinQueue());
  });

  Future<void> _onAppResumed(
    MatchmakingAppResumed event,
    Emitter<MatchmakingState> emit,
  ) => guard(() async {
    if (state.status == MatchmakingStatus.matched) return;
    if (await _restoreActiveRoom(emit)) return;

    final statusResult = await _getQueueStatusUseCase();
    switch (statusResult) {
      case AppSuccess(:final value):
        if (value.inQueue == true && value.timedOut != true) {
          emit(
            state.copyWith(
              status: MatchmakingStatus.searching,
              queueData: value,
              localWaitSeconds: value.waitSeconds ?? 0,
              localExpiresInSeconds: value.expiresInSeconds ?? 0,
              errorMessage: null,
            ),
          );
          _startQueueTimer();
          if (!_socketService.isConnected) _connectSocket();
          return;
        }

        _disconnectSocket();
        emit(
          state.copyWith(
            status: value.timedOut == true
                ? MatchmakingStatus.timedOut
                : MatchmakingStatus.idle,
            queueData: value,
            localWaitSeconds: value.waitSeconds ?? 0,
            localExpiresInSeconds: 0,
          ),
        );
      case AppFailure(:final error):
        emit(
          state.copyWith(
            status: MatchmakingStatus.error,
            errorMessage: error.message,
          ),
        );
    }
  });

  void _onVisibilityChanged(
    MatchmakingVisibilityChanged event,
    Emitter<MatchmakingState> emit,
  ) {
    _isAppForeground = event.visible;
    _socketService.emitQueueVisibility(event.visible);
  }

  Future<void> _onJoinQueue(
    MatchmakingJoinQueue event,
    Emitter<MatchmakingState> emit,
  ) => guard(() async {
    emit(state.copyWith(status: MatchmakingStatus.joining));

    final request = JoinQueueRequest(
      preference: state.selectedPreference.value,
    );

    final result = await _joinQueueUseCase(request);

    switch (result) {
      case AppSuccess(:final value):
        if (value.timedOut == true) {
          _stopQueueTimer();
          emit(
            state.copyWith(
              status: MatchmakingStatus.timedOut,
              queueData: value,
              localWaitSeconds: value.waitSeconds ?? 0,
              localExpiresInSeconds: 0,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: MatchmakingStatus.searching,
            queueData: value,
            localWaitSeconds: value.waitSeconds ?? 0,
            localExpiresInSeconds: value.expiresInSeconds ?? 0,
          ),
        );
        _startQueueTimer();

        _connectSocket();

      case AppFailure(:final error):
        final code = error.apiCode;
        if (code == ApiCode.matchmakingAlreadyInQueue) {
          await _syncQueueStatusAfterAlreadyQueued(emit);
          _connectSocket();
          return;
        }
        if (code == ApiCode.profileNotFound ||
            code == ApiCode.profileIncomplete) {
          emit(
            state.copyWith(
              status: MatchmakingStatus.profileRequired,
              errorMessage: error.message,
            ),
          );
          return;
        }
        throw error;
    }
  });

  Future<void> _onLeaveQueue(
    MatchmakingLeaveQueue event,
    Emitter<MatchmakingState> emit,
  ) => guard(() async {
    _socketService.emitQueueLeave();
    _disconnectSocket();
    await _leaveQueueUseCase();
    emit(
      state.copyWith(
        status: MatchmakingStatus.idle,
        queueData: null,
        localWaitSeconds: 0,
        localExpiresInSeconds: 0,
        roomId: null,
        partnerId: null,
      ),
    );
  });

  void _onUpdatePreference(
    MatchmakingUpdatePreference event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(state.copyWith(selectedPreference: event.preference));
  }

  Future<void> _onRestartSearch(
    MatchmakingRestartSearch event,
    Emitter<MatchmakingState> emit,
  ) => guard(() async {
    _socketService.emitQueueLeave();
    _disconnectSocket();
    await _leaveQueueUseCase();
    emit(
      state.copyWith(
        queueData: null,
        localWaitSeconds: 0,
        localExpiresInSeconds: 0,
        roomId: null,
        partnerId: null,
      ),
    );
    add(const MatchmakingJoinQueue());
  });

  Future<void> _onQueueTimerTick(
    MatchmakingQueueTimerTick event,
    Emitter<MatchmakingState> emit,
  ) => guard(() async {
    if (state.status != MatchmakingStatus.searching ||
        state.queueData == null) {
      _stopQueueTimer();
      return;
    }

    final nextWaitSeconds = state.localWaitSeconds + 1;
    final nextExpiresInSeconds = state.localExpiresInSeconds > 0
        ? state.localExpiresInSeconds - 1
        : 0;

    emit(
      state.copyWith(
        localWaitSeconds: nextWaitSeconds,
        localExpiresInSeconds: nextExpiresInSeconds,
      ),
    );

    if (nextExpiresInSeconds > 0) return;

    _stopQueueTimer();
    final result = await _getQueueStatusUseCase();

    switch (result) {
      case AppSuccess(:final value):
        if (value.timedOut == true || value.inQueue != true) {
          _disconnectSocket();
          emit(
            state.copyWith(
              status: MatchmakingStatus.timedOut,
              queueData: value,
              localWaitSeconds: value.waitSeconds ?? nextWaitSeconds,
              localExpiresInSeconds: 0,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: MatchmakingStatus.searching,
            queueData: value,
            localWaitSeconds: value.waitSeconds ?? nextWaitSeconds,
            localExpiresInSeconds: value.expiresInSeconds ?? 0,
          ),
        );
        _startQueueTimer();

      case AppFailure():
        _startQueueTimer();
    }
  });

  // ── Socket event handlers ──

  void _onSocketConnected(
    MatchmakingSocketConnected event,
    Emitter<MatchmakingState> emit,
  ) {
    _socketService.emitQueueSync();
    _socketService.emitQueueVisibility(_isAppForeground);
  }

  void _onQueueJoined(
    MatchmakingQueueJoined event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(
      state.copyWith(
        status: MatchmakingStatus.searching,
        queueData: event.data,
        localWaitSeconds: event.data.waitSeconds ?? state.localWaitSeconds,
        localExpiresInSeconds:
            event.data.expiresInSeconds ?? state.localExpiresInSeconds,
      ),
    );
    _startQueueTimer();
  }

  void _onPositionUpdated(
    MatchmakingPositionUpdated event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(
      state.copyWith(
        queueData: event.data,
        localWaitSeconds: event.data.waitSeconds ?? state.localWaitSeconds,
        localExpiresInSeconds:
            event.data.expiresInSeconds ?? state.localExpiresInSeconds,
      ),
    );
    _startQueueTimer();
  }

  void _onMatchFound(
    MatchmakingMatchFound event,
    Emitter<MatchmakingState> emit,
  ) {
    _disconnectSocket();
    emit(
      state.copyWith(
        status: MatchmakingStatus.matched,
        roomId: event.roomId,
        partnerId: event.partnerId,
      ),
    );
  }

  void _onQueueTimeout(
    MatchmakingQueueTimeout event,
    Emitter<MatchmakingState> emit,
  ) {
    _disconnectSocket();
    emit(state.copyWith(status: MatchmakingStatus.timedOut, queueData: null));
  }

  void _onQueueLeft(
    MatchmakingQueueLeft event,
    Emitter<MatchmakingState> emit,
  ) {
    _disconnectSocket();
    emit(
      state.copyWith(
        status: MatchmakingStatus.idle,
        queueData: null,
        localWaitSeconds: 0,
        localExpiresInSeconds: 0,
      ),
    );
  }

  void _onSocketError(
    MatchmakingSocketError event,
    Emitter<MatchmakingState> emit,
  ) {
    _disconnectSocket();
    emit(
      state.copyWith(
        status: MatchmakingStatus.error,
        queueData: null,
        localWaitSeconds: 0,
        localExpiresInSeconds: 0,
        errorMessage: event.message,
      ),
    );
  }

  void _onSocketDisconnected(
    MatchmakingSocketDisconnected event,
    Emitter<MatchmakingState> emit,
  ) {
    if (state.status == MatchmakingStatus.searching) {
      // Backend removes the user from the queue immediately on disconnect.
      // Never keep showing a stale local "searching" state or auto-rejoin.
      _disconnectSocket();
      emit(
        state.copyWith(
          status: MatchmakingStatus.idle,
          queueData: null,
          localWaitSeconds: 0,
          localExpiresInSeconds: 0,
          errorMessage: event.reason,
        ),
      );
    }
  }

  // ── Socket management ──

  void _connectSocket() {
    _socketSub?.cancel();
    _socketSub = _socketService.events.listen(_mapSocketEvent);
    _socketService.connect();
  }

  void _disconnectSocket() {
    _stopQueueTimer();
    _socketSub?.cancel();
    _socketSub = null;
    _socketService.disconnect();
  }

  void _startQueueTimer() {
    if (state.status != MatchmakingStatus.searching ||
        state.queueData == null) {
      return;
    }
    if (_queueTimer?.isActive == true) return;

    _queueTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) add(const MatchmakingQueueTimerTick());
    });
  }

  void _stopQueueTimer() {
    _queueTimer?.cancel();
    _queueTimer = null;
  }

  Future<void> _syncQueueStatusAfterAlreadyQueued(
    Emitter<MatchmakingState> emit,
  ) async {
    final statusResult = await _getQueueStatusUseCase();

    switch (statusResult) {
      case AppSuccess(:final value):
        if (value.timedOut == true) {
          _stopQueueTimer();
          emit(
            state.copyWith(
              status: MatchmakingStatus.timedOut,
              queueData: value,
              localWaitSeconds: value.waitSeconds ?? 0,
              localExpiresInSeconds: 0,
            ),
          );
          return;
        }

        emit(
          state.copyWith(
            status: MatchmakingStatus.searching,
            queueData: value,
            localWaitSeconds: value.waitSeconds ?? 0,
            localExpiresInSeconds: value.expiresInSeconds ?? 0,
          ),
        );
        _startQueueTimer();

      case AppFailure():
        emit(state.copyWith(status: MatchmakingStatus.searching));
    }
  }

  Future<bool> _restoreActiveRoom(Emitter<MatchmakingState> emit) async {
    final roomResult = await _getActiveRoomUseCase();
    final value = roomResult.orThrow(
      (error) => emit(
        state.copyWith(
          status: MatchmakingStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
    final roomId = value.roomId;
    if (value.hasActiveRoom && roomId != null && roomId.isNotEmpty) {
      _disconnectSocket();
      emit(
        state.copyWith(
          status: MatchmakingStatus.matched,
          roomId: roomId,
          queueData: null,
          localWaitSeconds: 0,
          localExpiresInSeconds: 0,
        ),
      );
      return true;
    }
    return false;
  }

  void _mapSocketEvent(MatchmakingSocketEvent event) {
    switch (event) {
      case SocketConnected():
        add(const MatchmakingSocketConnected());
      case SocketQueueJoined(:final data):
        add(MatchmakingQueueJoined(data));
      case SocketQueuePosition(:final data):
        add(MatchmakingPositionUpdated(data));
      case SocketMatchFound(:final roomId, :final partnerId):
        add(MatchmakingMatchFound(roomId, partnerId));
      case SocketQueueTimeout():
        add(const MatchmakingQueueTimeout());
      case SocketQueueLeft():
        add(const MatchmakingQueueLeft());
      case SocketError(:final message):
        add(MatchmakingSocketError(message));
      case SocketDisconnected(:final reason):
        add(MatchmakingSocketDisconnected(reason));
    }
  }

  @override
  Future<void> close() {
    if (state.status == MatchmakingStatus.searching) {
      _socketService.emitQueueLeave();
      _leaveQueueUseCase();
    }
    _disconnectSocket();
    return super.close();
  }
}
