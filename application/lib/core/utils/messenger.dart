import 'package:flutter/material.dart';

void showSnackbar(
  BuildContext context,
  String message, {
  SnackBarBehavior? behavior = SnackBarBehavior.fixed,
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: behavior,
      content: Row(
        children: [
          if (loading)
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator.adaptive(),
              ),
            ),
          Expanded(child: Text(message, softWrap: true, maxLines: null)),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
