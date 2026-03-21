import 'package:flutter/foundation.dart';

/// Represents a user profile.
@immutable
abstract class User {
  /// User identifier.
  final String id;

  /// Account creation timestamp.
  final DateTime createdAt;

  /// User display name.
  final String displayName;

  /// User email address.
  final String email;

  /// Whether the email is verified.
  final bool verified;

  /// User role.
  final String role;

  /// Profile picture URL (if any).
  final String? pictureUrl;

  /// Push notification token (if any).
  final String? deviceToken;

  /// Associated plan identifier.
  final String planId;

  const User(
    this.id, {
    required this.createdAt,
    required this.displayName,
    required this.email,
    required this.verified,
    required this.role,
    this.pictureUrl,
    this.deviceToken,
    required this.planId,
  });
}
