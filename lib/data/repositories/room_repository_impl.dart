import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/room_repository.dart';
import '../datasources/room_remote_datasource.dart';
import '../models/response/active_room_response.dart';
import 'base_repository.dart';

@LazySingleton(as: RoomRepository)
class RoomRepositoryImpl extends BaseRepository implements RoomRepository {
  RoomRepositoryImpl(this._remoteDatasource);

  final RoomRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<ActiveRoomResponse>> getActiveRoom() =>
      safeApiCall(() => _remoteDatasource.getActiveRoom());

  @override
  Future<AppResult<void>> leaveRoom(String roomId) async {
    try {
      await _remoteDatasource.leaveRoom(roomId);
      return AppSuccess(null);
    } on DioException catch (e) {
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }

  @override
  Future<AppResult<void>> blockRoom(
    String roomId,
    String targetUserId,
  ) async {
    try {
      await _remoteDatasource.blockRoom(
        roomId,
        {'targetUserId': targetUserId},
      );
      return AppSuccess(null);
    } on DioException catch (e) {
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }
}
