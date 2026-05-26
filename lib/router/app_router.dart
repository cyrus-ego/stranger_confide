import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/di/injection.dart';
import '../core/token_storage.dart';
import '../features/auth/bloc/login_bloc.dart';
import '../features/auth/bloc/login_state.dart';
import '../features/auth/login_page.dart';
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
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashPage(
        tokenStorage: getIt<TokenStorage>(),
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
        return _ChatPlaceholder(roomId: roomId);
      },
    ),
  ],
);

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

// TODO: Replace with actual ChatPage when chat feature is implemented
class _ChatPlaceholder extends StatelessWidget {
  const _ChatPlaceholder({required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.chat_rounded, size: 64),
            const SizedBox(height: 16),
            Text('Room: $roomId'),
            const SizedBox(height: 8),
            const Text('Chat feature coming soon...'),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
