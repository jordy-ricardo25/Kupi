import 'package:flutter/material.dart';

final class AppColorScheme {
  // 🌞 LIGHT
  static final ColorScheme light = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFF3B82F6),

    // Primary
    primary: const Color(0xFF3B82F6),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0xFFD8E2FF),
    onPrimaryContainer: const Color(0xFF001A42),

    // Secondary
    secondary: const Color(0xFFFCBE2B),
    onSecondary: const Color(0xFFFFFFFF),
    secondaryContainer: const Color(0xFFFFDEA3),
    onSecondaryContainer: const Color(0xFF261900),

    // Tertiary
    tertiary: const Color(0xFF1E40AF),
    onTertiary: const Color(0xFFFFFFFF),
    tertiaryContainer: const Color(0xFFDDE1FF),
    onTertiaryContainer: const Color(0xFF001453),

    // Surfaces
    surface: const Color(0xFFFBF8FF),
    onSurface: const Color(0xFF111827),
    inverseSurface: const Color(0xFFDBEAFE),
    onInverseSurface: const Color(0xFF111827),

    // Error
    error: const Color(0xFFEF4444),
    onError: const Color(0xFFFFFFFF),
  );

  // 🌙 DARK
  static final ColorScheme dark = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFF3B82F6),

    // Primary
    primary: const Color(0xFF3B82F6),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0xFF1E40AF),
    onPrimaryContainer: const Color(0xFFE5E7EB),

    // Secondary
    secondary: const Color(0xFFFCBE2B),
    onSecondary: const Color(0xFF000000),
    secondaryContainer: const Color(0xFF7C5A00),
    onSecondaryContainer: const Color(0xFFFFF3D0),

    // Tertiary
    tertiary: const Color(0xFF60A5FA),
    onTertiary: const Color(0xFF000000),
    tertiaryContainer: const Color(0xFF1E293B),
    onTertiaryContainer: const Color(0xFFE5E7EB),

    // Surfaces
    surface: const Color(0xFF0F172A),
    onSurface: const Color(0xFFE5E7EB),
    inverseSurface: const Color(0xFF1E293B),
    onInverseSurface: const Color(0xFFE5E7EB),

    // Error
    error: const Color(0xFFEF4444),
    onError: const Color(0xFFFFFFFF),
  );
}
