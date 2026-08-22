import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/models/response/user_dto.dart';

import '../repositories/user_repository.dart';

@injectable
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final UserRepository _repository;

  Future<AppResult<UserDto>> call() => _repository.getMe();
}
