import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'moderation_remote_datasource.g.dart';

@RestApi()
abstract class ModerationRemoteDatasource {
  factory ModerationRemoteDatasource(Dio dio, {String baseUrl}) =
      _ModerationRemoteDatasource;

  @POST('/moderation/report')
  Future<dynamic> reportUser(@Body() Map<String, dynamic> body);
}
