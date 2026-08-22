// ignore_for_file: avoid_print
import 'dart:io';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talk_first/data/datasources/auth_remote_datasource.dart';
import 'package:talk_first/data/repositories/auth_repository_impl.dart';

/// Integration test gọi API login thật qua Retrofit + envelope interceptor.
///
/// Cần backend chạy tại URL cấu hình. Chạy:
/// ```bash
/// INTEGRATION_API_BASE_URL=https://api.example.com/api \
/// INTEGRATION_TEST_EMAIL=user@example.com \
/// INTEGRATION_TEST_PASSWORD=secret \
/// flutter test test/integration/auth_login_integration_test.dart
/// ```
void main() {
  final baseUrl = Platform.environment['INTEGRATION_API_BASE_URL'];
  final email = Platform.environment['INTEGRATION_TEST_EMAIL'];
  final password = Platform.environment['INTEGRATION_TEST_PASSWORD'];
  final missingConfiguration = [
    baseUrl,
    email,
    password,
  ].any((value) => value == null || value.trim().isEmpty);

  test(
    'POST /auth/login trả AuthTokens khi credentials đúng',
    () async {
      HttpOverrides.global = null;

      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl!,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': 'true',
          },
        ),
      );

      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () => HttpClient(),
      );

      dio.interceptors.add(const ApiEnvelopeInterceptor());

      final api = AuthRemoteDatasource(dio);
      final repo = AuthRepositoryImpl(api);

      final result = await repo.login(email: email!, password: password!);

      switch (result) {
        case AppSuccess(:final value):
          expect(value.accessToken, isNotEmpty);
          expect(value.refreshToken, isNotEmpty);
          expect(value.user?.email, email);

          print('PASS — user: ${value.user}');

        case AppFailure(:final error):
          fail('Login thất bại: ${error.code} — ${error.message}');
      }
    },
    skip: missingConfiguration
        ? 'Set INTEGRATION_API_BASE_URL, INTEGRATION_TEST_EMAIL, and '
              'INTEGRATION_TEST_PASSWORD to run this live API test.'
        : false,
  );
}
