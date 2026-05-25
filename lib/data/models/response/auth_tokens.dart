import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/response/user_dto.dart';


part 'auth_tokens.freezed.dart';
part 'auth_tokens.g.dart';

@freezed
sealed class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
    required UserDto user,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}
