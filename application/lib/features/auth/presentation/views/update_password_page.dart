import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';

final class UpdatePasswordPage extends ConsumerStatefulWidget {
  static const routePath = '/update-password';

  const UpdatePasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UpdatePasswordPageState();
  }
}

class _UpdatePasswordPageState extends ConsumerState<UpdatePasswordPage> {
  static const brandPurple = Color(0xFF813EF4);

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_normalizePasswordInput);
    confirmController.addListener(_normalizeConfirmInput);
  }

  void _normalizePasswordInput() {
    final raw = passwordController.text;
    var normalized = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (normalized.length > 6) {
      normalized = normalized.substring(0, 6);
    }

    if (raw == normalized) return;

    passwordController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  void _normalizeConfirmInput() {
    final raw = confirmController.text;
    var normalized = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (normalized.length > 6) {
      normalized = normalized.substring(0, 6);
    }

    if (raw == normalized) return;

    confirmController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  @override
  void dispose() {
    passwordController.removeListener(_normalizePasswordInput);
    confirmController.removeListener(_normalizeConfirmInput);
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await ref
        .read(updatePasswordControllerProvider)
        .mutate(password: passwordController.text.trim());
  }

  String? _validatePassword(String? value) {
    final password = value?.trim() ?? '';
    if (!RegExp(r'^\d{6}$').hasMatch(password)) {
      return 'La contraseña debe tener exactamente 6 dígitos.';
    }
    return null;
  }

  String? _validateConfirm(String? value) {
    final confirm = value?.trim() ?? '';
    if (confirm != passwordController.text.trim()) {
      return 'Las contraseñas no coinciden.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mutation = ref.watch(updatePasswordMutationProvider);

    ref.listen(updatePasswordMutationProvider, (previous, next) {
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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F2FA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 410),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE9E5F4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Actualizar contraseña',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A1F),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Define tu nueva contraseña de 6 dígitos.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: const Color(0xFF808090)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        PasswordFormField(
                          controller: passwordController,
                          validator: _validatePassword,
                          labelText: 'NUEVA CONTRASEÑA',
                          hintText: '6 dígitos',
                          backgroundColor: const Color(0xFFFAFAFD),
                        ),
                        const SizedBox(height: 12),
                        PasswordFormField(
                          controller: confirmController,
                          validator: _validateConfirm,
                          labelText: 'CONFIRMAR CONTRASEÑA',
                          hintText: '6 dígitos',
                          backgroundColor: const Color(0xFFFAFAFD),
                        ),
                        const SizedBox(height: 18),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF6F31E8), brandPurple],
                            ),
                          ),
                          child: FilledButton(
                            onPressed: mutation.isLoading ? null : _submit,
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            child: mutation.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text('Guardar contraseña'),
                          ),
                        ),
                      ],
                    ),
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
