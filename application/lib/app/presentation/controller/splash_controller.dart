import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:package_info_plus/package_info_plus.dart';

import 'package:kupi/app/index.dart';
// import 'package:kupi/core/exceptions/index.dart';
// import 'package:kupi/core/platform/index.dart';
// import 'package:kupi/core/services/index.dart';
// import 'package:kupi/features/app_config/index.dart';
// import 'package:kupi/features/auth/index.dart';
// import 'package:kupi/features/user/index.dart';

final class SplashController extends AutoDisposeAsyncNotifier<AppStatus> {
  @override
  Future<AppStatus> build() async {
    // final userId = ref.read(authStateProvider).user?.id;

    // final config = await ref
    //     .read(appConfigRepositoryProvider)
    //     .getOne(_platformToString())
    //     .then((r) => r.fold((e) => throw QueryException(e), (v) => v));

    // if (config.maintenanceMode) return AppStatus.maintenance;

    // final info = await PackageInfo.fromPlatform();
    // final needsForceUpdate =
    //     (config.forceUpdate &&
    //         _compareVersions(info.version, config.latestVersion) != 0) ||
    //     (_compareVersions(info.version, config.minVersion) < 0);

    // if (needsForceUpdate) return AppStatus.forceUpdate;
    // if (userId == null || userId.isEmpty) return AppStatus.ready;

    // final (user, userPreference, deviceToken) =
    //     await Future.wait([
    //       ref
    //           .read(userRepositoryProvider)
    //           .getCurrent()
    //           .then((r) => r.fold((e) => throw AuthException(e), (v) => v)),
    //       ref
    //           .read(userPreferenceRepositoryProvider)
    //           .get(userId: userId)
    //           .then((r) => r.fold((e) => throw QueryException(e), (v) => v)),
    //       FCMService.instance.getDeviceToken(),
    //     ], eagerError: true).then((r) {
    //       return (r[0] as User, r[1] as UserPreference, r[2] as String?);
    //     });

    // final prefNotifier = ref.read(preferencesProvider.notifier);

    // prefNotifier.setLocale(userPreference.language);

    // if (user.deviceToken != deviceToken) {
    //   await ref
    //       .read(userRepositoryProvider)
    //       .update(userId, deviceToken: deviceToken)
    //       .then((r) => r.fold((e) => throw QueryException(e), (_) {}));
    // }

    // final notificationsEnabled = await _updateNotificationPreference(
    //   userPreference,
    //   userId,
    // );
    // prefNotifier.setNotifications(notificationsEnabled);

    await Future.delayed(Duration(seconds: 5));

    return AppStatus.ready;
  }

  // Future<bool> _updateNotificationPreference(
  //   UserPreference preference,
  //   String userId,
  // ) async {
  //   if (!preference.notificationsEnabled) return false;
  //   final hasPermission = await FCMService.instance.checkPermission();
  //   if (!hasPermission) {
  //     await ref
  //         .read(userPreferenceRepositoryProvider)
  //         .update(userId, notificationsEnabled: false);
  //     return false;
  //   }
  //   return true;
  // }

  // String _platformToString() {
  //   switch (currentPlatform) {
  //     case AppPlatform.android:
  //       return 'ANDROID';
  //     case AppPlatform.ios:
  //       return 'IOS';
  //     case AppPlatform.web:
  //       return 'WEB';
  //   }
  // }

  // int _compareVersions(String a, String b) {
  //   final aParts = a.split('.').map(int.parse).toList();
  //   final bParts = b.split('.').map(int.parse).toList();

  //   final maxLength = [
  //     aParts.length,
  //     bParts.length,
  //   ].reduce((v, e) => v > e ? v : e);
  //   while (aParts.length < maxLength) {
  //     aParts.add(0);
  //   }
  //   while (bParts.length < maxLength) {
  //     bParts.add(0);
  //   }

  //   for (int i = 0; i < maxLength; i++) {
  //     if (aParts[i] < bParts[i]) return -1;
  //     if (aParts[i] > bParts[i]) return 1;
  //   }

  //   return 0; // Equals
  // }
}
