import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';
import 'package:stranger_confide/data/models/response/register_response.dart';

abstract class AuthRepository {
  Future<AppResult<AuthTokens>> login({
    required String email,
    required String password,
  });

  Future<AppResult<RegisterResponse>> register({
    required String email,
    required String password,
    required String displayName,
    required String gender,
  });

  Future<AppResult<RegisterResponse>> verifyEmail({
    required String email,
    required String otp,
  });
}
