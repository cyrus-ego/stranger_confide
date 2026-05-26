import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/response/user_dto.dart';

import 'profile_dto.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
sealed class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    UserDto? user,
    ProfileDto? profile,
    bool? isComplete,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
