import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_message_dto.dart';

part 'chat_image_upload_response.freezed.dart';
part 'chat_image_upload_response.g.dart';

@freezed
sealed class ChatImageUploadResponse with _$ChatImageUploadResponse {
  const factory ChatImageUploadResponse({required ChatMessageDto message}) =
      _ChatImageUploadResponse;

  factory ChatImageUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatImageUploadResponseFromJson(json);
}
