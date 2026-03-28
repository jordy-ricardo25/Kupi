import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color_extension.dart';
import 'app_color_scheme.dart';

extension AppThemeData on ThemeData {
  // 🌞 LIGHT THEME
  ThemeData get light {
    final scheme = AppColorScheme.light;

    return _base(scheme, Brightness.light);
  }

  // 🌙 DARK THEME
  ThemeData get dark {
    final scheme = AppColorScheme.dark;

    return _base(scheme, Brightness.dark);
  }

  // 🔁 BASE THEME
  ThemeData _base(ColorScheme scheme, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      applyElevationOverlayColor: brightness == Brightness.dark,

      textTheme: const TextTheme(
        labelSmall: TextStyle(fontSize: 10),
        labelMedium: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 14),

        bodySmall: TextStyle(fontSize: 12),
        bodyMedium: TextStyle(fontSize: 14),
        bodyLarge: TextStyle(fontSize: 16),

        titleSmall: TextStyle(fontSize: 14),
        titleMedium: TextStyle(fontSize: 18),
        titleLarge: TextStyle(fontSize: 22),

        headlineSmall: TextStyle(fontSize: 24),
        headlineMedium: TextStyle(fontSize: 30),
        headlineLarge: TextStyle(fontSize: 36),

        displaySmall: TextStyle(fontSize: 42),
        displayMedium: TextStyle(fontSize: 50),
        displayLarge: TextStyle(fontSize: 58),
      ),

      dividerTheme: DividerThemeData(color: scheme.outlineVariant),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(
            const Size(double.minPositive, 44),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(
            const Size(double.minPositive, 44),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(
            const Size(double.minPositive, 44),
          ),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? scheme.outlineVariant
                  : scheme.primary,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(style: ButtonStyle()),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: WidgetStateProperty.all(Size.zero),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(color: scheme.outline.withAlpha(155)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.error),
        ),
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(scheme.surface),
        elevation: WidgetStateProperty.all(0),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        side: BorderSide.none,
        showCheckmark: false,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      ),

      appBarTheme: AppBarThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: Colors.transparent,
      ),

      scaffoldBackgroundColor: Colors.white,

      extensions: [
        brightness == Brightness.dark
            ? AppColorExtension.dark
            : AppColorExtension.light,
      ],
    );
  }
}
