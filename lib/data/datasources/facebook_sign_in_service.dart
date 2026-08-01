import 'dart:math';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/facebook_login_token.dart' as domain;
import '../../domain/services/facebook_sign_in_service.dart';

@LazySingleton(as: FacebookSignInService)
class FacebookSignInServiceImpl implements FacebookSignInService {
  FacebookSignInServiceImpl() : _facebookAuth = FacebookAuth.instance;

  final FacebookAuth _facebookAuth;

  @override
  Future<domain.FacebookLoginToken?> signIn() async {
    final nonce = _generateNonce();
    final result = await _facebookAuth.login(
      permissions: const ['public_profile'],
      loginTracking: LoginTracking.limited,
      nonce: nonce,
    );

    switch (result.status) {
      case LoginStatus.success:
        final token = result.accessToken;
        if (token == null || token.tokenString.isEmpty) {
          throw const FacebookAccessTokenMissingException();
        }

        final isLimited = token.type == AccessTokenType.limited;
        return domain.FacebookLoginToken(
          accessToken: token.tokenString,
          type: isLimited
              ? domain.FacebookTokenType.limited
              : domain.FacebookTokenType.classic,
          nonce: isLimited
              ? (token is LimitedToken ? token.nonce : nonce)
              : null,
        );

      case LoginStatus.cancelled:
        return null;

      case LoginStatus.failed:
      case LoginStatus.operationInProgress:
        throw FacebookSignInException(
          result.message ?? 'Facebook Sign-In failed: ${result.status.name}',
        );
    }
  }

  @override
  Future<void> signOut() => _facebookAuth.logOut();

  String _generateNonce([int length = 32]) {
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
  }
}

class FacebookSignInException implements Exception {
  const FacebookSignInException(this.message);

  final String message;

  @override
  String toString() => message;
}

class FacebookAccessTokenMissingException implements Exception {
  const FacebookAccessTokenMissingException();

  @override
  String toString() => 'Facebook Sign-In did not return a token.';
}
