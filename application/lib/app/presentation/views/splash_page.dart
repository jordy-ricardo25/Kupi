import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/core/theme/index.dart';
import 'package:kupi/core/widgets/index.dart';

final class SplashPage extends ConsumerStatefulWidget {
  static const routePath = '/splash';

  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends ConsumerState<SplashPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    ref.listenManual(splashControllerProvider, (_, next) {
      next.maybeWhen(
        data: (status) async {
          if (status != AppStatus.ready) return;
          await ref.read(goRouterProvider).replace('/home');
        },
        orElse: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(splashControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(
          context,
        ).extension<AppColorExtension>()!.scaffold,

        body: Stack(
          children: [
            AnimatedImage(enabled: asyncValue.isLoading),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
