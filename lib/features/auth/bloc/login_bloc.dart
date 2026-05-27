import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/token_storage.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../domain/usecases/verify_email_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends AppBloc<LoginEvent, LoginState> {
  LoginBloc(
    this._loginUseCase,
    this._registerUseCase,
    this._verifyEmailUseCase,
    this._tokenStorage,
  ) : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<OtpSubmitted>(_onOtpSubmitted);
  }

  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final TokenStorage _tokenStorage;

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) =>
      guard(() async {
        emit(state.copyWith(status: LoginStatus.loading));

        final tokens = (await _loginUseCase(
          LoginParams(email: event.email, password: event.password),
        ))
            .orThrow((_) => emit(state.copyWith(status: LoginStatus.failure)));

        await _tokenStorage.save(
          accessToken: tokens.accessToken ?? '',
          refreshToken: tokens.refreshToken ?? '',
        );
        emit(state.copyWith(status: LoginStatus.success));
      });

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<LoginState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(registerStatus: RegisterStatus.loading));

        final response = (await _registerUseCase(
          RegisterParams(
            email: event.email,
            password: event.password,
            displayName: event.displayName,
            gender: event.gender,
          ),
        ))
            .orThrow(
          (_) => emit(state.copyWith(registerStatus: RegisterStatus.failure)),
        );

        emit(state.copyWith(
          registerStatus: RegisterStatus.success,
          registerMessage: response.message,
          pendingEmail: event.email,
        ));
      });

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<LoginState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(otpStatus: OtpStatus.loading));

        final response = (await _verifyEmailUseCase(
          VerifyEmailParams(email: event.email, otp: event.otp),
        ))
            .orThrow(
          (_) => emit(state.copyWith(otpStatus: OtpStatus.failure)),
        );

        emit(state.copyWith(
          otpStatus: OtpStatus.success,
          otpMessage: response.message,
          pendingEmail: null,
        ));
      });
}
