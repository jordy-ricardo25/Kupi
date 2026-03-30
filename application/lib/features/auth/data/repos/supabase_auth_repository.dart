import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/auth/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart'
    hide AuthUser, AuthException;

final class SupabaseAuthRepository implements AuthRepository {
  static const _signInRedirect = 'kupi://auth/signin';
  static const _updatePasswordRedirect = 'kupi://auth/update-password';

  final SupabaseClient _client;

  const SupabaseAuthRepository(this._client);

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = _mapUser(res.user);
    if (user == null) {
      throw const AuthException('Usuario no encontrado.');
    }

    return user;
  }

  @override
  Future<bool> signInWithGoogle() {
    return _signInWithOAuth(
      provider: OAuthProvider.google,
      fallbackError: 'No se pudo iniciar sesión con Google.',
    );
  }

  @override
  Future<bool> signInWithApple() {
    return _signInWithOAuth(
      provider: OAuthProvider.apple,
      fallbackError: 'No se pudo iniciar sesión con Apple.',
    );
  }

  @override
  Future<AuthUser> signUp({
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
        throw const AuthException('No se pudo crear el usuario.');
      }

      return user;
    } catch (e) {
      return Future.error(
        e is AppException
            ? e.message
            : 'Ocurrió un error al registrar tu cuenta.'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }

  @override
  Future<void> recoverPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: _updatePasswordRedirect,
      );
    } catch (e) {
      return Future.error(
        e is AppException
            ? e.message
            : 'Ocurrió un error al enviar el correo de recuperación.'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }

  @override
  Future<void> updatePassword(String password) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: password));
    } catch (e) {
      return Future.error(
        e is AppException
            ? e.message
            : 'Ocurrió un error al actualizar la contraseña.'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      return;
    } catch (_) {
      return Future.error(
        'No se pudo cerrar sesión.'
        '\n'
        'Inténtalo de nuevo más tarde.',
      );
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

  Future<bool> _signInWithOAuth({
    required OAuthProvider provider,
    required String fallbackError,
  }) async {
    try {
      final opened = await _client.auth.signInWithOAuth(
        provider,
        redirectTo: _signInRedirect,
        authScreenLaunchMode: LaunchMode.inAppWebView,
        queryParams: provider == OAuthProvider.google
            ? {'prompt': 'select_account consent'}
            : null,
      );

      return opened;
    } catch (e) {
      return Future.error(
        e is AppException
            ? e.message
            : 'Ocurrió un error al iniciar con ${provider == OAuthProvider.google ? 'Google' : 'Apple'}'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }
}
