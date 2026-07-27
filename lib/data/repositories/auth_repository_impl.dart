import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/models/request/google_auth_request.dart';
import 'package:stranger_confide/data/models/request/login_request.dart';
import 'package:stranger_confide/data/models/request/register_request.dart';
import 'package:stranger_confide/data/models/request/resend_otp_request.dart';
import 'package:stranger_confide/data/models/request/verify_email_request.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';
import 'package:stranger_confide/data/models/response/register_response.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import 'base_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._remoteDatasource);

  final AuthRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<AuthTokens>> login({
    required String email,
    required String password,
  }) => safeApiCall(
    () =>
        _remoteDatasource.login(LoginRequest(email: email, password: password)),
    onError: (e) => AppFailure(ApiError.fromDioException(e)),
  );

  @override
  Future<AppResult<AuthTokens>> googleLogin({required String idToken}) =>
      safeApiCall(
        () => _remoteDatasource.googleLogin(
          GoogleAuthRequest(idToken: idToken),
        ),
        onError: (e) => AppFailure(ApiError.fromDioException(e)),
      );

  @override
  Future<AppResult<RegisterResponse>> register({
    required String email,
    required String password,
    required String displayName,
    required String gender,
  }) => safeApiCall(
    () => _remoteDatasource.register(
      RegisterRequest(
        email: email,
        password: password,
        displayName: displayName,
        gender: gender,
      ),
    ),
  );

  @override
  Future<AppResult<RegisterResponse>> verifyEmail({
    required String email,
    required String otp,
  }) => safeApiCall(
    () => _remoteDatasource.verifyEmail(
      VerifyEmailRequest(email: email, otp: otp),
    ),
  );

  @override
  Future<AppResult<RegisterResponse>> resendOtp({
    required String email,
  }) => safeApiCall(
    () => _remoteDatasource.resendOtp(ResendOtpRequest(email: email)),
  );
}
