// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActiveRoomResponse _$ActiveRoomResponseFromJson(Map<String, dynamic> json) =>
    _ActiveRoomResponse(
      hasActiveRoom: json['hasActiveRoom'] as bool? ?? false,
      roomId: json['roomId'] as String?,
    );

Map<String, dynamic> _$ActiveRoomResponseToJson(_ActiveRoomResponse instance) =>
    <String, dynamic>{
      'hasActiveRoom': instance.hasActiveRoom,
      'roomId': instance.roomId,
    };
