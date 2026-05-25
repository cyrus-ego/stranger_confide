import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
sealed class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    required String id,
    @Default('') String gender,
    @Default(0) int age,
    @Default('') String bio,
    @Default('') String avatar,
    @Default('') String chatPreference,
    @Default('') String preferredGender,
    @Default(false) bool isVip,
    String? vipExpiresAt,
    String? createdAt,
    String? updatedAt,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);
}
