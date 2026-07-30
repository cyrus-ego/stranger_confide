// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequest(
  displayName: json['displayName'] as String,
  gender: json['gender'] as String,
  age: (json['age'] as num).toInt(),
  bio: json['bio'] as String,
  chatPreference: json['chatPreference'] as String,
  offlineMatchingEnabled: json['offlineMatchingEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  _UpdateProfileRequest instance,
) => <String, dynamic>{
  'displayName': instance.displayName,
  'gender': instance.gender,
  'age': instance.age,
  'bio': instance.bio,
  'chatPreference': instance.chatPreference,
  'offlineMatchingEnabled': instance.offlineMatchingEnabled,
};
