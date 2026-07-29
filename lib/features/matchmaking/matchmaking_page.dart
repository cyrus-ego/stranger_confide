import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../core/locale/locale_keys.dart';
import '../../domain/enums/chat_preference.dart';
import '../../router/app_router.dart';
import '../../shared/widgets/app_snack_bar.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'bloc/matchmaking_bloc.dart';
import 'bloc/matchmaking_event.dart';
import 'bloc/matchmaking_state.dart';

class MatchmakingPage extends BlocHostPage {
  const MatchmakingPage({super.key});

  @override
  State<MatchmakingPage> createState() => _MatchmakingPageState();
}

class _MatchmakingPageState extends BlocHostPageState<MatchmakingPage>
    with WidgetsBindingObserver {
  @override
  Stream<String> get errorStream => context.read<MatchmakingBloc>().errorStream;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    final bloc = context.read<MatchmakingBloc>();
    if (state == AppLifecycleState.resumed) {
      bloc
        ..add(const MatchmakingVisibilityChanged(true))
        ..add(const MatchmakingAppResumed());
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.detached) {
      bloc.add(const MatchmakingVisibilityChanged(false));
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gradient = isDark
        ? AppColors.darkGradientBackground
        : AppColors.lightGradientBackground;

    return MultiBlocListener(
      listeners: [
        BlocListener<MatchmakingBloc, MatchmakingState>(
          listenWhen: (prev, curr) =>
              curr.status == MatchmakingStatus.matched &&
              prev.status != MatchmakingStatus.matched,
          listener: (context, state) {
            // AppSnackBar.show(
            //   context,
            //   message: tr(LocaleKeys.matchmakingMatchFound),
            // );
            if (state.roomId != null && state.roomId!.isNotEmpty) {
              context.go('${AppRoutes.chat}/${state.roomId}');
            }
          },
        ),
        BlocListener<MatchmakingBloc, MatchmakingState>(
          listenWhen: (prev, curr) =>
              curr.status == MatchmakingStatus.timedOut &&
              prev.status != MatchmakingStatus.timedOut,
          listener: (context, state) {
            AppSnackBar.show(
              context,
              message: tr(LocaleKeys.matchmakingTimeout),
            );
          },
        ),
        BlocListener<MatchmakingBloc, MatchmakingState>(
          listenWhen: (prev, curr) =>
              curr.status == MatchmakingStatus.profileRequired &&
              prev.status != MatchmakingStatus.profileRequired,
          listener: (context, state) {
            AppSnackBar.show(
              context,
              message:
                  state.errorMessage ??
                  tr(LocaleKeys.matchmakingProfileRequired),
            );
            context.go(AppRoutes.profile);
          },
        ),
        BlocListener<MatchmakingBloc, MatchmakingState>(
          listenWhen: (prev, curr) =>
              curr.status == MatchmakingStatus.idle &&
              prev.status == MatchmakingStatus.searching,
          listener: (context, state) {
            context.go(AppRoutes.home);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(LocaleKeys.matchmakingTitle)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
          child: SafeArea(
            child: BlocBuilder<MatchmakingBloc, MatchmakingState>(
              builder: (context, state) {
                return switch (state.status) {
                  MatchmakingStatus.initial ||
                  MatchmakingStatus.loadingProfile ||
                  MatchmakingStatus.idle ||
                  MatchmakingStatus.joining => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  MatchmakingStatus.searching => _SearchingView(state: state),
                  MatchmakingStatus.matched => _MatchedView(state: state),
                  MatchmakingStatus.timedOut => _TimedOutView(state: state),
                  MatchmakingStatus.error => _ErrorView(state: state),
                  MatchmakingStatus.profileRequired => const Center(
                    child: CircularProgressIndicator(),
                  ),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ── Preference chips ──

class _PreferenceChips extends StatelessWidget {
  const _PreferenceChips({
    required this.selected,
    required this.options,
    required this.onChanged,
  });

  final String selected;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      children: options.entries.map((e) {
        final isSelected = e.key == selected;
        return ChoiceChip(
          label: Text(e.value),
          selected: isSelected,
          onSelected: (_) => onChanged(e.key),
          selectedColor: AppColors.primary.withAlpha(40),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : null,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
}

// ── Searching — animated radar + queue info ──

class _SearchingView extends StatelessWidget {
  const _SearchingView({required this.state});

  final MatchmakingState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final queue = state.queueData;
    final waitSeconds = state.localWaitSeconds;
    final expiresInSeconds = state.localExpiresInSeconds;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _PulsingRadar(),
          const Gap(AppSpacing.xxl),
          Text(
            tr(LocaleKeys.matchmakingSearching),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(AppSpacing.md),
          FilledButton.tonalIcon(
            onPressed: () => _showPreferenceSheet(context),
            icon: const Icon(Icons.tune_rounded, size: 18),
            label: Text(tr(LocaleKeys.matchmakingPreferenceTitle)),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primaryContainer,
              foregroundColor: theme.colorScheme.onPrimaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            tr(LocaleKeys.matchmakingSearchingHint),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(153),
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.xxl),

          if (queue != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _QueueInfoRow(
                      icon: Icons.group_outlined,
                      label: tr(LocaleKeys.matchmakingQueueSize),
                      value: '${queue.queueSize}',
                    ),
                    const Divider(),
                    _QueueInfoRow(
                      icon: Icons.format_list_numbered,
                      label: tr(LocaleKeys.matchmakingPosition),
                      value: '#${queue.position}',
                    ),
                    const Divider(),
                    _QueueInfoRow(
                      icon: Icons.timer_outlined,
                      label: tr(LocaleKeys.matchmakingWaitTime),
                      value: _formatDuration(waitSeconds),
                    ),
                    const Divider(),
                    _QueueInfoRow(
                      icon: Icons.hourglass_bottom_rounded,
                      label: tr(LocaleKeys.matchmakingTimeLeft),
                      value: _formatDuration(expiresInSeconds),
                      valueColor: expiresInSeconds < 60
                          ? AppColors.error
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],

          const Gap(AppSpacing.xl),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => context.read<MatchmakingBloc>().add(
                const MatchmakingLeaveQueue(),
              ),
              icon: const Icon(Icons.close_rounded, color: AppColors.error),
              label: Text(
                tr(LocaleKeys.matchmakingCancel),
                style: const TextStyle(color: AppColors.error),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPreferenceSheet(BuildContext context) {
    final bloc = context.read<MatchmakingBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      builder: (_) =>
          BlocProvider.value(value: bloc, child: const _PreferenceSheet()),
    );
  }

  String _formatDuration(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }
}

// ── Queue info row ──

class _QueueInfoRow extends StatelessWidget {
  const _QueueInfoRow({
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
            child: Text(
              label,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: valueColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pulsing radar animation ──

class _PulsingRadar extends StatefulWidget {
  const _PulsingRadar();

  @override
  State<_PulsingRadar> createState() => _PulsingRadarState();
}

class _PulsingRadarState extends State<_PulsingRadar>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
      )..repeat();
    });

    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 667), () {
        if (mounted) _controllers[i].repeat();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ..._controllers.map(
            (c) => AnimatedBuilder(
              animation: c,
              builder: (context, _) {
                return Container(
                  width: 160 * c.value,
                  height: 160 * c.value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withAlpha(
                        (255 * (1 - c.value)).toInt(),
                      ),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.gradientPrimary,
            ),
            child: const Icon(
              Icons.person_search_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Matched ──

class _MatchedView extends StatelessWidget {
  const _MatchedView({required this.state});

  final MatchmakingState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.success.withAlpha(30),
                    ),
                    child: const Icon(
                      Icons.celebration_rounded,
                      size: 48,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    tr(LocaleKeys.matchmakingMatchFound),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    tr(LocaleKeys.matchmakingMatchHint),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withAlpha(153),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  FilledButton.icon(
                    onPressed: () {
                      final roomId = state.roomId;
                      if (roomId != null && roomId.isNotEmpty) {
                        context.go('${AppRoutes.chat}/$roomId');
                      }
                    },
                    icon: const Icon(Icons.chat_rounded),
                    label: Text(tr(LocaleKeys.matchmakingStartChat)),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxl,
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLg,
                        ),
                      ),
                    ),
                  ),
                ]
                .animate(interval: 100.ms)
                .fadeIn(duration: 500.ms)
                .scale(begin: const Offset(0.8, 0.8)),
      ),
    );
  }
}

// ── Timed out ──

class _TimedOutView extends StatelessWidget {
  const _TimedOutView({required this.state});

  final MatchmakingState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
              [
                    Icon(
                      Icons.timer_off_rounded,
                      size: 72,
                      color: theme.colorScheme.onSurface.withAlpha(120),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      tr(LocaleKeys.matchmakingTimeout),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      tr(LocaleKeys.matchmakingTimeoutHint),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: () => context.read<MatchmakingBloc>().add(
                          const MatchmakingJoinQueue(),
                        ),
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(tr(LocaleKeys.matchmakingRetry)),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusLg,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                  .animate(interval: 80.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.05),
        ),
      ),
    );
  }
}

// ── Preference bottom sheet ──

class _PreferenceSheet extends StatelessWidget {
  const _PreferenceSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MatchmakingBloc, MatchmakingState>(
      buildWhen: (p, c) => p.selectedPreference != c.selectedPreference,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xl,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              Text(
                tr(LocaleKeys.matchmakingPreferenceTitle),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(AppSpacing.xl),

              Text(
                tr(LocaleKeys.profileChatPreference),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withAlpha(153),
                ),
              ),
              const Gap(AppSpacing.sm),
              _PreferenceChips(
                selected: state.selectedPreference.value,
                options: {
                  for (final p in ChatPreference.values)
                    p.value: tr(p.labelKey),
                },
                onChanged: (v) => context.read<MatchmakingBloc>().add(
                  MatchmakingUpdatePreference(ChatPreference.tryParse(v)),
                ),
              ),
              const Gap(AppSpacing.xl),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<MatchmakingBloc>().add(
                      const MatchmakingRestartSearch(),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                    ),
                  ),
                  child: Text(
                    tr(LocaleKeys.matchmakingFind),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Error ──

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.state});

  final MatchmakingState state;

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
              Icons.error_outline_rounded,
              size: 64,
              color: AppColors.error.withAlpha(180),
            ),
            const Gap(AppSpacing.lg),
            Text(
              state.errorMessage ?? tr(LocaleKeys.commonConnectionError),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withAlpha(153),
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.xl),
            OutlinedButton.icon(
              onPressed: () => context.read<MatchmakingBloc>().add(
                const MatchmakingStarted(),
              ),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(tr(LocaleKeys.profileRetry)),
            ),
          ],
        ),
      ),
    );
  }
}
