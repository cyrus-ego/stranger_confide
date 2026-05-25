import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/token_storage.dart';
import '../../data/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends AppBloc<LoginEvent, LoginState> {
  LoginBloc(this._repo, this._tokenStorage) : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _repo;
  final TokenStorage _tokenStorage;

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) =>
      guard(() async {
        emit(state.copyWith(status: LoginStatus.loading));

        final tokens = (await _repo.login(
          email: event.email,
          password: event.password,
        )).orThrow((_) => emit(state.copyWith(status: LoginStatus.failure)));

        _tokenStorage.save(
          accessToken: tokens.accessToken,
          refreshToken: tokens.refreshToken,
        );
        emit(state.copyWith(status: LoginStatus.success, tokens: tokens));
      });
}
