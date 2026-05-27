import 'dart:developer';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection.dart';
import '../core/token_storage.dart';
import '../domain/usecases/get_active_room_usecase.dart';
import '../domain/usecases/get_profile_usecase.dart';
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
import '../features/profile/create_profile_page.dart';
import '../features/profile/profile_page.dart';
import '../features/splash/splash_page.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const profile = '/profile';
  static const createProfile = '/create-profile';
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
        getProfileUseCase: getIt<GetProfileUseCase>(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LoginBloc>(),
        child: _LoginWrapper(
          getProfileUseCase: getIt<GetProfileUseCase>(),
        ),
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
      path: AppRoutes.createProfile,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<ProfileBloc>()..add(const ProfileLoadMe()),
        child: const CreateProfilePage(),
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
  const _LoginWrapper({required this.getProfileUseCase});

  final GetProfileUseCase getProfileUseCase;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (prev, curr) => curr.status == LoginStatus.success,
      listener: (context, state) async {
        final result = await getProfileUseCase();
        if (!context.mounted) return;

        if (result case AppSuccess(:final value)) {
          if (value.isComplete == true) {
            context.go(AppRoutes.home);
            return;
          }
          context.go(AppRoutes.createProfile);
          return;
        }

        // Profile not found (new user) → create profile
        context.go(AppRoutes.createProfile);
      },
      child: const LoginPage(),
    );
  }
}
