import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class VerifiedMark extends ConsumerWidget {
  const VerifiedMark({super.key, this.size = 24.0});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Icon(
      TablerIcons.rosette_discount_check_filled,
      size: 24.0,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
