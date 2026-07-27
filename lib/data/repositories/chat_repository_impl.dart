import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/response/chat_messages_response.dart';
import '../models/response/chat_image_upload_response.dart';
import 'base_repository.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl extends BaseRepository implements ChatRepository {
  ChatRepositoryImpl(this._remoteDatasource);

  final ChatRemoteDatasource _remoteDatasource;

  @override
  Future<AppResult<ChatImageUploadResponse>> uploadImage({
    required String roomId,
    required String filePath,
  }) => safeApiCall(() async {
    final image = await MultipartFile.fromFile(filePath);
    return _remoteDatasource.uploadImage(roomId, image);
  });

  @override
  Future<AppResult<ChatMessagesResponse>> getMessages({
    required String roomId,
    required String beforeMessageId,
    int limit = 50,
  }) => safeApiCall(
    () => _remoteDatasource.getMessages(roomId, beforeMessageId, limit),
  );
}
