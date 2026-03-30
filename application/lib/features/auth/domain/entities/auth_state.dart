import 'package:flutter/foundation.dart';
import 'package:kupi/features/auth/index.dart';

/// Immutable auth UI state.
@immutable
final class AuthState {
  /// Current authenticated user (if any).
  final AuthUser? user;

  /// True when a user is present.
  bool get isAuthenticated => user != null;

  const AuthState({this.user});

  /// Creates a new state with an updated [user].
  ///
  /// Pass `null` to clear the current user.
  AuthState copyWith({AuthUser? user}) {
    return AuthState(user: user);
  }

  factory AuthState.initial() => const AuthState();
}
