import 'package:flutter/foundation.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/user/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final class SupabaseUserPreferenceRepository
    implements UserPreferenceRepository {
  const SupabaseUserPreferenceRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<Result<UserPreference>> get({required String userId}) async {
    try {
      final entity = await _client
          .from('user_preference')
          .select()
          .eq('user_id', userId)
          .maybeSingle()
          .withConverter((v) {
            return v != null ? UserPreferenceModel.fromMap(v) : null;
          });

      if (entity == null) {
        return Result.failure('No se encontraron preferencias.');
      }

      return Result.success(entity);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        e is AppException
            ? e.message
            : 'Ocurrió un error al obtener las preferencias.'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }

  @override
  Future<Result<UserPreference>> update(
    String userId, {
    String? language,
    bool? notificationsEnabled,
  }) async {
    final updates = <String, dynamic>{};

    if (language != null && language.isNotEmpty) {
      updates['language'] = language;
    }
    if (notificationsEnabled != null) {
      updates['notifications_enabled'] = notificationsEnabled;
    }

    if (updates.isEmpty) return await get(userId: userId);

    try {
      final entity = await _client
          .from('user_preference')
          .update(updates)
          .eq('user_id', userId)
          .select()
          .single()
          .withConverter((res) {
            return UserPreferenceModel.fromMap(res);
          });

      return Result.success(entity);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        e is AppException
            ? e.message
            : 'Ocurrió un error al actualizar las preferencias.'
                  '\n'
                  'Inténtalo de nuevo más tarde.',
      );
    }
  }
}
