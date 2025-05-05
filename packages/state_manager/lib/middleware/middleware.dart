/// 中间件接口
abstract class StateMiddleware<T> {
  void onChange(T oldValue, T newValue);
} 