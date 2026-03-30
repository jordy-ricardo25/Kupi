import 'package:easy_localization/easy_localization.dart';

import 'validator.dart';

extension IntRules on Validator<int> {
  Validator<int> required([String? message]) {
    return addRule(
      (v) => v == null ? (message ?? 'validation.select_option'.tr()) : null,
    );
  }
}
