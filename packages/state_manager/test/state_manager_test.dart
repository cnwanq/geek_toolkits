import 'package:flutter_test/flutter_test.dart';
import 'package:state_manager/state_manager.dart';

// 测试用的简单对象
class TestObject {
  final int value;
  TestObject(this.value);
}

void main() {
  group('StateSignal Tests', () {
    test('should initialize with correct value', () {
      final signal = StateSignal<int>(42);
      expect(signal.value, equals(42));
    });

    test('should update value correctly', () {
      final signal = StateSignal<int>(42);
      signal.value = 100;
      expect(signal.value, equals(100));
    });

    test('should notify listeners when value changes', () {
      final signal = StateSignal<int>(42);
      int? lastValue;
      
      signal.listen((value) {
        lastValue = value;
      });

      signal.value = 100;
      expect(lastValue, equals(100));
    });

    test('should call middleware on value change', () {
      bool middlewareCalled = false;
      int? oldValue;
      int? newValue;

      final middleware = _TestMiddleware<int>(
        onValueChange: (old, new_) {
          middlewareCalled = true;
          oldValue = old;
          newValue = new_;
        },
      );

      final signal = StateSignal<int>(42, middlewares: [middleware]);
      signal.value = 100;

      expect(middlewareCalled, isTrue);
      expect(oldValue, equals(42));
      expect(newValue, equals(100));
    });

    test('should handle multiple middlewares', () {
      int middlewareCallCount = 0;

      final middleware1 = _TestMiddleware<int>(
        onValueChange: (_, __) => middlewareCallCount++,
      );

      final middleware2 = _TestMiddleware<int>(
        onValueChange: (_, __) => middlewareCallCount++,
      );

      final signal = StateSignal<int>(
        42,
        middlewares: [middleware1, middleware2],
      );

      signal.value = 100;
      expect(middlewareCallCount, equals(2));
    });

    test('should dispose resources correctly', () {
      final signal = StateSignal<int>(42);
      int? lastValue;
      
      signal.listen((value) {
        lastValue = value;
      });

      signal.dispose();
      signal.value = 100; // This should not trigger the listener

      expect(lastValue, equals(42)); // Value should not have changed
    });

    test('should handle null values', () {
      final signal = StateSignal<int?>(null);
      expect(signal.value, isNull);

      signal.value = 42;
      expect(signal.value, equals(42));

      signal.value = null;
      expect(signal.value, isNull);
    });

    test('should handle complex objects', () {
      final signal = StateSignal<TestObject>(TestObject(42));
      expect(signal.value.value, equals(42));

      signal.value = TestObject(100);
      expect(signal.value.value, equals(100));
    });
  });
}

// 测试用的中间件实现
class _TestMiddleware<T> implements StateMiddleware<T> {
  final void Function(T oldValue, T newValue) onValueChange;

  _TestMiddleware({required this.onValueChange});

  @override
  void onChange(T oldValue, T newValue) {
    onValueChange(oldValue, newValue);
  }
}
