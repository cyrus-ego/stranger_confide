import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:stranger_confide/data/models/response/user_dto.dart';

abstract class UserRepository {
  Future<AppResult<UserDto>> getMe();
}
