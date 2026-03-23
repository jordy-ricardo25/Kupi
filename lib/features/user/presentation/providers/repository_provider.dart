import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/features/user/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userPreferenceRepositoryProvider =
    Provider.autoDispose<UserPreferenceRepository>(
      (_) => SupabaseUserPreferenceRepository(Supabase.instance.client),
    );

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (ref) => SupabaseUserRepository(Supabase.instance.client, ref),
);
