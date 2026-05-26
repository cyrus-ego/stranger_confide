import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.freezed.dart';

@freezed
sealed class ChatEvent extends BlocEvent with _$ChatEvent {
  const ChatEvent._();

  const factory ChatEvent.started(String roomId) = ChatStarted;
  const factory ChatEvent.sendMessage(String text) = ChatSendMessage;
  const factory ChatEvent.sendImage(String filePath) = ChatSendImage;
  const factory ChatEvent.typing() = ChatTyping;
  const factory ChatEvent.leaveRoom() = ChatLeaveRoom;
  const factory ChatEvent.blockPartner() = ChatBlockPartner;
  const factory ChatEvent.reportPartner(String reason, String? description) =
      ChatReportPartner;

  // Socket-driven events
  const factory ChatEvent.messageReceived(Map<String, dynamic> data) =
      ChatMessageReceived;
  const factory ChatEvent.partnerTyping(bool isTyping) = ChatPartnerTyping;
  const factory ChatEvent.partnerLeft() = ChatPartnerLeft;
  const factory ChatEvent.roomClosed(String reason) = ChatRoomClosed;
  const factory ChatEvent.socketConnected() = ChatSocketConnected;
  const factory ChatEvent.socketError(String message) = ChatSocketError;
  const factory ChatEvent.roomReady(String partnerAlias) = ChatRoomReady;
  const factory ChatEvent.partnerOnlineChanged(bool online) =
      ChatPartnerOnlineChanged;
}
