import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/models/response/register_response.dart';

import '../repositories/auth_repository.dart';

class VerifyEmailParams {
  const VerifyEmailParams({
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;
}

@injectable
class VerifyEmailUseCase {
  const VerifyEmailUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppResult<RegisterResponse>> call(VerifyEmailParams params) {
    return _repository.verifyEmail(
      email: params.email,
      otp: params.otp,
    );
  }
}
