import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/token_storage.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends AppBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase, this._tokenStorage)
      : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final LoginUseCase _loginUseCase;
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
}
