// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_room_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActiveRoomResponse {

 bool get hasActiveRoom; String? get roomId;
/// Create a copy of ActiveRoomResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveRoomResponseCopyWith<ActiveRoomResponse> get copyWith => _$ActiveRoomResponseCopyWithImpl<ActiveRoomResponse>(this as ActiveRoomResponse, _$identity);

  /// Serializes this ActiveRoomResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveRoomResponse&&(identical(other.hasActiveRoom, hasActiveRoom) || other.hasActiveRoom == hasActiveRoom)&&(identical(other.roomId, roomId) || other.roomId == roomId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasActiveRoom,roomId);

@override
String toString() {
  return 'ActiveRoomResponse(hasActiveRoom: $hasActiveRoom, roomId: $roomId)';
}


}

/// @nodoc
abstract mixin class $ActiveRoomResponseCopyWith<$Res>  {
  factory $ActiveRoomResponseCopyWith(ActiveRoomResponse value, $Res Function(ActiveRoomResponse) _then) = _$ActiveRoomResponseCopyWithImpl;
@useResult
$Res call({
 bool hasActiveRoom, String? roomId
});




}
/// @nodoc
class _$ActiveRoomResponseCopyWithImpl<$Res>
    implements $ActiveRoomResponseCopyWith<$Res> {
  _$ActiveRoomResponseCopyWithImpl(this._self, this._then);

  final ActiveRoomResponse _self;
  final $Res Function(ActiveRoomResponse) _then;

/// Create a copy of ActiveRoomResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasActiveRoom = null,Object? roomId = freezed,}) {
  return _then(_self.copyWith(
hasActiveRoom: null == hasActiveRoom ? _self.hasActiveRoom : hasActiveRoom // ignore: cast_nullable_to_non_nullable
as bool,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveRoomResponse].
extension ActiveRoomResponsePatterns on ActiveRoomResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveRoomResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveRoomResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveRoomResponse value)  $default,){
final _that = this;
switch (_that) {
case _ActiveRoomResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveRoomResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveRoomResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasActiveRoom,  String? roomId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveRoomResponse() when $default != null:
return $default(_that.hasActiveRoom,_that.roomId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasActiveRoom,  String? roomId)  $default,) {final _that = this;
switch (_that) {
case _ActiveRoomResponse():
return $default(_that.hasActiveRoom,_that.roomId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasActiveRoom,  String? roomId)?  $default,) {final _that = this;
switch (_that) {
case _ActiveRoomResponse() when $default != null:
return $default(_that.hasActiveRoom,_that.roomId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActiveRoomResponse implements ActiveRoomResponse {
  const _ActiveRoomResponse({this.hasActiveRoom = false, this.roomId});
  factory _ActiveRoomResponse.fromJson(Map<String, dynamic> json) => _$ActiveRoomResponseFromJson(json);

@override@JsonKey() final  bool hasActiveRoom;
@override final  String? roomId;

/// Create a copy of ActiveRoomResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveRoomResponseCopyWith<_ActiveRoomResponse> get copyWith => __$ActiveRoomResponseCopyWithImpl<_ActiveRoomResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActiveRoomResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveRoomResponse&&(identical(other.hasActiveRoom, hasActiveRoom) || other.hasActiveRoom == hasActiveRoom)&&(identical(other.roomId, roomId) || other.roomId == roomId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasActiveRoom,roomId);

@override
String toString() {
  return 'ActiveRoomResponse(hasActiveRoom: $hasActiveRoom, roomId: $roomId)';
}


}

/// @nodoc
abstract mixin class _$ActiveRoomResponseCopyWith<$Res> implements $ActiveRoomResponseCopyWith<$Res> {
  factory _$ActiveRoomResponseCopyWith(_ActiveRoomResponse value, $Res Function(_ActiveRoomResponse) _then) = __$ActiveRoomResponseCopyWithImpl;
@override @useResult
$Res call({
 bool hasActiveRoom, String? roomId
});




}
/// @nodoc
class __$ActiveRoomResponseCopyWithImpl<$Res>
    implements _$ActiveRoomResponseCopyWith<$Res> {
  __$ActiveRoomResponseCopyWithImpl(this._self, this._then);

  final _ActiveRoomResponse _self;
  final $Res Function(_ActiveRoomResponse) _then;

/// Create a copy of ActiveRoomResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasActiveRoom = null,Object? roomId = freezed,}) {
  return _then(_ActiveRoomResponse(
hasActiveRoom: null == hasActiveRoom ? _self.hasActiveRoom : hasActiveRoom // ignore: cast_nullable_to_non_nullable
as bool,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
