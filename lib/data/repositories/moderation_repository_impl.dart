import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/moderation_repository.dart';
import '../datasources/moderation_remote_datasource.dart';
import 'base_repository.dart';

@LazySingleton(as: ModerationRepository)
class ModerationRepositoryImpl extends BaseRepository
    implements ModerationRepository {
  ModerationRepositoryImpl(this._remoteDatasource);

  final ModerationRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<void>> reportUser({
    required String reportedUserId,
    required String roomId,
    required String reason,
    String? description,
  }) async {
    try {
      await _remoteDatasource.reportUser({
        'reportedUserId': reportedUserId,
        'roomId': roomId,
        'reason': reason,
        if (description != null && description.isNotEmpty)
          'description': description,
      });
      return AppSuccess(null);
    } on DioException catch (e) {
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }
}
