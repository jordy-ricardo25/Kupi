import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class UserPicture extends ConsumerWidget {
  const UserPicture({
    super.key,
    this.pictureUrl,
    this.shadow,
    this.border,
    this.size = 80.0,
  });

  final String? pictureUrl;
  final BoxShadow? shadow;
  final BoxBorder? border;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        border:
            border ??
            Border.all(color: Colors.orange.withAlpha(100), width: 4.0),
        shape: BoxShape.circle,
        boxShadow: [
          shadow ??
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.4),

                offset: Offset.zero,
                blurRadius: 8.0,
                spreadRadius: 4.0,
              ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),

        child: (pictureUrl ?? '').isNotEmpty
            ? Image.network(pictureUrl!, width: size, height: size)
            : SvgPicture.asset(
                'assets/images/user.svg',
                width: size,
                height: size,
              ),
      ),
    );
  }
}
