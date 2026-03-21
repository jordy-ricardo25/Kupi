import 'package:flutter/foundation.dart';

import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/user/index.dart';

/// Repository contract for user operations.
@immutable
abstract class UserRepository {
  /// Returns the currently authenticated user.
  Future<Result<User>> getCurrent();

  /// Returns a user by its identifier.
  Future<Result<User>> getOne({String? id, String? email});

  /// Creates a new user record.
  Future<Result<User>> create({
    required String id,
    required String displayName,
    required String email,
    String? pictureUrl,
    String? deviceToken,
    required String planId,
  });

  /// Updates an existing user record.
  Future<Result<User>> update(
    String id, {
    String? displayName,
    String? pictureUrl,
    String? deviceToken,
    String? planId,
  });
}
