import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/matchmaking_repository.dart';

@injectable
class LeaveQueueUseCase {
  const LeaveQueueUseCase(this._repository);

  final MatchmakingRepository _repository;

  Future<AppResult<void>> call() {
    return _repository.leaveQueue();
  }
}
