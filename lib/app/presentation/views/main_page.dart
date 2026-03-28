import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final class MainPage extends ConsumerStatefulWidget {
  final StatefulNavigationShell? navigationShell;

  const MainPage({super.key, this.navigationShell});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends ConsumerState<MainPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    int _ = indexFromLocation(currentLocation);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        key: scaffoldKey,

        body: const Center(child: Text('Main Page')),
      ),
    );
  }

  int indexFromLocation(String location) {
    if (location.startsWith('/calendar')) return 1;
    if (location.startsWith('/shopping')) return 2;
    if (location.startsWith('/favourites')) return 3;
    return 0;
  }
}
