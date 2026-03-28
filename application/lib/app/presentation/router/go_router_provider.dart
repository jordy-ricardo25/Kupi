import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/features/auth/index.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: SplashPage.routePath,
    routes: appRoutes,

    redirect: (_, state) {
      final location = state.matchedLocation;
      final loggedIn = ref.read(authStateProvider).isAuthenticated;

      const publicRoutes = [
        SignInPage.routePath,
        SignUpPage.routePath,
        ResetPasswordPage.routePath,
        UpdatePasswordPage.routePath,
      ];

      final isPublicRoute = publicRoutes.contains(location);

      if (!loggedIn && !isPublicRoute) {
        return SignInPage.routePath;
      }

      if (loggedIn && isPublicRoute) {
        return '/';
      }

      return null;
    },
  );

  ref.listen<AuthState>(authStateProvider, (_, _) {
    router.refresh();
  });

  return router;
});
