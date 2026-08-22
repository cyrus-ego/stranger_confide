import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/models/response/queue_status_response.dart';

import '../repositories/matchmaking_repository.dart';

@injectable
class GetQueueStatusUseCase {
  const GetQueueStatusUseCase(this._repository);

  final MatchmakingRepository _repository;

  Future<AppResult<QueueStatusResponse>> call() {
    return _repository.getStatus();
  }
}
