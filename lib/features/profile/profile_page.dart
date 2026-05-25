import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:stranger_confide/data/models/response/profile_response.dart';

import '../../shared/widgets/app_shimmer.dart';
import '../../shared/widgets/gradient_avatar.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

class ProfilePage extends BlocHostPage {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BlocHostPageState<ProfilePage> {
  @override
  Stream<String> get errorStream => context.read<ProfileBloc>().errorStream;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return switch (state.status) {
            ProfileStatus.initial ||
            ProfileStatus.loading =>
              const _ProfileShimmer(),
            ProfileStatus.failure => _ProfileError(
                onRetry: () =>
                    context.read<ProfileBloc>().add(const ProfileLoad()),
              ),
            ProfileStatus.loaded => _ProfileContent(data: state.data!),
          };
        },
      ),
    );
  }
}

class _ProfileShimmer extends StatelessWidget {
  const _ProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const Gap(AppSpacing.lg),
            const ShimmerBox(width: 96, height: 96, radius: 48),
            const Gap(AppSpacing.lg),
            const ShimmerBox(width: 160, height: 24),
            const Gap(AppSpacing.sm),
            const ShimmerBox(width: 200, height: 16),
            const Gap(AppSpacing.xl),
            ShimmerBox(
              width: double.infinity,
              height: 280,
              radius: AppSpacing.radiusLg,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileError extends StatelessWidget {
  const _ProfileError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 64,
              color: AppColors.textMuted,
            ),
            const Gap(AppSpacing.lg),
            Text(
              'Không tải được profile',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(AppSpacing.xl),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.data});

  final ProfileResponse data;

  @override
  Widget build(BuildContext context) {
    final user = data.user;
    final profile = data.profile;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        children: [
          GradientAvatar(
            radius: 48,
            imageUrl: user.avatar,
            fallbackText: user.displayName,
          ),
          const Gap(AppSpacing.lg),
          Text(
            user.displayName,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(AppSpacing.xs),
          Text(
            user.email,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(AppSpacing.xl),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.person_outline,
                    label: 'Giới tính',
                    value: _genderLabel(profile.gender),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.cake_outlined,
                    label: 'Tuổi',
                    value: '${profile.age}',
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.chat_bubble_outline,
                    label: 'Muốn chat với',
                    value: _genderLabel(profile.preferredGender),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.verified_outlined,
                    label: 'Role',
                    value: user.role,
                  ),
                  if (profile.bio.isNotEmpty) ...[
                    const Divider(),
                    _InfoRow(
                      icon: Icons.info_outline,
                      label: 'Bio',
                      value: profile.bio,
                    ),
                  ],
                  const Divider(),
                  _InfoRow(
                    icon: Icons.star_outline,
                    label: 'VIP',
                    value: profile.isVip ? 'Có' : 'Không',
                    valueColor:
                        profile.isVip ? AppColors.secondary : null,
                  ),
                ],
              ),
            ),
          ),
        ]
            .animate(interval: 100.ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.05),
      ),
    );
  }

  static String _genderLabel(String gender) => switch (gender) {
        'male' => 'Nam',
        'female' => 'Nữ',
        _ => gender,
      };
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textMuted),
          const Gap(AppSpacing.md),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
