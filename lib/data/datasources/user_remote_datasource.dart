import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stranger_confide/data/models/response/user_dto.dart';

part 'user_remote_datasource.g.dart';

@RestApi()
abstract class UserRemoteDatasource {
  factory UserRemoteDatasource(Dio dio, {String baseUrl}) =
      _UserRemoteDatasource;

  @GET('/users/me')
  Future<UserDto> getMe();

  @POST('/users/me/fcm-tokens')
  Future<void> registerFcmToken(@Body() Map<String, dynamic> body);

  @DELETE('/users/me/fcm-tokens')
  Future<void> unregisterFcmToken(@Body() Map<String, dynamic> body);
}
