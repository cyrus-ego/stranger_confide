import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_status_response.freezed.dart';
part 'queue_status_response.g.dart';

@freezed
sealed class QueueStatusResponse with _$QueueStatusResponse {
  const factory QueueStatusResponse({
    bool? inQueue,
    int? position,
    int? queueSize,
    int? waitSeconds,
    int? expiresInSeconds,
    String? preference,
    String? preferredGender,
    bool? timedOut,
    String? roomId,
    String? partnerId,
  }) = _QueueStatusResponse;

  factory QueueStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusResponseFromJson(json);
}
