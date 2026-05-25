import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/locale/locale_keys.dart';
import '../../core/token_storage.dart';
import '../../router/app_router.dart';
import '../../theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.tokenStorage});

  final TokenStorage tokenStorage;

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

    if (widget.tokenStorage.hasToken) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
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
