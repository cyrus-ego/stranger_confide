import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/room_repository.dart';

@injectable
class BlockRoomUseCase {
  const BlockRoomUseCase(this._repository);

  final RoomRepository _repository;

  Future<AppResult<void>> call(String roomId, String targetUserId) {
    return _repository.blockRoom(roomId, targetUserId);
  }
}
