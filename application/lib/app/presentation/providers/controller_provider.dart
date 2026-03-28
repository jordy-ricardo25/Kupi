import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/app/index.dart';

// final settingsControllerProvider = AsyncNotifierProvider.autoDispose(() {
//   return SettingsController();
// });

final splashControllerProvider = AsyncNotifierProvider.autoDispose(() {
  return SplashController();
});
