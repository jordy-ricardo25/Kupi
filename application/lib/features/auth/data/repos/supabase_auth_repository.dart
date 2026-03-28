import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart'
    hide AuthUser, AuthException;

final class SupabaseAuthRepository implements AuthRepository {
  static const _signInRedirect = 'kupi://auth/signin';
  static const _updatePasswordRedirect = 'kupi://auth/update-password';

  final SupabaseClient _client;

  const SupabaseAuthRepository(this._client);

  @override
  Future<Result<AuthUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = _mapUser(res.user);
      if (user == null) {
        throw AuthException('Usuario no encontrado');
      }

      return Result.success(user);
    } catch (e) {
      return Result.failure(
        _extractError(
          e,
          fallback: 'El correo o la contraseña no son correctos.',
        ),
      );
    }
  }

  @override
  Future<Result<bool>> signInWithGoogle() {
    return _signInWithOAuth(
      provider: OAuthProvider.google,
      fallbackError: 'No se pudo iniciar sesión con Google.',
    );
  }

  @override
  Future<Result<bool>> signInWithApple() {
    return _signInWithOAuth(
      provider: OAuthProvider.apple,
      fallbackError: 'No se pudo iniciar sesión con Apple.',
    );
  }

  @override
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _client.auth.signUp(
        email: email,
        password: password,
        emailRedirectTo: _signInRedirect,
      );

      final user = _mapUser(res.user ?? _client.auth.currentUser);
      if (user == null) {
        throw AuthException(
          'No se pudo recuperar la sesión después del registro. Revisa tu correo de confirmación e intenta iniciar sesión.',
        );
      }

      return Result.success(user);
    } catch (e) {
      return Result.failure(
        _extractError(e, fallback: 'No se pudo completar el registro.'),
      );
    }
  }

  @override
  Future<Result<void>> recoverPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: _updatePasswordRedirect,
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        _extractError(
          e,
          fallback: 'No se pudo enviar el correo de recuperación.',
        ),
      );
    }
  }

  @override
  Future<Result<void>> updatePassword(String password) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: password));
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        _extractError(e, fallback: 'No se pudo actualizar la contraseña.'),
      );
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _client.auth.signOut();
      return Result.success(null);
    } catch (_) {
      return Result.failure('No se pudo cerrar sesión.');
    }
  }

  @override
  AuthUser? getCurrentUser() {
    return _mapUser(_client.auth.currentUser);
  }

  /// Maps Supabase User → Domain AuthUser
  AuthUser? _mapUser(User? user) {
    if (user == null) return null;
    return AuthUserModel(user.id, email: user.email!);
  }

  Future<Result<bool>> _signInWithOAuth({
    required OAuthProvider provider,
    required String fallbackError,
  }) async {
    try {
      final opened = await _client.auth.signInWithOAuth(
        provider,
        redirectTo: _signInRedirect,
      );

      return Result.success(opened);
    } catch (e) {
      return Result.failure(_extractError(e, fallback: fallbackError));
    }
  }

  String _extractError(Object error, {required String fallback}) {
    if (error is AppException) return error.message;

    final message = error.toString().replaceFirst('Exception: ', '').trim();
    if (message.isEmpty) return fallback;

    return message;
  }
}
