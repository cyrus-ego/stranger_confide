import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/chat_messages_response.dart';
import '../repositories/chat_repository.dart';

@injectable
class GetChatMessagesUseCase {
  const GetChatMessagesUseCase(this._repository);

  final ChatRepository _repository;

  Future<AppResult<ChatMessagesResponse>> call({
    required String roomId,
    required String beforeMessageId,
    int limit = 50,
  }) {
    return _repository.getMessages(
      roomId: roomId,
      beforeMessageId: beforeMessageId,
      limit: limit,
    );
  }
}
