import 'package:easy_localization/easy_localization.dart';

import 'validator.dart';

extension BoolRules on Validator<bool> {
  Validator<bool> mustBeTrue([String? message]) {
    return addRule(
      (v) => (v ?? false) ? null : (message ?? 'validation.must_accept_terms'.tr()),
    );
  }
}
