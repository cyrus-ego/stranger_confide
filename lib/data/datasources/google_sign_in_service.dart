import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../domain/services/google_sign_in_service.dart';

@LazySingleton(as: GoogleSignInService)
class GoogleSignInServiceImpl implements GoogleSignInService {
  GoogleSignInServiceImpl() : _googleSignIn = GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;
  Future<void>? _initialization;

  @override
  Future<String?> signIn() async {
    await (_initialization ??= _initialize());

    try {
      final account = await _googleSignIn.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw const GoogleIdTokenMissingException();
      }
      return idToken;
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await (_initialization ??= _initialize());
    await _googleSignIn.signOut();
  }

  Future<void> _initialize() {
    final serverClientId = _requiredEnv('GOOGLE_SERVER_CLIENT_ID');
    final clientId = defaultTargetPlatform == TargetPlatform.iOS
        ? _requiredEnv('GOOGLE_IOS_CLIENT_ID')
        : null;

    return _googleSignIn.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
    );
  }

  String _requiredEnv(String key) {
    final value = dotenv.env[key]?.trim();
    if (value == null || value.isEmpty) {
      throw GoogleSignInConfigurationException(key);
    }
    return value;
  }
}

class GoogleSignInConfigurationException implements Exception {
  const GoogleSignInConfigurationException(this.missingKey);

  final String missingKey;

  @override
  String toString() => 'Missing Google Sign-In configuration: $missingKey';
}

class GoogleIdTokenMissingException implements Exception {
  const GoogleIdTokenMissingException();

  @override
  String toString() => 'Google Sign-In did not return an ID token.';
}
