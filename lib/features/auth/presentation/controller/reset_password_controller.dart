import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';

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

      await _ref
          .read(authRepositoryProvider)
          .recoverPassword(email)
          .then((r) => r.fold((e) => throw AuthException(e), (_) {}));

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
