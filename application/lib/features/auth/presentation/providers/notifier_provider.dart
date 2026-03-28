import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/features/auth/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (_) => SupabaseAuthNotifier(Supabase.instance.client),
);
