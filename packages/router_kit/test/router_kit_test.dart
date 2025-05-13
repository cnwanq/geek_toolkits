import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' hide RouterConfig;
import 'package:router_kit/router_kit.dart';

void main() {
  group('RouterManager Tests', () {
    late RouterManager routerManager;

    setUp(() {
      routerManager = RouterManager();
    });

    test('RouterManager is singleton', () {
      final instance1 = RouterManager();
      final instance2 = RouterManager();
      expect(instance1, equals(instance2));
    });

    test('RouterManager initialization', () {
      final config = RouterConfig(
        initialLocation: '/',
        routes: [],
        debugLogDiagnostics: true,
      );
      
      expect(() => routerManager.init(config), returnsNormally);
    });
  });
}
