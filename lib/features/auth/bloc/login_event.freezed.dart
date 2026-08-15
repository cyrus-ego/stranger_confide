// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginSubmitted value)?  submitted,TResult Function( GoogleLoginSubmitted value)?  googleSubmitted,TResult Function( FacebookLoginSubmitted value)?  facebookSubmitted,TResult Function( RegisterSubmitted value)?  registerSubmitted,TResult Function( OtpSubmitted value)?  otpSubmitted,TResult Function( ResendOtpSubmitted value)?  resendOtpSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginSubmitted() when submitted != null:
return submitted(_that);case GoogleLoginSubmitted() when googleSubmitted != null:
return googleSubmitted(_that);case FacebookLoginSubmitted() when facebookSubmitted != null:
return facebookSubmitted(_that);case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that);case OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that);case ResendOtpSubmitted() when resendOtpSubmitted != null:
return resendOtpSubmitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginSubmitted value)  submitted,required TResult Function( GoogleLoginSubmitted value)  googleSubmitted,required TResult Function( FacebookLoginSubmitted value)  facebookSubmitted,required TResult Function( RegisterSubmitted value)  registerSubmitted,required TResult Function( OtpSubmitted value)  otpSubmitted,required TResult Function( ResendOtpSubmitted value)  resendOtpSubmitted,}){
final _that = this;
switch (_that) {
case LoginSubmitted():
return submitted(_that);case GoogleLoginSubmitted():
return googleSubmitted(_that);case FacebookLoginSubmitted():
return facebookSubmitted(_that);case RegisterSubmitted():
return registerSubmitted(_that);case OtpSubmitted():
return otpSubmitted(_that);case ResendOtpSubmitted():
return resendOtpSubmitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginSubmitted value)?  submitted,TResult? Function( GoogleLoginSubmitted value)?  googleSubmitted,TResult? Function( FacebookLoginSubmitted value)?  facebookSubmitted,TResult? Function( RegisterSubmitted value)?  registerSubmitted,TResult? Function( OtpSubmitted value)?  otpSubmitted,TResult? Function( ResendOtpSubmitted value)?  resendOtpSubmitted,}){
final _that = this;
switch (_that) {
case LoginSubmitted() when submitted != null:
return submitted(_that);case GoogleLoginSubmitted() when googleSubmitted != null:
return googleSubmitted(_that);case FacebookLoginSubmitted() when facebookSubmitted != null:
return facebookSubmitted(_that);case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that);case OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that);case ResendOtpSubmitted() when resendOtpSubmitted != null:
return resendOtpSubmitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password)?  submitted,TResult Function()?  googleSubmitted,TResult Function()?  facebookSubmitted,TResult Function( String email,  String password,  String displayName,  String gender)?  registerSubmitted,TResult Function( String email,  String otp)?  otpSubmitted,TResult Function( String email)?  resendOtpSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginSubmitted() when submitted != null:
return submitted(_that.email,_that.password);case GoogleLoginSubmitted() when googleSubmitted != null:
return googleSubmitted();case FacebookLoginSubmitted() when facebookSubmitted != null:
return facebookSubmitted();case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that.email,_that.password,_that.displayName,_that.gender);case OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that.email,_that.otp);case ResendOtpSubmitted() when resendOtpSubmitted != null:
return resendOtpSubmitted(_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password)  submitted,required TResult Function()  googleSubmitted,required TResult Function()  facebookSubmitted,required TResult Function( String email,  String password,  String displayName,  String gender)  registerSubmitted,required TResult Function( String email,  String otp)  otpSubmitted,required TResult Function( String email)  resendOtpSubmitted,}) {final _that = this;
switch (_that) {
case LoginSubmitted():
return submitted(_that.email,_that.password);case GoogleLoginSubmitted():
return googleSubmitted();case FacebookLoginSubmitted():
return facebookSubmitted();case RegisterSubmitted():
return registerSubmitted(_that.email,_that.password,_that.displayName,_that.gender);case OtpSubmitted():
return otpSubmitted(_that.email,_that.otp);case ResendOtpSubmitted():
return resendOtpSubmitted(_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password)?  submitted,TResult? Function()?  googleSubmitted,TResult? Function()?  facebookSubmitted,TResult? Function( String email,  String password,  String displayName,  String gender)?  registerSubmitted,TResult? Function( String email,  String otp)?  otpSubmitted,TResult? Function( String email)?  resendOtpSubmitted,}) {final _that = this;
switch (_that) {
case LoginSubmitted() when submitted != null:
return submitted(_that.email,_that.password);case GoogleLoginSubmitted() when googleSubmitted != null:
return googleSubmitted();case FacebookLoginSubmitted() when facebookSubmitted != null:
return facebookSubmitted();case RegisterSubmitted() when registerSubmitted != null:
return registerSubmitted(_that.email,_that.password,_that.displayName,_that.gender);case OtpSubmitted() when otpSubmitted != null:
return otpSubmitted(_that.email,_that.otp);case ResendOtpSubmitted() when resendOtpSubmitted != null:
return resendOtpSubmitted(_that.email);case _:
  return null;

}
}

}

/// @nodoc


class LoginSubmitted extends LoginEvent {
  const LoginSubmitted({required this.email, required this.password}): super._();
  

 final  String email;
 final  String password;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginSubmittedCopyWith<LoginSubmitted> get copyWith => _$LoginSubmittedCopyWithImpl<LoginSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSubmitted&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginEvent.submitted(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginSubmittedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $LoginSubmittedCopyWith(LoginSubmitted value, $Res Function(LoginSubmitted) _then) = _$LoginSubmittedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LoginSubmittedCopyWithImpl<$Res>
    implements $LoginSubmittedCopyWith<$Res> {
  _$LoginSubmittedCopyWithImpl(this._self, this._then);

  final LoginSubmitted _self;
  final $Res Function(LoginSubmitted) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(LoginSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GoogleLoginSubmitted extends LoginEvent {
  const GoogleLoginSubmitted(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleLoginSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.googleSubmitted()';
}


}




/// @nodoc


class FacebookLoginSubmitted extends LoginEvent {
  const FacebookLoginSubmitted(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FacebookLoginSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.facebookSubmitted()';
}


}




/// @nodoc


class RegisterSubmitted extends LoginEvent {
  const RegisterSubmitted({required this.email, required this.password, required this.displayName, required this.gender}): super._();
  

 final  String email;
 final  String password;
 final  String displayName;
 final  String gender;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSubmittedCopyWith<RegisterSubmitted> get copyWith => _$RegisterSubmittedCopyWithImpl<RegisterSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSubmitted&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,displayName,gender);

@override
String toString() {
  return 'LoginEvent.registerSubmitted(email: $email, password: $password, displayName: $displayName, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $RegisterSubmittedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $RegisterSubmittedCopyWith(RegisterSubmitted value, $Res Function(RegisterSubmitted) _then) = _$RegisterSubmittedCopyWithImpl;
@useResult
$Res call({
 String email, String password, String displayName, String gender
});




}
/// @nodoc
class _$RegisterSubmittedCopyWithImpl<$Res>
    implements $RegisterSubmittedCopyWith<$Res> {
  _$RegisterSubmittedCopyWithImpl(this._self, this._then);

  final RegisterSubmitted _self;
  final $Res Function(RegisterSubmitted) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? displayName = null,Object? gender = null,}) {
  return _then(RegisterSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OtpSubmitted extends LoginEvent {
  const OtpSubmitted({required this.email, required this.otp}): super._();
  

 final  String email;
 final  String otp;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpSubmittedCopyWith<OtpSubmitted> get copyWith => _$OtpSubmittedCopyWithImpl<OtpSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpSubmitted&&(identical(other.email, email) || other.email == email)&&(identical(other.otp, otp) || other.otp == otp));
}


@override
int get hashCode => Object.hash(runtimeType,email,otp);

@override
String toString() {
  return 'LoginEvent.otpSubmitted(email: $email, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $OtpSubmittedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $OtpSubmittedCopyWith(OtpSubmitted value, $Res Function(OtpSubmitted) _then) = _$OtpSubmittedCopyWithImpl;
@useResult
$Res call({
 String email, String otp
});




}
/// @nodoc
class _$OtpSubmittedCopyWithImpl<$Res>
    implements $OtpSubmittedCopyWith<$Res> {
  _$OtpSubmittedCopyWithImpl(this._self, this._then);

  final OtpSubmitted _self;
  final $Res Function(OtpSubmitted) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? otp = null,}) {
  return _then(OtpSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ResendOtpSubmitted extends LoginEvent {
  const ResendOtpSubmitted({required this.email}): super._();
  

 final  String email;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResendOtpSubmittedCopyWith<ResendOtpSubmitted> get copyWith => _$ResendOtpSubmittedCopyWithImpl<ResendOtpSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResendOtpSubmitted&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'LoginEvent.resendOtpSubmitted(email: $email)';
}


}

/// @nodoc
abstract mixin class $ResendOtpSubmittedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $ResendOtpSubmittedCopyWith(ResendOtpSubmitted value, $Res Function(ResendOtpSubmitted) _then) = _$ResendOtpSubmittedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ResendOtpSubmittedCopyWithImpl<$Res>
    implements $ResendOtpSubmittedCopyWith<$Res> {
  _$ResendOtpSubmittedCopyWithImpl(this._self, this._then);

  final ResendOtpSubmitted _self;
  final $Res Function(ResendOtpSubmitted) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ResendOtpSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
