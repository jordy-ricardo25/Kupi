typedef ValidationRule<T> = String? Function(T? value);

class Validator<T> {
  final List<ValidationRule<T>> _rules = [];

  Validator<T> addRule(ValidationRule<T> rule) {
    _rules.add(rule);
    return this;
  }

  String? validate(T? value) {
    for (final rule in _rules) {
      final result = rule(value);
      if (result?.trim().isNotEmpty == true) {
        return result;
      }
    }
    return null;
  }
}
