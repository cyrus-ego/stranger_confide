import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

enum LoginStatus { initial, loading, success, failure }

enum RegisterStatus { initial, loading, success, failure }

enum OtpStatus { initial, loading, success, failure }

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    @Default(RegisterStatus.initial) RegisterStatus registerStatus,
    @Default(OtpStatus.initial) OtpStatus otpStatus,
    String? registerMessage,
    String? otpMessage,
    String? pendingEmail,
    @Default(OtpStatus.initial) OtpStatus resendOtpStatus,
  }) = _LoginState;
}
