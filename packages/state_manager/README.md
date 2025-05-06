<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# State Manager

一个轻量级、高性能的 Flutter 状态管理解决方案，基于响应式编程模型。

## 特性

- 🚀 高性能：基于 signals 实现，性能优异
- 🎯 简单易用：API 设计简洁直观
- 🔄 响应式：自动追踪依赖，精确更新
- 🛠 可扩展：支持中间件机制
- 📦 轻量级：零依赖，体积小

## 快速开始

### 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  state_manager: ^1.0.0
```

### 基本使用

```dart
import 'package:state_manager/state_manager.dart';

// 创建状态
final counter = StateSignal<int>(0);

// 读取状态
print(counter.value); // 0

// 更新状态
counter.value = 1;

// 监听状态变化
counter.listen((value) {
  print('Counter changed to: $value');
});
```

## 核心概念

### StateSignal

`StateSignal` 是最基础的状态容器，用于存储和响应单个值的变化。

```dart
// 创建状态
final name = StateSignal<String>('John');

// 更新状态
name.value = 'Jane';

// 监听变化
name.listen((value) {
  print('Name changed to: $value');
});
```

### ComputedSignal

`ComputedSignal` 用于创建派生状态，自动追踪依赖并更新。

```dart
final count = StateSignal<int>(0);
final doubled = ComputedSignal<int>(
  () => count.value * 2,
);

// 当 count 变化时，doubled 会自动更新
count.value = 5;
print(doubled.value); // 10
```

### AsyncSignal

`AsyncSignal` 用于处理异步状态，支持加载、成功和错误状态。

```dart
final userData = AsyncSignal<UserData>(
  () => fetchUserData(),
);

// 使用状态
if (userData.isLoading) {
  return CircularProgressIndicator();
} else if (userData.hasError) {
  return Text('Error: ${userData.error}');
} else {
  return Text('User: ${userData.value.name}');
}
```

### StateStore

`StateStore` 用于管理复杂的状态树，支持状态组合和模块化。

```dart
class CounterStore extends StateStore {
  final count = StateSignal<int>(0);
  final doubled = ComputedSignal<int>(() => count.value * 2);

  void increment() {
    count.value++;
  }
}

// 使用
final store = CounterStore();
store.increment();
print(store.doubled.value); // 2
```

## 中间件

State Manager 支持中间件机制，可以用于日志记录、持久化等功能。

```dart
// 创建日志中间件
final loggerMiddleware = StateMiddleware<int>(
  onChange: (oldValue, newValue) {
    print('Value changed from $oldValue to $newValue');
  },
);

// 使用中间件
final counter = StateSignal<int>(
  0,
  middlewares: [loggerMiddleware],
);
```

## 最佳实践

1. **状态粒度**
   - 将状态分解为小的、独立的部分
   - 避免过大的状态对象

2. **性能优化**
   - 使用 `ComputedSignal` 缓存计算结果
   - 避免不必要的状态更新

3. **状态组织**
   - 使用 `StateStore` 组织相关状态
   - 遵循单一职责原则

4. **错误处理**
   - 使用 `AsyncSignal` 处理异步操作
   - 正确处理加载和错误状态

## 示例

查看 [example](example) 目录获取更多使用示例。

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
