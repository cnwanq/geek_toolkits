import 'state_signal.dart';
import '../middleware/middleware.dart';

/// 全局/模块状态仓库
class StateStore {
  final Map<String, dynamic> _signals = {};

  StateSignal<T> use<T>(String key, T initial, {List<StateMiddleware<T>>? middlewares}) {
    if (_signals.containsKey(key)) {
      return _signals[key] as StateSignal<T>;
    }
    final sig = StateSignal<T>(initial, middlewares: middlewares);
    _signals[key] = sig;
    return sig;
  }

  void dispose() {
    for (final sig in _signals.values) {
      if (sig is StateSignal) sig.dispose();
    }
    _signals.clear();
  }
} 