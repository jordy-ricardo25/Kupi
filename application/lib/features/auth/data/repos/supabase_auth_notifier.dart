import 'package:flutter/foundation.dart';

import 'package:kupi/features/auth/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

final class SupabaseAuthNotifier extends AuthNotifier {
  final SupabaseClient _client;

  SupabaseAuthNotifier(this._client) : super() {
    _client.auth.onAuthStateChange.listen((state) {
      switch (state.event) {
        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.signedIn:
          if (state.session == null) break;

          this.state = this.state.copyWith(
            user: AuthUserModel(
              state.session!.user.id,
              email: state.session!.user.email!,
            ),
          );
          break;
        case AuthChangeEvent.signedOut:
          this.state = this.state.copyWith(user: null);
          break;
        default:
          debugPrint('Unknown auth event ${state.event}');
      }
    });
  }
}
