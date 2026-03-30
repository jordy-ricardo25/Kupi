import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/core/exceptions/index.dart';
import 'package:kupi/core/utils/index.dart';

import 'package:url_launcher/url_launcher.dart';

final class LinkButton extends ConsumerWidget {
  final Widget child;
  final Uri uri;

  const LinkButton({super.key, required this.child, required this.uri});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        try {
          final success = await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );

          if (!success) {
            throw LaunchException('No se pudo abrir el enlace solicitado.');
          }
        } on LaunchException catch (e) {
          showSnackbar(context, e.message);
        }
      },

      style: Theme.of(context).textButtonTheme.style?.copyWith(
        minimumSize: WidgetStateProperty.all(Size.zero),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),

      child: child,
    );
  }
}
