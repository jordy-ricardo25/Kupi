import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart' show AuthApiException;

final class SignInController {
  final Ref _ref;

  const SignInController(this._ref);

  Future<void> mutate({
    required AuthProvider provider,
    String? email,
    String? password,
  }) async {
    final notifier = _ref.read(signInMutationProvider.notifier);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      final repo = _ref.read(authRepositoryProvider);

      switch (provider) {
        case AuthProvider.google:
          await repo.signInWithGoogle();
          break;
        case AuthProvider.apple:
          await repo.signInWithApple();
          break;
        default:
          if (email!.trim().isEmpty || password!.trim().isEmpty) {
            throw const AuthException(
              'Por favor ingresa tu correo y contraseña.',
            );
          }

          await repo.signInWithEmail(email: email, password: password);
      }

      notifier.state = notifier.state.copyWith(isLoading: false);
    } catch (e) {
      if (!notifier.mounted) return;

      notifier.state = notifier.state.copyWith(
        isLoading: false,
        hasError: true,
        error: switch (e) {
          AuthApiException ex => ex.message,
          AppException ex => ex.message,
          _ =>
            'Ocurrió un error al iniciar sesión.'
                '\n'
                'Inténtalo de nuevo más tarde.',
        },
      );
    }
  }
}

enum AuthProvider { email, google, apple }
