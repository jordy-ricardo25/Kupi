import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';
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
    final normalizedName = AuthValidators.normalizeName(name);
    final normalizedEmail = AuthValidators.normalizeEmail(email);
    final normalizedPassword = AuthValidators.normalizePassword(password);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      final nameError = AuthValidators.validateFullName(normalizedName);
      if (nameError != null) throw AuthException(nameError);

      final emailError = AuthValidators.validateEmail(
        normalizedEmail,
        emptyMessage: 'Ingresa un correo electrónico válido.',
        invalidMessage: 'Ingresa un correo electrónico válido.',
      );
      if (emailError != null) throw AuthException(emailError);

      final passwordError = AuthValidators.validateSixDigitsPassword(
        normalizedPassword,
        emptyMessage: 'Ingresa una contraseña válida.',
      );
      if (passwordError != null) throw AuthException(passwordError);

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
