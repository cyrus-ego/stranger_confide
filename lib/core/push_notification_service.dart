import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../data/datasources/user_remote_datasource.dart';
import '../firebase_options.dart';
import 'network_inspector.dart';
import 'token_storage.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

@lazySingleton
class PushNotificationService {
  PushNotificationService(this._tokenStorage, this._userRemoteDatasource);

  final TokenStorage _tokenStorage;
  final UserRemoteDatasource _userRemoteDatasource;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  StreamSubscription<String>? _tokenRefreshSub;
  StreamSubscription<RemoteMessage>? _openedSub;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    await _requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await syncToken();

    _tokenRefreshSub = _messaging.onTokenRefresh.listen((token) {
      debugPrint('---FCM token refreshed: $token');
      unawaited(_registerToken(token));
    });

    _openedSub = FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageTap);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageTap(initialMessage);
    }
  }

  Future<void> syncToken() async {
    try {
      final token = await _messaging.getToken();
      debugPrint('---FCM token: ${token ?? '(null)'}');
      if (token == null || token.isEmpty || !_tokenStorage.hasToken) return;
      await _registerToken(token);
    } catch (err) {
      log('Unable to sync FCM token: $err', name: 'PushNotification');
    }
  }

  Future<void> unregisterCurrentToken() async {
    if (!_tokenStorage.hasToken) return;

    try {
      final token = await _messaging.getToken();
      if (token == null || token.isEmpty) return;
      await _userRemoteDatasource.unregisterFcmToken({'token': token});
    } catch (err) {
      log('Unable to unregister FCM token: $err', name: 'PushNotification');
    }
  }

  Future<void> _requestPermission() async {
    try {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
    } catch (err) {
      log(
        'Notification permission request failed: $err',
        name: 'PushNotification',
      );
    }
  }

  Future<void> _registerToken(String token) async {
    if (!_tokenStorage.hasToken) return;

    try {
      await _userRemoteDatasource.registerFcmToken({
        'token': token,
        'platform': _platformName(),
      });
    } catch (err) {
      log('Unable to register FCM token: $err', name: 'PushNotification');
    }
  }

  void _handleMessageTap(RemoteMessage message) {
    final roomId = message.data['roomId']?.toString();
    if (roomId == null || roomId.isEmpty) return;

    final kind = message.data['kind']?.toString();
    if (kind != 'chat_message' && kind != 'match_found') return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = appNavigatorKey.currentContext;
      if (context == null) return;
      GoRouter.of(context).go('/chat/$roomId');
    });
  }

  String _platformName() {
    if (kIsWeb) return 'web';

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      TargetPlatform.macOS => 'macos',
      TargetPlatform.windows => 'windows',
      TargetPlatform.linux => 'linux',
      TargetPlatform.fuchsia => 'unknown',
    };
  }

  @disposeMethod
  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    await _openedSub?.cancel();
  }
}
