import 'middleware.dart';

/// 日志中间件
class LoggerMiddleware<T> implements StateMiddleware<T> {
  @override
  void onChange(T oldValue, T newValue) {
    print('State changed: $oldValue -> $newValue');
  }
} 