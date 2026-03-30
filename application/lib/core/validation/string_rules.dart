import 'package:easy_localization/easy_localization.dart';

import 'validator.dart';

extension StringRules on Validator<String> {
  Validator<String> required([String? message]) {
    return addRule(
      (v) =>
          (v == null || v.trim().isEmpty)
              ? (message ?? 'validation.required_field'.tr())
              : null,
    );
  }

  Validator<String> minLength(int min, [String? message]) {
    return addRule(
      (v) => (v != null && v.length < min)
          ? (message ?? 'validation.min_characters'.tr(namedArgs: {'min': '$min'}))
          : null,
    );
  }

  Validator<String> minLengthIfPresent(int min, [String? message]) {
    return addRule((v) {
      if (v == null || v.trim().isEmpty) return null;
      if (v.length < min) {
        return message ??
            'validation.min_characters'.tr(namedArgs: {'min': '$min'});
      }
      return null;
    });
  }

  Validator<String> email([String? message]) {
    return addRule((v) {
      if (v == null || v.trim().isEmpty) {
        return message ?? 'validation.invalid_email'.tr();
      }
      // ignore: deprecated_member_use
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(v)
          ? null
          : (message ?? 'validation.invalid_email'.tr());
    });
  }

  Validator<String> matches(
    String Function() otherValueGetter, [
    String? message,
  ]) {
    return addRule(
      (v) =>
          v != otherValueGetter()
              ? (message ?? 'validation.no_match'.tr())
              : null,
    );
  }

  Validator<String> isDouble([String? message]) {
    return addRule(
      (v) =>
          double.tryParse(v ?? '') == null
              ? (message ?? 'validation.must_be_number'.tr())
              : null,
    );
  }
}
