// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => _ProfileDto(
  id: json['id'] as String?,
  gender: json['gender'] as String?,
  age: (json['age'] as num?)?.toInt(),
  bio: json['bio'] as String?,
  avatar: json['avatar'] as String?,
  chatPreference: json['chatPreference'] as String?,
  offlineMatchingEnabled: json['offlineMatchingEnabled'] as bool?,
  isVip: json['isVip'] as bool?,
  vipExpiresAt: json['vipExpiresAt'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$ProfileDtoToJson(_ProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'age': instance.age,
      'bio': instance.bio,
      'avatar': instance.avatar,
      'chatPreference': instance.chatPreference,
      'offlineMatchingEnabled': instance.offlineMatchingEnabled,
      'isVip': instance.isVip,
      'vipExpiresAt': instance.vipExpiresAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
