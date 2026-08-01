import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/auth_tokens.dart';
import '../models/facebook_login_token.dart';
import '../repositories/auth_repository.dart';

@injectable
class FacebookLoginUseCase {
  const FacebookLoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppResult<AuthTokens>> call(FacebookLoginToken token) {
    return _repository.facebookLogin(token: token);
  }
}
