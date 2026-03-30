import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:go_router/go_router.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/core/extensions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/core/validation/index.dart';
import 'package:kupi/features/auth/index.dart';
import 'package:lucide_icons/lucide_icons.dart';

final class UpdatePasswordPage extends ConsumerStatefulWidget {
  static const routePath = '/update-password';

  const UpdatePasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UpdatePasswordPageState();
  }
}

class _UpdatePasswordPageState extends ConsumerState<UpdatePasswordPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

    ref.listenManual(updatePasswordMutationProvider, (previous, next) {
      if (previous?.hasError == true && next.hasError) return;

      if (next.hasError && next.error != null) {
        showSnackbar(context, next.error!);
        return;
      }

      final finishedLoading = previous?.isLoading == true && !next.isLoading;
      if (finishedLoading && !next.hasError) {
        showSnackbar(context, 'Contraseña actualizada con éxito.');
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          context.go(SignInPage.routePath);
        });
      }
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(updatePasswordControllerProvider);
    final mutation = ref.watch(updatePasswordMutationProvider);

    final theme = Theme.of(context);

    return PopScope(
      canPop: !mutation.isLoading,

      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.colorScheme.surface,

        body: SafeArea(
          child: Align(
            alignment: Alignment.center,

            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 24.0,
              ),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: theme.colorScheme.onPrimary,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    blurRadius: 8.0,
                    spreadRadius: 0.5,
                    offset: Offset.zero,
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 4.0,

                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primaryContainer.withValues(
                        alpha: 0.75,
                      ),
                    ),
                    width: 64.0,
                    height: 64.0,

                    child: Icon(
                      TablerIcons.shield_lock_filled,
                      color: theme.colorScheme.primary,
                      size: 28.0,
                    ),
                  ).centered(),

                  Text(
                    'Actualizar contraseña',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ).padded(const EdgeInsets.only(top: 16.0)),
                  Text(
                    'Ingresa tu nueva contraseña y confírmala.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ).padded(const EdgeInsets.only(top: 4.0, bottom: 16.0)),

                  form(),

                  FilledButton(
                    onPressed: !mutation.isLoading
                        ? () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            await controller.mutate(
                              password: passwordController.text,
                            );
                          }
                        : null,

                    child: const Text('Actualizar'),
                  ).padded(const EdgeInsets.only(top: 16.0)),

                  TextButton.icon(
                        onPressed: !mutation.isLoading
                            ? () async {
                                final router = ref.read(goRouterProvider);

                                try {
                                  router.pop();
                                } catch (e) {
                                  if (kDebugMode) {
                                    debugPrint(e.toString());
                                  }

                                  await router.replace(SignInPage.routePath);
                                }
                              }
                            : null,

                        icon: const Icon(LucideIcons.arrowLeft),
                        label: const Text('Volver al inicio'),
                      )
                      .aligned(Alignment.center)
                      .padded(const EdgeInsets.only(top: 16.0)),
                ],
              ),
            ),
          ),
        ),
      ).dismissKeyboard(context),
    );
  }

  Widget form() {
    return Form(
      key: formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4.0,

        children: [
          Text(
            'common.fields.password'.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ).padded(const EdgeInsets.only(top: 8.0)),
          PasswordFormField(
            controller: passwordController,
            validator: passwordValidator.validate,

            hintText: 'auth.sign_in.password_hint'.tr(),
          ),

          Text(
            'Ingresa tu nueva contraseña'.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ).padded(const EdgeInsets.only(top: 8.0)),
          PasswordFormField(
            controller: confirmPasswordController,
            validator: confirmationValidator(
              () => passwordController.text,
            ).validate,

            hintText: 'Confirma tu nueva contraseña'.tr(),
          ),
        ],
      ),
    );
  }
}
