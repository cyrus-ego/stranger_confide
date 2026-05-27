import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/models/request/update_profile_request.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';

import '../repositories/profile_repository.dart';

@injectable
class CreateProfileUseCase {
  const CreateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<AppResult<ProfileResponse>> call(UpdateProfileRequest request) {
    return _repository.createProfile(request);
  }
}
