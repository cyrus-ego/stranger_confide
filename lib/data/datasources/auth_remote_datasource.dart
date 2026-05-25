import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stranger_confide/data/models/request/login_request.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';


part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(Dio dio, {String baseUrl}) =
      _AuthRemoteDatasource;

  @POST('/auth/login')
  Future<AuthTokens> login(@Body() LoginRequest body);
}
