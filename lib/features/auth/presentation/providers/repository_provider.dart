import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/features/auth/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (_) => SupabaseAuthRepository(Supabase.instance.client),
);
