import 'state_signal.dart';

/// 派生/计算状态
class ComputedSignal<T> extends StateSignal<T> {
  ComputedSignal(T Function() compute, {List<StateSignal>? dependencies})
      : super(compute()) {
    dependencies?.forEach((dep) => dep.listen((_) => value = compute()));
  }
} 