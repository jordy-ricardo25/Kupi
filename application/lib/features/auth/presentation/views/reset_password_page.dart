import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/core/extensions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/core/validation/index.dart';
import 'package:kupi/features/auth/index.dart';

import 'package:lucide_icons/lucide_icons.dart';

final class ResetPasswordPage extends ConsumerStatefulWidget {
  static const routePath = '/reset-password';

  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final emailValidator = Validator<String>()
    ..required()
    ..email();

  @override
  void initState() {
    super.initState();

    ref.listenManual(resetPasswordMutationProvider, (previous, next) {
      if (previous?.hasError == true && next.hasError) return;

      if (next.hasError && next.error != null) {
        showSnackbar(context, next.error!);
        return;
      }

      final finishedLoading = previous?.isLoading == true && !next.isLoading;
      if (finishedLoading && !next.hasError) {
        showSnackbar(
          context,
          'Te enviamos un correo para restablecer tu contraseña.',
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(resetPasswordControllerProvider);
    final mutation = ref.watch(resetPasswordMutationProvider);

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
                      TablerIcons.lock_filled,
                      color: theme.colorScheme.primary,
                      size: 28.0,
                    ),
                  ).centered(),

                  Text(
                    'Restablecer contraseña',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ).padded(const EdgeInsets.only(top: 16.0)),
                  Text(
                    'Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
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
                              email: emailController.text,
                            );
                          }
                        : null,

                    child: const Text('Restablecer'),
                  ).padded(const EdgeInsets.only(top: 16.0)),

                  TextButton.icon(
                        onPressed: !mutation.isLoading
                            ? () {
                                ref.read(goRouterProvider).pop();
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
      ),
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
            'common.fields.email'.tr(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
          ).padded(const EdgeInsets.only(top: 8.0)),
          EmailFormField(
            controller: emailController,
            validator: emailValidator.validate,

            hintText: 'auth.sign_in.email_hint'.tr(),
          ),
        ],
      ),
    );
  }
}
