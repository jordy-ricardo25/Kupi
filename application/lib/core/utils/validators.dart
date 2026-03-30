final class AuthValidators {
  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _sixDigitsRegex = RegExp(r'^\d{6}$');

  static String normalizeEmailInput(String raw) {
    return raw
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll(RegExp(r'[^a-z0-9@._+\-]'), '');
  }

  static String normalizePasswordInput(String raw, {int maxLength = 6}) {
    var normalized = raw.replaceAll(RegExp(r'[^0-9]'), '');

    if (normalized.length > maxLength) {
      normalized = normalized.substring(0, maxLength);
    }

    return normalized;
  }

  static String normalizeEmail(String value) {
    return value.trim().toLowerCase();
  }

  static String normalizePassword(String value) {
    return value.trim();
  }

  static String normalizeName(String value) {
    return value.trim();
  }

  static bool isValidEmail(String value) => _emailRegex.hasMatch(value);

  static bool isSixDigitsPassword(String value) {
    return _sixDigitsRegex.hasMatch(value);
  }

  static String? validateEmail(
    String? value, {
    String emptyMessage = 'Ingresa tu correo electrónico.',
    String invalidMessage = 'Ingresa un correo válido.',
  }) {
    final email = normalizeEmail(value ?? '');
    if (email.isEmpty) return emptyMessage;
    if (!isValidEmail(email)) return invalidMessage;

    return null;
  }

  static String? validateSixDigitsPassword(
    String? value, {
    String emptyMessage = 'Ingresa tu contraseña.',
    String invalidMessage = 'La contraseña debe tener exactamente 6 dígitos.',
  }) {
    final password = normalizePassword(value ?? '');
    if (password.isEmpty) return emptyMessage;
    if (!isSixDigitsPassword(password)) return invalidMessage;

    return null;
  }

  static String? validateFullName(
    String? value, {
    String emptyMessage = 'Ingresa tu nombre completo.',
    String shortMessage = 'Tu nombre debe tener al menos 3 caracteres.',
  }) {
    final name = normalizeName(value ?? '');
    if (name.isEmpty) return emptyMessage;
    if (name.length < 3) return shortMessage;

    return null;
  }
}
