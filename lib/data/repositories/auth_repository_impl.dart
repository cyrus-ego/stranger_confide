import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/models/request/login_request.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import 'base_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._remoteDatasource);

  final AuthRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<AuthTokens>> login({
    required String email,
    required String password,
  }) => safeApiCall(
    () =>
        _remoteDatasource.login(LoginRequest(email: email, password: password)),
  );
}
