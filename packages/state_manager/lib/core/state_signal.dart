import 'package:signals/signals.dart';
import 'package:flutter/foundation.dart';
import '../middleware/middleware.dart';

/// 单一响应式状态
class StateSignal<T> extends ValueNotifier<T> {
  final Signal<T> _signal;
  final List<StateMiddleware<T>> _middlewares;

  StateSignal(T initial, {List<StateMiddleware<T>>? middlewares})
      : _signal = signal(initial),
        _middlewares = middlewares ?? [],
        super(initial) {
    _signal.subscribe((value) {
      this.value = value;
    });
  }

  @override
  T get value => _signal.value;
  
  @override
  set value(T v) {
    final oldValue = _signal.value;
    _signal.value = v;
    _middlewares.forEach((m) => m.onChange(oldValue, v));
    super.value = v;
  }

  void listen(void Function(T) listener) => _signal.subscribe(listener);

  @override
  void dispose() {
    _signal.dispose();
    super.dispose();
  }
} 