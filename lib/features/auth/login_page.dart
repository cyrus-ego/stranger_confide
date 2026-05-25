import 'package:cyr_flutter_core/cyr_flutter_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../core/locale/locale_keys.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Stream<String> get errorStream => context.read<LoginBloc>().errorStream;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginBloc>().add(
          LoginSubmitted(
            email: _emailController.text.trim(),
            password: _passwordController.text,
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
                    Text(
                      tr(LocaleKeys.loginSubtitle),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colors.onSurface.withAlpha(153),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 300.ms)
                        .slideY(begin: 0.3),
                    const Gap(AppSpacing.xxxl),
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
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: tr(LocaleKeys.loginPassword),
                        prefixIcon: const Icon(Icons.lock_outlined),
                      ),
                      validator: (v) => (v == null || v.isEmpty)
                          ? tr(LocaleKeys.loginPasswordRequired)
                          : null,
                    )
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 500.ms)
                        .slideX(begin: -0.1),
                    const Gap(AppSpacing.xl),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.status == LoginStatus.success) {
                              // GoRouter redirect sẽ xử lý chuyển trang
                            }
                          },
                          builder: (context, state) {
                            final isLoading =
                                state.status == LoginStatus.loading;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: isLoading ? 52 : constraints.maxWidth,
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
                                    : Text(tr(LocaleKeys.loginSubmit)),
                              ),
                            );
                          },
                        );
                      },
                    )
                        .animate()
                        .fadeIn(duration: 500.ms, delay: 600.ms)
                        .slideY(begin: 0.2),
                    const Gap(AppSpacing.xxl),
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
                                duration: const Duration(milliseconds: 300),
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
    );
  }
}
