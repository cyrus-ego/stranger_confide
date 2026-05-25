// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    _ProfileResponse(
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      profile: ProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileResponseToJson(_ProfileResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'profile': instance.profile,
      'isComplete': instance.isComplete,
    };
