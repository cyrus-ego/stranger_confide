import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';


abstract class AuthRepository {
  Future<AppResult<AuthTokens>> login({
    required String email,
    required String password,
  });
}
