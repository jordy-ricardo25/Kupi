import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/app/index.dart';

abstract class PreferencesNotifier extends StateNotifier<Preferences> {
  PreferencesNotifier() : super(PreferencesModel.initial());

  void setTheme(ThemeMode mode);

  void setLocale(String code);

  void setNotifications(bool enabled);
}
