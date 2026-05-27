import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
sealed class UserDto with _$UserDto {
  const factory UserDto({
    String? id,
    String? email,
    String? displayName,
    String? avatar,
    String? gender,
    String? role,
    String? provider,
    bool? isEmailVerified,
    String? createdAt,
    String? updatedAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
