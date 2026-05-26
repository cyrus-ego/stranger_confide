import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/response/queue_status_response.dart';

part 'matchmaking_event.freezed.dart';

@freezed
sealed class MatchmakingEvent extends BlocEvent with _$MatchmakingEvent {
  const MatchmakingEvent._();

  const factory MatchmakingEvent.started() = MatchmakingStarted;
  const factory MatchmakingEvent.joinQueue() = MatchmakingJoinQueue;
  const factory MatchmakingEvent.leaveQueue() = MatchmakingLeaveQueue;
  const factory MatchmakingEvent.updatePreference(String preference) =
      MatchmakingUpdatePreference;
  const factory MatchmakingEvent.updatePreferredGender(String gender) =
      MatchmakingUpdatePreferredGender;
  const factory MatchmakingEvent.restartSearch() = MatchmakingRestartSearch;

  // Socket events
  const factory MatchmakingEvent.socketConnected() = MatchmakingSocketConnected;
  const factory MatchmakingEvent.queueJoined(QueueStatusResponse data) =
      MatchmakingQueueJoined;
  const factory MatchmakingEvent.positionUpdated(QueueStatusResponse data) =
      MatchmakingPositionUpdated;
  const factory MatchmakingEvent.matchFound(String roomId, String? partnerId) =
      MatchmakingMatchFound;
  const factory MatchmakingEvent.queueTimeout() = MatchmakingQueueTimeout;
  const factory MatchmakingEvent.socketError(String message) =
      MatchmakingSocketError;
  const factory MatchmakingEvent.socketDisconnected(String reason) =
      MatchmakingSocketDisconnected;
}
