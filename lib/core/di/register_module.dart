import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stranger_confide/data/datasources/matchmaking_remote_datasource.dart';
import 'package:stranger_confide/data/datasources/room_remote_datasource.dart';
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

  @lazySingleton
  MatchmakingRemoteDatasource matchmakingRemoteDatasource(Dio dio) =>
      MatchmakingRemoteDatasource(dio);

  @lazySingleton
  RoomRemoteDatasource roomRemoteDatasource(Dio dio) =>
      RoomRemoteDatasource(dio);
}
