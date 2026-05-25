import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/auth_tokens.dart';

part 'login_state.freezed.dart';

enum LoginStatus { initial, loading, success, failure }

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    AuthTokens? tokens,
  }) = _LoginState;
}
