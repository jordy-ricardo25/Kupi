// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kupi/app/index.dart';
import 'package:kupi/core/services/index.dart';
import 'package:kupi/core/theme/index.dart';

final class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();

    ref.listenManual(preferencesProvider, (_, next) {
      if (next.locale.languageCode != context.locale.languageCode) {
        context.setLocale(next.locale);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // QuickActionsService.instance.initialize();
      DeepLinksService.instance.initialize(ref: ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final preferences = ref.watch(preferencesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'KUPI',

      theme: Theme.of(context).light,
      darkTheme: Theme.of(context).dark,
      themeMode: preferences.theme,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      routerConfig: router,
    );
  }
}
