import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/features/auth/index.dart';

final resetPasswordControllerProvider = Provider.autoDispose(
  (ref) => ResetPasswordController(ref),
);

final signInControllerProvider = Provider.autoDispose(
  (ref) => SignInController(ref),
);

final signUpControllerProvider = Provider.autoDispose(
  (ref) => SignUpController(ref),
);

final updatePasswordControllerProvider = Provider.autoDispose(
  (ref) => UpdatePasswordController(ref),
);
