// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matchmaking_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MatchmakingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent()';
}


}

/// @nodoc
class $MatchmakingEventCopyWith<$Res>  {
$MatchmakingEventCopyWith(MatchmakingEvent _, $Res Function(MatchmakingEvent) __);
}


/// Adds pattern-matching-related methods to [MatchmakingEvent].
extension MatchmakingEventPatterns on MatchmakingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MatchmakingStarted value)?  started,TResult Function( MatchmakingJoinQueue value)?  joinQueue,TResult Function( MatchmakingLeaveQueue value)?  leaveQueue,TResult Function( MatchmakingUpdatePreference value)?  updatePreference,TResult Function( MatchmakingRestartSearch value)?  restartSearch,TResult Function( MatchmakingSocketConnected value)?  socketConnected,TResult Function( MatchmakingQueueJoined value)?  queueJoined,TResult Function( MatchmakingPositionUpdated value)?  positionUpdated,TResult Function( MatchmakingMatchFound value)?  matchFound,TResult Function( MatchmakingQueueTimeout value)?  queueTimeout,TResult Function( MatchmakingSocketError value)?  socketError,TResult Function( MatchmakingSocketDisconnected value)?  socketDisconnected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started(_that);case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue(_that);case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue(_that);case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that);case MatchmakingRestartSearch() when restartSearch != null:
return restartSearch(_that);case MatchmakingSocketConnected() when socketConnected != null:
return socketConnected(_that);case MatchmakingQueueJoined() when queueJoined != null:
return queueJoined(_that);case MatchmakingPositionUpdated() when positionUpdated != null:
return positionUpdated(_that);case MatchmakingMatchFound() when matchFound != null:
return matchFound(_that);case MatchmakingQueueTimeout() when queueTimeout != null:
return queueTimeout(_that);case MatchmakingSocketError() when socketError != null:
return socketError(_that);case MatchmakingSocketDisconnected() when socketDisconnected != null:
return socketDisconnected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MatchmakingStarted value)  started,required TResult Function( MatchmakingJoinQueue value)  joinQueue,required TResult Function( MatchmakingLeaveQueue value)  leaveQueue,required TResult Function( MatchmakingUpdatePreference value)  updatePreference,required TResult Function( MatchmakingRestartSearch value)  restartSearch,required TResult Function( MatchmakingSocketConnected value)  socketConnected,required TResult Function( MatchmakingQueueJoined value)  queueJoined,required TResult Function( MatchmakingPositionUpdated value)  positionUpdated,required TResult Function( MatchmakingMatchFound value)  matchFound,required TResult Function( MatchmakingQueueTimeout value)  queueTimeout,required TResult Function( MatchmakingSocketError value)  socketError,required TResult Function( MatchmakingSocketDisconnected value)  socketDisconnected,}){
final _that = this;
switch (_that) {
case MatchmakingStarted():
return started(_that);case MatchmakingJoinQueue():
return joinQueue(_that);case MatchmakingLeaveQueue():
return leaveQueue(_that);case MatchmakingUpdatePreference():
return updatePreference(_that);case MatchmakingRestartSearch():
return restartSearch(_that);case MatchmakingSocketConnected():
return socketConnected(_that);case MatchmakingQueueJoined():
return queueJoined(_that);case MatchmakingPositionUpdated():
return positionUpdated(_that);case MatchmakingMatchFound():
return matchFound(_that);case MatchmakingQueueTimeout():
return queueTimeout(_that);case MatchmakingSocketError():
return socketError(_that);case MatchmakingSocketDisconnected():
return socketDisconnected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MatchmakingStarted value)?  started,TResult? Function( MatchmakingJoinQueue value)?  joinQueue,TResult? Function( MatchmakingLeaveQueue value)?  leaveQueue,TResult? Function( MatchmakingUpdatePreference value)?  updatePreference,TResult? Function( MatchmakingRestartSearch value)?  restartSearch,TResult? Function( MatchmakingSocketConnected value)?  socketConnected,TResult? Function( MatchmakingQueueJoined value)?  queueJoined,TResult? Function( MatchmakingPositionUpdated value)?  positionUpdated,TResult? Function( MatchmakingMatchFound value)?  matchFound,TResult? Function( MatchmakingQueueTimeout value)?  queueTimeout,TResult? Function( MatchmakingSocketError value)?  socketError,TResult? Function( MatchmakingSocketDisconnected value)?  socketDisconnected,}){
final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started(_that);case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue(_that);case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue(_that);case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that);case MatchmakingRestartSearch() when restartSearch != null:
return restartSearch(_that);case MatchmakingSocketConnected() when socketConnected != null:
return socketConnected(_that);case MatchmakingQueueJoined() when queueJoined != null:
return queueJoined(_that);case MatchmakingPositionUpdated() when positionUpdated != null:
return positionUpdated(_that);case MatchmakingMatchFound() when matchFound != null:
return matchFound(_that);case MatchmakingQueueTimeout() when queueTimeout != null:
return queueTimeout(_that);case MatchmakingSocketError() when socketError != null:
return socketError(_that);case MatchmakingSocketDisconnected() when socketDisconnected != null:
return socketDisconnected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  joinQueue,TResult Function()?  leaveQueue,TResult Function( ChatPreference preference)?  updatePreference,TResult Function()?  restartSearch,TResult Function()?  socketConnected,TResult Function( QueueStatusResponse data)?  queueJoined,TResult Function( QueueStatusResponse data)?  positionUpdated,TResult Function( String roomId,  String? partnerId)?  matchFound,TResult Function()?  queueTimeout,TResult Function( String message)?  socketError,TResult Function( String reason)?  socketDisconnected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started();case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue();case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue();case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that.preference);case MatchmakingRestartSearch() when restartSearch != null:
return restartSearch();case MatchmakingSocketConnected() when socketConnected != null:
return socketConnected();case MatchmakingQueueJoined() when queueJoined != null:
return queueJoined(_that.data);case MatchmakingPositionUpdated() when positionUpdated != null:
return positionUpdated(_that.data);case MatchmakingMatchFound() when matchFound != null:
return matchFound(_that.roomId,_that.partnerId);case MatchmakingQueueTimeout() when queueTimeout != null:
return queueTimeout();case MatchmakingSocketError() when socketError != null:
return socketError(_that.message);case MatchmakingSocketDisconnected() when socketDisconnected != null:
return socketDisconnected(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  joinQueue,required TResult Function()  leaveQueue,required TResult Function( ChatPreference preference)  updatePreference,required TResult Function()  restartSearch,required TResult Function()  socketConnected,required TResult Function( QueueStatusResponse data)  queueJoined,required TResult Function( QueueStatusResponse data)  positionUpdated,required TResult Function( String roomId,  String? partnerId)  matchFound,required TResult Function()  queueTimeout,required TResult Function( String message)  socketError,required TResult Function( String reason)  socketDisconnected,}) {final _that = this;
switch (_that) {
case MatchmakingStarted():
return started();case MatchmakingJoinQueue():
return joinQueue();case MatchmakingLeaveQueue():
return leaveQueue();case MatchmakingUpdatePreference():
return updatePreference(_that.preference);case MatchmakingRestartSearch():
return restartSearch();case MatchmakingSocketConnected():
return socketConnected();case MatchmakingQueueJoined():
return queueJoined(_that.data);case MatchmakingPositionUpdated():
return positionUpdated(_that.data);case MatchmakingMatchFound():
return matchFound(_that.roomId,_that.partnerId);case MatchmakingQueueTimeout():
return queueTimeout();case MatchmakingSocketError():
return socketError(_that.message);case MatchmakingSocketDisconnected():
return socketDisconnected(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  joinQueue,TResult? Function()?  leaveQueue,TResult? Function( ChatPreference preference)?  updatePreference,TResult? Function()?  restartSearch,TResult? Function()?  socketConnected,TResult? Function( QueueStatusResponse data)?  queueJoined,TResult? Function( QueueStatusResponse data)?  positionUpdated,TResult? Function( String roomId,  String? partnerId)?  matchFound,TResult? Function()?  queueTimeout,TResult? Function( String message)?  socketError,TResult? Function( String reason)?  socketDisconnected,}) {final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started();case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue();case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue();case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that.preference);case MatchmakingRestartSearch() when restartSearch != null:
return restartSearch();case MatchmakingSocketConnected() when socketConnected != null:
return socketConnected();case MatchmakingQueueJoined() when queueJoined != null:
return queueJoined(_that.data);case MatchmakingPositionUpdated() when positionUpdated != null:
return positionUpdated(_that.data);case MatchmakingMatchFound() when matchFound != null:
return matchFound(_that.roomId,_that.partnerId);case MatchmakingQueueTimeout() when queueTimeout != null:
return queueTimeout();case MatchmakingSocketError() when socketError != null:
return socketError(_that.message);case MatchmakingSocketDisconnected() when socketDisconnected != null:
return socketDisconnected(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class MatchmakingStarted extends MatchmakingEvent {
  const MatchmakingStarted(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.started()';
}


}




/// @nodoc


class MatchmakingJoinQueue extends MatchmakingEvent {
  const MatchmakingJoinQueue(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingJoinQueue);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.joinQueue()';
}


}




/// @nodoc


class MatchmakingLeaveQueue extends MatchmakingEvent {
  const MatchmakingLeaveQueue(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingLeaveQueue);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.leaveQueue()';
}


}




/// @nodoc


class MatchmakingUpdatePreference extends MatchmakingEvent {
  const MatchmakingUpdatePreference(this.preference): super._();
  

 final  ChatPreference preference;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingUpdatePreferenceCopyWith<MatchmakingUpdatePreference> get copyWith => _$MatchmakingUpdatePreferenceCopyWithImpl<MatchmakingUpdatePreference>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingUpdatePreference&&(identical(other.preference, preference) || other.preference == preference));
}


@override
int get hashCode => Object.hash(runtimeType,preference);

@override
String toString() {
  return 'MatchmakingEvent.updatePreference(preference: $preference)';
}


}

/// @nodoc
abstract mixin class $MatchmakingUpdatePreferenceCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingUpdatePreferenceCopyWith(MatchmakingUpdatePreference value, $Res Function(MatchmakingUpdatePreference) _then) = _$MatchmakingUpdatePreferenceCopyWithImpl;
@useResult
$Res call({
 ChatPreference preference
});




}
/// @nodoc
class _$MatchmakingUpdatePreferenceCopyWithImpl<$Res>
    implements $MatchmakingUpdatePreferenceCopyWith<$Res> {
  _$MatchmakingUpdatePreferenceCopyWithImpl(this._self, this._then);

  final MatchmakingUpdatePreference _self;
  final $Res Function(MatchmakingUpdatePreference) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preference = null,}) {
  return _then(MatchmakingUpdatePreference(
null == preference ? _self.preference : preference // ignore: cast_nullable_to_non_nullable
as ChatPreference,
  ));
}


}

/// @nodoc


class MatchmakingRestartSearch extends MatchmakingEvent {
  const MatchmakingRestartSearch(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingRestartSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.restartSearch()';
}


}




/// @nodoc


class MatchmakingSocketConnected extends MatchmakingEvent {
  const MatchmakingSocketConnected(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingSocketConnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.socketConnected()';
}


}




/// @nodoc


class MatchmakingQueueJoined extends MatchmakingEvent {
  const MatchmakingQueueJoined(this.data): super._();
  

 final  QueueStatusResponse data;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingQueueJoinedCopyWith<MatchmakingQueueJoined> get copyWith => _$MatchmakingQueueJoinedCopyWithImpl<MatchmakingQueueJoined>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingQueueJoined&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'MatchmakingEvent.queueJoined(data: $data)';
}


}

/// @nodoc
abstract mixin class $MatchmakingQueueJoinedCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingQueueJoinedCopyWith(MatchmakingQueueJoined value, $Res Function(MatchmakingQueueJoined) _then) = _$MatchmakingQueueJoinedCopyWithImpl;
@useResult
$Res call({
 QueueStatusResponse data
});


$QueueStatusResponseCopyWith<$Res> get data;

}
/// @nodoc
class _$MatchmakingQueueJoinedCopyWithImpl<$Res>
    implements $MatchmakingQueueJoinedCopyWith<$Res> {
  _$MatchmakingQueueJoinedCopyWithImpl(this._self, this._then);

  final MatchmakingQueueJoined _self;
  final $Res Function(MatchmakingQueueJoined) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(MatchmakingQueueJoined(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueueStatusResponse,
  ));
}

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueStatusResponseCopyWith<$Res> get data {
  
  return $QueueStatusResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class MatchmakingPositionUpdated extends MatchmakingEvent {
  const MatchmakingPositionUpdated(this.data): super._();
  

 final  QueueStatusResponse data;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingPositionUpdatedCopyWith<MatchmakingPositionUpdated> get copyWith => _$MatchmakingPositionUpdatedCopyWithImpl<MatchmakingPositionUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingPositionUpdated&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'MatchmakingEvent.positionUpdated(data: $data)';
}


}

/// @nodoc
abstract mixin class $MatchmakingPositionUpdatedCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingPositionUpdatedCopyWith(MatchmakingPositionUpdated value, $Res Function(MatchmakingPositionUpdated) _then) = _$MatchmakingPositionUpdatedCopyWithImpl;
@useResult
$Res call({
 QueueStatusResponse data
});


$QueueStatusResponseCopyWith<$Res> get data;

}
/// @nodoc
class _$MatchmakingPositionUpdatedCopyWithImpl<$Res>
    implements $MatchmakingPositionUpdatedCopyWith<$Res> {
  _$MatchmakingPositionUpdatedCopyWithImpl(this._self, this._then);

  final MatchmakingPositionUpdated _self;
  final $Res Function(MatchmakingPositionUpdated) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(MatchmakingPositionUpdated(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueueStatusResponse,
  ));
}

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueStatusResponseCopyWith<$Res> get data {
  
  return $QueueStatusResponseCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc


class MatchmakingMatchFound extends MatchmakingEvent {
  const MatchmakingMatchFound(this.roomId, this.partnerId): super._();
  

 final  String roomId;
 final  String? partnerId;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingMatchFoundCopyWith<MatchmakingMatchFound> get copyWith => _$MatchmakingMatchFoundCopyWithImpl<MatchmakingMatchFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingMatchFound&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}


@override
int get hashCode => Object.hash(runtimeType,roomId,partnerId);

@override
String toString() {
  return 'MatchmakingEvent.matchFound(roomId: $roomId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class $MatchmakingMatchFoundCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingMatchFoundCopyWith(MatchmakingMatchFound value, $Res Function(MatchmakingMatchFound) _then) = _$MatchmakingMatchFoundCopyWithImpl;
@useResult
$Res call({
 String roomId, String? partnerId
});




}
/// @nodoc
class _$MatchmakingMatchFoundCopyWithImpl<$Res>
    implements $MatchmakingMatchFoundCopyWith<$Res> {
  _$MatchmakingMatchFoundCopyWithImpl(this._self, this._then);

  final MatchmakingMatchFound _self;
  final $Res Function(MatchmakingMatchFound) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? partnerId = freezed,}) {
  return _then(MatchmakingMatchFound(
null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class MatchmakingQueueTimeout extends MatchmakingEvent {
  const MatchmakingQueueTimeout(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingQueueTimeout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.queueTimeout()';
}


}




/// @nodoc


class MatchmakingSocketError extends MatchmakingEvent {
  const MatchmakingSocketError(this.message): super._();
  

 final  String message;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingSocketErrorCopyWith<MatchmakingSocketError> get copyWith => _$MatchmakingSocketErrorCopyWithImpl<MatchmakingSocketError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingSocketError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'MatchmakingEvent.socketError(message: $message)';
}


}

/// @nodoc
abstract mixin class $MatchmakingSocketErrorCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingSocketErrorCopyWith(MatchmakingSocketError value, $Res Function(MatchmakingSocketError) _then) = _$MatchmakingSocketErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$MatchmakingSocketErrorCopyWithImpl<$Res>
    implements $MatchmakingSocketErrorCopyWith<$Res> {
  _$MatchmakingSocketErrorCopyWithImpl(this._self, this._then);

  final MatchmakingSocketError _self;
  final $Res Function(MatchmakingSocketError) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(MatchmakingSocketError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MatchmakingSocketDisconnected extends MatchmakingEvent {
  const MatchmakingSocketDisconnected(this.reason): super._();
  

 final  String reason;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingSocketDisconnectedCopyWith<MatchmakingSocketDisconnected> get copyWith => _$MatchmakingSocketDisconnectedCopyWithImpl<MatchmakingSocketDisconnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingSocketDisconnected&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'MatchmakingEvent.socketDisconnected(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $MatchmakingSocketDisconnectedCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingSocketDisconnectedCopyWith(MatchmakingSocketDisconnected value, $Res Function(MatchmakingSocketDisconnected) _then) = _$MatchmakingSocketDisconnectedCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$MatchmakingSocketDisconnectedCopyWithImpl<$Res>
    implements $MatchmakingSocketDisconnectedCopyWith<$Res> {
  _$MatchmakingSocketDisconnectedCopyWithImpl(this._self, this._then);

  final MatchmakingSocketDisconnected _self;
  final $Res Function(MatchmakingSocketDisconnected) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(MatchmakingSocketDisconnected(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
