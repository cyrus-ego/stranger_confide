import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';



part 'profile_remote_datasource.g.dart';

@RestApi()
abstract class ProfileRemoteDatasource {
  factory ProfileRemoteDatasource(Dio dio, {String baseUrl}) =
      _ProfileRemoteDatasource;

  @GET('/profile')
  Future<ProfileResponse> getProfile();
}
