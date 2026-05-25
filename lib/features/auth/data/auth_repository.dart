import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'auth_api.dart';
import 'models/auth_tokens.dart';
import 'models/login_request.dart';

@lazySingleton
class AuthRepository {
  AuthRepository(this._api);

  final AuthApi _api;

  Future<AppResult<AuthTokens>> login({
    required String email,
    required String password,
  }) async {
    try {
      final tokens = await _api.login(
        LoginRequest(email: email, password: password),
      );
      return AppSuccess(tokens);
    } on DioException catch (e) {
      final apiError = e.error is ApiError
          ? e.error! as ApiError
          : ApiError.fromDioException(e);
      return AppFailure(apiError);
    }
  }
}
