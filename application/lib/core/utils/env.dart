import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final class Env {
  static bool get _useDartDefine => kIsWeb && kReleaseMode;

  static String get supabaseUrl {
    if (_useDartDefine) {
      return const String.fromEnvironment('SUPABASE_URL');
    }
    return dotenv.env['SUPABASE_URL']!;
  }

  static String get supabaseAnonKey {
    if (_useDartDefine) {
      return const String.fromEnvironment('SUPABASE_ANON_KEY');
    }
    return dotenv.env['SUPABASE_ANON_KEY']!;
  }
}
