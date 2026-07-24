import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stranger_confide/data/models/response/chat_message_dto.dart';

part 'chat_messages_response.freezed.dart';
part 'chat_messages_response.g.dart';

@freezed
sealed class ChatMessagesResponse with _$ChatMessagesResponse {
  const factory ChatMessagesResponse({
    @Default([]) List<ChatMessageDto> messages,
    String? nextBeforeMessageId,
    @Default(false) bool hasMore,
  }) = _ChatMessagesResponse;

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagesResponseFromJson(json);
}
