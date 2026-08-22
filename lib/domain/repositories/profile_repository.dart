import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:talk_first/data/models/request/update_profile_request.dart';
import 'package:talk_first/data/models/response/profile_response.dart';

abstract class ProfileRepository {
  Future<AppResult<ProfileResponse>> getProfile();
  Future<AppResult<ProfileResponse>> createProfile(
    UpdateProfileRequest request,
  );
  Future<AppResult<ProfileResponse>> updateProfile(
    UpdateProfileRequest request,
  );
  Future<AppResult<ProfileResponse>> patchProfile(Map<String, dynamic> fields);
}
