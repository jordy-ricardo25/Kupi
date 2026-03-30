import 'package:easy_localization/easy_localization.dart';

import 'validator.dart';

extension ListRules<T> on Validator<List<T>> {
  Validator<List<T>> required([String? message]) {
    return addRule((v) {
      if (v == null || v.isEmpty) {
        return message ?? 'validation.required_field'.tr();
      }
      return null;
    });
  }

  Validator<List<T>> minLength(int min, [String? message]) {
    return addRule((v) {
      if (v != null && v.length < min) {
        return message ?? 'validation.min_items'.tr(namedArgs: {'min': '$min'});
      }
      return null;
    });
  }

  Validator<List<T>> minLengthIfPresent(int min, [String? message]) {
    return addRule((v) {
      if (v == null || v.isEmpty) return null;
      if (v.length < min) {
        return message ?? 'validation.min_items'.tr(namedArgs: {'min': '$min'});
      }
      return null;
    });
  }

  Validator<List<T>> maxLength(int max, [String? message]) {
    return addRule((v) {
      if (v != null && v.length > max) {
        return message ?? 'validation.max_items'.tr(namedArgs: {'max': '$max'});
      }
      return null;
    });
  }

  Validator<List<T>> lengthEquals(int length, [String? message]) {
    return addRule((v) {
      if (v != null && v.length != length) {
        return message ??
            'validation.exact_items'.tr(namedArgs: {'count': '$length'});
      }
      return null;
    });
  }
}
