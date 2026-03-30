import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lucide_icons/lucide_icons.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/core/extensions/index.dart';

final class PopButton extends ConsumerWidget {
  final PopButtonType type;
  final dynamic argument;
  final ButtonStyle? style;
  final bool enabled;

  const PopButton({
    super.key,
    this.type = PopButtonType.back,
    this.argument,
    this.style,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: type == PopButtonType.back
          ? 'common.actions.back'.tr()
          : 'common.actions.close'.tr(),

      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.075),
              blurRadius: 4.0,
              spreadRadius: 0.25,
              offset: Offset.zero,
            ),
          ],
        ),

        child: IconButton(
          onPressed: enabled
              ? () => ref.read(goRouterProvider).pop(argument)
              : null,

          style: style,

          icon: Icon(
            type == PopButtonType.back
                ? LucideIcons.chevronLeft
                : LucideIcons.x,
            size: 24.0,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    ).aligned(Alignment.centerRight);
  }
}

enum PopButtonType { back, close }
