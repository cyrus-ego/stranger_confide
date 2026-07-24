import 'package:dio/dio.dart';
import 'package:stranger_confide/data/models/response/auth_tokens.dart';

import 'token_storage.dart';

class AuthRefreshInterceptor extends Interceptor {
  AuthRefreshInterceptor({
    required TokenStorage tokenStorage,
    required String baseUrl,
    required Map<String, String> defaultHeaders,
    Dio? refreshDio,
  }) : _tokenStorage = tokenStorage,
       _refreshDio =
           refreshDio ??
           Dio(BaseOptions(baseUrl: baseUrl, headers: defaultHeaders));

  static const _retryExtraKey = 'auth_refresh_retry';

  final TokenStorage _tokenStorage;
  final Dio _refreshDio;

  Dio? _dio;
  Future<AuthTokens?>? _refreshing;

  void attach(Dio dio) {
    _dio = dio;
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final dio = _dio;
    if (dio == null || !_shouldRefresh(err)) {
      handler.next(err);
      return;
    }

    final tokens = await _refreshTokens();
    final accessToken = tokens?.accessToken;
    if (accessToken == null || accessToken.isEmpty) {
      handler.next(err);
      return;
    }

    final requestOptions = err.requestOptions;
    requestOptions.extra[_retryExtraKey] = true;
    requestOptions.headers['Authorization'] = 'Bearer $accessToken';

    try {
      final response = await dio.fetch<dynamic>(requestOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRefresh(DioException err) {
    if (err.response?.statusCode != 401) return false;
    if (err.requestOptions.extra[_retryExtraKey] == true) return false;
    if (_isPublicAuthRequest(err.requestOptions)) return false;

    final refreshToken = _tokenStorage.refreshToken;
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  bool _isPublicAuthRequest(RequestOptions options) {
    final path = options.uri.path;
    return path.endsWith('/auth/login') ||
        path.endsWith('/auth/register') ||
        path.endsWith('/auth/verify-email') ||
        path.endsWith('/auth/resend-otp') ||
        path.endsWith('/auth/refresh') ||
        path.endsWith('/auth/google') ||
        path.endsWith('/auth/google/callback') ||
        path.endsWith('/auth/facebook') ||
        path.endsWith('/auth/facebook/callback');
  }

  Future<AuthTokens?> _refreshTokens() {
    final current = _refreshing;
    if (current != null) return current;

    final refreshing = _doRefreshTokens();
    _refreshing = refreshing;
    return refreshing.whenComplete(() {
      if (identical(_refreshing, refreshing)) {
        _refreshing = null;
      }
    });
  }

  Future<AuthTokens?> _doRefreshTokens() async {
    final refreshToken = _tokenStorage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) return null;

    try {
      final response = await _refreshDio.post<dynamic>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      final tokenJson = _extractTokenJson(response.data);
      if (tokenJson == null) return null;

      final tokens = AuthTokens.fromJson(tokenJson);
      final accessToken = tokens.accessToken;
      if (accessToken == null || accessToken.isEmpty) return null;

      await _tokenStorage.save(
        accessToken: accessToken,
        refreshToken: tokens.refreshToken ?? refreshToken,
      );
      return tokens;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        await _tokenStorage.clear();
      }
      return null;
    }
  }

  Map<String, dynamic>? _extractTokenJson(Object? data) {
    final map = _asJsonMap(data);
    if (map == null) return null;
    if (map.containsKey('accessToken')) return map;

    final nestedData = map['data'];
    final nestedMap = _asJsonMap(nestedData);
    if (nestedMap != null && nestedMap.containsKey('accessToken')) {
      return nestedMap;
    }
    return null;
  }

  Map<String, dynamic>? _asJsonMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}
