import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/models/request/join_queue_request.dart';
import 'package:talk_first/data/models/response/queue_status_response.dart';

import '../repositories/matchmaking_repository.dart';

@injectable
class JoinQueueUseCase {
  const JoinQueueUseCase(this._repository);

  final MatchmakingRepository _repository;

  Future<AppResult<QueueStatusResponse>> call(JoinQueueRequest request) {
    return _repository.joinQueue(request);
  }
}
