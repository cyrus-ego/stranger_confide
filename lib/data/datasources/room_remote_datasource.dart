import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:talk_first/data/models/response/active_room_response.dart';

part 'room_remote_datasource.g.dart';

@RestApi()
abstract class RoomRemoteDatasource {
  factory RoomRemoteDatasource(Dio dio, {String baseUrl}) =
      _RoomRemoteDatasource;

  @GET('/rooms/active')
  Future<ActiveRoomResponse> getActiveRoom();

  @POST('/rooms/{roomId}/leave')
  Future<dynamic> leaveRoom(@Path('roomId') String roomId);
}
