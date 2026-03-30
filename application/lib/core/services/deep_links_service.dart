import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kupi/app/index.dart';

import 'app_service.dart';

/// Service implementation for handling deep links.
final class DeepLinksService extends AppService<AppLinks> {
  /// Singleton instance.
  static final instance = DeepLinksService._();

  late final StreamSubscription<Uri>? _linkSubscription;

  DeepLinksService._() : super(AppLinks());

  @override
  void initialize({WidgetRef? ref}) async {
    assert(ref != null, 'WidgetRef must not be null');
    if (isInitialized) return;

    final uri = await service.getInitialLink();

    if (uri != null) {
      final path = _normalizeDeepLink(uri);
      ref!.read(goRouterProvider).push(path);
    }

    // Initialize deep link handling here
    _linkSubscription = service.uriLinkStream.listen((uri) {
      final path = _normalizeDeepLink(uri);
      ref!.read(goRouterProvider).push(path);
    });

    setInitialized(true);
  }

  @override
  void dispose() {
    // Cancel the link subscription
    _linkSubscription?.cancel();
    setInitialized(false);
  }

  String _normalizeDeepLink(Uri uri) {
    var path = uri.path;

    if (uri.fragment.isNotEmpty) {
      path = uri.fragment; // "/chats"
    }

    if (!path.startsWith('/')) {
      path = '/$path';
    }

    return path;
  }
}
