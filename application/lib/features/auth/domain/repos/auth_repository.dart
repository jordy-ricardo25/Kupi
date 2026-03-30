import 'package:flutter/foundation.dart';
import 'package:kupi/features/auth/index.dart';

/// Domain contract for auth operations.
@immutable
abstract class AuthRepository {
  /// Signs in with [email] and [password].
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<bool> signInWithGoogle();

  Future<bool> signInWithApple();

  /// Signs up with [email] and [password].
  Future<AuthUser> signUp({required String email, required String password});

  /// Sends password recovery instructions to [email].
  Future<void> recoverPassword(String email);

  /// Updates the current user's password.
  Future<void> updatePassword(String password);

  /// Signs out the current session.
  Future<void> signOut();

  /// Returns the current user, or `null` if unauthenticated.
  AuthUser? getCurrentUser();
}
