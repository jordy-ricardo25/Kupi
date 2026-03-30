import 'package:kupi/features/auth/index.dart';

/// Data-layer representation of [AuthUser].
final class AuthUserModel extends AuthUser {
  const AuthUserModel(super.id, {required super.email});
}
