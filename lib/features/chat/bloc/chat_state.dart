import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_state.freezed.dart';

enum ChatStatus { connecting, active, closed, error }

enum MessageType { text, image, system }

@freezed
sealed class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String senderAlias,
    required MessageType type,
    required String content,
    String? imageUrl,
    required DateTime createdAt,
    required bool isMine,
    @Default(false) bool isUploading,
  }) = _ChatMessage;
}

enum ChatAction {
  none,
  reportSuccess,
  reportFailed,
  moderationBlocked,
  spamDetected,
}

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    @Default(ChatStatus.connecting) ChatStatus status,
    @Default([]) List<ChatMessage> messages,
    @Default('') String roomId,
    @Default('') String myAlias,
    @Default('') String myAvatar,
    @Default('Stranger') String partnerAlias,
    @Default('') String partnerAvatar,
    @Default('') String partnerUserId,
    @Default(false) bool partnerOnline,
    @Default(false) bool partnerTyping,
    @Default(false) bool isUploading,
    @Default(false) bool isSending,
    @Default(false) bool isLoadingOlderMessages,
    @Default(false) bool hasMoreOlderMessages,
    @Default(false) bool closureInitiatedByMe,
    @Default(ChatAction.none) ChatAction lastAction,
    String? oldestMessageId,
    String? closedReason,
    String? errorMessage,
  }) = _ChatState;
}
