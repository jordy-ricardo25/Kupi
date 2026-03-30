import 'package:flutter/foundation.dart';
import 'package:kupi/app/index.dart';

AppPlatform get currentPlatform {
  if (kIsWeb) throw UnimplementedError();

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return AppPlatform.android;
    case TargetPlatform.iOS:
      return AppPlatform.ios;
    default:
      throw UnimplementedError();
  }
}
