import 'package:flutter/material.dart';

final class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color success;
  final Color warning;
  final Color info;

  final Color selectedItem;
  final Color unselectedItem;

  final Color scaffold;
  final Color bottomAppBar;

  const AppColorExtension({
    required this.success,
    required this.warning,
    required this.info,

    required this.selectedItem,
    required this.unselectedItem,

    required this.scaffold,
    required this.bottomAppBar,
  });

  @override
  AppColorExtension copyWith({
    Color? success,
    Color? warning,
    Color? info,
    Color? selectedItem,
    Color? unselectedItem,
    Color? scaffold,
    Color? bottomAppBar,
  }) => AppColorExtension(
    success: success ?? this.success,
    warning: warning ?? this.warning,
    info: info ?? this.info,

    selectedItem: selectedItem ?? this.selectedItem,
    unselectedItem: unselectedItem ?? this.unselectedItem,

    scaffold: scaffold ?? this.scaffold,
    bottomAppBar: bottomAppBar ?? this.bottomAppBar,
  );

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;
    return AppColorExtension(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,

      selectedItem: Color.lerp(selectedItem, other.selectedItem, t)!,
      unselectedItem: Color.lerp(unselectedItem, other.unselectedItem, t)!,

      scaffold: Color.lerp(scaffold, other.scaffold, t)!,
      bottomAppBar: Color.lerp(bottomAppBar, other.bottomAppBar, t)!,
    );
  }

  // 🌞 LIGHT
  static const light = AppColorExtension(
    success: Color(0xFF22C55E),
    warning: Color(0xFFF59E0B),
    info: Color(0xFF3B82F6),

    selectedItem: Color(0xFF3B82F6),
    unselectedItem: Color(0xFFC6C8CC),

    scaffold: Color(0xFFFFFFFF),
    bottomAppBar: Color(0xFFFFFFFF),
  );

  // 🌙 DARK
  static const dark = AppColorExtension(
    success: Color(0xFF4ADE80),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),

    selectedItem: Color(0xFF1E40AF),
    unselectedItem: Color(0xFFC6C8CC),

    scaffold: Color(0xFF1B1B1B),
    bottomAppBar: Color(0xFF000000),
  );
}
