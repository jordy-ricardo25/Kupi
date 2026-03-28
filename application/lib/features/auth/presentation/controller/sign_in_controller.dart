import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
//import 'package:kupi/features/account/index.dart';
import 'package:kupi/features/auth/index.dart';

final class SignInController {
  final Ref _ref;

  const SignInController(this._ref);

  Future<void> mutate({required String email, required String password}) async {
    final notifier = _ref.read(signInMutationProvider.notifier);
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPassword = password.trim();

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
        throw AuthException('Por favor ingresa tu correo y contraseña.');
      }

      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(normalizedEmail)) {
        throw AuthException('Ingresa un correo válido.');
      }

      final passwordRegex = RegExp(r'^\d{6}$');
      if (!passwordRegex.hasMatch(normalizedPassword)) {
        throw AuthException('La contraseña debe tener exactamente 6 dígitos.');
      }

      await _ref
          .read(authRepositoryProvider)
          .signIn(email: normalizedEmail, password: normalizedPassword)
          .then((r) => r.fold((e) => throw AuthException(e), (_) => {}));
      // final requests = await ref
      //     .read(accountDeletionRequestRepositoryProvider)
      //     .getFor(userId: user.id, status: 'PENDING')
      //     .then((r) => r.fold((_) {}, (v) => v));

      // if (requests != null && requests.isNotEmpty) {
      //   await ref
      //       .read(accountDeletionRequestRepositoryProvider)
      //       .update(
      //         requests.single.id,
      //         cancelledAt: DateTime.now(),
      //         status: 'CANCELLED',
      //       )
      //       .then((r) => r.fold((_) {}, (_) {}));
      // }

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
}
