import 'package:flutter/material.dart';
import 'package:kupi/app/index.dart';
import 'package:kupi/core/utils/index.dart';

final class PreferencesModel extends Preferences
    implements Copyable<PreferencesModel> {
  const PreferencesModel({
    required super.theme,
    required super.locale,
    required super.allowNotifications,
  });

  @override
  PreferencesModel copyWith({
    ThemeMode? theme,
    Locale? locale,
    bool? allowNotifications,
  }) {
    return PreferencesModel(
      theme: theme ?? this.theme,
      locale: locale ?? this.locale,
      allowNotifications: allowNotifications ?? this.allowNotifications,
    );
  }

  factory PreferencesModel.initial() {
    return const PreferencesModel(
      theme: ThemeMode.light,
      locale: Locale('es'),
      allowNotifications: false,
    );
  }
}
