import 'dart:async';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/datasources/matchmaking_socket_service.dart';
import '../../../data/models/request/join_queue_request.dart';
import '../../../domain/usecases/get_profile_usecase.dart';
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
    this._socketService,
  ) : super(const MatchmakingState()) {
    on<MatchmakingStarted>(_onStarted);
    on<MatchmakingJoinQueue>(_onJoinQueue);
    on<MatchmakingLeaveQueue>(_onLeaveQueue);
    on<MatchmakingUpdatePreference>(_onUpdatePreference);
    on<MatchmakingUpdatePreferredGender>(_onUpdatePreferredGender);

    on<MatchmakingSocketConnected>(_onSocketConnected);
    on<MatchmakingQueueJoined>(_onQueueJoined);
    on<MatchmakingPositionUpdated>(_onPositionUpdated);
    on<MatchmakingMatchFound>(_onMatchFound);
    on<MatchmakingQueueTimeout>(_onQueueTimeout);
    on<MatchmakingSocketError>(_onSocketError);
    on<MatchmakingSocketDisconnected>(_onSocketDisconnected);
  }

  final JoinQueueUseCase _joinQueueUseCase;
  final LeaveQueueUseCase _leaveQueueUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final MatchmakingSocketService _socketService;

  StreamSubscription<MatchmakingSocketEvent>? _socketSub;

  Future<void> _onStarted(
    MatchmakingStarted event,
    Emitter<MatchmakingState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: MatchmakingStatus.loadingProfile));

        final profile = (await _getProfileUseCase()).orThrow(
          (_) => emit(state.copyWith(status: MatchmakingStatus.error)),
        );

        final pref = profile.profile?.chatPreference ?? '';
        final gender = profile.profile?.preferredGender ?? '';

        emit(state.copyWith(
          status: MatchmakingStatus.idle,
          selectedPreference: pref.isEmpty ? 'any' : pref,
          selectedPreferredGender: gender,
        ));
      });

  Future<void> _onJoinQueue(
    MatchmakingJoinQueue event,
    Emitter<MatchmakingState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: MatchmakingStatus.joining));

        final request = JoinQueueRequest(
          preference: state.selectedPreference,
          preferredGender: state.selectedPreferredGender.isEmpty
              ? null
              : state.selectedPreferredGender,
        );

        final result = await _joinQueueUseCase(request);

        switch (result) {
          case AppSuccess(:final value):
            if (value.timedOut == true) {
              emit(state.copyWith(
                status: MatchmakingStatus.timedOut,
                queueData: value,
              ));
              return;
            }

            emit(state.copyWith(
              status: MatchmakingStatus.searching,
              queueData: value,
            ));

            _connectSocket();

          case AppFailure(:final error):
            final code = error.apiCode;
            if (code == ApiCode.matchmakingAlreadyInQueue) {
              emit(state.copyWith(status: MatchmakingStatus.searching));
              _connectSocket();
              return;
            }
            if (code == ApiCode.profileNotFound ||
                code == ApiCode.profileIncomplete) {
              emit(state.copyWith(
                status: MatchmakingStatus.profileRequired,
                errorMessage: error.message,
              ));
              return;
            }
            throw error;
        }
      });

  Future<void> _onLeaveQueue(
    MatchmakingLeaveQueue event,
    Emitter<MatchmakingState> emit,
  ) =>
      guard(() async {
        _socketService.emitQueueLeave();
        _disconnectSocket();
        await _leaveQueueUseCase();
        emit(state.copyWith(
          status: MatchmakingStatus.idle,
          queueData: null,
          roomId: null,
          partnerId: null,
        ));
      });

  void _onUpdatePreference(
    MatchmakingUpdatePreference event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(state.copyWith(selectedPreference: event.preference));
  }

  void _onUpdatePreferredGender(
    MatchmakingUpdatePreferredGender event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(state.copyWith(selectedPreferredGender: event.gender));
  }

  // ── Socket event handlers ──

  void _onSocketConnected(
    MatchmakingSocketConnected event,
    Emitter<MatchmakingState> emit,
  ) {
    _socketService.emitQueueSync();
  }

  void _onQueueJoined(
    MatchmakingQueueJoined event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(state.copyWith(
      status: MatchmakingStatus.searching,
      queueData: event.data,
    ));
  }

  void _onPositionUpdated(
    MatchmakingPositionUpdated event,
    Emitter<MatchmakingState> emit,
  ) {
    emit(state.copyWith(queueData: event.data));
  }

  void _onMatchFound(
    MatchmakingMatchFound event,
    Emitter<MatchmakingState> emit,
  ) {
    _disconnectSocket();
    emit(state.copyWith(
      status: MatchmakingStatus.matched,
      roomId: event.roomId,
      partnerId: event.partnerId,
    ));
  }

  void _onQueueTimeout(
    MatchmakingQueueTimeout event,
    Emitter<MatchmakingState> emit,
  ) {
    _disconnectSocket();
    emit(state.copyWith(
      status: MatchmakingStatus.timedOut,
      queueData: null,
    ));
  }

  void _onSocketError(
    MatchmakingSocketError event,
    Emitter<MatchmakingState> emit,
  ) {
    if (state.status == MatchmakingStatus.searching) return;
    emit(state.copyWith(
      status: MatchmakingStatus.error,
      errorMessage: event.message,
    ));
  }

  void _onSocketDisconnected(
    MatchmakingSocketDisconnected event,
    Emitter<MatchmakingState> emit,
  ) {
    if (state.status == MatchmakingStatus.searching) {
      _socketService.connect();
    }
  }

  // ── Socket management ──

  void _connectSocket() {
    _socketSub?.cancel();
    _socketSub = _socketService.events.listen(_mapSocketEvent);
    _socketService.connect();
  }

  void _disconnectSocket() {
    _socketSub?.cancel();
    _socketSub = null;
    _socketService.disconnect();
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
