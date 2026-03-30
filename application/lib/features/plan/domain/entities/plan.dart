import 'package:flutter/foundation.dart';

@immutable
abstract class Plan {
  /// User identifier.
  final String id;

  /// Account creation timestamp.
  final DateTime createdAt;

  final String name;

  /// Plan price.
  final double price;

  /// Plan benefits.
  final Map<String, dynamic> benefits;

  const Plan(
    this.id, {
    required this.createdAt,
    required this.name,
    required this.price,
    required this.benefits,
  });
}
