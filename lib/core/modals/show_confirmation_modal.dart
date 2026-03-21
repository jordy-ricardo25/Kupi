import 'package:flutter/material.dart';
import 'package:kupi/core/extensions/index.dart';

import 'show_app_modal.dart';

Future<bool?> showConfirmationModal(
  BuildContext context, {
  required String title,
  String? description,
  Widget? icon,
  String? primaryButtonText,
  String? secondaryButtonText,
  ButtonStyle? primaryButtonStyle,
  ButtonStyle? secondaryButtonStyle,
}) {
  return showAppModal<bool?>(
    context,

    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: [
        if (icon != null) ...[icon, const SizedBox(height: 12.0)],

        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),

        const SizedBox(height: 12.0),

        if (description != null) ...[
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),

          const SizedBox(height: 12.0),
        ],

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 12.0,

          children: [
            FilledButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop<bool>(true);
              },

              style:
                  primaryButtonStyle ??
                  Theme.of(context).filledButtonTheme.style?.copyWith(
                    elevation: WidgetStateProperty.all(0.0),
                  ),

              child: Text(primaryButtonText ?? 'Confirmar'),
            ).expand(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop<bool>(false);
              },

              style:
                  secondaryButtonStyle ??
                  Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    elevation: WidgetStateProperty.all(0.0),
                  ),

              child: Text(secondaryButtonText ?? 'Cancelar'),
            ).expand(),
          ],
        ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),
      ],
    ),
  );
}
