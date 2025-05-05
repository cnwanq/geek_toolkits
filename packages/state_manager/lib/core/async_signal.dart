import 'state_signal.dart';
import '../models/state_snapshot.dart';

/// 异步状态
class AsyncSignal<T> extends StateSignal<StateSnapshot<T>> {
  AsyncSignal(Future<T> Function() loader)
      : super(StateSnapshot.waiting()) {
    _load(loader);
  }

  Future<void> _load(Future<T> Function() loader) async {
    try {
      value = StateSnapshot.loading();
      final data = await loader();
      value = StateSnapshot.withData(data);
    } catch (e) {
      value = StateSnapshot.withError(e);
    }
  }

  void retry(Future<T> Function() loader) => _load(loader);
} 