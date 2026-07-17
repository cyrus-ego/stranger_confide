import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:stranger_confide/data/models/request/update_profile_request.dart';
import 'package:stranger_confide/data/models/response/user_dto.dart';

import '../../core/locale/locale_keys.dart';
import '../../domain/enums/chat_preference.dart';
import '../../domain/enums/gender.dart';
import '../../router/app_router.dart';
import '../../shared/widgets/app_snack_bar.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'bloc/profile_bloc.dart';
import 'bloc/profile_event.dart';
import 'bloc/profile_state.dart';

class CreateProfilePage extends BlocHostPage {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends BlocHostPageState<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _bioController = TextEditingController();

  String _displayName = '';
  Gender? _gender;
  ChatPreference _chatPreference = ChatPreference.defaultPreference;
  bool _userApplied = false;

  @override
  Stream<String> get errorStream => context.read<ProfileBloc>().errorStream;

  @override
  void dispose() {
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _applyUser(UserDto user) {
    if (_userApplied) return;
    _userApplied = true;

    _displayName = user.displayName ?? '';
    final gender = Gender.tryParse(user.gender);
    if (gender != null) {
      _gender = gender;
      _chatPreference = ChatPreference.tryParse(gender.opposite.value);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr(LocaleKeys.loginGenderRequired)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    context.read<ProfileBloc>().add(
          ProfileCreate(
            UpdateProfileRequest(
              displayName: _displayName,
              gender: _gender!.value,
              age: int.parse(_ageController.text.trim()),
              bio: _bioController.text.trim(),
              chatPreference: _chatPreference.value,
            ),
          ),
        );
  }

  @override
  Widget buildPage(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final gradient = isDark
        ? AppColors.darkGradientBackground
        : AppColors.lightGradientBackground;

    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prev, curr) =>
          curr.currentUser != null && prev.currentUser == null,
      listener: (context, state) {
        setState(() => _applyUser(state.currentUser!));
      },
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (prev, curr) =>
            curr.createSuccess && !prev.createSuccess,
        listener: (context, state) {
          AppSnackBar.show(
            context,
            message: tr(LocaleKeys.profileCreateSuccess),
          );
          context.go(AppRoutes.home);
        },
        child: Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(gradient: gradient),
            child: SafeArea(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.status == ProfileStatus.loading &&
                      state.currentUser == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == ProfileStatus.failure &&
                      state.currentUser == null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tr(LocaleKeys.profileLoadError)),
                          const Gap(AppSpacing.lg),
                          FilledButton(
                            onPressed: () => context
                                .read<ProfileBloc>()
                                .add(const ProfileLoadMe()),
                            child: Text(tr(LocaleKeys.profileRetry)),
                          ),
                        ],
                      ),
                    );
                  }

                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxl,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_add_rounded,
                              size: 56,
                              color: colors.primary,
                            )
                                .animate()
                                .fadeIn(duration: 600.ms)
                                .scale(begin: const Offset(0.5, 0.5)),
                            const Gap(AppSpacing.lg),
                            Text(
                              tr(LocaleKeys.profileCreateTitle),
                              style:
                                  theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 500.ms, delay: 200.ms)
                                .slideY(begin: 0.3),
                            const Gap(AppSpacing.sm),
                            Text(
                              tr(LocaleKeys.profileCreateSubtitle),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colors.onSurface.withAlpha(153),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 500.ms, delay: 300.ms)
                                .slideY(begin: 0.3),
                            const Gap(AppSpacing.xxxl),

                            // Gender
                            _SectionLabel(
                              label: tr(LocaleKeys.profileGender),
                            ),
                            const Gap(AppSpacing.sm),
                            SegmentedButton<Gender>(
                              segments: [
                                for (final g in Gender.values)
                                  ButtonSegment(
                                    value: g,
                                    label: Text(tr(g.labelKey)),
                                    icon: Icon(
                                      switch (g) {
                                        Gender.male => Icons.male_rounded,
                                        Gender.female => Icons.female_rounded,
                                        Gender.other =>
                                          Icons.transgender_rounded,
                                      },
                                    ),
                                  ),
                              ],
                              selected: _gender != null ? {_gender!} : {},
                              emptySelectionAllowed: true,
                              onSelectionChanged: (selected) {
                                final g = selected.firstOrNull;
                                if (g == null) return;
                                setState(() {
                                  _gender = g;
                                  _chatPreference = ChatPreference.tryParse(
                                    g.opposite.value,
                                  );
                                });
                              },
                              style: const ButtonStyle(
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            const Gap(AppSpacing.lg),

                            // Age
                            TextFormField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                labelText:
                                    tr(LocaleKeys.profileCreateAgeHint),
                                prefixIcon: const Icon(Icons.cake_outlined),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return tr(
                                      LocaleKeys.profileCreateAgeRequired);
                                }
                                final age = int.tryParse(v);
                                if (age == null || age < 1 || age > 150) {
                                  return tr(
                                      LocaleKeys.profileCreateAgeRequired);
                                }
                                return null;
                              },
                            ),
                            const Gap(AppSpacing.lg),

                            // Bio
                            TextFormField(
                              controller: _bioController,
                              maxLines: 3,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText:
                                    tr(LocaleKeys.profileCreateBioHint),
                                prefixIcon: const Icon(Icons.info_outline),
                                alignLabelWithHint: true,
                              ),
                            ),
                            const Gap(AppSpacing.xl),

                            // Chat Preference
                            _SectionLabel(
                              label: tr(
                                  LocaleKeys.profileCreateChatPreference),
                            ),
                            const Gap(AppSpacing.sm),
                            SegmentedButton<ChatPreference>(
                              segments: [
                                for (final p in ChatPreference.values)
                                  ButtonSegment(
                                    value: p,
                                    label: Text(tr(p.labelKey)),
                                  ),
                              ],
                              selected: {_chatPreference},
                              onSelectionChanged: (selected) {
                                setState(
                                    () => _chatPreference = selected.first);
                              },
                              style: const ButtonStyle(
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            const Gap(AppSpacing.xxl),

                            // Submit
                            Builder(
                              builder: (context) {
                                final isLoading = state.status ==
                                    ProfileStatus.updating;
                                return SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: FilledButton(
                                    onPressed: isLoading ? null : _submit,
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(tr(
                                            LocaleKeys.profileCreateSubmit)),
                                  ),
                                );
                              },
                            ),
                            const Gap(AppSpacing.xxl),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(178),
            ),
      ),
    );
  }
}
