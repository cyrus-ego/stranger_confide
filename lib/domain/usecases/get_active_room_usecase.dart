import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/response/active_room_response.dart';
import '../repositories/room_repository.dart';

@injectable
class GetActiveRoomUseCase {
  const GetActiveRoomUseCase(this._repository);

  final RoomRepository _repository;

  Future<AppResult<ActiveRoomResponse>> call() {
    return _repository.getActiveRoom();
  }
}
