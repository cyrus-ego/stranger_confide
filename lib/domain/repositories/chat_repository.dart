import 'package:cyr_flutter_core/cyr_flutter_core.dart';

import '../../data/models/response/chat_messages_response.dart';
import '../../data/models/response/chat_image_upload_response.dart';

abstract class ChatRepository {
  Future<AppResult<ChatImageUploadResponse>> uploadImage({
    required String roomId,
    required String filePath,
  });

  Future<AppResult<ChatMessagesResponse>> getMessages({
    required String roomId,
    required String beforeMessageId,
    int limit = 50,
  });
}
