import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';


abstract class ProfileRepository {
  Future<AppResult<ProfileResponse>> getProfile();
}
