import 'package:flutter/foundation.dart';

/// Domain entity representing an authenticated user.
@immutable
abstract class AuthUser {
  /// Stable user identifier from the auth provider.
  final String id;

  /// User email address.
  final String email;

  const AuthUser(this.id, {required this.email});
}
