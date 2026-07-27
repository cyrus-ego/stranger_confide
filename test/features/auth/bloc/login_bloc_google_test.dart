import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stranger_confide/core/token_storage.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';
import 'package:stranger_confide/data/models/response/register_response.dart';
import 'package:stranger_confide/domain/repositories/auth_repository.dart';
import 'package:stranger_confide/domain/services/google_sign_in_service.dart';
import 'package:stranger_confide/domain/usecases/google_login_usecase.dart';
import 'package:stranger_confide/domain/usecases/login_usecase.dart';
import 'package:stranger_confide/domain/usecases/register_usecase.dart';
import 'package:stranger_confide/domain/usecases/resend_otp_usecase.dart';
import 'package:stranger_confide/domain/usecases/verify_email_usecase.dart';
import 'package:stranger_confide/features/auth/bloc/login_bloc.dart';
import 'package:stranger_confide/features/auth/bloc/login_event.dart';
import 'package:stranger_confide/features/auth/bloc/login_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeAuthRepository repository;
  late _FakeGoogleSignInService googleSignInService;
  late TokenStorage tokenStorage;
  late LoginBloc bloc;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = _FakeAuthRepository();
    googleSignInService = _FakeGoogleSignInService();
    tokenStorage = TokenStorage();
    bloc = LoginBloc(
      LoginUseCase(repository),
      GoogleLoginUseCase(repository),
      googleSignInService,
      RegisterUseCase(repository),
      ResendOtpUseCase(repository),
      VerifyEmailUseCase(repository),
      tokenStorage,
    );
  });

  tearDown(() => bloc.close());

  test('sends Google ID token to backend and stores app tokens', () async {
    googleSignInService.idToken = 'google-id-token';
    repository.googleTokens = const AuthTokens(
      accessToken: 'access-token',
      refreshToken: 'refresh-token',
    );

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<LoginState>().having(
          (state) => state.status,
          'status',
          LoginStatus.loading,
        ),
        isA<LoginState>().having(
          (state) => state.status,
          'status',
          LoginStatus.success,
        ),
      ]),
    );

    bloc.add(const GoogleLoginSubmitted());
    await expectation;

    expect(repository.receivedGoogleIdToken, 'google-id-token');
    expect(tokenStorage.accessToken, 'access-token');
    expect(tokenStorage.refreshToken, 'refresh-token');
  });

  test('returns to initial state when account selection is canceled', () async {
    googleSignInService.idToken = null;

    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<LoginState>().having(
          (state) => state.status,
          'status',
          LoginStatus.loading,
        ),
        isA<LoginState>().having(
          (state) => state.status,
          'status',
          LoginStatus.initial,
        ),
      ]),
    );

    bloc.add(const GoogleLoginSubmitted());
    await expectation;

    expect(repository.receivedGoogleIdToken, isNull);
    expect(tokenStorage.hasToken, isFalse);
  });
}

class _FakeGoogleSignInService implements GoogleSignInService {
  String? idToken;

  @override
  Future<String?> signIn() async => idToken;

  @override
  Future<void> signOut() async {}
}

class _FakeAuthRepository implements AuthRepository {
  AuthTokens googleTokens = const AuthTokens();
  String? receivedGoogleIdToken;

  @override
  Future<AppResult<AuthTokens>> googleLogin({required String idToken}) async {
    receivedGoogleIdToken = idToken;
    return AppSuccess(googleTokens);
  }

  @override
  Future<AppResult<AuthTokens>> login({
    required String email,
    required String password,
  }) async => AppSuccess(googleTokens);

  @override
  Future<AppResult<RegisterResponse>> register({
    required String email,
    required String password,
    required String displayName,
    required String gender,
  }) async => const AppSuccess(RegisterResponse());

  @override
  Future<AppResult<RegisterResponse>> resendOtp({
    required String email,
  }) async => const AppSuccess(RegisterResponse());

  @override
  Future<AppResult<RegisterResponse>> verifyEmail({
    required String email,
    required String otp,
  }) async => const AppSuccess(RegisterResponse());
}
