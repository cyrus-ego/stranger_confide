import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:talk_first/data/models/response/chat_messages_response.dart';

import '../models/response/chat_image_upload_response.dart';

part 'chat_remote_datasource.g.dart';

@RestApi()
abstract class ChatRemoteDatasource {
  factory ChatRemoteDatasource(Dio dio, {String baseUrl}) =
      _ChatRemoteDatasource;

  @GET('/chat/{roomId}/messages')
  Future<ChatMessagesResponse> getMessages(
    @Path('roomId') String roomId,
    @Query('beforeMessageId') String beforeMessageId,
    @Query('limit') int limit,
  );

  @MultiPart()
  @POST('/chat/{roomId}/image')
  Future<ChatImageUploadResponse> uploadImage(
    @Path('roomId') String roomId,
    @Part(name: 'image') MultipartFile image,
  );
}
