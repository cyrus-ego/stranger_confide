// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    _ProfileResponse(
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : ProfileDto.fromJson(json['profile'] as Map<String, dynamic>),
      isComplete: json['isComplete'] as bool?,
    );

Map<String, dynamic> _$ProfileResponseToJson(_ProfileResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'profile': instance.profile,
      'isComplete': instance.isComplete,
    };
