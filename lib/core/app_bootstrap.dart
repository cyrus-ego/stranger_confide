import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'token_storage.dart';

const _defaultApiBaseUrl =
    'https://api.chatvn.online/api';

late final TokenStorage _tokenStorage;

Future<void> bootstrapAppCore() async {
  _tokenStorage = TokenStorage();
  await _tokenStorage.load();

  final config = CoreConfig(
    network: NetworkConfig(
      baseUrl: dotenv.env['API_BASE_URL'] ?? _defaultApiBaseUrl,
      enableLogging: false,
      defaultHeaders: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
      headerProvider: _authHeaders,
      extraInterceptors: [
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
