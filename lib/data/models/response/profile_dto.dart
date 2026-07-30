import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
sealed class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    String? id,
    String? gender,
    int? age,
    String? bio,
    String? avatar,
    String? chatPreference,
    bool? offlineMatchingEnabled,
    bool? isVip,
    String? vipExpiresAt,
    String? createdAt,
    String? updatedAt,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
