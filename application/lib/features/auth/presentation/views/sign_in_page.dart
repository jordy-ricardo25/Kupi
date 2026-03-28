import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  static const brandPurple = Color(0xFF813EF4);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_normalizeEmailInput);
    passwordController.addListener(_normalizePasswordInput);
  }

  void _normalizeEmailInput() {
    final raw = emailController.text;
    final normalized = AuthValidators.normalizeEmailInput(raw);

    if (raw == normalized) return;

    emailController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  void _normalizePasswordInput() {
    final raw = passwordController.text;
    final normalized = AuthValidators.normalizePasswordInput(raw);

    if (raw == normalized) return;

    passwordController.value = TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
    );
  }

  @override
  void dispose() {
    emailController.removeListener(_normalizeEmailInput);
    passwordController.removeListener(_normalizePasswordInput);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await ref
        .read(signInControllerProvider)
        .mutate(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  String? _validateEmail(String? value) {
    return AuthValidators.validateEmail(value);
  }

  String? _validatePassword(String? value) {
    return AuthValidators.validateSixDigitsPassword(value);
  }

  Widget _buildOrb({
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

  Widget _buildSocialButton({
    required String label,
    required Widget icon,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF212126),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFE7E3F1)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mutation = ref.watch(signInMutationProvider);

    ref.listen(signInMutationProvider, (previous, next) {
      if (previous?.hasError == true && next.hasError) return;
      if (next.hasError && next.error != null) {
        showSnackbar(context, next.error!);
      }
    });

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF7F5FD),
      body: SafeArea(
        child: Stack(
          children: [
            _buildOrb(
              size: 280,
              alignment: const Alignment(-1.15, -1.05),
              colors: [
                brandPurple.withValues(alpha: 0.16),
                brandPurple.withValues(alpha: 0.03),
              ],
            ),
            _buildOrb(
              size: 190,
              alignment: const Alignment(1.2, -0.95),
              colors: [brandPurple.withValues(alpha: 0.12), Colors.transparent],
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 410),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFEBE5F7)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x190F0C1F),
                          blurRadius: 30,
                          offset: Offset(0, 14),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: brandPurple,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: brandPurple,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Kupi',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.6,
                                    color: Color(0xFF15151B),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Bienvenido de\nregreso',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                height: 1.02,
                                color: Color(0xFF16161D),
                                letterSpacing: -1.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Inicia sesión para continuar con tu cuenta.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: const Color(0xFF81808D),
                                    height: 1.24,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            EmailFormField(
                              controller: emailController,
                              validator: _validateEmail,
                              labelText: 'CORREO ELECTRÓNICO',
                              hintText: 'nombre@ejemplo.com',
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 12),
                            PasswordFormField(
                              controller: passwordController,
                              validator: _validatePassword,
                              labelText: 'CONTRASEÑA',
                              hintText: '6 dígitos',
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(height: 6),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: mutation.isLoading
                                    ? null
                                    : () {
                                        context.push(
                                          ResetPasswordPage.routePath,
                                        );
                                      },
                                child: const Text(
                                  '¿Olvidaste tu contraseña?',
                                  style: TextStyle(
                                    color: brandPurple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Color(0xFF6F31E8), brandPurple],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3D813EF4),
                                    blurRadius: 18,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: FilledButton(
                                onPressed: mutation.isLoading ? null : _submit,
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: mutation.isLoading
                                    ? const SizedBox(
                                        height: 22,
                                        width: 22,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                    Colors.white,
                                                  ),
                                            ),
                                      )
                                    : const Text('Iniciar Sesión'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'O continúa con',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF8A8996),
                                    fontWeight: FontWeight.w500,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            _buildSocialButton(
                              label: 'Continuar con Google',
                              onPressed: mutation.isLoading
                                  ? null
                                  : () async {
                                      await ref
                                          .read(signInControllerProvider)
                                          .signInWithGoogle();
                                    },
                              icon: Container(
                                width: 24,
                                height: 24,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF3F5FF),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'G',
                                  style: TextStyle(
                                    color: Color(0xFF2C67F2),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _buildSocialButton(
                              label: 'Continuar con Apple',
                              onPressed: mutation.isLoading
                                  ? null
                                  : () async {
                                      await ref
                                          .read(signInControllerProvider)
                                          .signInWithApple();
                                    },
                              icon: const Icon(Icons.apple, size: 20),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¿No tienes cuenta? ',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: const Color(0xFF777686),
                                      ),
                                ),
                                TextButton(
                                  onPressed: mutation.isLoading
                                      ? null
                                      : () {
                                          context.push(SignUpPage.routePath);
                                        },
                                  child: const Text(
                                    'Regístrate',
                                    style: TextStyle(
                                      color: brandPurple,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
