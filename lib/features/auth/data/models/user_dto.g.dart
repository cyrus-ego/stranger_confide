// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  avatar: json['avatar'] as String? ?? '',
  role: json['role'] as String? ?? 'user',
  isEmailVerified: json['isEmailVerified'] as bool? ?? false,
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'displayName': instance.displayName,
  'avatar': instance.avatar,
  'role': instance.role,
  'isEmailVerified': instance.isEmailVerified,
};
