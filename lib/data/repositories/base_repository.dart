import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  Future<AppResult<T>> safeApiCall<T>(
    Future<T> Function() call, {
    AppResult<T> Function(DioException e)? onError,
  }) async {
    try {
      final result = await call();
      return AppSuccess(result);
    } on DioException catch (e) {
      if (onError != null) return onError(e);
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }
}
