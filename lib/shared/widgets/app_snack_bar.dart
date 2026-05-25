import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

enum SnackBarType { success, error, info }

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();

    final (icon, color) = switch (type) {
      SnackBarType.success => (Icons.check_circle_rounded, AppColors.success),
      SnackBarType.error => (Icons.error_rounded, AppColors.error),
      SnackBarType.info => (Icons.info_rounded, AppColors.primary),
    };

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const Gap(AppSpacing.md),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: color.withAlpha(230),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        duration: duration,
        dismissDirection: DismissDirection.horizontal,
        elevation: 6,
      ),
    );
  }
}
