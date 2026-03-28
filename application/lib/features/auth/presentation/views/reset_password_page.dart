import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';

final class ResetPasswordPage extends ConsumerStatefulWidget {
  static const routePath = '/reset-password';

  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  static const brandPurple = Color(0xFF813EF4);

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_normalizeEmailInput);
  }

  void _normalizeEmailInput() {
    final raw = emailController.text;
    final normalized = raw
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll(RegExp(r'[^a-z0-9@._+\-]'), '');

    if (raw == normalized) return;

    emailController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  @override
  void dispose() {
    emailController.removeListener(_normalizeEmailInput);
    emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await ref
        .read(resetPasswordControllerProvider)
        .mutate(email: emailController.text.trim());
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Ingresa tu correo electrónico.';

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Ingresa un correo válido.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final mutation = ref.watch(resetPasswordMutationProvider);

    ref.listen(resetPasswordMutationProvider, (previous, next) {
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
                          'Recuperar contraseña',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1A1F),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Ingresa tu correo y te enviaremos un enlace para restablecerla.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: const Color(0xFF808090)),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        EmailFormField(
                          controller: emailController,
                          validator: _validateEmail,
                          labelText: 'EMAIL',
                          hintText: 'nombre@ejemplo.com',
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
                                : const Text('Enviar enlace'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: mutation.isLoading
                              ? null
                              : () {
                                  context.pop();
                                },
                          child: const Text('Volver a iniciar sesión'),
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
