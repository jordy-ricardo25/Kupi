import 'package:flutter/foundation.dart';
import 'package:kupi/features/plan/index.dart';

/// Repository contract for plan operations.
@immutable
abstract class PlanRepository {
  /// Returns all plans.
  Future<List<Plan>> getAll();

  /// Returns a plan by its name.
  Future<Plan> getOne({String? id, String? name});
}
