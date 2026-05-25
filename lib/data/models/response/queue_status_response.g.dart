// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QueueStatusResponse _$QueueStatusResponseFromJson(Map<String, dynamic> json) =>
    _QueueStatusResponse(
      inQueue: json['inQueue'] as bool? ?? false,
      position: (json['position'] as num?)?.toInt() ?? 0,
      queueSize: (json['queueSize'] as num?)?.toInt() ?? 0,
      waitSeconds: (json['waitSeconds'] as num?)?.toInt() ?? 0,
      expiresInSeconds: (json['expiresInSeconds'] as num?)?.toInt() ?? 0,
      preference: json['preference'] as String? ?? '',
      preferredGender: json['preferredGender'] as String? ?? '',
      timedOut: json['timedOut'] as bool? ?? false,
      roomId: json['roomId'] as String?,
      partnerId: json['partnerId'] as String?,
    );

Map<String, dynamic> _$QueueStatusResponseToJson(
  _QueueStatusResponse instance,
) => <String, dynamic>{
  'inQueue': instance.inQueue,
  'position': instance.position,
  'queueSize': instance.queueSize,
  'waitSeconds': instance.waitSeconds,
  'expiresInSeconds': instance.expiresInSeconds,
  'preference': instance.preference,
  'preferredGender': instance.preferredGender,
  'timedOut': instance.timedOut,
  'roomId': instance.roomId,
  'partnerId': instance.partnerId,
};
