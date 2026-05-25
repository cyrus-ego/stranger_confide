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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MatchmakingStarted value)?  started,TResult Function( MatchmakingJoinQueue value)?  joinQueue,TResult Function( MatchmakingLeaveQueue value)?  leaveQueue,TResult Function( MatchmakingPollStatus value)?  pollStatus,TResult Function( MatchmakingUpdatePreference value)?  updatePreference,TResult Function( MatchmakingUpdatePreferredGender value)?  updatePreferredGender,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started(_that);case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue(_that);case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue(_that);case MatchmakingPollStatus() when pollStatus != null:
return pollStatus(_that);case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that);case MatchmakingUpdatePreferredGender() when updatePreferredGender != null:
return updatePreferredGender(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MatchmakingStarted value)  started,required TResult Function( MatchmakingJoinQueue value)  joinQueue,required TResult Function( MatchmakingLeaveQueue value)  leaveQueue,required TResult Function( MatchmakingPollStatus value)  pollStatus,required TResult Function( MatchmakingUpdatePreference value)  updatePreference,required TResult Function( MatchmakingUpdatePreferredGender value)  updatePreferredGender,}){
final _that = this;
switch (_that) {
case MatchmakingStarted():
return started(_that);case MatchmakingJoinQueue():
return joinQueue(_that);case MatchmakingLeaveQueue():
return leaveQueue(_that);case MatchmakingPollStatus():
return pollStatus(_that);case MatchmakingUpdatePreference():
return updatePreference(_that);case MatchmakingUpdatePreferredGender():
return updatePreferredGender(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MatchmakingStarted value)?  started,TResult? Function( MatchmakingJoinQueue value)?  joinQueue,TResult? Function( MatchmakingLeaveQueue value)?  leaveQueue,TResult? Function( MatchmakingPollStatus value)?  pollStatus,TResult? Function( MatchmakingUpdatePreference value)?  updatePreference,TResult? Function( MatchmakingUpdatePreferredGender value)?  updatePreferredGender,}){
final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started(_that);case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue(_that);case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue(_that);case MatchmakingPollStatus() when pollStatus != null:
return pollStatus(_that);case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that);case MatchmakingUpdatePreferredGender() when updatePreferredGender != null:
return updatePreferredGender(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  joinQueue,TResult Function()?  leaveQueue,TResult Function()?  pollStatus,TResult Function( String preference)?  updatePreference,TResult Function( String gender)?  updatePreferredGender,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started();case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue();case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue();case MatchmakingPollStatus() when pollStatus != null:
return pollStatus();case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that.preference);case MatchmakingUpdatePreferredGender() when updatePreferredGender != null:
return updatePreferredGender(_that.gender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  joinQueue,required TResult Function()  leaveQueue,required TResult Function()  pollStatus,required TResult Function( String preference)  updatePreference,required TResult Function( String gender)  updatePreferredGender,}) {final _that = this;
switch (_that) {
case MatchmakingStarted():
return started();case MatchmakingJoinQueue():
return joinQueue();case MatchmakingLeaveQueue():
return leaveQueue();case MatchmakingPollStatus():
return pollStatus();case MatchmakingUpdatePreference():
return updatePreference(_that.preference);case MatchmakingUpdatePreferredGender():
return updatePreferredGender(_that.gender);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  joinQueue,TResult? Function()?  leaveQueue,TResult? Function()?  pollStatus,TResult? Function( String preference)?  updatePreference,TResult? Function( String gender)?  updatePreferredGender,}) {final _that = this;
switch (_that) {
case MatchmakingStarted() when started != null:
return started();case MatchmakingJoinQueue() when joinQueue != null:
return joinQueue();case MatchmakingLeaveQueue() when leaveQueue != null:
return leaveQueue();case MatchmakingPollStatus() when pollStatus != null:
return pollStatus();case MatchmakingUpdatePreference() when updatePreference != null:
return updatePreference(_that.preference);case MatchmakingUpdatePreferredGender() when updatePreferredGender != null:
return updatePreferredGender(_that.gender);case _:
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


class MatchmakingPollStatus extends MatchmakingEvent {
  const MatchmakingPollStatus(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingPollStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchmakingEvent.pollStatus()';
}


}




/// @nodoc


class MatchmakingUpdatePreference extends MatchmakingEvent {
  const MatchmakingUpdatePreference(this.preference): super._();
  

 final  String preference;

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
 String preference
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
as String,
  ));
}


}

/// @nodoc


class MatchmakingUpdatePreferredGender extends MatchmakingEvent {
  const MatchmakingUpdatePreferredGender(this.gender): super._();
  

 final  String gender;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingUpdatePreferredGenderCopyWith<MatchmakingUpdatePreferredGender> get copyWith => _$MatchmakingUpdatePreferredGenderCopyWithImpl<MatchmakingUpdatePreferredGender>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingUpdatePreferredGender&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,gender);

@override
String toString() {
  return 'MatchmakingEvent.updatePreferredGender(gender: $gender)';
}


}

/// @nodoc
abstract mixin class $MatchmakingUpdatePreferredGenderCopyWith<$Res> implements $MatchmakingEventCopyWith<$Res> {
  factory $MatchmakingUpdatePreferredGenderCopyWith(MatchmakingUpdatePreferredGender value, $Res Function(MatchmakingUpdatePreferredGender) _then) = _$MatchmakingUpdatePreferredGenderCopyWithImpl;
@useResult
$Res call({
 String gender
});




}
/// @nodoc
class _$MatchmakingUpdatePreferredGenderCopyWithImpl<$Res>
    implements $MatchmakingUpdatePreferredGenderCopyWith<$Res> {
  _$MatchmakingUpdatePreferredGenderCopyWithImpl(this._self, this._then);

  final MatchmakingUpdatePreferredGender _self;
  final $Res Function(MatchmakingUpdatePreferredGender) _then;

/// Create a copy of MatchmakingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? gender = null,}) {
  return _then(MatchmakingUpdatePreferredGender(
null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
