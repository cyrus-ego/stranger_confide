import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'models/profile_response.dart';
import 'profile_api.dart';

@lazySingleton
class ProfileRepository {
  ProfileRepository(this._api);

  final ProfileApi _api;

  Future<AppResult<ProfileResponse>> getProfile() async {
    try {
      final response = await _api.getProfile();
      return AppSuccess(response);
    } on DioException catch (e) {
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }
}
