import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stranger_confide/data/models/request/login_request.dart';
import 'package:stranger_confide/data/models/request/register_request.dart';
import 'package:stranger_confide/data/models/request/resend_otp_request.dart';
import 'package:stranger_confide/data/models/request/verify_email_request.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';
import 'package:stranger_confide/data/models/response/register_response.dart';

part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(Dio dio, {String baseUrl}) =
      _AuthRemoteDatasource;

  @POST('/auth/login')
  Future<AuthTokens> login(@Body() LoginRequest body);

  @POST('/auth/refresh')
  Future<AuthTokens> refresh(@Body() Map<String, dynamic> body);

  @POST('/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest body);

  @POST('/auth/verify-email')
  Future<RegisterResponse> verifyEmail(@Body() VerifyEmailRequest body);

  @POST('/auth/resend-otp')
  Future<RegisterResponse> resendOtp(@Body() ResendOtpRequest body);
}
