import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/models/response/register_response.dart';

import '../repositories/auth_repository.dart';

class ResendOtpParams {
  const ResendOtpParams({required this.email});

  final String email;
}

@injectable
class ResendOtpUseCase {
  const ResendOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<AppResult<RegisterResponse>> call(ResendOtpParams params) {
    return _repository.resendOtp(email: params.email);
  }
}
