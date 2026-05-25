import 'dart:async';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/request/join_queue_request.dart';
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
    this._getQueueStatusUseCase,
    this._getProfileUseCase,
  ) : super(const MatchmakingState()) {
    on<MatchmakingStarted>(_onStarted);
    on<MatchmakingJoinQueue>(_onJoinQueue);
    on<MatchmakingLeaveQueue>(_onLeaveQueue);
    on<MatchmakingPollStatus>(_onPollStatus);
    on<MatchmakingUpdatePreference>(_onUpdatePreference);
    on<MatchmakingUpdatePreferredGender>(_onUpdatePreferredGender);
  }

  final JoinQueueUseCase _joinQueueUseCase;
  final LeaveQueueUseCase _leaveQueueUseCase;
  final GetQueueStatusUseCase _getQueueStatusUseCase;
  final GetProfileUseCase _getProfileUseCase;

  Timer? _pollingTimer;

  Future<void> _onStarted(
    MatchmakingStarted event,
    Emitter<MatchmakingState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: MatchmakingStatus.loadingProfile));

        final profile = (await _getProfileUseCase()).orThrow(
          (_) => emit(state.copyWith(status: MatchmakingStatus.error)),
        );

        final pref = profile.profile.chatPreference;
        final gender = profile.profile.preferredGender;

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

        final data = (await _joinQueueUseCase(request)).orThrow(
          (_) => emit(state.copyWith(status: MatchmakingStatus.idle)),
        );

        if (data.timedOut) {
          emit(state.copyWith(
            status: MatchmakingStatus.timedOut,
            queueData: data,
          ));
          return;
        }

        emit(state.copyWith(
          status: MatchmakingStatus.searching,
          queueData: data,
        ));

        _startPolling();
      });

  Future<void> _onLeaveQueue(
    MatchmakingLeaveQueue event,
    Emitter<MatchmakingState> emit,
  ) =>
      guard(() async {
        _stopPolling();
        await _leaveQueueUseCase();
        emit(state.copyWith(
          status: MatchmakingStatus.idle,
          queueData: null,
        ));
      });

  Future<void> _onPollStatus(
    MatchmakingPollStatus event,
    Emitter<MatchmakingState> emit,
  ) =>
      guard(() async {
        final result = await _getQueueStatusUseCase();

        if (result case AppSuccess(:final value)) {
          if (value.timedOut) {
            _stopPolling();
            emit(state.copyWith(
              status: MatchmakingStatus.timedOut,
              queueData: value,
            ));
            return;
          }

          if (!value.inQueue && state.status == MatchmakingStatus.searching) {
            _stopPolling();
            emit(state.copyWith(
              status: MatchmakingStatus.matched,
              queueData: value,
            ));
            return;
          }

          emit(state.copyWith(queueData: value));
        }
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

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => add(const MatchmakingPollStatus()),
    );
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  @override
  Future<void> close() {
    _stopPolling();
    return super.close();
  }
}
