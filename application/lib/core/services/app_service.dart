import 'package:flutter/foundation.dart';

/// Base class for application services.
abstract class AppService<T> {
  @protected
  late final T service;

  bool _initialized = false;

  bool get isInitialized => _initialized;

  AppService(this.service);

  @protected
  void setInitialized(bool value) {
    _initialized = value;
  }

  /// Initialize the service
  void initialize();

  /// Dispose resources
  void dispose();
}
