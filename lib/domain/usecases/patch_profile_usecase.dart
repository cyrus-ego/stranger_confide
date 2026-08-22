import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/models/response/profile_response.dart';

import '../repositories/profile_repository.dart';

@injectable
class PatchProfileUseCase {
  const PatchProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<AppResult<ProfileResponse>> call(Map<String, dynamic> fields) {
    return _repository.patchProfile(fields);
  }
}
