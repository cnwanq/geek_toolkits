# ComputedSignal

`ComputedSignal` 用于创建派生状态，自动追踪依赖并更新。当依赖的状态发生变化时，计算值会自动重新计算。

## 特性

- 自动依赖追踪
- 惰性计算
- 缓存结果
- 类型安全

## API 参考

### 构造函数

```dart
ComputedSignal<T>(T Function() compute)
```

参数：
- `compute`: 计算函数，返回派生值

### 属性

#### value
```dart
T get value
```
获取计算后的值。

## 使用示例

### 基本使用

```dart
// 创建基础状态
final count = StateSignal<int>(0);

// 创建派生状态
final doubled = ComputedSignal<int>(
  () => count.value * 2,
);

// 当 count 变化时，doubled 会自动更新
count.value = 5;
print(doubled.value); // 10
```

### 多依赖计算

```dart
final firstName = StateSignal<String>('John');
final lastName = StateSignal<String>('Doe');

final fullName = ComputedSignal<String>(
  () => '${firstName.value} ${lastName.value}',
);

// 更新任一依赖都会触发重新计算
firstName.value = 'Jane';
print(fullName.value); // Jane Doe
```

### 复杂计算

```dart
class User {
  final String name;
  final int age;
  User(this.name, this.age);
}

final user = StateSignal<User>(User('John', 25));

final isAdult = ComputedSignal<bool>(
  () => user.value.age >= 18,
);

final greeting = ComputedSignal<String>(
  () => isAdult.value 
    ? 'Hello, ${user.value.name}'
    : 'Hi, ${user.value.name}',
);

// 更新用户年龄
user.value = User('John', 20);
print(greeting.value); // Hello, John
```

### 条件计算

```dart
final count = StateSignal<int>(0);
final threshold = StateSignal<int>(10);

final status = ComputedSignal<String>(
  () => count.value > threshold.value 
    ? 'Above threshold'
    : 'Below threshold',
);

count.value = 15;
print(status.value); // Above threshold
```

## 最佳实践

1. **计算函数设计**
   - 保持计算函数简单
   - 避免副作用
   - 确保计算函数是纯函数

2. **依赖管理**
   - 最小化依赖数量
   - 避免循环依赖
   - 合理组织依赖关系

3. **性能优化**
   - 避免复杂计算
   - 合理使用缓存
   - 避免不必要的重新计算

4. **错误处理**
   - 处理可能的异常
   - 提供合理的默认值
   - 避免空值问题 