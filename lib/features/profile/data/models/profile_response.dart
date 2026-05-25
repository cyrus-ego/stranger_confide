import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/data/models/user_dto.dart';
import 'profile_dto.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
sealed class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    required UserDto user,
    required ProfileDto profile,
    @Default(false) bool isComplete,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
