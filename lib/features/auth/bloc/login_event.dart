import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent extends BlocEvent with _$LoginEvent {
  const LoginEvent._();

  const factory LoginEvent.submitted({
    required String email,
    required String password,
  }) = LoginSubmitted;

  const factory LoginEvent.registerSubmitted({
    required String email,
    required String password,
    required String displayName,
    required String gender,
  }) = RegisterSubmitted;

  const factory LoginEvent.otpSubmitted({
    required String email,
    required String otp,
  }) = OtpSubmitted;
}
