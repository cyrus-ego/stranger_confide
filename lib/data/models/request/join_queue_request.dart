import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_queue_request.freezed.dart';
part 'join_queue_request.g.dart';

@freezed
sealed class JoinQueueRequest with _$JoinQueueRequest {
  const factory JoinQueueRequest({
    required String preference,
    String? preferredGender,
  }) = _JoinQueueRequest;

  factory JoinQueueRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinQueueRequestFromJson(json);
}
