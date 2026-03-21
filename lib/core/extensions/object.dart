import 'package:flutter/material.dart';

extension ObjectX on Object? {
  T? safe<T>(T Function(Map<String, dynamic> value) parser) {
    final value = this;

    if (value is! Map) return null;

    try {
      return parser(Map<String, dynamic>.from(value));
    } catch (_) {
      return null;
    }
  }

  List<T> safeMap<T>(T Function(Map<String, dynamic> value) parser) {
    final value = this;

    if (value is! List) return const [];

    final result = <T>[];

    for (final item in value) {
      if (item is! Map) continue;

      try {
        result.add(parser(Map<String, dynamic>.from(item)));
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return result;
  }
}
