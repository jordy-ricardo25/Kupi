import 'package:flutter/foundation.dart';

import 'package:kupi/core/utils/results.dart';
import 'package:kupi/features/user/index.dart';

/// Repository contract for user preference operations.
@immutable
abstract class UserPreferenceRepository {
  /// Returns preferences for a user.
  Future<Result<UserPreference>> get({required String userId});

  /// Updates user preferences.
  Future<Result<UserPreference>> update(
    String userId, {
    String? language,
    bool? notificationsEnabled,
  });
}
