import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';

final class UpdatePasswordController {
  const UpdatePasswordController(this._ref);

  final Ref _ref;

  Future<void> mutate({required String password}) async {
    final notifier = _ref.read(updatePasswordMutationProvider.notifier);

    notifier.state = notifier.state.copyWith(
      isLoading: true,
      hasError: false,
      error: null,
    );

    try {
      if (password.trim().isEmpty) {
        throw const AuthException('La contraseña no puede estar vacía.');
      }

      await _ref.read(authRepositoryProvider).updatePassword(password);

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
