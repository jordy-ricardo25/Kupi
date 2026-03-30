import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedImage extends ConsumerStatefulWidget {
  final String animation;
  final bool enabled;

  const AnimatedImage({
    super.key,
    this.animation = 'scale',
    this.enabled = true,
  }) : assert(animation == 'scale', '');

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimatedImageState();
  }
}

class AnimatedImageState extends ConsumerState<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    animation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final src = 'assets/images/icon-blue.png';
    final size = calculateSize(context);
    return Center(
      child: widget.enabled
          ? ScaleTransition(
              scale: animation,
              child: Image.asset(src, width: size, height: size),
            )
          : Image.asset(src, width: size, height: size),
    );
  }

  /// Returns a responsive icon size based on the screen's shortest side.
  /// Uses about 40% of that dimension for consistent scaling.
  double calculateSize(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide * 0.35;
  }
}
