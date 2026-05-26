import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_room_response.freezed.dart';
part 'active_room_response.g.dart';

@freezed
sealed class ActiveRoomResponse with _$ActiveRoomResponse {
  const factory ActiveRoomResponse({
    @Default(false) bool hasActiveRoom,
    String? roomId,
  }) = _ActiveRoomResponse;

  factory ActiveRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveRoomResponseFromJson(json);
}
