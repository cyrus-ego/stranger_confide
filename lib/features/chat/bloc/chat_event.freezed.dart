// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent()';
}


}

/// @nodoc
class $ChatEventCopyWith<$Res>  {
$ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}


/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatStarted value)?  started,TResult Function( ChatSendMessage value)?  sendMessage,TResult Function( ChatSendImage value)?  sendImage,TResult Function( ChatTyping value)?  typing,TResult Function( ChatLeaveRoom value)?  leaveRoom,TResult Function( ChatBlockPartner value)?  blockPartner,TResult Function( ChatReportPartner value)?  reportPartner,TResult Function( ChatMessageReceived value)?  messageReceived,TResult Function( ChatPartnerTyping value)?  partnerTyping,TResult Function( ChatRoomClosed value)?  roomClosed,TResult Function( ChatSocketConnected value)?  socketConnected,TResult Function( ChatSocketError value)?  socketError,TResult Function( ChatRoomJoined value)?  roomJoined,TResult Function( ChatPartnerOnlineChanged value)?  partnerOnlineChanged,TResult Function( ChatAccessDenied value)?  accessDenied,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatStarted() when started != null:
return started(_that);case ChatSendMessage() when sendMessage != null:
return sendMessage(_that);case ChatSendImage() when sendImage != null:
return sendImage(_that);case ChatTyping() when typing != null:
return typing(_that);case ChatLeaveRoom() when leaveRoom != null:
return leaveRoom(_that);case ChatBlockPartner() when blockPartner != null:
return blockPartner(_that);case ChatReportPartner() when reportPartner != null:
return reportPartner(_that);case ChatMessageReceived() when messageReceived != null:
return messageReceived(_that);case ChatPartnerTyping() when partnerTyping != null:
return partnerTyping(_that);case ChatRoomClosed() when roomClosed != null:
return roomClosed(_that);case ChatSocketConnected() when socketConnected != null:
return socketConnected(_that);case ChatSocketError() when socketError != null:
return socketError(_that);case ChatRoomJoined() when roomJoined != null:
return roomJoined(_that);case ChatPartnerOnlineChanged() when partnerOnlineChanged != null:
return partnerOnlineChanged(_that);case ChatAccessDenied() when accessDenied != null:
return accessDenied(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatStarted value)  started,required TResult Function( ChatSendMessage value)  sendMessage,required TResult Function( ChatSendImage value)  sendImage,required TResult Function( ChatTyping value)  typing,required TResult Function( ChatLeaveRoom value)  leaveRoom,required TResult Function( ChatBlockPartner value)  blockPartner,required TResult Function( ChatReportPartner value)  reportPartner,required TResult Function( ChatMessageReceived value)  messageReceived,required TResult Function( ChatPartnerTyping value)  partnerTyping,required TResult Function( ChatRoomClosed value)  roomClosed,required TResult Function( ChatSocketConnected value)  socketConnected,required TResult Function( ChatSocketError value)  socketError,required TResult Function( ChatRoomJoined value)  roomJoined,required TResult Function( ChatPartnerOnlineChanged value)  partnerOnlineChanged,required TResult Function( ChatAccessDenied value)  accessDenied,}){
final _that = this;
switch (_that) {
case ChatStarted():
return started(_that);case ChatSendMessage():
return sendMessage(_that);case ChatSendImage():
return sendImage(_that);case ChatTyping():
return typing(_that);case ChatLeaveRoom():
return leaveRoom(_that);case ChatBlockPartner():
return blockPartner(_that);case ChatReportPartner():
return reportPartner(_that);case ChatMessageReceived():
return messageReceived(_that);case ChatPartnerTyping():
return partnerTyping(_that);case ChatRoomClosed():
return roomClosed(_that);case ChatSocketConnected():
return socketConnected(_that);case ChatSocketError():
return socketError(_that);case ChatRoomJoined():
return roomJoined(_that);case ChatPartnerOnlineChanged():
return partnerOnlineChanged(_that);case ChatAccessDenied():
return accessDenied(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatStarted value)?  started,TResult? Function( ChatSendMessage value)?  sendMessage,TResult? Function( ChatSendImage value)?  sendImage,TResult? Function( ChatTyping value)?  typing,TResult? Function( ChatLeaveRoom value)?  leaveRoom,TResult? Function( ChatBlockPartner value)?  blockPartner,TResult? Function( ChatReportPartner value)?  reportPartner,TResult? Function( ChatMessageReceived value)?  messageReceived,TResult? Function( ChatPartnerTyping value)?  partnerTyping,TResult? Function( ChatRoomClosed value)?  roomClosed,TResult? Function( ChatSocketConnected value)?  socketConnected,TResult? Function( ChatSocketError value)?  socketError,TResult? Function( ChatRoomJoined value)?  roomJoined,TResult? Function( ChatPartnerOnlineChanged value)?  partnerOnlineChanged,TResult? Function( ChatAccessDenied value)?  accessDenied,}){
final _that = this;
switch (_that) {
case ChatStarted() when started != null:
return started(_that);case ChatSendMessage() when sendMessage != null:
return sendMessage(_that);case ChatSendImage() when sendImage != null:
return sendImage(_that);case ChatTyping() when typing != null:
return typing(_that);case ChatLeaveRoom() when leaveRoom != null:
return leaveRoom(_that);case ChatBlockPartner() when blockPartner != null:
return blockPartner(_that);case ChatReportPartner() when reportPartner != null:
return reportPartner(_that);case ChatMessageReceived() when messageReceived != null:
return messageReceived(_that);case ChatPartnerTyping() when partnerTyping != null:
return partnerTyping(_that);case ChatRoomClosed() when roomClosed != null:
return roomClosed(_that);case ChatSocketConnected() when socketConnected != null:
return socketConnected(_that);case ChatSocketError() when socketError != null:
return socketError(_that);case ChatRoomJoined() when roomJoined != null:
return roomJoined(_that);case ChatPartnerOnlineChanged() when partnerOnlineChanged != null:
return partnerOnlineChanged(_that);case ChatAccessDenied() when accessDenied != null:
return accessDenied(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String roomId)?  started,TResult Function( String text)?  sendMessage,TResult Function( String filePath)?  sendImage,TResult Function()?  typing,TResult Function()?  leaveRoom,TResult Function()?  blockPartner,TResult Function( String reason,  String? description)?  reportPartner,TResult Function( Map<String, dynamic> data)?  messageReceived,TResult Function( bool isTyping)?  partnerTyping,TResult Function( String reason)?  roomClosed,TResult Function()?  socketConnected,TResult Function( String message)?  socketError,TResult Function( Map<String, dynamic> data)?  roomJoined,TResult Function( bool online)?  partnerOnlineChanged,TResult Function( String message)?  accessDenied,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatStarted() when started != null:
return started(_that.roomId);case ChatSendMessage() when sendMessage != null:
return sendMessage(_that.text);case ChatSendImage() when sendImage != null:
return sendImage(_that.filePath);case ChatTyping() when typing != null:
return typing();case ChatLeaveRoom() when leaveRoom != null:
return leaveRoom();case ChatBlockPartner() when blockPartner != null:
return blockPartner();case ChatReportPartner() when reportPartner != null:
return reportPartner(_that.reason,_that.description);case ChatMessageReceived() when messageReceived != null:
return messageReceived(_that.data);case ChatPartnerTyping() when partnerTyping != null:
return partnerTyping(_that.isTyping);case ChatRoomClosed() when roomClosed != null:
return roomClosed(_that.reason);case ChatSocketConnected() when socketConnected != null:
return socketConnected();case ChatSocketError() when socketError != null:
return socketError(_that.message);case ChatRoomJoined() when roomJoined != null:
return roomJoined(_that.data);case ChatPartnerOnlineChanged() when partnerOnlineChanged != null:
return partnerOnlineChanged(_that.online);case ChatAccessDenied() when accessDenied != null:
return accessDenied(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String roomId)  started,required TResult Function( String text)  sendMessage,required TResult Function( String filePath)  sendImage,required TResult Function()  typing,required TResult Function()  leaveRoom,required TResult Function()  blockPartner,required TResult Function( String reason,  String? description)  reportPartner,required TResult Function( Map<String, dynamic> data)  messageReceived,required TResult Function( bool isTyping)  partnerTyping,required TResult Function( String reason)  roomClosed,required TResult Function()  socketConnected,required TResult Function( String message)  socketError,required TResult Function( Map<String, dynamic> data)  roomJoined,required TResult Function( bool online)  partnerOnlineChanged,required TResult Function( String message)  accessDenied,}) {final _that = this;
switch (_that) {
case ChatStarted():
return started(_that.roomId);case ChatSendMessage():
return sendMessage(_that.text);case ChatSendImage():
return sendImage(_that.filePath);case ChatTyping():
return typing();case ChatLeaveRoom():
return leaveRoom();case ChatBlockPartner():
return blockPartner();case ChatReportPartner():
return reportPartner(_that.reason,_that.description);case ChatMessageReceived():
return messageReceived(_that.data);case ChatPartnerTyping():
return partnerTyping(_that.isTyping);case ChatRoomClosed():
return roomClosed(_that.reason);case ChatSocketConnected():
return socketConnected();case ChatSocketError():
return socketError(_that.message);case ChatRoomJoined():
return roomJoined(_that.data);case ChatPartnerOnlineChanged():
return partnerOnlineChanged(_that.online);case ChatAccessDenied():
return accessDenied(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String roomId)?  started,TResult? Function( String text)?  sendMessage,TResult? Function( String filePath)?  sendImage,TResult? Function()?  typing,TResult? Function()?  leaveRoom,TResult? Function()?  blockPartner,TResult? Function( String reason,  String? description)?  reportPartner,TResult? Function( Map<String, dynamic> data)?  messageReceived,TResult? Function( bool isTyping)?  partnerTyping,TResult? Function( String reason)?  roomClosed,TResult? Function()?  socketConnected,TResult? Function( String message)?  socketError,TResult? Function( Map<String, dynamic> data)?  roomJoined,TResult? Function( bool online)?  partnerOnlineChanged,TResult? Function( String message)?  accessDenied,}) {final _that = this;
switch (_that) {
case ChatStarted() when started != null:
return started(_that.roomId);case ChatSendMessage() when sendMessage != null:
return sendMessage(_that.text);case ChatSendImage() when sendImage != null:
return sendImage(_that.filePath);case ChatTyping() when typing != null:
return typing();case ChatLeaveRoom() when leaveRoom != null:
return leaveRoom();case ChatBlockPartner() when blockPartner != null:
return blockPartner();case ChatReportPartner() when reportPartner != null:
return reportPartner(_that.reason,_that.description);case ChatMessageReceived() when messageReceived != null:
return messageReceived(_that.data);case ChatPartnerTyping() when partnerTyping != null:
return partnerTyping(_that.isTyping);case ChatRoomClosed() when roomClosed != null:
return roomClosed(_that.reason);case ChatSocketConnected() when socketConnected != null:
return socketConnected();case ChatSocketError() when socketError != null:
return socketError(_that.message);case ChatRoomJoined() when roomJoined != null:
return roomJoined(_that.data);case ChatPartnerOnlineChanged() when partnerOnlineChanged != null:
return partnerOnlineChanged(_that.online);case ChatAccessDenied() when accessDenied != null:
return accessDenied(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChatStarted extends ChatEvent {
  const ChatStarted(this.roomId): super._();
  

 final  String roomId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStartedCopyWith<ChatStarted> get copyWith => _$ChatStartedCopyWithImpl<ChatStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatStarted&&(identical(other.roomId, roomId) || other.roomId == roomId));
}


@override
int get hashCode => Object.hash(runtimeType,roomId);

@override
String toString() {
  return 'ChatEvent.started(roomId: $roomId)';
}


}

/// @nodoc
abstract mixin class $ChatStartedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatStartedCopyWith(ChatStarted value, $Res Function(ChatStarted) _then) = _$ChatStartedCopyWithImpl;
@useResult
$Res call({
 String roomId
});




}
/// @nodoc
class _$ChatStartedCopyWithImpl<$Res>
    implements $ChatStartedCopyWith<$Res> {
  _$ChatStartedCopyWithImpl(this._self, this._then);

  final ChatStarted _self;
  final $Res Function(ChatStarted) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roomId = null,}) {
  return _then(ChatStarted(
null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatSendMessage extends ChatEvent {
  const ChatSendMessage(this.text): super._();
  

 final  String text;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSendMessageCopyWith<ChatSendMessage> get copyWith => _$ChatSendMessageCopyWithImpl<ChatSendMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSendMessage&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ChatEvent.sendMessage(text: $text)';
}


}

/// @nodoc
abstract mixin class $ChatSendMessageCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatSendMessageCopyWith(ChatSendMessage value, $Res Function(ChatSendMessage) _then) = _$ChatSendMessageCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$ChatSendMessageCopyWithImpl<$Res>
    implements $ChatSendMessageCopyWith<$Res> {
  _$ChatSendMessageCopyWithImpl(this._self, this._then);

  final ChatSendMessage _self;
  final $Res Function(ChatSendMessage) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(ChatSendMessage(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatSendImage extends ChatEvent {
  const ChatSendImage(this.filePath): super._();
  

 final  String filePath;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSendImageCopyWith<ChatSendImage> get copyWith => _$ChatSendImageCopyWithImpl<ChatSendImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSendImage&&(identical(other.filePath, filePath) || other.filePath == filePath));
}


@override
int get hashCode => Object.hash(runtimeType,filePath);

@override
String toString() {
  return 'ChatEvent.sendImage(filePath: $filePath)';
}


}

/// @nodoc
abstract mixin class $ChatSendImageCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatSendImageCopyWith(ChatSendImage value, $Res Function(ChatSendImage) _then) = _$ChatSendImageCopyWithImpl;
@useResult
$Res call({
 String filePath
});




}
/// @nodoc
class _$ChatSendImageCopyWithImpl<$Res>
    implements $ChatSendImageCopyWith<$Res> {
  _$ChatSendImageCopyWithImpl(this._self, this._then);

  final ChatSendImage _self;
  final $Res Function(ChatSendImage) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filePath = null,}) {
  return _then(ChatSendImage(
null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatTyping extends ChatEvent {
  const ChatTyping(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatTyping);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.typing()';
}


}




/// @nodoc


class ChatLeaveRoom extends ChatEvent {
  const ChatLeaveRoom(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLeaveRoom);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.leaveRoom()';
}


}




/// @nodoc


class ChatBlockPartner extends ChatEvent {
  const ChatBlockPartner(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatBlockPartner);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.blockPartner()';
}


}




/// @nodoc


class ChatReportPartner extends ChatEvent {
  const ChatReportPartner(this.reason, this.description): super._();
  

 final  String reason;
 final  String? description;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatReportPartnerCopyWith<ChatReportPartner> get copyWith => _$ChatReportPartnerCopyWithImpl<ChatReportPartner>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatReportPartner&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,reason,description);

@override
String toString() {
  return 'ChatEvent.reportPartner(reason: $reason, description: $description)';
}


}

/// @nodoc
abstract mixin class $ChatReportPartnerCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatReportPartnerCopyWith(ChatReportPartner value, $Res Function(ChatReportPartner) _then) = _$ChatReportPartnerCopyWithImpl;
@useResult
$Res call({
 String reason, String? description
});




}
/// @nodoc
class _$ChatReportPartnerCopyWithImpl<$Res>
    implements $ChatReportPartnerCopyWith<$Res> {
  _$ChatReportPartnerCopyWithImpl(this._self, this._then);

  final ChatReportPartner _self;
  final $Res Function(ChatReportPartner) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,Object? description = freezed,}) {
  return _then(ChatReportPartner(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChatMessageReceived extends ChatEvent {
  const ChatMessageReceived(final  Map<String, dynamic> data): _data = data,super._();
  

 final  Map<String, dynamic> _data;
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageReceivedCopyWith<ChatMessageReceived> get copyWith => _$ChatMessageReceivedCopyWithImpl<ChatMessageReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageReceived&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ChatEvent.messageReceived(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatMessageReceivedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatMessageReceivedCopyWith(ChatMessageReceived value, $Res Function(ChatMessageReceived) _then) = _$ChatMessageReceivedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class _$ChatMessageReceivedCopyWithImpl<$Res>
    implements $ChatMessageReceivedCopyWith<$Res> {
  _$ChatMessageReceivedCopyWithImpl(this._self, this._then);

  final ChatMessageReceived _self;
  final $Res Function(ChatMessageReceived) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatMessageReceived(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class ChatPartnerTyping extends ChatEvent {
  const ChatPartnerTyping(this.isTyping): super._();
  

 final  bool isTyping;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPartnerTypingCopyWith<ChatPartnerTyping> get copyWith => _$ChatPartnerTypingCopyWithImpl<ChatPartnerTyping>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPartnerTyping&&(identical(other.isTyping, isTyping) || other.isTyping == isTyping));
}


@override
int get hashCode => Object.hash(runtimeType,isTyping);

@override
String toString() {
  return 'ChatEvent.partnerTyping(isTyping: $isTyping)';
}


}

/// @nodoc
abstract mixin class $ChatPartnerTypingCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatPartnerTypingCopyWith(ChatPartnerTyping value, $Res Function(ChatPartnerTyping) _then) = _$ChatPartnerTypingCopyWithImpl;
@useResult
$Res call({
 bool isTyping
});




}
/// @nodoc
class _$ChatPartnerTypingCopyWithImpl<$Res>
    implements $ChatPartnerTypingCopyWith<$Res> {
  _$ChatPartnerTypingCopyWithImpl(this._self, this._then);

  final ChatPartnerTyping _self;
  final $Res Function(ChatPartnerTyping) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isTyping = null,}) {
  return _then(ChatPartnerTyping(
null == isTyping ? _self.isTyping : isTyping // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChatRoomClosed extends ChatEvent {
  const ChatRoomClosed(this.reason): super._();
  

 final  String reason;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomClosedCopyWith<ChatRoomClosed> get copyWith => _$ChatRoomClosedCopyWithImpl<ChatRoomClosed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomClosed&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'ChatEvent.roomClosed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ChatRoomClosedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatRoomClosedCopyWith(ChatRoomClosed value, $Res Function(ChatRoomClosed) _then) = _$ChatRoomClosedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$ChatRoomClosedCopyWithImpl<$Res>
    implements $ChatRoomClosedCopyWith<$Res> {
  _$ChatRoomClosedCopyWithImpl(this._self, this._then);

  final ChatRoomClosed _self;
  final $Res Function(ChatRoomClosed) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(ChatRoomClosed(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatSocketConnected extends ChatEvent {
  const ChatSocketConnected(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSocketConnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.socketConnected()';
}


}




/// @nodoc


class ChatSocketError extends ChatEvent {
  const ChatSocketError(this.message): super._();
  

 final  String message;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSocketErrorCopyWith<ChatSocketError> get copyWith => _$ChatSocketErrorCopyWithImpl<ChatSocketError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSocketError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatEvent.socketError(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatSocketErrorCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatSocketErrorCopyWith(ChatSocketError value, $Res Function(ChatSocketError) _then) = _$ChatSocketErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatSocketErrorCopyWithImpl<$Res>
    implements $ChatSocketErrorCopyWith<$Res> {
  _$ChatSocketErrorCopyWithImpl(this._self, this._then);

  final ChatSocketError _self;
  final $Res Function(ChatSocketError) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatSocketError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatRoomJoined extends ChatEvent {
  const ChatRoomJoined(final  Map<String, dynamic> data): _data = data,super._();
  

 final  Map<String, dynamic> _data;
 Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomJoinedCopyWith<ChatRoomJoined> get copyWith => _$ChatRoomJoinedCopyWithImpl<ChatRoomJoined>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomJoined&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ChatEvent.roomJoined(data: $data)';
}


}

/// @nodoc
abstract mixin class $ChatRoomJoinedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatRoomJoinedCopyWith(ChatRoomJoined value, $Res Function(ChatRoomJoined) _then) = _$ChatRoomJoinedCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class _$ChatRoomJoinedCopyWithImpl<$Res>
    implements $ChatRoomJoinedCopyWith<$Res> {
  _$ChatRoomJoinedCopyWithImpl(this._self, this._then);

  final ChatRoomJoined _self;
  final $Res Function(ChatRoomJoined) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(ChatRoomJoined(
null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class ChatPartnerOnlineChanged extends ChatEvent {
  const ChatPartnerOnlineChanged(this.online): super._();
  

 final  bool online;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPartnerOnlineChangedCopyWith<ChatPartnerOnlineChanged> get copyWith => _$ChatPartnerOnlineChangedCopyWithImpl<ChatPartnerOnlineChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPartnerOnlineChanged&&(identical(other.online, online) || other.online == online));
}


@override
int get hashCode => Object.hash(runtimeType,online);

@override
String toString() {
  return 'ChatEvent.partnerOnlineChanged(online: $online)';
}


}

/// @nodoc
abstract mixin class $ChatPartnerOnlineChangedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatPartnerOnlineChangedCopyWith(ChatPartnerOnlineChanged value, $Res Function(ChatPartnerOnlineChanged) _then) = _$ChatPartnerOnlineChangedCopyWithImpl;
@useResult
$Res call({
 bool online
});




}
/// @nodoc
class _$ChatPartnerOnlineChangedCopyWithImpl<$Res>
    implements $ChatPartnerOnlineChangedCopyWith<$Res> {
  _$ChatPartnerOnlineChangedCopyWithImpl(this._self, this._then);

  final ChatPartnerOnlineChanged _self;
  final $Res Function(ChatPartnerOnlineChanged) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? online = null,}) {
  return _then(ChatPartnerOnlineChanged(
null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ChatAccessDenied extends ChatEvent {
  const ChatAccessDenied(this.message): super._();
  

 final  String message;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatAccessDeniedCopyWith<ChatAccessDenied> get copyWith => _$ChatAccessDeniedCopyWithImpl<ChatAccessDenied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatAccessDenied&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatEvent.accessDenied(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatAccessDeniedCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $ChatAccessDeniedCopyWith(ChatAccessDenied value, $Res Function(ChatAccessDenied) _then) = _$ChatAccessDeniedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatAccessDeniedCopyWithImpl<$Res>
    implements $ChatAccessDeniedCopyWith<$Res> {
  _$ChatAccessDeniedCopyWithImpl(this._self, this._then);

  final ChatAccessDenied _self;
  final $Res Function(ChatAccessDenied) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatAccessDenied(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
