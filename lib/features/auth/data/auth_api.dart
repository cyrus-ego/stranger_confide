import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/auth_tokens.dart';
import 'models/login_request.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<AuthTokens> login(@Body() LoginRequest body);
}
