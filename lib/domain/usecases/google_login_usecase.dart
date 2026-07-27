import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';

import '../repositories/auth_repository.dart';

@injectable
class GoogleLoginUseCase {
  const GoogleLoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppResult<AuthTokens>> call(String idToken) {
    return _repository.googleLogin(idToken: idToken);
  }
}
