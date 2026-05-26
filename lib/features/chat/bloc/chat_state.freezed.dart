// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatMessage {

 String get id; String get senderAlias; MessageType get type; String get content; String? get imageUrl; DateTime get createdAt; bool get isMine; bool get isUploading;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderAlias, senderAlias) || other.senderAlias == senderAlias)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderAlias,type,content,imageUrl,createdAt,isMine,isUploading);

@override
String toString() {
  return 'ChatMessage(id: $id, senderAlias: $senderAlias, type: $type, content: $content, imageUrl: $imageUrl, createdAt: $createdAt, isMine: $isMine, isUploading: $isUploading)';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String senderAlias, MessageType type, String content, String? imageUrl, DateTime createdAt, bool isMine, bool isUploading
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderAlias = null,Object? type = null,Object? content = null,Object? imageUrl = freezed,Object? createdAt = null,Object? isMine = null,Object? isUploading = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderAlias: null == senderAlias ? _self.senderAlias : senderAlias // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderAlias,  MessageType type,  String content,  String? imageUrl,  DateTime createdAt,  bool isMine,  bool isUploading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.senderAlias,_that.type,_that.content,_that.imageUrl,_that.createdAt,_that.isMine,_that.isUploading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderAlias,  MessageType type,  String content,  String? imageUrl,  DateTime createdAt,  bool isMine,  bool isUploading)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.senderAlias,_that.type,_that.content,_that.imageUrl,_that.createdAt,_that.isMine,_that.isUploading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderAlias,  MessageType type,  String content,  String? imageUrl,  DateTime createdAt,  bool isMine,  bool isUploading)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.senderAlias,_that.type,_that.content,_that.imageUrl,_that.createdAt,_that.isMine,_that.isUploading);case _:
  return null;

}
}

}

/// @nodoc


class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.senderAlias, required this.type, required this.content, this.imageUrl, required this.createdAt, required this.isMine, this.isUploading = false});
  

@override final  String id;
@override final  String senderAlias;
@override final  MessageType type;
@override final  String content;
@override final  String? imageUrl;
@override final  DateTime createdAt;
@override final  bool isMine;
@override@JsonKey() final  bool isUploading;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.senderAlias, senderAlias) || other.senderAlias == senderAlias)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isMine, isMine) || other.isMine == isMine)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderAlias,type,content,imageUrl,createdAt,isMine,isUploading);

@override
String toString() {
  return 'ChatMessage(id: $id, senderAlias: $senderAlias, type: $type, content: $content, imageUrl: $imageUrl, createdAt: $createdAt, isMine: $isMine, isUploading: $isUploading)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderAlias, MessageType type, String content, String? imageUrl, DateTime createdAt, bool isMine, bool isUploading
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderAlias = null,Object? type = null,Object? content = null,Object? imageUrl = freezed,Object? createdAt = null,Object? isMine = null,Object? isUploading = null,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderAlias: null == senderAlias ? _self.senderAlias : senderAlias // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMine: null == isMine ? _self.isMine : isMine // ignore: cast_nullable_to_non_nullable
as bool,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ChatState {

 ChatStatus get status; List<ChatMessage> get messages; String get roomId; String get myAlias; String get myAvatar; String get partnerAlias; String get partnerAvatar; String get partnerUserId; bool get partnerOnline; bool get partnerTyping; bool get isUploading; bool get isSending; ChatAction get lastAction; String? get closedReason; String? get errorMessage;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.myAlias, myAlias) || other.myAlias == myAlias)&&(identical(other.myAvatar, myAvatar) || other.myAvatar == myAvatar)&&(identical(other.partnerAlias, partnerAlias) || other.partnerAlias == partnerAlias)&&(identical(other.partnerAvatar, partnerAvatar) || other.partnerAvatar == partnerAvatar)&&(identical(other.partnerUserId, partnerUserId) || other.partnerUserId == partnerUserId)&&(identical(other.partnerOnline, partnerOnline) || other.partnerOnline == partnerOnline)&&(identical(other.partnerTyping, partnerTyping) || other.partnerTyping == partnerTyping)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction)&&(identical(other.closedReason, closedReason) || other.closedReason == closedReason)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(messages),roomId,myAlias,myAvatar,partnerAlias,partnerAvatar,partnerUserId,partnerOnline,partnerTyping,isUploading,isSending,lastAction,closedReason,errorMessage);

@override
String toString() {
  return 'ChatState(status: $status, messages: $messages, roomId: $roomId, myAlias: $myAlias, myAvatar: $myAvatar, partnerAlias: $partnerAlias, partnerAvatar: $partnerAvatar, partnerUserId: $partnerUserId, partnerOnline: $partnerOnline, partnerTyping: $partnerTyping, isUploading: $isUploading, isSending: $isSending, lastAction: $lastAction, closedReason: $closedReason, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 ChatStatus status, List<ChatMessage> messages, String roomId, String myAlias, String myAvatar, String partnerAlias, String partnerAvatar, String partnerUserId, bool partnerOnline, bool partnerTyping, bool isUploading, bool isSending, ChatAction lastAction, String? closedReason, String? errorMessage
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? messages = null,Object? roomId = null,Object? myAlias = null,Object? myAvatar = null,Object? partnerAlias = null,Object? partnerAvatar = null,Object? partnerUserId = null,Object? partnerOnline = null,Object? partnerTyping = null,Object? isUploading = null,Object? isSending = null,Object? lastAction = null,Object? closedReason = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatStatus,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,myAlias: null == myAlias ? _self.myAlias : myAlias // ignore: cast_nullable_to_non_nullable
as String,myAvatar: null == myAvatar ? _self.myAvatar : myAvatar // ignore: cast_nullable_to_non_nullable
as String,partnerAlias: null == partnerAlias ? _self.partnerAlias : partnerAlias // ignore: cast_nullable_to_non_nullable
as String,partnerAvatar: null == partnerAvatar ? _self.partnerAvatar : partnerAvatar // ignore: cast_nullable_to_non_nullable
as String,partnerUserId: null == partnerUserId ? _self.partnerUserId : partnerUserId // ignore: cast_nullable_to_non_nullable
as String,partnerOnline: null == partnerOnline ? _self.partnerOnline : partnerOnline // ignore: cast_nullable_to_non_nullable
as bool,partnerTyping: null == partnerTyping ? _self.partnerTyping : partnerTyping // ignore: cast_nullable_to_non_nullable
as bool,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,lastAction: null == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as ChatAction,closedReason: freezed == closedReason ? _self.closedReason : closedReason // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatStatus status,  List<ChatMessage> messages,  String roomId,  String myAlias,  String myAvatar,  String partnerAlias,  String partnerAvatar,  String partnerUserId,  bool partnerOnline,  bool partnerTyping,  bool isUploading,  bool isSending,  ChatAction lastAction,  String? closedReason,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.status,_that.messages,_that.roomId,_that.myAlias,_that.myAvatar,_that.partnerAlias,_that.partnerAvatar,_that.partnerUserId,_that.partnerOnline,_that.partnerTyping,_that.isUploading,_that.isSending,_that.lastAction,_that.closedReason,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatStatus status,  List<ChatMessage> messages,  String roomId,  String myAlias,  String myAvatar,  String partnerAlias,  String partnerAvatar,  String partnerUserId,  bool partnerOnline,  bool partnerTyping,  bool isUploading,  bool isSending,  ChatAction lastAction,  String? closedReason,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.status,_that.messages,_that.roomId,_that.myAlias,_that.myAvatar,_that.partnerAlias,_that.partnerAvatar,_that.partnerUserId,_that.partnerOnline,_that.partnerTyping,_that.isUploading,_that.isSending,_that.lastAction,_that.closedReason,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatStatus status,  List<ChatMessage> messages,  String roomId,  String myAlias,  String myAvatar,  String partnerAlias,  String partnerAvatar,  String partnerUserId,  bool partnerOnline,  bool partnerTyping,  bool isUploading,  bool isSending,  ChatAction lastAction,  String? closedReason,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.status,_that.messages,_that.roomId,_that.myAlias,_that.myAvatar,_that.partnerAlias,_that.partnerAvatar,_that.partnerUserId,_that.partnerOnline,_that.partnerTyping,_that.isUploading,_that.isSending,_that.lastAction,_that.closedReason,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({this.status = ChatStatus.connecting, final  List<ChatMessage> messages = const [], this.roomId = '', this.myAlias = '', this.myAvatar = '', this.partnerAlias = 'Stranger', this.partnerAvatar = '', this.partnerUserId = '', this.partnerOnline = false, this.partnerTyping = false, this.isUploading = false, this.isSending = false, this.lastAction = ChatAction.none, this.closedReason, this.errorMessage}): _messages = messages;
  

@override@JsonKey() final  ChatStatus status;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override@JsonKey() final  String roomId;
@override@JsonKey() final  String myAlias;
@override@JsonKey() final  String myAvatar;
@override@JsonKey() final  String partnerAlias;
@override@JsonKey() final  String partnerAvatar;
@override@JsonKey() final  String partnerUserId;
@override@JsonKey() final  bool partnerOnline;
@override@JsonKey() final  bool partnerTyping;
@override@JsonKey() final  bool isUploading;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  ChatAction lastAction;
@override final  String? closedReason;
@override final  String? errorMessage;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.myAlias, myAlias) || other.myAlias == myAlias)&&(identical(other.myAvatar, myAvatar) || other.myAvatar == myAvatar)&&(identical(other.partnerAlias, partnerAlias) || other.partnerAlias == partnerAlias)&&(identical(other.partnerAvatar, partnerAvatar) || other.partnerAvatar == partnerAvatar)&&(identical(other.partnerUserId, partnerUserId) || other.partnerUserId == partnerUserId)&&(identical(other.partnerOnline, partnerOnline) || other.partnerOnline == partnerOnline)&&(identical(other.partnerTyping, partnerTyping) || other.partnerTyping == partnerTyping)&&(identical(other.isUploading, isUploading) || other.isUploading == isUploading)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.lastAction, lastAction) || other.lastAction == lastAction)&&(identical(other.closedReason, closedReason) || other.closedReason == closedReason)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_messages),roomId,myAlias,myAvatar,partnerAlias,partnerAvatar,partnerUserId,partnerOnline,partnerTyping,isUploading,isSending,lastAction,closedReason,errorMessage);

@override
String toString() {
  return 'ChatState(status: $status, messages: $messages, roomId: $roomId, myAlias: $myAlias, myAvatar: $myAvatar, partnerAlias: $partnerAlias, partnerAvatar: $partnerAvatar, partnerUserId: $partnerUserId, partnerOnline: $partnerOnline, partnerTyping: $partnerTyping, isUploading: $isUploading, isSending: $isSending, lastAction: $lastAction, closedReason: $closedReason, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 ChatStatus status, List<ChatMessage> messages, String roomId, String myAlias, String myAvatar, String partnerAlias, String partnerAvatar, String partnerUserId, bool partnerOnline, bool partnerTyping, bool isUploading, bool isSending, ChatAction lastAction, String? closedReason, String? errorMessage
});




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? messages = null,Object? roomId = null,Object? myAlias = null,Object? myAvatar = null,Object? partnerAlias = null,Object? partnerAvatar = null,Object? partnerUserId = null,Object? partnerOnline = null,Object? partnerTyping = null,Object? isUploading = null,Object? isSending = null,Object? lastAction = null,Object? closedReason = freezed,Object? errorMessage = freezed,}) {
  return _then(_ChatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatStatus,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,myAlias: null == myAlias ? _self.myAlias : myAlias // ignore: cast_nullable_to_non_nullable
as String,myAvatar: null == myAvatar ? _self.myAvatar : myAvatar // ignore: cast_nullable_to_non_nullable
as String,partnerAlias: null == partnerAlias ? _self.partnerAlias : partnerAlias // ignore: cast_nullable_to_non_nullable
as String,partnerAvatar: null == partnerAvatar ? _self.partnerAvatar : partnerAvatar // ignore: cast_nullable_to_non_nullable
as String,partnerUserId: null == partnerUserId ? _self.partnerUserId : partnerUserId // ignore: cast_nullable_to_non_nullable
as String,partnerOnline: null == partnerOnline ? _self.partnerOnline : partnerOnline // ignore: cast_nullable_to_non_nullable
as bool,partnerTyping: null == partnerTyping ? _self.partnerTyping : partnerTyping // ignore: cast_nullable_to_non_nullable
as bool,isUploading: null == isUploading ? _self.isUploading : isUploading // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,lastAction: null == lastAction ? _self.lastAction : lastAction // ignore: cast_nullable_to_non_nullable
as ChatAction,closedReason: freezed == closedReason ? _self.closedReason : closedReason // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
