import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns a string representation of the date in `dd-MM-yyyy` format.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2025, 9, 27);
  /// print(date.toShortDateString()); // 27-09-2025
  /// ```
  String toShortDateString() {
    return '$year-'
        '${'$month'.padLeft(2, '0')}-'
        '${'$day'.padLeft(2, '0')}';
  }

  /// Returns a string representation of the time in 24-hour format (`HH:mm`).
  ///
  /// Example:
  /// ```dart
  /// final dateTime = DateTime(2025, 9, 27, 14, 45);
  /// print(dateTime.toShortTimeString()); // 14:45
  /// ```
  String toShortTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  /// Formats this [DateTime] into a long, human-friendly date + time string.
  ///
  /// Examples:
  /// - `locale: 'en'` → `Oct 12, 2023 at 2:30 PM`
  /// - `locale: 'es'` → `10 de febrero de 2026 a las 4:41 p. m.`
  /// - `locale: 'es', use24h: true` → `10 de febrero de 2026 a las 16:41`
  ///
  /// By default it:
  /// - Converts the value to local time ([convertToLocal] = true)
  /// - Uses 12h clock unless [use24h] is true
  /// - Includes a connector between date and time ([includeAt] = true)
  ///
  /// Parameters:
  /// - [locale]: Optional locale code (e.g. `'es'`, `'es_MX'`, `'en_US'`).
  /// - [use24h]: If true, formats time as `HH:mm`; otherwise uses `h:mm a`.
  /// - [includeAt]: If true, includes a connector:
  ///   - Spanish locales: `" a las "`
  ///   - Other locales: `" at "`
  /// - [capitalize]: Capitalizes the first character of the final string.
  /// - [convertToLocal]: If true, uses [toLocal] before formatting.
  /// - [longMonth]: If true, uses full month name (e.g. `"febrero"`), otherwise abbreviated (e.g. `"feb."`).
  /// - [includeWeekday]: If true, includes the weekday (e.g. `"lun., 10 de febrero de 2026 ..."`).
  ///
  /// Note:
  /// - For Spanish, the date pattern is adjusted to a more natural grammar:
  ///   `d 'de' MMMM 'de' y` (or abbreviated month when [longMonth] is false).
  String toLongDateTimeString({
    String? locale,
    bool use24h = false,
    bool includeAt = true,
    bool capitalize = false,
    bool convertToLocal = true,
    bool longMonth = true,
    bool includeWeekday = false,
  }) {
    final dt = convertToLocal ? toLocal() : this;

    final loc = locale ?? Intl.getCurrentLocale();
    final isSpanish = loc.toLowerCase().startsWith('es');

    // Date pattern: Spanish needs a grammar-friendly format.
    final monthToken = longMonth ? 'MMMM' : 'MMM';
    final datePattern = isSpanish
        ? (includeWeekday
              ? "EEE, d 'de' $monthToken 'de' y"
              : "d 'de' $monthToken 'de' y")
        : (includeWeekday ? 'EEE, MMM d, y' : 'MMM d, y');

    final dateFormatter = DateFormat(datePattern, loc);
    final timeFormatter = DateFormat(use24h ? 'HH:mm' : 'h:mm a', loc);

    final datePart = dateFormatter.format(dt);
    final timePart = timeFormatter.format(dt);

    final connector = isSpanish ? 'a las' : 'at';

    var result = includeAt
        ? '$datePart $connector $timePart'
        : '$datePart $timePart';

    if (capitalize && result.isNotEmpty) {
      result = result[0].toUpperCase() + result.substring(1);
    }

    return result;
  }
}
