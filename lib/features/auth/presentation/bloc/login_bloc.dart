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

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) =>
      guard(() async {
        emit(state.copyWith(status: LoginStatus.loading));

        final result = await _repo.login(
          email: event.email,
          password: event.password,
        );

        switch (result) {
          case AppSuccess(:final value):
            _tokenStorage.save(
              accessToken: value.accessToken,
              refreshToken: value.refreshToken,
            );
            emit(state.copyWith(status: LoginStatus.success, tokens: value));
          case AppFailure(:final error):
            emit(state.copyWith(status: LoginStatus.failure));
            throw error;
        }
      });
}
