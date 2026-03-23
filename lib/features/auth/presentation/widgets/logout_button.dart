import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/extensions/index.dart';
import 'package:kupi/core/modals/index.dart';
import 'package:kupi/features/auth/index.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        final result = await showConfirmationModal(
          context,
          title: '¿Salir de tu cuenta?',
          description: 'Puedes volver a iniciar sesión cuando quieras.',
        );

        if (result != true) return;

        await ref.read(authRepositoryProvider).signOut();
      },

      child: Text(
        'Cerrar sesión',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    ).aligned(Alignment.center);
  }
}
