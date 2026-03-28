import 'package:flutter/material.dart';
import 'package:kupi/core/extensions/index.dart';

Future<T?> showAppModal<T>(
  BuildContext context, {
  required Widget child,
  bool dismissible = true,
  bool rootNavigator = true,
  bool scrollControlled = true,
}) {
  return showModalBottomSheet<T>(
    context: context,

    isDismissible: dismissible,
    useRootNavigator: rootNavigator,
    isScrollControlled: scrollControlled,

    backgroundColor: Colors.transparent,
    elevation: 0.0,

    builder: (_) {
      return SafeArea(
        minimum: const EdgeInsets.all(8.0),

        child: Material(
          borderRadius: BorderRadius.circular(24.0),
          clipBehavior: Clip.antiAlias,
          elevation: 1.0,

          color: Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              if (dismissible)
                Container(
                      width: 48.0,
                      height: 6.0,

                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    )
                    .aligned(Alignment.center)
                    .padded(const EdgeInsets.only(bottom: 20.0)),
              child,
            ],
          ).padded(const EdgeInsets.symmetric(vertical: 20.0)),
        ),
      );
    },
  );
}
