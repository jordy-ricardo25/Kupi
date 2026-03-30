import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/core/extensions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';

final class SignInPage extends ConsumerStatefulWidget {
  static const routePath = '/signin';

  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    ref.listenManual(signInMutationProvider, (previous, next) {
      if (previous?.hasError == true && next.hasError) return;
      if (next.hasError && next.error != null) {
        showSnackbar(context, next.error!);
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(signInControllerProvider);
    final mutation = ref.watch(signInMutationProvider);

    final router = ref.read(goRouterProvider);
    final theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.colorScheme.surface,

      body: SafeArea(
        child: Stack(
          children: [
            orb(
              size: 280,
              alignment: const Alignment(-1.15, -1.05),
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.16),
                theme.colorScheme.primary.withValues(alpha: 0.03),
              ],
            ),
            orb(
              size: 190,
              alignment: const Alignment(1.2, 0.95),
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.16),
                theme.colorScheme.primary.withValues(alpha: 0.015),
              ],
            ),

            Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 4.0,

                  children: [
                    Text(
                      'app.name'.tr(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontFamily: 'Memsmark!',
                        letterSpacing: 1.1,
                        color: theme.colorScheme.primary,
                      ),
                    ).padded(const EdgeInsets.only(bottom: 20.0)),

                    Text(
                      'auth.sign_in.title'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'auth.sign_in.subtitle'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ).padded(const EdgeInsets.only(top: 4.0, bottom: 16.0)),

                    ...[
                      form(),
                      TextButton(
                            onPressed: () async {
                              await router.push(ResetPasswordPage.routePath);
                            },

                            child: Text('auth.sign_in.forgot_password'.tr()),
                          )
                          .aligned(Alignment.centerRight)
                          .padded(const EdgeInsets.only(top: 4.0)),
                    ],

                    ...[
                      FilledButton(
                        onPressed: mutation.isLoading
                            ? null
                            : () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                await controller.mutate(
                                  provider: AuthProvider.email,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              },

                        child: Text('common.actions.sign_in'.tr()),
                      ).padded(const EdgeInsets.only(top: 16.0)),

                      Row(
                        spacing: 16.0,

                        children: [
                          Divider(
                            color: theme.colorScheme.outlineVariant.withValues(
                              alpha: 0.75,
                            ),
                          ).expand(),
                          Text(
                            'auth.sign_in.or_continue_with'.tr(),
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          Divider(
                            color: theme.colorScheme.outlineVariant.withValues(
                              alpha: 0.75,
                            ),
                          ).expand(),
                        ],
                      ).padded(const EdgeInsets.symmetric(vertical: 16.0)),

                      Row(
                        spacing: 16.0,

                        children: [
                          socialButton(
                            onPressed: () async {
                              await controller.mutate(
                                provider: AuthProvider.google,
                              );
                            },

                            label: 'Google',
                            icon: SvgPicture.asset(
                              'assets/icons/google.svg',
                              width: 20.0,
                              height: 20.0,
                            ),
                          ).expand(),

                          socialButton(
                            onPressed: () async {
                              await controller.mutate(
                                provider: AuthProvider.apple,
                              );
                            },

                            label: 'Apple',
                            icon: SvgPicture.asset(
                              'assets/icons/apple.svg',
                              width: 20.0,
                              height: 20.0,
                            ),
                          ).expand(),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 2.0,

                        children: [
                          Text('auth.sign_in.no_account'.tr()),
                          TextButton(
                            onPressed: () async {
                              await router.push(SignUpPage.routePath);
                            },
                            child: Text('common.actions.sign_up'.tr()),
                          ),
                        ],
                      ).padded(const EdgeInsets.only(top: 16.0)),
                    ],
                  ],
                )
                .aligned(Alignment.center)
                .padded(
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                ),
          ],
        ),
      ),
    );
  }

  Widget orb({
    required double size,
    required Alignment alignment,
    required List<Color> colors,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors, stops: const [0.0, 1.0]),
        ),
      ),
    );
  }

  Widget form() {
    final theme = Theme.of(context);

    return Form(
      key: formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4.0,

        children: [
          Text(
            'common.fields.email'.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ).padded(const EdgeInsets.only(top: 8.0)),
          EmailFormField(
            controller: emailController,
            hintText: 'auth.sign_in.email_hint'.tr(),
          ),

          Text(
            'common.fields.password'.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ).padded(const EdgeInsets.only(top: 8.0)),
          PasswordFormField(
            controller: passwordController,
            hintText: 'auth.sign_in.password_hint'.tr(),
          ),
        ],
      ),
    );
  }

  Widget socialButton({
    required VoidCallback? onPressed,
    required String label,
    required Widget icon,
  }) {
    final theme = Theme.of(context);

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,

      label: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      style: theme.outlinedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(
          BorderSide(color: theme.colorScheme.outlineVariant),
        ),
      ),
    );
  }
}
