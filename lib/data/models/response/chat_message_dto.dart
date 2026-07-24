import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_dto.freezed.dart';
part 'chat_message_dto.g.dart';

@freezed
sealed class ChatMessageDto with _$ChatMessageDto {
  const factory ChatMessageDto({
    String? id,
    String? senderAlias,
    String? type,
    String? content,
    String? imageUrl,
    String? createdAt,
  }) = _ChatMessageDto;

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);
}
