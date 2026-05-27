import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/models/response/register_response.dart';

import '../repositories/auth_repository.dart';

class RegisterParams {
  const RegisterParams({
    required this.email,
    required this.password,
    required this.displayName,
    required this.gender,
  });

  final String email;
  final String password;
  final String displayName;
  final String gender;
}

@injectable
class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppResult<RegisterResponse>> call(RegisterParams params) {
    return _repository.register(
      email: params.email,
      password: params.password,
      displayName: params.displayName,
      gender: params.gender,
    );
  }
}
