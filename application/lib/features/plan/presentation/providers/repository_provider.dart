import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/features/plan/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final planRepositoryProvider = Provider.autoDispose((_) {
  final client = Supabase.instance.client;
  return SupabasePlanRepository(client);
});
