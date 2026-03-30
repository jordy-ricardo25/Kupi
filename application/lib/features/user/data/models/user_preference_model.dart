import 'package:kupi/features/user/index.dart';

/// Data-layer representation of [UserPreference].
final class UserPreferenceModel extends UserPreference {
  const UserPreferenceModel(
    super.id, {
    required super.createdAt,
    required super.language,
    required super.notificationsEnabled,
    required super.userId,
  });

  /// Creates a [UserPreference] from a database map.
  factory UserPreferenceModel.fromMap(Map<String, dynamic> map) {
    return UserPreferenceModel(
      map['id'],
      createdAt: DateTime.parse(map['created_at']),
      language: map['language'],
      notificationsEnabled: map['notifications_enabled'],
      userId: map['user_id'],
    );
  }
}
