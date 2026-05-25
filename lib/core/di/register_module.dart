import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/datasources/profile_remote_datasource.dart';

import '../../data/datasources/auth_remote_datasource.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AuthRemoteDatasource authRemoteDatasource(Dio dio) =>
      AuthRemoteDatasource(dio);

  @lazySingleton
  ProfileRemoteDatasource profileRemoteDatasource(Dio dio) =>
      ProfileRemoteDatasource(dio);
}
