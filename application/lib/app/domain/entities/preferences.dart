import 'package:flutter/material.dart';

@immutable
abstract class Preferences {
  final ThemeMode theme;
  final Locale locale;
  final bool allowNotifications;

  const Preferences({
    required this.theme,
    required this.locale,
    required this.allowNotifications,
  });
}
