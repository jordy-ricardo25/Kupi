import 'package:easy_localization/easy_localization.dart';

import 'validator.dart';

extension NumRules on Validator<num> {
  Validator<num> required([String? message]) {
    return addRule(
      (v) => v == null ? (message ?? 'validation.required_field'.tr()) : null,
    );
  }

  Validator<num> nonNegative([String? message]) {
    return addRule((v) {
      if (v != null && v < 0) {
        return message ?? 'validation.non_negative'.tr();
      }
      return null;
    });
  }

  Validator<num> greaterThan(num min, [String? message]) {
    return addRule((v) {
      if (v != null && v <= min) {
        return message ??
            'validation.greater_than'.tr(namedArgs: {'min': '$min'});
      }
      return null;
    });
  }

  Validator<num> greaterOrEqual(num min, [String? message]) {
    return addRule((v) {
      if (v != null && v < min) {
        return message ??
            'validation.greater_or_equal'.tr(namedArgs: {'min': '$min'});
      }
      return null;
    });
  }

  Validator<num> lessThan(num max, [String? message]) {
    return addRule((v) {
      if (v != null && v >= max) {
        return message ?? 'validation.less_than'.tr(namedArgs: {'max': '$max'});
      }
      return null;
    });
  }

  Validator<num> lessOrEqual(num max, [String? message]) {
    return addRule((v) {
      if (v != null && v > max) {
        return message ??
            'validation.less_or_equal'.tr(namedArgs: {'max': '$max'});
      }
      return null;
    });
  }

  Validator<num> between(num min, num max, [String? message]) {
    return addRule((v) {
      if (v != null && (v < min || v > max)) {
        return message ??
            'validation.between'.tr(namedArgs: {'min': '$min', 'max': '$max'});
      }
      return null;
    });
  }

  Validator<num> maxDecimals(int decimals, [String? message]) {
    return addRule((v) {
      if (v == null) return null;

      final text = v.toString();
      if (!text.contains('.')) return null;

      final decimalPart = text.split('.').last;
      if (decimalPart.length > decimals) {
        return message ??
            'validation.max_decimals'.tr(namedArgs: {'decimals': '$decimals'});
      }
      return null;
    });
  }

  Validator<num> integerOnly([String? message]) {
    return addRule((v) {
      if (v != null && v % 1 != 0) {
        return message ?? 'validation.integer_only'.tr();
      }
      return null;
    });
  }
}
