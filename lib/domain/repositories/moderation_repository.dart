import 'package:cyr_flutter_core/cyr_flutter_core.dart';

abstract class ModerationRepository {
  Future<AppResult<void>> reportUser({
    required String reportedUserId,
    required String roomId,
    required String reason,
    String? description,
  });
}
