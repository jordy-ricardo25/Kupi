import 'package:flutter/material.dart';
import 'package:kupi/app/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalPreferencesNotifier extends PreferencesNotifier {
  static const _kThemeKey = '__theme_mode__';
  static const _kLocaleKey = '__locale_mode__';
  static const _kNotificationsKey = '__notifications_enabled__';

  final SharedPreferences _prefs;

  LocalPreferencesNotifier(this._prefs) : super() {
    final isDarkThemeMode = _prefs.getBool(_kThemeKey);
    final currentLocale = _prefs.getString(_kLocaleKey);
    final notificationsEnabled = _prefs.getBool(_kNotificationsKey);

    state = (state as PreferencesModel).copyWith(
      theme: (isDarkThemeMode ?? false) ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(currentLocale ?? 'es'),
      allowNotifications: notificationsEnabled ?? false,
    );
  }

  @override
  void setTheme(ThemeMode mode) {
    _prefs.setBool(_kThemeKey, mode == ThemeMode.dark);
    state = (state as PreferencesModel).copyWith(theme: mode);
  }

  @override
  void setLocale(String code) {
    _prefs.setString(_kLocaleKey, code);
    state = (state as PreferencesModel).copyWith(locale: Locale(code));
  }

  @override
  void setNotifications(bool enabled) {
    _prefs.setBool(_kNotificationsKey, enabled);
    state = (state as PreferencesModel).copyWith(allowNotifications: enabled);
  }
}
