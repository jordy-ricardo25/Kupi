import 'package:flutter/foundation.dart';

import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';

/// Domain contract for auth operations.
@immutable
abstract class AuthRepository {
  /// Signs in with [email] and [password].
  Future<Result<AuthUser>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Result<bool>> signInWithGoogle();

  Future<Result<bool>> signInWithApple();

  /// Signs up with [email] and [password].
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
  });

  /// Sends password recovery instructions to [email].
  Future<Result<void>> recoverPassword(String email);

  /// Updates the current user's password.
  Future<Result<void>> updatePassword(String password);

  /// Signs out the current session.
  Future<Result<void>> signOut();

  /// Returns the current user, or `null` if unauthenticated.
  AuthUser? getCurrentUser();
}
