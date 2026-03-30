import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:kupi/core/extensions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/core/validation/index.dart';
import 'package:kupi/core/widgets/index.dart';
import 'package:kupi/features/auth/index.dart';

final class SignUpPage extends ConsumerStatefulWidget {
  static const routePath = '/signup';

  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final nameValidator = Validator<String>()
    ..required()
    ..minLength(3);
  final emailValidator = Validator<String>()
    ..required()
    ..email();
  final passwordValidator = Validator<String>()
    ..required()
    ..minLength(8);
  Validator<String> confirmationValidator(String Function() getPassword) =>
      Validator<String>()
        ..required()
        ..matches(getPassword);

  @override
  void initState() {
    super.initState();

    ref.listenManual(signUpMutationProvider, (previous, next) {
      if (previous?.hasError == true && next.hasError) return;

      if (next.hasError && next.error != null) {
        showSnackbar(context, next.error!);
        return;
      }

      final finishedLoading = previous?.isLoading == true && !next.isLoading;
      if (finishedLoading && !next.hasError) {
        showSnackbar(
          context,
          'Cuenta creada con éxito. Revisa tu correo y luego inicia sesión.',
        );

        Future.delayed(const Duration(milliseconds: 600), () {
          if (!mounted) return;
          context.go(SignInPage.routePath);
        });
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(signUpControllerProvider);
    final mutation = ref.watch(signUpMutationProvider);

    final theme = Theme.of(context);

    return PopScope(
      canPop: !mutation.isLoading,

      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.colorScheme.surface,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: PopButton(
            enabled: !mutation.isLoading,

            style: theme.iconButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              minimumSize: WidgetStateProperty.all(const Size(44.0, 44.0)),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              orb(
                size: 280,
                alignment: const Alignment(1.15, 1.05),
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.16),
                  theme.colorScheme.primary.withValues(alpha: 0.03),
                ],
              ),

              orb(
                size: 190,
                alignment: const Alignment(-1.2, -0.95),
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.16),
                  Colors.transparent,
                ],
              ),

              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 24.0,
                ),

                child: Column(
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
                      'auth.sign_up.title'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'auth.sign_up.subtitle'.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ).padded(const EdgeInsets.only(top: 4.0, bottom: 16.0)),

                    ...[
                      form(),

                      Wrap(
                        children: [
                          Text('${'auth.sign_up.legal.accept_prefix'.tr()} '),
                          LinkButton(
                            uri: Uri.parse(
                              'https://paralelo.ec/terms-of-service',
                            ),
                            child: Text(
                              'auth.sign_up.legal.terms_of_service'.tr(),
                            ),
                          ),
                          Text(' ${'auth.sign_up.legal.and'.tr()} '),
                          LinkButton(
                            uri: Uri.parse(
                              'https://paralelo.ec/privacy-policy',
                            ),
                            child: Text(
                              'auth.sign_up.legal.privacy_policy'.tr(),
                            ),
                          ),
                        ],
                      ).padded(const EdgeInsets.only(top: 16.0)),
                    ],

                    FilledButton(
                      onPressed: mutation.isLoading
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }

                              await controller.mutate(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },

                      child: Text('common.actions.create_account'.tr()),
                    ).padded(const EdgeInsets.only(top: 16.0)),
                  ],
                ),
              ),
            ],
          ),
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
            'common.fields.name'.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ).padded(const EdgeInsets.only(top: 8.0)),
          NameFormField(
            controller: nameController,
            validator: nameValidator.validate,

            hintText: 'auth.sign_up.name_hint'.tr(),
          ),

          Text(
            'common.fields.email'.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ).padded(const EdgeInsets.only(top: 8.0)),
          EmailFormField(
            controller: emailController,
            validator: emailValidator.validate,

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
            validator: passwordValidator.validate,

            hintText: 'auth.sign_up.password_hint'.tr(),
          ),

          Text(
            'common.fields.confirm_password'.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ).padded(const EdgeInsets.only(top: 8.0)),
          PasswordFormField(
            controller: confirmPasswordController,
            validator: confirmationValidator(
              () => passwordController.text,
            ).validate,

            hintText: 'auth.sign_up.confirm_password_hint'.tr(),
          ),
        ],
      ),
    );
  }
}
