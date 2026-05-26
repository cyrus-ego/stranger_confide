import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection.dart';
import '../core/token_storage.dart';
import '../domain/usecases/get_active_room_usecase.dart';
import '../features/auth/bloc/login_bloc.dart';
import '../features/auth/bloc/login_state.dart';
import '../features/auth/login_page.dart';
import '../features/chat/bloc/chat_bloc.dart';
import '../features/chat/bloc/chat_event.dart';
import '../features/chat/chat_page.dart';
import '../features/home/home_page.dart';
import '../features/matchmaking/bloc/matchmaking_bloc.dart';
import '../features/matchmaking/bloc/matchmaking_event.dart';
import '../features/matchmaking/matchmaking_page.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/profile/bloc/profile_event.dart';
import '../features/profile/profile_page.dart';
import '../features/splash/splash_page.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const profile = '/profile';
  static const matchmaking = '/matchmaking';
  static const chat = '/chat';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  observers: [_RouterObserver()],
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashPage(
        tokenStorage: getIt<TokenStorage>(),
        getActiveRoomUseCase: getIt<GetActiveRoomUseCase>(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LoginBloc>(),
        child: const _LoginWrapper(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ProfileBloc>()..add(const ProfileLoad()),
        child: const ProfilePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.matchmaking,
      builder: (context, state) => BlocProvider(
        create: (_) =>
            getIt<MatchmakingBloc>()..add(const MatchmakingStarted()),
        child: const MatchmakingPage(),
      ),
    ),
    GoRoute(
      path: '${AppRoutes.chat}/:roomId',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId'] ?? '';
        return BlocProvider(
          create: (_) => getIt<ChatBloc>()..add(ChatStarted(roomId)),
          child: ChatPage(roomId: roomId),
        );
      },
    ),
  ],
);

class _RouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(
      '→ PUSH ${route.settings.name ?? route.settings.toString()}'
      '${previousRoute != null ? ' (from ${previousRoute.settings.name})' : ''}',
      name: 'Router',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(
      '← POP ${route.settings.name ?? route.settings.toString()}'
      '${previousRoute != null ? ' (back to ${previousRoute.settings.name})' : ''}',
      name: 'Router',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log(
      '⇄ REPLACE ${oldRoute?.settings.name} → ${newRoute?.settings.name}',
      name: 'Router',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(
      '✕ REMOVE ${route.settings.name ?? route.settings.toString()}',
      name: 'Router',
    );
  }
}

class _LoginWrapper extends StatelessWidget {
  const _LoginWrapper();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, curr) => curr.status == LoginStatus.success,
      listener: (context, state) => context.go(AppRoutes.home),
      child: const LoginPage(),
    );
  }
}
