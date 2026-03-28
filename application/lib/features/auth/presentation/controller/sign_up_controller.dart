import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';
import 'package:kupi/features/user/index.dart';

final class SignUpController {
  const SignUpController(this._ref);

  final Ref _ref;

  Future<void> mutate({
    required String name,
    required String email,
    required String password,
  }) async {
    final notifier = _ref.read(signUpMutationProvider.notifier);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      if (name.trim().isEmpty) {
        throw AuthException('Ingresa tu nombre completo.');
      }

      if (email.trim().isEmpty) {
        throw AuthException('Ingresa un correo electrónico válido.');
      }

      if (password.trim().isEmpty) {
        throw AuthException('Ingresa una contraseña válida.');
      }

      final user = await _ref
          .read(authRepositoryProvider)
          .signUp(email: email, password: password)
          .then((r) => r.fold((e) => throw AuthException(e), (v) => v));

      await _ref
          .read(userRepositoryProvider)
          .create(id: user.id, displayName: name, email: email, planId: '')
          .then((r) => r.fold((e) => throw AuthException(e), (_) => {}));

      notifier.state = notifier.state.copyWith(isLoading: false);
    } catch (e) {
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
}
