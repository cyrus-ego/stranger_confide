import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_status_response.freezed.dart';
part 'queue_status_response.g.dart';

@freezed
sealed class QueueStatusResponse with _$QueueStatusResponse {
  const factory QueueStatusResponse({
    @Default(false) bool inQueue,
    @Default(0) int position,
    @Default(0) int queueSize,
    @Default(0) int waitSeconds,
    @Default(0) int expiresInSeconds,
    @Default('') String preference,
    @Default('') String preferredGender,
    @Default(false) bool timedOut,
    String? roomId,
    String? partnerId,
  }) = _QueueStatusResponse;

  factory QueueStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusResponseFromJson(json);
}
