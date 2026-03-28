import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';
//import 'package:kupi/features/account/index.dart';
import 'package:kupi/features/auth/index.dart';

final class SignInController {
  final Ref _ref;

  const SignInController(this._ref);

  Future<void> signInWithGoogle() {
    return _signInWithSocial(
      request: () => _ref.read(authRepositoryProvider).signInWithGoogle(),
    );
  }

  Future<void> signInWithApple() {
    return _signInWithSocial(
      request: () => _ref.read(authRepositoryProvider).signInWithApple(),
    );
  }

  Future<void> mutate({required String email, required String password}) async {
    final notifier = _ref.read(signInMutationProvider.notifier);
    final normalizedEmail = AuthValidators.normalizeEmail(email);
    final normalizedPassword = AuthValidators.normalizePassword(password);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
        throw AuthException('Por favor ingresa tu correo y contraseña.');
      }

      final emailError = AuthValidators.validateEmail(normalizedEmail);
      if (emailError != null) throw AuthException(emailError);

      final passwordError = AuthValidators.validateSixDigitsPassword(
        normalizedPassword,
      );
      if (passwordError != null) throw AuthException(passwordError);

      await _ref
          .read(authRepositoryProvider)
          .signInWithEmail(email: normalizedEmail, password: normalizedPassword)
          .then((r) => r.fold((e) => throw AuthException(e), (_) => {}));

      notifier.state = notifier.state.copyWith(isLoading: false);
    } catch (e) {
      if (!notifier.mounted) return;

      notifier.state = notifier.state.copyWith(
        isLoading: false,
        hasError: true,
        error: e is AppException
            ? e.message
            : 'Ocurrió un error inesperado.'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }

  Future<void> _signInWithSocial({
    required Future<Result<bool>> Function() request,
  }) async {
    final notifier = _ref.read(signInMutationProvider.notifier);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      await request().then(
        (r) => r.fold((e) => throw AuthException(e), (_) {}),
      );

      notifier.state = notifier.state.copyWith(isLoading: false);
    } catch (e) {
      if (!notifier.mounted) return;

      notifier.state = notifier.state.copyWith(
        isLoading: false,
        hasError: true,
        error: e is AppException
            ? e.message
            : 'Ocurrió un error inesperado.\nInténtalo de nuevo más tarde.',
      );
    }
  }
}
