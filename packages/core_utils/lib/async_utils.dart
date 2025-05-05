// lib/core_utils/async_utils.dart

import 'dart:async';

/// 防抖：在指定时间内只执行最后一次调用
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

/// 节流：在指定时间内只执行第一次调用
class Throttler {
  final Duration delay;
  Timer? _timer;
  bool _isReady = true;

  Throttler(this.delay);

  void call(void Function() action) {
    if (_isReady) {
      action();
      _isReady = false;
      _timer = Timer(delay, () {
        _isReady = true;
      });
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}

/// 重试机制
Future<T> retry<T>(
  Future<T> Function() task, {
  int retries = 3,
  Duration delay = const Duration(milliseconds: 500),
  bool Function(Exception)? retryIf,
}) async {
  int attempt = 0;
  while (true) {
    try {
      return await task();
    } catch (e) {
      attempt++;
      if (e is Exception &&
          attempt <= retries &&
          (retryIf == null || retryIf(e))) {
        await Future.delayed(delay);
        continue;
      }
      rethrow;
    }
  }
}

/// 延迟执行
Future<void> delay(Duration duration, [void Function()? action]) async {
  await Future.delayed(duration);
  action?.call();
}

/// 超时处理
Future<T?> timeout<T>(
  Future<T> future, {
  required Duration duration,
  T? onTimeout(),
}) {
  return future.timeout(duration, onTimeout: onTimeout);
}


// final debouncer = Debouncer(Duration(milliseconds: 300));
// debouncer(() {
//   print('只会在最后一次调用后300ms执行');
// });

// final throttler = Throttler(Duration(seconds: 1));
// throttler(() {
//   print('每秒最多执行一次');
// });

// await retry(() async {
//   // 你的异步操作
// }, retries: 5);

// await delay(Duration(seconds: 2), () => print('2秒后执行'));

// await timeout(Future.delayed(Duration(seconds: 3), () => 42),
//     duration: Duration(seconds: 1),
//     onTimeout: () => -1);