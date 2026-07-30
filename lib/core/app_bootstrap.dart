import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:go_router/go_router.dart';

import 'auth_refresh_interceptor.dart';
import 'network_inspector.dart';
import 'token_storage.dart';

const _defaultApiBaseUrl = 'https://api.chatvn.online/api';
const _defaultHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  'ngrok-skip-browser-warning': 'true',
};

late final TokenStorage _tokenStorage;

Future<void> bootstrapAppCore() async {
  _tokenStorage = TokenStorage();
  await _tokenStorage.load();
  final chuckInterceptor = networkInspectorInterceptor;
  final baseUrl = dotenv.env['API_BASE_URL'] ?? _defaultApiBaseUrl;
  final authRefreshInterceptor = AuthRefreshInterceptor(
    tokenStorage: _tokenStorage,
    baseUrl: baseUrl,
    defaultHeaders: _defaultHeaders,
    onSessionExpired: () {
      final context = appNavigatorKey.currentContext;
      if (context != null && context.mounted) {
        context.go('/login');
      }
    },
  );

  final config = CoreConfig(
    network: NetworkConfig(
      baseUrl: baseUrl,
      enableLogging: false,
      defaultHeaders: _defaultHeaders,
      headerProvider: _authHeaders,
      extraInterceptors: [
        authRefreshInterceptor,
        if (chuckInterceptor != null) chuckInterceptor,
        if (kDebugMode) CurlLoggerDioInterceptor(printOnSuccess: true),
      ],
    ),
    presentation: const PresentationConfig(
      errorDialogTitle: 'Lỗi',
      errorDialogCloseLabel: 'Đóng',
      connectionErrorMessage: 'Không kết nối được. Thử lại.',
    ),
  );

  AppCore.initialize(
    config,
    setup: (locator) {
      registerHttpClient(config.network, locator: locator);
      authRefreshInterceptor.attach(locator<Dio>());
      registerLazySingletonOverride<TokenStorage>(
        () => _tokenStorage,
        locator: locator,
      );
    },
  );
}

Future<Map<String, String>> _authHeaders() async {
  final token = _tokenStorage.accessToken;
  if (token == null || token.isEmpty) return {};
  return {'Authorization': 'Bearer $token'};
}
