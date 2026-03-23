import 'package:kupi/features/user/index.dart';

/// Data-layer representation of [User].
class UserModel extends User {
  const UserModel(
    super.id, {
    required super.createdAt,
    required super.displayName,
    required super.email,
    required super.verified,
    required super.role,
    super.pictureUrl,
    super.deviceToken,
    required super.planId,
  });

  /// Creates a [User] from a database map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['id'],
      createdAt: DateTime.parse(map['created_at']),
      displayName: map['display_name'],
      email: map['email'],
      verified: map['verified'],
      role: map['role'],
      pictureUrl: map['picture_url'],
      deviceToken: map['device_token'],
      planId: map['plan_id'],
    );
  }
}
