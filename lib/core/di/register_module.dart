import 'package:cyr_app_kit/cyr_app_kit.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:talk_first/data/datasources/chat_remote_datasource.dart';
import 'package:talk_first/data/datasources/matchmaking_remote_datasource.dart';
import 'package:talk_first/data/datasources/moderation_remote_datasource.dart';
import 'package:talk_first/data/datasources/room_remote_datasource.dart';
import 'package:talk_first/data/datasources/profile_remote_datasource.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  AuthRemoteDatasource authRemoteDatasource(Dio dio) =>
      AuthRemoteDatasource(dio);

  @lazySingleton
  ChatRemoteDatasource chatRemoteDatasource(Dio dio) =>
      ChatRemoteDatasource(dio);

  @lazySingleton
  UserRemoteDatasource userRemoteDatasource(Dio dio) =>
      UserRemoteDatasource(dio);

  @lazySingleton
  ProfileRemoteDatasource profileRemoteDatasource(Dio dio) =>
      ProfileRemoteDatasource(dio);

  @lazySingleton
  MatchmakingRemoteDatasource matchmakingRemoteDatasource(Dio dio) =>
      MatchmakingRemoteDatasource(dio);

  @lazySingleton
  RoomRemoteDatasource roomRemoteDatasource(Dio dio) =>
      RoomRemoteDatasource(dio);

  @lazySingleton
  ModerationRemoteDatasource moderationRemoteDatasource(Dio dio) =>
      ModerationRemoteDatasource(dio);

  @lazySingleton
  PushNotificationService pushNotificationService(
    TokenStorage tokenStorage,
    UserRemoteDatasource userDataSource,
  ) => PushNotificationService(
    tokenStorage,
    PushNotificationHandlers(
      onTokenRegister: (token, platform) => userDataSource.registerFcmToken({
        'token': token,
        'platform': platform,
      }),
      onTokenUnregister: (token) =>
          userDataSource.unregisterFcmToken({'token': token}),
      onMessageTap: _handlePushMessageTap,
    ),
  );
}

void _handlePushMessageTap(RemoteMessage message) {
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
