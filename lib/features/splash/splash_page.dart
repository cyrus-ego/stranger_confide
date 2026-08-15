import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/locale/locale_keys.dart';
import 'package:cyr_app_kit/cyr_app_kit.dart';
import '../../domain/usecases/get_active_room_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    required this.tokenStorage,
    required this.getActiveRoomUseCase,
    required this.getProfileUseCase,
  });

  final TokenStorage tokenStorage;
  final GetActiveRoomUseCase getActiveRoomUseCase;
  final GetProfileUseCase getProfileUseCase;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    if (!widget.tokenStorage.hasToken) {
      context.go(AppRoutes.login);
      return;
    }

    // Check active room
    final roomResult = await widget.getActiveRoomUseCase();
    if (!mounted) return;

    if (roomResult case AppSuccess(:final value)) {
      if (value.hasActiveRoom && value.roomId != null) {
        context.go('${AppRoutes.chat}/${value.roomId}');
        return;
      }
    }

    // Check profile completeness
    final profileResult = await widget.getProfileUseCase();
    if (!mounted) return;

    if (profileResult case AppSuccess(:final value)) {
      if (value.isComplete == true) {
        context.go(AppRoutes.home);
        return;
      }
      context.go(AppRoutes.createProfile);
      return;
    }

    // Profile fetch failed (new user or error) → create profile
    context.go(AppRoutes.createProfile);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradient = isDark
        ? AppColors.darkGradientBackground
        : AppColors.lightGradientBackground;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_bubble_rounded,
                size: 72,
                color: theme.colorScheme.primary,
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.5, 0.5)),
              const SizedBox(height: 24),
              Text(
                tr(LocaleKeys.appName),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 300.ms)
                  .slideY(begin: 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
