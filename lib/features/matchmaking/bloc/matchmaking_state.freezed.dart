// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matchmaking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MatchmakingState {

 MatchmakingStatus get status; QueueStatusResponse? get queueData; ChatPreference get selectedPreference; String? get errorMessage; String? get roomId; String? get partnerId;
/// Create a copy of MatchmakingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingStateCopyWith<MatchmakingState> get copyWith => _$MatchmakingStateCopyWithImpl<MatchmakingState>(this as MatchmakingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingState&&(identical(other.status, status) || other.status == status)&&(identical(other.queueData, queueData) || other.queueData == queueData)&&(identical(other.selectedPreference, selectedPreference) || other.selectedPreference == selectedPreference)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}


@override
int get hashCode => Object.hash(runtimeType,status,queueData,selectedPreference,errorMessage,roomId,partnerId);

@override
String toString() {
  return 'MatchmakingState(status: $status, queueData: $queueData, selectedPreference: $selectedPreference, errorMessage: $errorMessage, roomId: $roomId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class $MatchmakingStateCopyWith<$Res>  {
  factory $MatchmakingStateCopyWith(MatchmakingState value, $Res Function(MatchmakingState) _then) = _$MatchmakingStateCopyWithImpl;
@useResult
$Res call({
 MatchmakingStatus status, QueueStatusResponse? queueData, ChatPreference selectedPreference, String? errorMessage, String? roomId, String? partnerId
});


$QueueStatusResponseCopyWith<$Res>? get queueData;

}
/// @nodoc
class _$MatchmakingStateCopyWithImpl<$Res>
    implements $MatchmakingStateCopyWith<$Res> {
  _$MatchmakingStateCopyWithImpl(this._self, this._then);

  final MatchmakingState _self;
  final $Res Function(MatchmakingState) _then;

/// Create a copy of MatchmakingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? queueData = freezed,Object? selectedPreference = null,Object? errorMessage = freezed,Object? roomId = freezed,Object? partnerId = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchmakingStatus,queueData: freezed == queueData ? _self.queueData : queueData // ignore: cast_nullable_to_non_nullable
as QueueStatusResponse?,selectedPreference: null == selectedPreference ? _self.selectedPreference : selectedPreference // ignore: cast_nullable_to_non_nullable
as ChatPreference,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,partnerId: freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MatchmakingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueStatusResponseCopyWith<$Res>? get queueData {
    if (_self.queueData == null) {
    return null;
  }

  return $QueueStatusResponseCopyWith<$Res>(_self.queueData!, (value) {
    return _then(_self.copyWith(queueData: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchmakingState].
extension MatchmakingStatePatterns on MatchmakingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchmakingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchmakingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchmakingState value)  $default,){
final _that = this;
switch (_that) {
case _MatchmakingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchmakingState value)?  $default,){
final _that = this;
switch (_that) {
case _MatchmakingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MatchmakingStatus status,  QueueStatusResponse? queueData,  ChatPreference selectedPreference,  String? errorMessage,  String? roomId,  String? partnerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchmakingState() when $default != null:
return $default(_that.status,_that.queueData,_that.selectedPreference,_that.errorMessage,_that.roomId,_that.partnerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MatchmakingStatus status,  QueueStatusResponse? queueData,  ChatPreference selectedPreference,  String? errorMessage,  String? roomId,  String? partnerId)  $default,) {final _that = this;
switch (_that) {
case _MatchmakingState():
return $default(_that.status,_that.queueData,_that.selectedPreference,_that.errorMessage,_that.roomId,_that.partnerId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MatchmakingStatus status,  QueueStatusResponse? queueData,  ChatPreference selectedPreference,  String? errorMessage,  String? roomId,  String? partnerId)?  $default,) {final _that = this;
switch (_that) {
case _MatchmakingState() when $default != null:
return $default(_that.status,_that.queueData,_that.selectedPreference,_that.errorMessage,_that.roomId,_that.partnerId);case _:
  return null;

}
}

}

/// @nodoc


class _MatchmakingState implements MatchmakingState {
  const _MatchmakingState({this.status = MatchmakingStatus.initial, this.queueData, this.selectedPreference = ChatPreference.defaultPreference, this.errorMessage, this.roomId, this.partnerId});
  

@override@JsonKey() final  MatchmakingStatus status;
@override final  QueueStatusResponse? queueData;
@override@JsonKey() final  ChatPreference selectedPreference;
@override final  String? errorMessage;
@override final  String? roomId;
@override final  String? partnerId;

/// Create a copy of MatchmakingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchmakingStateCopyWith<_MatchmakingState> get copyWith => __$MatchmakingStateCopyWithImpl<_MatchmakingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchmakingState&&(identical(other.status, status) || other.status == status)&&(identical(other.queueData, queueData) || other.queueData == queueData)&&(identical(other.selectedPreference, selectedPreference) || other.selectedPreference == selectedPreference)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}


@override
int get hashCode => Object.hash(runtimeType,status,queueData,selectedPreference,errorMessage,roomId,partnerId);

@override
String toString() {
  return 'MatchmakingState(status: $status, queueData: $queueData, selectedPreference: $selectedPreference, errorMessage: $errorMessage, roomId: $roomId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class _$MatchmakingStateCopyWith<$Res> implements $MatchmakingStateCopyWith<$Res> {
  factory _$MatchmakingStateCopyWith(_MatchmakingState value, $Res Function(_MatchmakingState) _then) = __$MatchmakingStateCopyWithImpl;
@override @useResult
$Res call({
 MatchmakingStatus status, QueueStatusResponse? queueData, ChatPreference selectedPreference, String? errorMessage, String? roomId, String? partnerId
});


@override $QueueStatusResponseCopyWith<$Res>? get queueData;

}
/// @nodoc
class __$MatchmakingStateCopyWithImpl<$Res>
    implements _$MatchmakingStateCopyWith<$Res> {
  __$MatchmakingStateCopyWithImpl(this._self, this._then);

  final _MatchmakingState _self;
  final $Res Function(_MatchmakingState) _then;

/// Create a copy of MatchmakingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? queueData = freezed,Object? selectedPreference = null,Object? errorMessage = freezed,Object? roomId = freezed,Object? partnerId = freezed,}) {
  return _then(_MatchmakingState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MatchmakingStatus,queueData: freezed == queueData ? _self.queueData : queueData // ignore: cast_nullable_to_non_nullable
as QueueStatusResponse?,selectedPreference: null == selectedPreference ? _self.selectedPreference : selectedPreference // ignore: cast_nullable_to_non_nullable
as ChatPreference,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,partnerId: freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MatchmakingState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueStatusResponseCopyWith<$Res>? get queueData {
    if (_self.queueData == null) {
    return null;
  }

  return $QueueStatusResponseCopyWith<$Res>(_self.queueData!, (value) {
    return _then(_self.copyWith(queueData: value));
  });
}
}

// dart format on
