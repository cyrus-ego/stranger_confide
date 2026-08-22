import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:talk_first/data/models/request/join_queue_request.dart';
import 'package:talk_first/data/models/response/queue_status_response.dart';

abstract class MatchmakingRepository {
  Future<AppResult<QueueStatusResponse>> joinQueue(JoinQueueRequest request);
  Future<AppResult<void>> leaveQueue();
  Future<AppResult<QueueStatusResponse>> getStatus();
}
