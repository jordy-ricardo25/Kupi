import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/features/plan/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class SupabasePlanRepository implements PlanRepository {
  final SupabaseClient _client;

  const SupabasePlanRepository(this._client);

  @override
  Future<List<Plan>> getAll() async {
    final entities = await _client.from('plan').select().withConverter((v) {
      return v.map(PlanModel.fromMap).toList();
    });

    return entities;
  }

  @override
  Future<Plan> getOne({String? id, String? name}) async {
    assert(
      (name != null && name.isNotEmpty) || (id != null && id.isNotEmpty),
      "You must provide either a non-empty name or a non-empty id to fetch a plan.",
    );

    var q = _client.from('plan').select();

    if (id != null && id.isNotEmpty) {
      q = q.eq('id', id);
    }
    if (name != null && name.isNotEmpty) {
      q = q.eq('name', name);
    }

    final entity = await q.maybeSingle().withConverter((v) {
      return v != null ? PlanModel.fromMap(v) : null;
    });

    if (entity == null) {
      throw NotFoundException("No se encontró el plan solicitado.");
    }

    return entity;
  }
}
