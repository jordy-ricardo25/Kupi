import 'package:easy_localization/easy_localization.dart';

/// Canonical role constants used by the domain/auth flow.
abstract final class UserRole {
  /// Regular end-user role.
  static const String user = 'USER';

  /// Moderation role with elevated permissions.
  static const String moderator = 'MODERATOR';

  /// Administrative role with full permissions.
  static const String admin = 'ADMIN';

  /// Supported role values.
  static const List<String> values = [user, moderator, admin];

  /// Localized label by role value.
  static final Map<String, String> labels = {
    user: 'domain.user.role.user'.tr(),
    moderator: 'domain.user.role.moderator'.tr(),
    admin: 'domain.user.role.admin'.tr(),
  };
}
