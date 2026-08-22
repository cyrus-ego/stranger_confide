import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/models/response/user_dto.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import 'base_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends BaseRepository implements UserRepository {
  UserRepositoryImpl(this._remoteDatasource);

  final UserRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<UserDto>> getMe() =>
      safeApiCall(() => _remoteDatasource.getMe());
}
