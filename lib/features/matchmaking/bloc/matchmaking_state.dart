import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/response/queue_status_response.dart';
import 'package:stranger_confide/domain/enums/chat_preference.dart';

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
  profileRequired,
}

@freezed
sealed class MatchmakingState with _$MatchmakingState {
  const factory MatchmakingState({
    @Default(MatchmakingStatus.initial) MatchmakingStatus status,
    QueueStatusResponse? queueData,
    @Default(ChatPreference.defaultPreference)
    ChatPreference selectedPreference,
    @Default(true) bool offlineMatchingEnabled,
    @Default(false) bool isUpdatingOfflineMatching,
    @Default(0) int localWaitSeconds,
    @Default(0) int localExpiresInSeconds,
    String? errorMessage,
    String? roomId,
    String? partnerId,
  }) = _MatchmakingState;
}
