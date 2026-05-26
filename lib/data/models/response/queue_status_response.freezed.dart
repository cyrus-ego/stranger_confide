// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_status_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueStatusResponse {

 bool? get inQueue; int? get position; int? get queueSize; int? get waitSeconds; int? get expiresInSeconds; String? get preference; String? get preferredGender; bool? get timedOut; String? get roomId; String? get partnerId;
/// Create a copy of QueueStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueStatusResponseCopyWith<QueueStatusResponse> get copyWith => _$QueueStatusResponseCopyWithImpl<QueueStatusResponse>(this as QueueStatusResponse, _$identity);

  /// Serializes this QueueStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueStatusResponse&&(identical(other.inQueue, inQueue) || other.inQueue == inQueue)&&(identical(other.position, position) || other.position == position)&&(identical(other.queueSize, queueSize) || other.queueSize == queueSize)&&(identical(other.waitSeconds, waitSeconds) || other.waitSeconds == waitSeconds)&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds)&&(identical(other.preference, preference) || other.preference == preference)&&(identical(other.preferredGender, preferredGender) || other.preferredGender == preferredGender)&&(identical(other.timedOut, timedOut) || other.timedOut == timedOut)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inQueue,position,queueSize,waitSeconds,expiresInSeconds,preference,preferredGender,timedOut,roomId,partnerId);

@override
String toString() {
  return 'QueueStatusResponse(inQueue: $inQueue, position: $position, queueSize: $queueSize, waitSeconds: $waitSeconds, expiresInSeconds: $expiresInSeconds, preference: $preference, preferredGender: $preferredGender, timedOut: $timedOut, roomId: $roomId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class $QueueStatusResponseCopyWith<$Res>  {
  factory $QueueStatusResponseCopyWith(QueueStatusResponse value, $Res Function(QueueStatusResponse) _then) = _$QueueStatusResponseCopyWithImpl;
@useResult
$Res call({
 bool? inQueue, int? position, int? queueSize, int? waitSeconds, int? expiresInSeconds, String? preference, String? preferredGender, bool? timedOut, String? roomId, String? partnerId
});




}
/// @nodoc
class _$QueueStatusResponseCopyWithImpl<$Res>
    implements $QueueStatusResponseCopyWith<$Res> {
  _$QueueStatusResponseCopyWithImpl(this._self, this._then);

  final QueueStatusResponse _self;
  final $Res Function(QueueStatusResponse) _then;

/// Create a copy of QueueStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inQueue = freezed,Object? position = freezed,Object? queueSize = freezed,Object? waitSeconds = freezed,Object? expiresInSeconds = freezed,Object? preference = freezed,Object? preferredGender = freezed,Object? timedOut = freezed,Object? roomId = freezed,Object? partnerId = freezed,}) {
  return _then(_self.copyWith(
inQueue: freezed == inQueue ? _self.inQueue : inQueue // ignore: cast_nullable_to_non_nullable
as bool?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,queueSize: freezed == queueSize ? _self.queueSize : queueSize // ignore: cast_nullable_to_non_nullable
as int?,waitSeconds: freezed == waitSeconds ? _self.waitSeconds : waitSeconds // ignore: cast_nullable_to_non_nullable
as int?,expiresInSeconds: freezed == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int?,preference: freezed == preference ? _self.preference : preference // ignore: cast_nullable_to_non_nullable
as String?,preferredGender: freezed == preferredGender ? _self.preferredGender : preferredGender // ignore: cast_nullable_to_non_nullable
as String?,timedOut: freezed == timedOut ? _self.timedOut : timedOut // ignore: cast_nullable_to_non_nullable
as bool?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,partnerId: freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QueueStatusResponse].
extension QueueStatusResponsePatterns on QueueStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _QueueStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QueueStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? inQueue,  int? position,  int? queueSize,  int? waitSeconds,  int? expiresInSeconds,  String? preference,  String? preferredGender,  bool? timedOut,  String? roomId,  String? partnerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueStatusResponse() when $default != null:
return $default(_that.inQueue,_that.position,_that.queueSize,_that.waitSeconds,_that.expiresInSeconds,_that.preference,_that.preferredGender,_that.timedOut,_that.roomId,_that.partnerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? inQueue,  int? position,  int? queueSize,  int? waitSeconds,  int? expiresInSeconds,  String? preference,  String? preferredGender,  bool? timedOut,  String? roomId,  String? partnerId)  $default,) {final _that = this;
switch (_that) {
case _QueueStatusResponse():
return $default(_that.inQueue,_that.position,_that.queueSize,_that.waitSeconds,_that.expiresInSeconds,_that.preference,_that.preferredGender,_that.timedOut,_that.roomId,_that.partnerId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? inQueue,  int? position,  int? queueSize,  int? waitSeconds,  int? expiresInSeconds,  String? preference,  String? preferredGender,  bool? timedOut,  String? roomId,  String? partnerId)?  $default,) {final _that = this;
switch (_that) {
case _QueueStatusResponse() when $default != null:
return $default(_that.inQueue,_that.position,_that.queueSize,_that.waitSeconds,_that.expiresInSeconds,_that.preference,_that.preferredGender,_that.timedOut,_that.roomId,_that.partnerId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueStatusResponse implements QueueStatusResponse {
  const _QueueStatusResponse({this.inQueue, this.position, this.queueSize, this.waitSeconds, this.expiresInSeconds, this.preference, this.preferredGender, this.timedOut, this.roomId, this.partnerId});
  factory _QueueStatusResponse.fromJson(Map<String, dynamic> json) => _$QueueStatusResponseFromJson(json);

@override final  bool? inQueue;
@override final  int? position;
@override final  int? queueSize;
@override final  int? waitSeconds;
@override final  int? expiresInSeconds;
@override final  String? preference;
@override final  String? preferredGender;
@override final  bool? timedOut;
@override final  String? roomId;
@override final  String? partnerId;

/// Create a copy of QueueStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueStatusResponseCopyWith<_QueueStatusResponse> get copyWith => __$QueueStatusResponseCopyWithImpl<_QueueStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueStatusResponse&&(identical(other.inQueue, inQueue) || other.inQueue == inQueue)&&(identical(other.position, position) || other.position == position)&&(identical(other.queueSize, queueSize) || other.queueSize == queueSize)&&(identical(other.waitSeconds, waitSeconds) || other.waitSeconds == waitSeconds)&&(identical(other.expiresInSeconds, expiresInSeconds) || other.expiresInSeconds == expiresInSeconds)&&(identical(other.preference, preference) || other.preference == preference)&&(identical(other.preferredGender, preferredGender) || other.preferredGender == preferredGender)&&(identical(other.timedOut, timedOut) || other.timedOut == timedOut)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inQueue,position,queueSize,waitSeconds,expiresInSeconds,preference,preferredGender,timedOut,roomId,partnerId);

@override
String toString() {
  return 'QueueStatusResponse(inQueue: $inQueue, position: $position, queueSize: $queueSize, waitSeconds: $waitSeconds, expiresInSeconds: $expiresInSeconds, preference: $preference, preferredGender: $preferredGender, timedOut: $timedOut, roomId: $roomId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class _$QueueStatusResponseCopyWith<$Res> implements $QueueStatusResponseCopyWith<$Res> {
  factory _$QueueStatusResponseCopyWith(_QueueStatusResponse value, $Res Function(_QueueStatusResponse) _then) = __$QueueStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 bool? inQueue, int? position, int? queueSize, int? waitSeconds, int? expiresInSeconds, String? preference, String? preferredGender, bool? timedOut, String? roomId, String? partnerId
});




}
/// @nodoc
class __$QueueStatusResponseCopyWithImpl<$Res>
    implements _$QueueStatusResponseCopyWith<$Res> {
  __$QueueStatusResponseCopyWithImpl(this._self, this._then);

  final _QueueStatusResponse _self;
  final $Res Function(_QueueStatusResponse) _then;

/// Create a copy of QueueStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inQueue = freezed,Object? position = freezed,Object? queueSize = freezed,Object? waitSeconds = freezed,Object? expiresInSeconds = freezed,Object? preference = freezed,Object? preferredGender = freezed,Object? timedOut = freezed,Object? roomId = freezed,Object? partnerId = freezed,}) {
  return _then(_QueueStatusResponse(
inQueue: freezed == inQueue ? _self.inQueue : inQueue // ignore: cast_nullable_to_non_nullable
as bool?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,queueSize: freezed == queueSize ? _self.queueSize : queueSize // ignore: cast_nullable_to_non_nullable
as int?,waitSeconds: freezed == waitSeconds ? _self.waitSeconds : waitSeconds // ignore: cast_nullable_to_non_nullable
as int?,expiresInSeconds: freezed == expiresInSeconds ? _self.expiresInSeconds : expiresInSeconds // ignore: cast_nullable_to_non_nullable
as int?,preference: freezed == preference ? _self.preference : preference // ignore: cast_nullable_to_non_nullable
as String?,preferredGender: freezed == preferredGender ? _self.preferredGender : preferredGender // ignore: cast_nullable_to_non_nullable
as String?,timedOut: freezed == timedOut ? _self.timedOut : timedOut // ignore: cast_nullable_to_non_nullable
as bool?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,partnerId: freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
