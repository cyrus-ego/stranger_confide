import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/response/queue_status_response.dart';

part 'matchmaking_state.freezed.dart';

enum MatchmakingStatus {
  initial,
  loadingProfile,
  idle,
  joining,
  searching,
  matched,
  timedOut,
  error,
}

@freezed
sealed class MatchmakingState with _$MatchmakingState {
  const factory MatchmakingState({
    @Default(MatchmakingStatus.initial) MatchmakingStatus status,
    QueueStatusResponse? queueData,
    @Default('any') String selectedPreference,
    @Default('') String selectedPreferredGender,
    String? errorMessage,
  }) = _MatchmakingState;
}
