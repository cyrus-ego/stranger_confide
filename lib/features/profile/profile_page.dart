import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:talk_first/data/models/response/profile_response.dart';

import '../../core/locale/locale_keys.dart';
import '../../domain/enums/chat_preference.dart';
import '../../domain/enums/gender.dart';
import '../../router/app_router.dart';
import 'package:cyr_app_kit/cyr_app_kit.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (prev, curr) =>
              curr.status == ProfileStatus.failure &&
              prev.status != ProfileStatus.failure,
          listener: (context, state) => context.go(AppRoutes.login),
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (prev, curr) => curr.loggedOut && !prev.loggedOut,
          listener: (context, state) => context.go(AppRoutes.login),
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listenWhen: (prev, curr) => curr.updateSuccess && !prev.updateSuccess,
          listener: (context, state) {
            AppSnackBar.show(
              context,
              message: tr(LocaleKeys.profileUpdateSuccess),
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(tr(LocaleKeys.profileTitle))),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return switch (state.status) {
              ProfileStatus.initial ||
              ProfileStatus.loading => const _ProfileShimmer(),
              ProfileStatus.failure => const _ProfileShimmer(),
              ProfileStatus.loaded || ProfileStatus.updating => _ProfileContent(
                data: state.data!,
                isUpdating: state.status == ProfileStatus.updating,
              ),
            };
          },
        ),
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
              height: 360,
              radius: AppSpacing.radiusLg,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.data, required this.isUpdating});

  final ProfileResponse data;
  final bool isUpdating;

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
            imageUrl: user?.avatar,
            fallbackText: user?.displayName,
          ),
          const Gap(AppSpacing.lg),
          Text(
            user?.displayName ?? '',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(AppSpacing.xs),
          Text(
            user?.email ?? '',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(153),
            ),
          ),
          if (isUpdating) ...[
            const Gap(AppSpacing.sm),
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
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
                    label: tr(LocaleKeys.profileGender),
                    value: _genderLabel(profile?.gender ?? ''),
                  ),
                  const Divider(),
                  _EditableInfoRow(
                    icon: Icons.cake_outlined,
                    label: tr(LocaleKeys.profileAge),
                    value: '${profile?.age ?? 0}',
                    onTap: () => _editAge(context, profile?.age ?? 0),
                  ),
                  const Divider(),
                  _EditableInfoRow(
                    icon: Icons.info_outline,
                    label: tr(LocaleKeys.profileBio),
                    value: (profile?.bio?.isEmpty ?? true)
                        ? '—'
                        : profile!.bio!,
                    onTap: () => _editBio(context, profile?.bio ?? ''),
                  ),
                  const Divider(),
                  _EditableInfoRow(
                    icon: Icons.swap_horiz,
                    label: tr(LocaleKeys.profileChatPreference),
                    value: _chatPrefLabel(profile?.chatPreference ?? ''),
                    onTap: () => _editChatPreference(
                      context,
                      profile?.chatPreference ?? '',
                    ),
                  ),
                  const Divider(),
                  _ToggleInfoRow(
                    icon: Icons.notifications_active_outlined,
                    label: tr(LocaleKeys.profileOfflineMatching),
                    description: tr(LocaleKeys.profileOfflineMatchingHint),
                    value: profile?.offlineMatchingEnabled ?? true,
                    enabled: !isUpdating,
                    onChanged: (value) => context.read<ProfileBloc>().add(
                      ProfilePatchField({'offlineMatchingEnabled': value}),
                    ),
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.star_outline,
                    label: tr(LocaleKeys.profileVip),
                    value: (profile?.isVip == true)
                        ? tr(LocaleKeys.profileYes)
                        : tr(LocaleKeys.profileNo),
                    valueColor: (profile?.isVip == true)
                        ? AppColors.secondary
                        : null,
                  ),
                ],
              ),
            ),
          ),
          const Gap(AppSpacing.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, mode) {
                  final isDarkMode = mode == ThemeMode.dark;
                  return TextButton.icon(
                    onPressed: () => context.read<ThemeCubit>().toggle(),
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => RotationTransition(
                        turns: anim,
                        child: FadeTransition(opacity: anim, child: child),
                      ),
                      child: Icon(
                        isDarkMode
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        key: ValueKey(isDarkMode),
                        size: 20,
                      ),
                    ),
                    label: Text(tr(LocaleKeys.commonTheme)),
                  );
                },
              ),
              Container(width: 1, height: 20, color: theme.colorScheme.outline),
              TextButton.icon(
                onPressed: () {
                  final next = context.locale.languageCode == 'vi'
                      ? const Locale('en')
                      : const Locale('vi');
                  context.setLocale(next);
                },
                icon: const Icon(Icons.language, size: 20),
                label: Text(context.locale.languageCode.toUpperCase()),
              ),
            ],
          ),
          const Gap(AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _confirmLogout(context),
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: Text(
                tr(LocaleKeys.profileLogout),
                style: const TextStyle(color: AppColors.error),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
              ),
            ),
          ),
          const Gap(AppSpacing.xl),
        ].animate(interval: 80.ms).fadeIn(duration: 400.ms).slideY(begin: 0.05),
      ),
    );
  }

  // ── Edit dialogs ──

  static void _editAge(BuildContext context, int currentAge) {
    final ctrl = TextEditingController(text: '$currentAge');
    _showFieldDialog(
      context: context,
      title: tr(LocaleKeys.profileAge),
      child: TextField(
        controller: ctrl,
        keyboardType: TextInputType.number,
        autofocus: true,
        decoration: InputDecoration(
          labelText: tr(LocaleKeys.profileAge),
          prefixIcon: const Icon(Icons.cake_outlined),
        ),
      ),
      onSave: () {
        final age = int.tryParse(ctrl.text);
        if (age == null || age < 1) return;
        Navigator.of(context).pop();
        context.read<ProfileBloc>().add(ProfilePatchField({'age': age}));
      },
    );
  }

  static void _editBio(BuildContext context, String currentBio) {
    final ctrl = TextEditingController(text: currentBio);
    _showFieldDialog(
      context: context,
      title: tr(LocaleKeys.profileBio),
      child: TextField(
        controller: ctrl,
        maxLines: 3,
        autofocus: true,
        decoration: InputDecoration(
          labelText: tr(LocaleKeys.profileBio),
          prefixIcon: const Icon(Icons.info_outline),
          alignLabelWithHint: true,
        ),
      ),
      onSave: () {
        Navigator.of(context).pop();
        context.read<ProfileBloc>().add(
          ProfilePatchField({'bio': ctrl.text.trim()}),
        );
      },
    );
  }

  static void _editChatPreference(BuildContext context, String current) {
    _showOptionsDialog(
      context: context,
      title: tr(LocaleKeys.profileChatPreference),
      options: {for (final p in ChatPreference.values) p.value: tr(p.labelKey)},
      current: current,
      onSelect: (v) {
        Navigator.of(context).pop();
        context.read<ProfileBloc>().add(
          ProfilePatchField({'chatPreference': v}),
        );
      },
    );
  }

  // ── Shared dialog helpers ──

  static void _showFieldDialog({
    required BuildContext context,
    required String title,
    required Widget child,
    required VoidCallback onSave,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: child,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(tr(LocaleKeys.profileCancel)),
          ),
          FilledButton(
            onPressed: onSave,
            child: Text(tr(LocaleKeys.profileSave)),
          ),
        ],
      ),
    );
  }

  static void _showOptionsDialog({
    required BuildContext context,
    required String title,
    required Map<String, String> options,
    required String current,
    required ValueChanged<String> onSelect,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(title),
        children: options.entries.map((e) {
          final isSelected = e.key == current;
          return SimpleDialogOption(
            onPressed: () => onSelect(e.key),
            child: Row(
              children: [
                Expanded(child: Text(e.value)),
                if (isSelected)
                  const Icon(Icons.check, color: AppColors.primary, size: 20),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Logout ──

  static void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr(LocaleKeys.profileLogout)),
        content: Text(tr(LocaleKeys.profileLogoutConfirm)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(tr(LocaleKeys.profileCancel)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<ProfileBloc>().add(const ProfileLogout());
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(tr(LocaleKeys.commonConfirm)),
          ),
        ],
      ),
    );
  }

  // ── Label helpers ──

  static String _genderLabel(String gender) {
    final parsed = Gender.tryParse(gender);
    return parsed != null ? tr(parsed.labelKey) : gender;
  }

  static String _chatPrefLabel(String value) {
    for (final p in ChatPreference.values) {
      if (p.value == value) return tr(p.labelKey);
    }
    return value;
  }
}

// ── Row không edit được (Gender, VIP) ──

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
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
          const Gap(AppSpacing.md),
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: valueColor ?? theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Row có thể tap để edit ──

class _EditableInfoRow extends StatelessWidget {
  const _EditableInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: theme.colorScheme.onSurface.withAlpha(100),
            ),
            const Gap(AppSpacing.md),
            SizedBox(
              width: 120,
              child: Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withAlpha(153),
                ),
              ),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: theme.colorScheme.onSurface.withAlpha(80),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleInfoRow extends StatelessWidget {
  const _ToggleInfoRow({
    required this.icon,
    required this.label,
    required this.description,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final String description;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurface.withAlpha(100),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(153),
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.sm),
          Switch.adaptive(value: value, onChanged: enabled ? onChanged : null),
        ],
      ),
    );
  }
}
