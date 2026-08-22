import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:talk_first/data/models/request/update_profile_request.dart';
import 'package:talk_first/data/models/response/profile_response.dart';

part 'profile_remote_datasource.g.dart';

@RestApi()
abstract class ProfileRemoteDatasource {
  factory ProfileRemoteDatasource(Dio dio, {String baseUrl}) =
      _ProfileRemoteDatasource;

  @GET('/profile')
  Future<ProfileResponse> getProfile();

  @POST('/profile')
  Future<ProfileResponse> createProfile(@Body() UpdateProfileRequest body);

  @PUT('/profile')
  Future<ProfileResponse> updateProfile(@Body() UpdateProfileRequest body);

  @PATCH('/profile')
  Future<ProfileResponse> patchProfile(@Body() Map<String, dynamic> body);
}
