import 'dart:async';

import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../core/locale/locale_keys.dart';
import '../../domain/enums/gender.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_cubit.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginPage extends BlocHostPage {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BlocHostPageState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isRegisterMode = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  Gender? _selectedGender;

  @override
  Stream<String> get errorStream => context.read<LoginBloc>().errorStream;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<LoginBloc>();
    if (_isRegisterMode) {
      if (_selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(tr(LocaleKeys.loginGenderRequired)),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      bloc.add(
        RegisterSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _displayNameController.text.trim(),
          gender: _selectedGender!.value,
        ),
      );
    } else {
      bloc.add(
        LoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _toggleMode() {
    setState(() {
      _isRegisterMode = !_isRegisterMode;
    });
  }

  void _showOtpDialog(String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: context.read<LoginBloc>(),
          child: _OtpDialogContent(
            email: email,
            onSuccess: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message ?? tr(LocaleKeys.loginOtpSuccess),
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              );
              setState(() => _isRegisterMode = false);
            },
          ),
        );
      },
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

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
              ),
              child: Form(
                key: _formKey,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_bubble_rounded,
                        size: 56,
                        color: colors.primary,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms)
                          .scale(begin: const Offset(0.5, 0.5)),
                      const Gap(AppSpacing.lg),
                      Text(
                        tr(LocaleKeys.appName),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 200.ms)
                          .slideY(begin: 0.3),
                      const Gap(AppSpacing.sm),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          tr(_isRegisterMode
                              ? LocaleKeys.loginRegisterSubtitle
                              : LocaleKeys.loginSubtitle),
                          key: ValueKey(_isRegisterMode),
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colors.onSurface.withAlpha(153),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 300.ms)
                          .slideY(begin: 0.3),
                      const Gap(AppSpacing.xxxl),
                      if (_isRegisterMode)
                        TextFormField(
                          controller: _displayNameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: tr(LocaleKeys.loginDisplayName),
                            prefixIcon: const Icon(Icons.person_outlined),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? tr(LocaleKeys.loginDisplayNameRequired)
                              : null,
                        )
                            .animate()
                            .fadeIn(duration: 300.ms)
                            .slideX(begin: -0.1),
                      if (_isRegisterMode) const Gap(AppSpacing.lg),
                      if (_isRegisterMode)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr(LocaleKeys.loginGender),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurface.withAlpha(178),
                              ),
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
                              selected: _selectedGender != null
                                  ? {_selectedGender!}
                                  : {},
                              emptySelectionAllowed: true,
                              onSelectionChanged: (selected) {
                                setState(() {
                                  _selectedGender = selected.firstOrNull;
                                });
                              },
                              style: const ButtonStyle(
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(duration: 300.ms)
                            .slideX(begin: -0.1),
                      if (_isRegisterMode) const Gap(AppSpacing.lg),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: tr(LocaleKeys.loginEmail),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (v) => (v == null || v.isEmpty)
                            ? tr(LocaleKeys.loginEmailRequired)
                            : null,
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 400.ms)
                          .slideX(begin: -0.1),
                      const Gap(AppSpacing.lg),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submit(),
                        decoration: InputDecoration(
                          labelText: tr(LocaleKeys.loginPassword),
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                          ),
                        ),
                        validator: (v) => (v == null || v.isEmpty)
                            ? tr(LocaleKeys.loginPasswordRequired)
                            : null,
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 500.ms)
                          .slideX(begin: -0.1),
                      if (_isRegisterMode) const Gap(AppSpacing.lg),
                      if (_isRegisterMode)
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          decoration: InputDecoration(
                            labelText: tr(LocaleKeys.loginConfirmPassword),
                            prefixIcon: const Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () => setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              }),
                            ),
                          ),
                          validator: (v) =>
                              (v == null || v != _passwordController.text)
                                  ? tr(LocaleKeys
                                      .loginConfirmPasswordRequired)
                                  : null,
                        )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 550.ms)
                            .slideX(begin: -0.1),
                      const Gap(AppSpacing.xl),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state.registerStatus ==
                                  RegisterStatus.success) {
                                final email = state.pendingEmail;
                                if (email != null) {
                                  _showOtpDialog(email);
                                }
                              }
                            },
                            builder: (context, state) {
                              final isLoading = _isRegisterMode
                                  ? state.registerStatus ==
                                      RegisterStatus.loading
                                  : state.status == LoginStatus.loading;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width:
                                    isLoading ? 52 : constraints.maxWidth,
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
                                      : Text(tr(_isRegisterMode
                                          ? LocaleKeys.loginRegisterSubmit
                                          : LocaleKeys.loginSubmit)),
                                ),
                              );
                            },
                          );
                        },
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 600.ms)
                          .slideY(begin: 0.2),
                      if (!_isRegisterMode) ...[
                        const Gap(AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(child: Divider(color: colors.outline)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                              ),
                              child: Text(
                                tr(LocaleKeys.loginOr),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colors.onSurface.withAlpha(153),
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: colors.outline)),
                          ],
                        ),
                        const Gap(AppSpacing.lg),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              final isLoading =
                                  state.status == LoginStatus.loading;
                              return OutlinedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () => context.read<LoginBloc>().add(
                                          const GoogleLoginSubmitted(),
                                        ),
                                icon: const Text(
                                  'G',
                                  style: TextStyle(
                                    color: Color(0xFF4285F4),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                label: Text(tr(LocaleKeys.loginGoogle)),
                              );
                            },
                          ),
                        ),
                      ],
                      const Gap(AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr(_isRegisterMode
                                ? LocaleKeys.loginAlreadyHaveAccount
                                : LocaleKeys.loginNoAccount),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurface.withAlpha(153),
                            ),
                          ),
                          TextButton(
                            onPressed: _toggleMode,
                            child: Text(
                              tr(_isRegisterMode
                                  ? LocaleKeys.loginSubmit
                                  : LocaleKeys.loginRegister),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 650.ms),
                      const Gap(AppSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<ThemeCubit, ThemeMode>(
                            builder: (context, mode) {
                              final isDarkMode = mode == ThemeMode.dark;
                              return TextButton.icon(
                                onPressed: () =>
                                    context.read<ThemeCubit>().toggle(),
                                icon: AnimatedSwitcher(
                                  duration:
                                      const Duration(milliseconds: 300),
                                  transitionBuilder: (child, anim) =>
                                      RotationTransition(
                                    turns: anim,
                                    child: FadeTransition(
                                      opacity: anim,
                                      child: child,
                                    ),
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
                          Container(
                            width: 1,
                            height: 20,
                            color: colors.outline,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              final next =
                                  context.locale.languageCode == 'vi'
                                      ? const Locale('en')
                                      : const Locale('vi');
                              context.setLocale(next);
                            },
                            icon: const Icon(Icons.language, size: 20),
                            label: Text(
                              context.locale.languageCode.toUpperCase(),
                            ),
                          ),
                        ],
                      )
                          .animate()
                          .fadeIn(duration: 500.ms, delay: 700.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpDialogContent extends StatefulWidget {
  const _OtpDialogContent({
    required this.email,
    required this.onSuccess,
  });

  final String email;
  final void Function(String? message) onSuccess;

  @override
  State<_OtpDialogContent> createState() => _OtpDialogContentState();
}

class _OtpDialogContentState extends State<_OtpDialogContent> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _resendTimer;
  int _countdown = 0;

  @override
  void dispose() {
    _otpController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _resendTimer?.cancel();
    setState(() => _countdown = 60);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 1) {
        timer.cancel();
        setState(() => _countdown = 0);
      } else {
        setState(() => _countdown--);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (ctx, state) {
        if (state.otpStatus == OtpStatus.success) {
          Navigator.of(context).pop();
          widget.onSuccess(state.otpMessage);
        }
        if (state.resendOtpStatus == OtpStatus.success) {
          _startCountdown();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(tr(LocaleKeys.loginOtpResend)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (ctx, state) {
        final isLoading = state.otpStatus == OtpStatus.loading;
        final isResending = state.resendOtpStatus == OtpStatus.loading;
        return AlertDialog(
          icon: Icon(
            Icons.mark_email_read_rounded,
            size: 48,
            color: colors.primary,
          ),
          title: Text(tr(LocaleKeys.loginOtpTitle)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr(LocaleKeys.loginOtpSubtitle),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface.withAlpha(153),
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                widget.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(AppSpacing.xl),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: tr(LocaleKeys.loginOtpHint),
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurface.withAlpha(100),
                      letterSpacing: 0,
                    ),
                  ),
                  validator: (v) => (v == null || v.isEmpty)
                      ? tr(LocaleKeys.loginOtpRequired)
                      : null,
                ),
              ),
              const Gap(AppSpacing.md),
              TextButton(
                onPressed: _countdown > 0 || isResending
                    ? null
                    : () {
                        ctx.read<LoginBloc>().add(
                              ResendOtpSubmitted(email: widget.email),
                            );
                      },
                child: isResending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _countdown > 0
                            ? tr(LocaleKeys.loginOtpResendIn,
                                namedArgs: {'seconds': _countdown.toString()})
                            : tr(LocaleKeys.loginOtpResend),
                        textAlign: TextAlign.center,
                      ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.of(context).pop(),
              child: Text(tr(LocaleKeys.commonClose)),
            ),
            FilledButton(
              onPressed: isLoading
                  ? null
                  : () {
                      if (!_formKey.currentState!.validate()) return;
                      ctx.read<LoginBloc>().add(
                            OtpSubmitted(
                              email: widget.email,
                              otp: _otpController.text.trim(),
                            ),
                          );
                    },
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(tr(LocaleKeys.loginOtpSubmit)),
            ),
          ],
        );
      },
    );
  }
}
