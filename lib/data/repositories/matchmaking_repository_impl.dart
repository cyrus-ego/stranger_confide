import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/datasources/matchmaking_remote_datasource.dart';
import 'package:talk_first/data/models/request/join_queue_request.dart';
import 'package:talk_first/data/models/response/queue_status_response.dart';

import '../../domain/repositories/matchmaking_repository.dart';
import 'base_repository.dart';

@LazySingleton(as: MatchmakingRepository)
class MatchmakingRepositoryImpl extends BaseRepository
    implements MatchmakingRepository {
  MatchmakingRepositoryImpl(this._remoteDatasource);

  final MatchmakingRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<QueueStatusResponse>> joinQueue(JoinQueueRequest request) =>
      safeApiCall(() => _remoteDatasource.joinQueue(request));

  @override
  Future<AppResult<void>> leaveQueue() async {
    try {
      await _remoteDatasource.leaveQueue();
      return AppSuccess(null);
    } on DioException catch (e) {
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }

  @override
  Future<AppResult<QueueStatusResponse>> getStatus() =>
      safeApiCall(() => _remoteDatasource.getStatus());
}
