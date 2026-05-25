import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/profile_response.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @GET('/profile')
  Future<ProfileResponse> getProfile();
}
