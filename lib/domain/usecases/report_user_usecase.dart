import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/moderation_repository.dart';

@injectable
class ReportUserUseCase {
  const ReportUserUseCase(this._repository);

  final ModerationRepository _repository;

  Future<AppResult<void>> call({
    required String reportedUserId,
    required String roomId,
    required String reason,
    String? description,
  }) {
    return _repository.reportUser(
      reportedUserId: reportedUserId,
      roomId: roomId,
      reason: reason,
      description: description,
    );
  }
}
