import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/token_storage.dart';
import '../../../core/push_notification_service.dart';
import '../../../domain/services/google_sign_in_service.dart';
import '../../../domain/usecases/google_login_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../domain/usecases/resend_otp_usecase.dart';
import '../../../domain/usecases/verify_email_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends AppBloc<LoginEvent, LoginState> {
  LoginBloc(
    this._loginUseCase,
    this._googleLoginUseCase,
    this._googleSignInService,
    this._registerUseCase,
    this._resendOtpUseCase,
    this._verifyEmailUseCase,
    this._tokenStorage,
    this._pushNotificationService,
  ) : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
    on<GoogleLoginSubmitted>(_onGoogleSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<ResendOtpSubmitted>(_onResendOtpSubmitted);
  }

  final LoginUseCase _loginUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;
  final GoogleSignInService _googleSignInService;
  final RegisterUseCase _registerUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final TokenStorage _tokenStorage;
  final PushNotificationService _pushNotificationService;

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) =>
      guard(() async {
        emit(state.copyWith(status: LoginStatus.loading));

        final tokens = (await _loginUseCase(
          LoginParams(email: event.email, password: event.password),
        )).orThrow((_) => emit(state.copyWith(status: LoginStatus.failure)));

        await _saveTokens(tokens.accessToken, tokens.refreshToken);
        emit(state.copyWith(status: LoginStatus.success));
      });

  Future<void> _onGoogleSubmitted(
    GoogleLoginSubmitted event,
    Emitter<LoginState> emit,
  ) => guard(() async {
    emit(state.copyWith(status: LoginStatus.loading));

    String? idToken;
    try {
      idToken = await _googleSignInService.signIn();
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.failure));
      rethrow;
    }

    if (idToken == null) {
      emit(state.copyWith(status: LoginStatus.initial));
      return;
    }

    final tokens = (await _googleLoginUseCase(
      idToken,
    )).orThrow((_) => emit(state.copyWith(status: LoginStatus.failure)));

    await _saveTokens(tokens.accessToken, tokens.refreshToken);
    emit(state.copyWith(status: LoginStatus.success));
  });

  Future<void> _saveTokens(String? accessToken, String? refreshToken) async {
    await _tokenStorage.save(
      accessToken: accessToken ?? '',
      refreshToken: refreshToken ?? '',
    );
    await _pushNotificationService.syncToken();
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<LoginState> emit,
  ) => guard(() async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));

    final response =
        (await _registerUseCase(
          RegisterParams(
            email: event.email,
            password: event.password,
            displayName: event.displayName,
            gender: event.gender,
          ),
        )).orThrow(
          (_) => emit(state.copyWith(registerStatus: RegisterStatus.failure)),
        );

    emit(
      state.copyWith(
        registerStatus: RegisterStatus.success,
        registerMessage: response.message,
        pendingEmail: event.email,
      ),
    );
  });

  Future<void> _onOtpSubmitted(OtpSubmitted event, Emitter<LoginState> emit) =>
      guard(() async {
        emit(state.copyWith(otpStatus: OtpStatus.loading));

        final response = (await _verifyEmailUseCase(
          VerifyEmailParams(email: event.email, otp: event.otp),
        )).orThrow((_) => emit(state.copyWith(otpStatus: OtpStatus.failure)));

        emit(
          state.copyWith(
            otpStatus: OtpStatus.success,
            otpMessage: response.message,
            pendingEmail: null,
          ),
        );
      });

  Future<void> _onResendOtpSubmitted(
    ResendOtpSubmitted event,
    Emitter<LoginState> emit,
  ) => guard(() async {
    emit(state.copyWith(resendOtpStatus: OtpStatus.loading));

    final result = await _resendOtpUseCase(ResendOtpParams(email: event.email));
    result.orThrow(
      (_) => emit(state.copyWith(resendOtpStatus: OtpStatus.failure)),
    );

    emit(state.copyWith(resendOtpStatus: OtpStatus.success));
    emit(state.copyWith(resendOtpStatus: OtpStatus.initial));
  });
}
