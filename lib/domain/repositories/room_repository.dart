import 'package:cyr_flutter_core/cyr_flutter_core.dart';

import '../../data/models/response/active_room_response.dart';

abstract class RoomRepository {
  Future<AppResult<ActiveRoomResponse>> getActiveRoom();
  Future<AppResult<void>> leaveRoom(String roomId);
  Future<AppResult<void>> blockRoom(String roomId, String targetUserId);
}
