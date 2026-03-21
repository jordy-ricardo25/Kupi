import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/features/auth/index.dart';

/// Base notifier for auth state management.
abstract class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());
}
