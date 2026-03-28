import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart'
    hide AuthUser, AuthException;

final class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient _client;

  const SupabaseAuthRepository(this._client);

  @override
  Future<Result<AuthUser>> signIn({
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
        e is AppException
            ? e.message
            : 'El correo o la contraseña no son correctos.',
      );
    }
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
        emailRedirectTo: 'https://app.paralelo.ec/signin',
      );

      final user = _mapUser(res.user);
      if (user == null) {
        throw AuthException('No se pudo crear el usuario');
      }

      return Result.success(user);
    } on AppException catch (e) {
      return Result.failure(e.message);
    } catch (_) {
      return Result.failure('Error inesperado');
    }
  }

  @override
  Future<Result<void>> recoverPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'https://app.paralelo.ec/update-password',
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure('Error inesperado');
    }
  }

  @override
  Future<Result<void>> updatePassword(String password) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: password));
      return Result.success(null);
    } catch (e) {
      return Result.failure('Error inesperado');
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _client.auth.signOut();
      return Result.success(null);
    } catch (_) {
      return Result.failure('Error inesperado');
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
}
