// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileLoad value)?  load,TResult Function( ProfileLoadMe value)?  loadMe,TResult Function( ProfileCreate value)?  create,TResult Function( ProfileUpdate value)?  update,TResult Function( ProfilePatchField value)?  patchField,TResult Function( ProfileLogout value)?  logout,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileLoad() when load != null:
return load(_that);case ProfileLoadMe() when loadMe != null:
return loadMe(_that);case ProfileCreate() when create != null:
return create(_that);case ProfileUpdate() when update != null:
return update(_that);case ProfilePatchField() when patchField != null:
return patchField(_that);case ProfileLogout() when logout != null:
return logout(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileLoad value)  load,required TResult Function( ProfileLoadMe value)  loadMe,required TResult Function( ProfileCreate value)  create,required TResult Function( ProfileUpdate value)  update,required TResult Function( ProfilePatchField value)  patchField,required TResult Function( ProfileLogout value)  logout,}){
final _that = this;
switch (_that) {
case ProfileLoad():
return load(_that);case ProfileLoadMe():
return loadMe(_that);case ProfileCreate():
return create(_that);case ProfileUpdate():
return update(_that);case ProfilePatchField():
return patchField(_that);case ProfileLogout():
return logout(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileLoad value)?  load,TResult? Function( ProfileLoadMe value)?  loadMe,TResult? Function( ProfileCreate value)?  create,TResult? Function( ProfileUpdate value)?  update,TResult? Function( ProfilePatchField value)?  patchField,TResult? Function( ProfileLogout value)?  logout,}){
final _that = this;
switch (_that) {
case ProfileLoad() when load != null:
return load(_that);case ProfileLoadMe() when loadMe != null:
return loadMe(_that);case ProfileCreate() when create != null:
return create(_that);case ProfileUpdate() when update != null:
return update(_that);case ProfilePatchField() when patchField != null:
return patchField(_that);case ProfileLogout() when logout != null:
return logout(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  loadMe,TResult Function( UpdateProfileRequest request)?  create,TResult Function( UpdateProfileRequest request)?  update,TResult Function( Map<String, dynamic> fields)?  patchField,TResult Function()?  logout,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileLoad() when load != null:
return load();case ProfileLoadMe() when loadMe != null:
return loadMe();case ProfileCreate() when create != null:
return create(_that.request);case ProfileUpdate() when update != null:
return update(_that.request);case ProfilePatchField() when patchField != null:
return patchField(_that.fields);case ProfileLogout() when logout != null:
return logout();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  loadMe,required TResult Function( UpdateProfileRequest request)  create,required TResult Function( UpdateProfileRequest request)  update,required TResult Function( Map<String, dynamic> fields)  patchField,required TResult Function()  logout,}) {final _that = this;
switch (_that) {
case ProfileLoad():
return load();case ProfileLoadMe():
return loadMe();case ProfileCreate():
return create(_that.request);case ProfileUpdate():
return update(_that.request);case ProfilePatchField():
return patchField(_that.fields);case ProfileLogout():
return logout();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  loadMe,TResult? Function( UpdateProfileRequest request)?  create,TResult? Function( UpdateProfileRequest request)?  update,TResult? Function( Map<String, dynamic> fields)?  patchField,TResult? Function()?  logout,}) {final _that = this;
switch (_that) {
case ProfileLoad() when load != null:
return load();case ProfileLoadMe() when loadMe != null:
return loadMe();case ProfileCreate() when create != null:
return create(_that.request);case ProfileUpdate() when update != null:
return update(_that.request);case ProfilePatchField() when patchField != null:
return patchField(_that.fields);case ProfileLogout() when logout != null:
return logout();case _:
  return null;

}
}

}

/// @nodoc


class ProfileLoad extends ProfileEvent {
  const ProfileLoad(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoad);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.load()';
}


}




/// @nodoc


class ProfileLoadMe extends ProfileEvent {
  const ProfileLoadMe(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoadMe);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.loadMe()';
}


}




/// @nodoc


class ProfileCreate extends ProfileEvent {
  const ProfileCreate(this.request): super._();
  

 final  UpdateProfileRequest request;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCreateCopyWith<ProfileCreate> get copyWith => _$ProfileCreateCopyWithImpl<ProfileCreate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileCreate&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ProfileEvent.create(request: $request)';
}


}

/// @nodoc
abstract mixin class $ProfileCreateCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileCreateCopyWith(ProfileCreate value, $Res Function(ProfileCreate) _then) = _$ProfileCreateCopyWithImpl;
@useResult
$Res call({
 UpdateProfileRequest request
});


$UpdateProfileRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$ProfileCreateCopyWithImpl<$Res>
    implements $ProfileCreateCopyWith<$Res> {
  _$ProfileCreateCopyWithImpl(this._self, this._then);

  final ProfileCreate _self;
  final $Res Function(ProfileCreate) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(ProfileCreate(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as UpdateProfileRequest,
  ));
}

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateProfileRequestCopyWith<$Res> get request {
  
  return $UpdateProfileRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

/// @nodoc


class ProfileUpdate extends ProfileEvent {
  const ProfileUpdate(this.request): super._();
  

 final  UpdateProfileRequest request;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateCopyWith<ProfileUpdate> get copyWith => _$ProfileUpdateCopyWithImpl<ProfileUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdate&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ProfileEvent.update(request: $request)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileUpdateCopyWith(ProfileUpdate value, $Res Function(ProfileUpdate) _then) = _$ProfileUpdateCopyWithImpl;
@useResult
$Res call({
 UpdateProfileRequest request
});


$UpdateProfileRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$ProfileUpdateCopyWithImpl<$Res>
    implements $ProfileUpdateCopyWith<$Res> {
  _$ProfileUpdateCopyWithImpl(this._self, this._then);

  final ProfileUpdate _self;
  final $Res Function(ProfileUpdate) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(ProfileUpdate(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as UpdateProfileRequest,
  ));
}

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateProfileRequestCopyWith<$Res> get request {
  
  return $UpdateProfileRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

/// @nodoc


class ProfilePatchField extends ProfileEvent {
  const ProfilePatchField(final  Map<String, dynamic> fields): _fields = fields,super._();
  

 final  Map<String, dynamic> _fields;
 Map<String, dynamic> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}


/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePatchFieldCopyWith<ProfilePatchField> get copyWith => _$ProfilePatchFieldCopyWithImpl<ProfilePatchField>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePatchField&&const DeepCollectionEquality().equals(other._fields, _fields));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'ProfileEvent.patchField(fields: $fields)';
}


}

/// @nodoc
abstract mixin class $ProfilePatchFieldCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfilePatchFieldCopyWith(ProfilePatchField value, $Res Function(ProfilePatchField) _then) = _$ProfilePatchFieldCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> fields
});




}
/// @nodoc
class _$ProfilePatchFieldCopyWithImpl<$Res>
    implements $ProfilePatchFieldCopyWith<$Res> {
  _$ProfilePatchFieldCopyWithImpl(this._self, this._then);

  final ProfilePatchField _self;
  final $Res Function(ProfilePatchField) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fields = null,}) {
  return _then(ProfilePatchField(
null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class ProfileLogout extends ProfileEvent {
  const ProfileLogout(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLogout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.logout()';
}


}




// dart format on
