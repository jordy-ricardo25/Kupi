import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart' show AuthApiException;

final class ResetPasswordController {
  const ResetPasswordController(this._ref);

  final Ref _ref;

  Future<void> mutate({required String email}) async {
    final notifier = _ref.read(resetPasswordMutationProvider.notifier);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      if (email.trim().isEmpty) {
        throw AuthException('Ingresa un correo electrónico válido.');
      }

      await _ref.read(authRepositoryProvider).recoverPassword(email);

      notifier.state = notifier.state.copyWith(isLoading: false);
    } catch (e) {
      notifier.state = notifier.state.copyWith(
        isLoading: false,
        hasError: true,
        error: switch (e) {
          AuthApiException ex => ex.message,
          AppException ex => ex.message,
          _ =>
            'Ocurrió un error al enviar el correo de recuperación.'
                '\n'
                'Inténtalo de nuevo más tarde.',
        },
      );
    }
  }
}
