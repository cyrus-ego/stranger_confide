import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/chat_image_upload_response.dart';
import '../repositories/chat_repository.dart';

@injectable
class UploadChatImageUseCase {
  const UploadChatImageUseCase(this._repository);

  final ChatRepository _repository;

  Future<AppResult<ChatImageUploadResponse>> call({
    required String roomId,
    required String filePath,
  }) {
    return _repository.uploadImage(roomId: roomId, filePath: filePath);
  }
}
