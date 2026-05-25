import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/data/auth_api.dart';
import '../../features/profile/data/profile_api.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);

  @lazySingleton
  ProfileApi profileApi(Dio dio) => ProfileApi(dio);
}
