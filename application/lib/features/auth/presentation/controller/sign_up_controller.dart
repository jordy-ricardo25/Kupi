import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

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
    final normalizedName = name.trim();
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPassword = password.trim();

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      if (normalizedName.isEmpty) {
        throw AuthException('Ingresa tu nombre completo.');
      }

      if (normalizedName.length < 3) {
        throw AuthException('Tu nombre debe tener al menos 3 caracteres.');
      }

      if (normalizedEmail.isEmpty) {
        throw AuthException('Ingresa un correo electrónico válido.');
      }

      final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
      if (!emailRegex.hasMatch(normalizedEmail)) {
        throw AuthException('Ingresa un correo electrónico válido.');
      }

      if (normalizedPassword.isEmpty) {
        throw AuthException('Ingresa una contraseña válida.');
      }

      final passwordRegex = RegExp(r'^\d{6}$');
      if (!passwordRegex.hasMatch(normalizedPassword)) {
        throw AuthException('La contraseña debe tener exactamente 6 dígitos.');
      }

      final user = await _ref
          .read(authRepositoryProvider)
          .signUp(email: normalizedEmail, password: normalizedPassword)
          .then((r) => r.fold((e) => throw AuthException(e), (v) => v));

      final userRepository = _ref.read(userRepositoryProvider);

      final profileResult = await userRepository.create(
        id: user.id,
        displayName: normalizedName,
        email: normalizedEmail,
        planId: 'free',
      );

      final fallbackResult = await profileResult.fold((_) {
        return userRepository.create(
          id: user.id,
          displayName: normalizedName,
          email: normalizedEmail,
          planId: '',
        );
      }, (_) async => profileResult);

      fallbackResult.fold(
        (e) => debugPrint('Profile creation failed after sign up: $e'),
        (_) {},
      );

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
