import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_auth_request.freezed.dart';
part 'google_auth_request.g.dart';

@freezed
sealed class GoogleAuthRequest with _$GoogleAuthRequest {
  const factory GoogleAuthRequest({required String idToken}) =
      _GoogleAuthRequest;

  factory GoogleAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthRequestFromJson(json);
}
