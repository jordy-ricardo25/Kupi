import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';
import 'package:kupi/features/auth/index.dart';
import 'package:kupi/features/user/index.dart';

import 'package:supabase_flutter/supabase_flutter.dart'
    hide User, AuthException;

/// Supabase implementation of [UserRepository].
class SupabaseUserRepository implements UserRepository {
  const SupabaseUserRepository(this._client, this._ref);

  final SupabaseClient _client;
  final Ref _ref;

  @override
  Future<Result<User>> getCurrent() async {
    try {
      final userId = _ref.read(authStateProvider).user!.id;

      final entity = await _client
          .from('user')
          .select()
          .eq('id', userId)
          .maybeSingle()
          .withConverter((v) {
            return v != null ? UserModel.fromMap(v) : null;
          });

      if (entity == null) {
        throw NotFoundException('No se encontró el usuario actual.');
      }

      return Result.success(entity);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        _extractError(
          e,
          fallback:
              'Ocurrió un error al obtener el usuario actual.\nInténtalo de nuevo más tarde.',
        ),
      );
    }
  }

  @override
  Future<Result<User>> getOne({String? id, String? email}) async {
    assert(
      (id != null && id.isNotEmpty) || (email != null && email.isNotEmpty),
      'You must provide either an id or an email.',
    );

    try {
      var q = _client.from('user').select();

      if (id != null && id.isNotEmpty) {
        q = q.eq('id', id);
      } else if (email != null && email.isNotEmpty) {
        q = q.eq('email', email);
      }

      final entity = await q.maybeSingle().withConverter((v) {
        return v != null ? UserModel.fromMap(v) : null;
      });

      if (entity == null) {
        throw NotFoundException('No se encontró el usuario solicitado.');
      }

      return Result.success(entity);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        _extractError(
          e,
          fallback:
              'Ocurrió un error al obtener el usuario solicitado.\nInténtalo de nuevo más tarde.',
        ),
      );
    }
  }

  @override
  Future<Result<User>> create({
    required String id,
    required String displayName,
    required String email,
    String? pictureUrl,
    String? deviceToken,
    required String planId,
  }) async {
    try {
      final payload = <String, dynamic>{
        'id': id,
        'display_name': displayName,
        'email': email,
        'picture_url': pictureUrl,
        'device_token': deviceToken,
      };

      if (planId.isNotEmpty) {
        payload['plan_id'] = planId;
      }

      final entity = await _client
          .from('user')
          .insert(payload)
          .select()
          .single()
          .withConverter((v) {
            return UserModel.fromMap(v);
          });

      return Result.success(entity);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        _extractError(
          e,
          fallback:
              'Ocurrió un error al crear el usuario.\nInténtalo de nuevo más tarde.',
        ),
      );
    }
  }

  @override
  Future<Result<User>> update(
    String id, {
    String? displayName,
    String? pictureUrl,
    String? deviceToken,
    String? planId,
  }) async {
    final updates = <String, dynamic>{};

    try {
      if (displayName != null && displayName.isNotEmpty) {
        updates['display_name'] = displayName;
      }

      if (pictureUrl != null && pictureUrl.isNotEmpty) {
        updates['picture_url'] = pictureUrl;
      }

      if (deviceToken != null) {
        updates['device_token'] = deviceToken.isNotEmpty ? deviceToken : null;
      }

      if (planId != null && planId.isNotEmpty) {
        updates['plan_id'] = planId;
      }

      if (updates.isEmpty) return await getOne(id: id);

      final entity = await _client
          .from('user')
          .update(updates)
          .eq('id', id)
          .select()
          .single()
          .withConverter((v) {
            return UserModel.fromMap(v);
          });

      return Result.success(entity);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        _extractError(
          e,
          fallback:
              'Ocurrió un error al actualizar el usuario.\nInténtalo de nuevo más tarde.',
        ),
      );
    }
  }

  String _extractError(Object error, {required String fallback}) {
    if (error is AppException) return error.message;

    final message = error.toString().replaceFirst('Exception: ', '').trim();
    if (message.isEmpty) return fallback;

    return message;
  }
}
