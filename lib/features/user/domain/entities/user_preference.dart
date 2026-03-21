import 'package:flutter/foundation.dart';

/// User-level app preferences.
@immutable
abstract class UserPreference {
  /// Unique preference record id.
  final String id;

  /// Record creation time.
  final DateTime createdAt;

  /// Preferred locale/language code.
  final String language;

  /// Whether push notifications are enabled.
  final bool notificationsEnabled;

  /// Owner user id.
  final String userId;

  const UserPreference(
    this.id, {
    required this.createdAt,
    required this.language,
    required this.notificationsEnabled,
    required this.userId,
  });
}
