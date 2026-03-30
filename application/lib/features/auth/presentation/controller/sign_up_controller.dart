import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';
import 'package:kupi/features/plan/index.dart';
import 'package:kupi/features/user/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthApiException, PostgrestException;

final class SignUpController {
  final Ref _ref;

  const SignUpController(this._ref);

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

      final (plan, user) =
          await Future.wait([
            _ref.read(planRepositoryProvider).getOne(name: 'Free'),
            _ref
                .read(authRepositoryProvider)
                .signUp(email: email, password: password),
          ], eagerError: true).then((r) {
            return (r[0] as Plan, r[1] as AuthUser);
          });

      await _ref
          .read(userRepositoryProvider)
          .create(
            id: user.id,
            displayName: name,
            email: email,
            planId: plan.id,
          );

      notifier.state = notifier.state.copyWith(isLoading: false);
    } catch (e) {
      if (!notifier.mounted) return;

      notifier.state = notifier.state.copyWith(
        isLoading: false,
        hasError: true,
        error: switch (e) {
          AuthApiException ex => ex.message,
          PostgrestException ex => ex.message,
          AppException ex => ex.message,
          _ =>
            'Ocurrió un error al registrarte.'
                '\n'
                'Inténtalo de nuevo más tarde.',
        },
      );
    }
  }
}
