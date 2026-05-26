import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

enum ChatStatus {
  connecting,
  active,
  closed,
  error,
}

enum MessageType {
  text,
  image,
  system,
}

@freezed
sealed class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required MessageType type,
    required String content,
    required bool isMine,
    required DateTime timestamp,
    @Default(false) bool isUploading,
  }) = _ChatMessage;
}

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    @Default(ChatStatus.connecting) ChatStatus status,
    @Default([]) List<ChatMessage> messages,
    @Default('') String roomId,
    @Default('Stranger') String partnerAlias,
    @Default(false) bool partnerOnline,
    @Default(false) bool partnerTyping,
    @Default(false) bool isUploading,
    String? closedReason,
    String? errorMessage,
  }) = _ChatState;
}
