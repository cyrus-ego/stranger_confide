import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../repositories/room_repository.dart';

@injectable
class LeaveRoomUseCase {
  const LeaveRoomUseCase(this._repository);

  final RoomRepository _repository;

  Future<AppResult<void>> call(String roomId) {
    return _repository.leaveRoom(roomId);
  }
}
