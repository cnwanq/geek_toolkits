# StateSignal

`StateSignal` 是 State Manager 中最基础的状态容器，用于存储和响应单个值的变化。

## 特性

- 响应式更新
- 支持中间件
- 类型安全
- 支持空值

## API 参考

### 构造函数

```dart
StateSignal<T>(T initial, {List<StateMiddleware<T>>? middlewares})
```

参数：
- `initial`: 初始值
- `middlewares`: 可选的中间件列表

### 属性

#### value
```dart
T get value
set value(T v)
```
获取或设置当前值。

### 方法

#### listen
```dart
void listen(void Function(T) listener)
```
添加值变化监听器。

#### dispose
```dart
void dispose()
```
释放资源，取消所有监听器。

## 使用示例

### 基本使用

```dart
// 创建状态
final counter = StateSignal<int>(0);

// 读取状态
print(counter.value); // 0

// 更新状态
counter.value = 1;

// 监听变化
counter.listen((value) {
  print('Counter changed to: $value');
});
```

### 使用中间件

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

// 更新状态会触发中间件
counter.value = 1; // 输出: Value changed from 0 to 1
```

### 处理复杂对象

```dart
class User {
  final String name;
  final int age;
  
  User(this.name, this.age);
}

final user = StateSignal<User>(User('John', 25));

// 更新对象
user.value = User('Jane', 30);

// 监听变化
user.listen((user) {
  print('User changed to: ${user.name}, ${user.age}');
});
```

### 处理空值

```dart
final name = StateSignal<String?>(null);

// 设置值
name.value = 'John';

// 清除值
name.value = null;
```

## 最佳实践

1. **状态粒度**
   - 将状态分解为小的、独立的部分
   - 避免过大的状态对象

2. **性能优化**
   - 避免频繁更新
   - 合理使用中间件

3. **资源管理**
   - 及时调用 dispose 释放资源
   - 避免内存泄漏

4. **类型安全**
   - 明确指定泛型类型
   - 使用空安全特性 