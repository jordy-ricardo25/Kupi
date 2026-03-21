import 'package:flutter/material.dart';
import 'package:kupi/core/extensions/index.dart';

import 'show_app_modal.dart';

final _languages = const [
  {'title': 'Español', 'code': 'es'},
];

Future<String?> showChoiceLanguageModal(
  BuildContext context, {
  String? initialValue,
}) {
  return showAppModal<String?>(
    context,

    child: RadioGroup<String>(
      groupValue: initialValue ?? _languages.first['code']!,
      onChanged: (value) {
        if (!context.mounted) return;
        Navigator.of(context, rootNavigator: true).pop<String?>(value);
      },

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text(
            'Selecciona tu idioma',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),

          const SizedBox(height: 12.0),

          Text(
            'Elige el idioma que prefieras. Puedes cambiarlo en cualquier momento.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ).padded(const EdgeInsets.symmetric(horizontal: 20.0)),

          const SizedBox(height: 12.0),

          ..._languages.map(
            (e) => RadioListTile<String>(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),

              value: e['code']!,
              title: Text(
                e['title']!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
