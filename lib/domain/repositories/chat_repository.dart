import 'package:cyr_flutter_core/cyr_flutter_core.dart';

import '../../data/models/response/chat_messages_response.dart';

abstract class ChatRepository {
  Future<AppResult<ChatMessagesResponse>> getMessages({
    required String roomId,
    required String beforeMessageId,
    int limit = 50,
  });
}
