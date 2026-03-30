import 'package:kupi/features/plan/index.dart';

final class PlanModel extends Plan {
  const PlanModel(
    super.id, {
    required super.createdAt,
    required super.name,
    required super.price,
    required super.benefits,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      name: map['name'],
      price: double.parse(map['price']),
      benefits: Map<String, dynamic>.from(map['benefits']),
    );
  }
}
