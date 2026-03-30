import 'package:go_router/go_router.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/features/auth/index.dart';

final appRoutes = <RouteBase>[
  /// =====================
  /// SPLASH
  /// =====================
  GoRoute(
    path: SplashPage.routePath,
    builder: (_, _) {
      return const SplashPage();
    },
  ),

  /// =====================
  /// AUTH
  /// =====================
  GoRoute(
    path: SignInPage.routePath,
    builder: (_, _) {
      return const SignInPage();
    },
  ),
  GoRoute(
    path: SignUpPage.routePath,
    builder: (_, _) {
      return const SignUpPage();
    },
  ),

  /// =====================
  /// PASSWORD
  /// =====================
  GoRoute(
    path: ResetPasswordPage.routePath,
    builder: (_, _) {
      return const ResetPasswordPage();
    },
  ),
  GoRoute(
    path: UpdatePasswordPage.routePath,
    builder: (_, _) {
      return const UpdatePasswordPage();
    },
  ),

  /// =====================
  /// APP SHELL (ROOT)
  /// =====================
  ///
  GoRoute(
    path: '/',
    builder: (_, _) {
      return const MainPage();
    },
  ),
];
