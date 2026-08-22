import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cyr_app_kit/cyr_app_kit.dart';
import 'package:talk_first/data/models/response/auth_tokens.dart';
import 'package:talk_first/data/models/response/register_response.dart';
import 'package:talk_first/domain/models/facebook_login_token.dart';
import 'package:talk_first/domain/repositories/auth_repository.dart';
import 'package:talk_first/domain/services/facebook_sign_in_service.dart';
import 'package:talk_first/domain/services/google_sign_in_service.dart';
import 'package:talk_first/domain/usecases/facebook_login_usecase.dart';
import 'package:talk_first/domain/usecases/google_login_usecase.dart';
import 'package:talk_first/domain/usecases/login_usecase.dart';
import 'package:talk_first/domain/usecases/register_usecase.dart';
import 'package:talk_first/domain/usecases/resend_otp_usecase.dart';
import 'package:talk_first/domain/usecases/verify_email_usecase.dart';
import 'package:talk_first/features/auth/bloc/login_bloc.dart';
import 'package:talk_first/features/auth/bloc/login_event.dart';
import 'package:talk_first/features/auth/bloc/login_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeAuthRepository repository;
  late _FakeGoogleSignInService googleSignInService;
  late _FakeFacebookSignInService facebookSignInService;
  late _FakePushNotificationService pushNotificationService;
  late TokenStorage tokenStorage;
  late LoginBloc bloc;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = _FakeAuthRepository();
    googleSignInService = _FakeGoogleSignInService();
    facebookSignInService = _FakeFacebookSignInService();
    pushNotificationService = _FakePushNotificationService();
    tokenStorage = TokenStorage();
    bloc = LoginBloc(
      LoginUseCase(repository),
      GoogleLoginUseCase(repository),
      googleSignInService,
      FacebookLoginUseCase(repository),
      facebookSignInService,
      RegisterUseCase(repository),
      ResendOtpUseCase(repository),
      VerifyEmailUseCase(repository),
      tokenStorage,
      pushNotificationService,
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

  test('sends Facebook Limited Login token and nonce to backend', () async {
    facebookSignInService.token = const FacebookLoginToken(
      accessToken: 'facebook-limited-token',
      type: FacebookTokenType.limited,
      nonce: 'facebook-nonce',
    );
    repository.facebookTokens = const AuthTokens(
      accessToken: 'facebook-app-access-token',
      refreshToken: 'facebook-app-refresh-token',
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

    bloc.add(const FacebookLoginSubmitted());
    await expectation;

    expect(
      repository.receivedFacebookToken?.accessToken,
      'facebook-limited-token',
    );
    expect(repository.receivedFacebookToken?.type, FacebookTokenType.limited);
    expect(repository.receivedFacebookToken?.nonce, 'facebook-nonce');
    expect(tokenStorage.accessToken, 'facebook-app-access-token');
    expect(tokenStorage.refreshToken, 'facebook-app-refresh-token');
  });

  test('returns to initial state when Facebook login is canceled', () async {
    facebookSignInService.token = null;

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

    bloc.add(const FacebookLoginSubmitted());
    await expectation;

    expect(repository.receivedFacebookToken, isNull);
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

class _FakeFacebookSignInService implements FacebookSignInService {
  FacebookLoginToken? token;

  @override
  Future<FacebookLoginToken?> signIn() async => token;

  @override
  Future<void> signOut() async {}
}

class _FakePushNotificationService implements PushNotificationService {
  int syncTokenCount = 0;

  @override
  final PushNotificationHandlers handlers = PushNotificationHandlers(
    onTokenRegister: (token, platform) async {},
    onTokenUnregister: (token) async {},
  );

  @override
  Future<void> initialize() async {}

  @override
  Future<void> syncToken() async {
    syncTokenCount++;
  }

  @override
  Future<void> unregisterCurrentToken() async {}

  @override
  Future<void> dispose() async {}
}

class _FakeAuthRepository implements AuthRepository {
  AuthTokens googleTokens = const AuthTokens();
  AuthTokens facebookTokens = const AuthTokens();
  String? receivedGoogleIdToken;
  FacebookLoginToken? receivedFacebookToken;

  @override
  Future<AppResult<AuthTokens>> facebookLogin({
    required FacebookLoginToken token,
  }) async {
    receivedFacebookToken = token;
    return AppSuccess(facebookTokens);
  }

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
