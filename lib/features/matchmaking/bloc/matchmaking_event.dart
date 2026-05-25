import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'matchmaking_event.freezed.dart';

@freezed
sealed class MatchmakingEvent extends BlocEvent with _$MatchmakingEvent {
  const MatchmakingEvent._();

  const factory MatchmakingEvent.started() = MatchmakingStarted;
  const factory MatchmakingEvent.joinQueue() = MatchmakingJoinQueue;
  const factory MatchmakingEvent.leaveQueue() = MatchmakingLeaveQueue;
  const factory MatchmakingEvent.pollStatus() = MatchmakingPollStatus;
  const factory MatchmakingEvent.updatePreference(String preference) =
      MatchmakingUpdatePreference;
  const factory MatchmakingEvent.updatePreferredGender(String gender) =
      MatchmakingUpdatePreferredGender;
}
