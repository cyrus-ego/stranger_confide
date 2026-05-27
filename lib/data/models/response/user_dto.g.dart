// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: json['id'] as String?,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  avatar: json['avatar'] as String?,
  gender: json['gender'] as String?,
  role: json['role'] as String?,
  provider: json['provider'] as String?,
  isEmailVerified: json['isEmailVerified'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'displayName': instance.displayName,
  'avatar': instance.avatar,
  'gender': instance.gender,
  'role': instance.role,
  'provider': instance.provider,
  'isEmailVerified': instance.isEmailVerified,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
