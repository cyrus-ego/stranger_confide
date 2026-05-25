// ignore_for_file: avoid_print
import 'dart:io';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stranger_confide/data/datasources/auth_remote_datasource.dart';
import 'package:stranger_confide/data/repositories/auth_repository_impl.dart';

/// Integration test gọi API login thật qua Retrofit + envelope interceptor.
///
/// Cần backend chạy tại URL cấu hình. Chạy:
/// ```bash
/// flutter test test/integration/auth_login_integration_test.dart
/// ```
void main() {
  test('POST /auth/login trả AuthTokens khi credentials đúng', () async {
    HttpOverrides.global = null;

    final dio = Dio(BaseOptions(
      baseUrl: 'https://c44e-1-54-23-149.ngrok-free.app/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    ));

    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () => HttpClient(),
    );

    dio.interceptors.add(const ApiEnvelopeInterceptor());

    final api = AuthRemoteDatasource(dio);
    final repo = AuthRepositoryImpl(api);

    final result = await repo.login(
      email: 'boy1@gmail.com',
      password: '123123',
    );

    switch (result) {
      case AppSuccess(:final value):
        expect(value.accessToken, isNotEmpty);
        expect(value.refreshToken, isNotEmpty);
        expect(value.user.email, 'boy1@gmail.com');

        print('PASS — accessToken: ${value.accessToken.substring(0, 20)}...');
        print('PASS — user: ${value.user}');

      case AppFailure(:final error):
        fail('Login thất bại: ${error.code} — ${error.message}');
    }
  });
}
