import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:stranger_confide/data/models/request/join_queue_request.dart';
import 'package:stranger_confide/data/models/response/queue_status_response.dart';

part 'matchmaking_remote_datasource.g.dart';

@RestApi()
abstract class MatchmakingRemoteDatasource {
  factory MatchmakingRemoteDatasource(Dio dio, {String baseUrl}) =
      _MatchmakingRemoteDatasource;

  @POST('/matchmaking/join')
  Future<QueueStatusResponse> joinQueue(@Body() JoinQueueRequest body);

  @DELETE('/matchmaking/leave')
  Future<dynamic> leaveQueue();

  @GET('/matchmaking/status')
  Future<QueueStatusResponse> getStatus();
}
