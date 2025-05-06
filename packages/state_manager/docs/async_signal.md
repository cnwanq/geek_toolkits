# AsyncSignal

`AsyncSignal` 用于处理异步状态，支持加载、成功和错误状态。它提供了一种优雅的方式来处理异步操作的状态管理。

## 特性

- 自动状态管理
- 支持加载状态
- 错误处理
- 类型安全
- 支持重试

## API 参考

### 构造函数

```dart
AsyncSignal<T>(Future<T> Function() loader)
```

参数：
- `loader`: 异步加载函数，返回 Future<T>

### 属性

#### value
```dart
T? get value
```
获取当前值（如果加载成功）。

#### isLoading
```dart
bool get isLoading
```
是否正在加载。

#### hasError
```dart
bool get hasError
```
是否发生错误。

#### error
```dart
Object? get error
```
获取错误信息（如果有）。

### 方法

#### load
```dart
Future<void> load()
```
重新加载数据。

#### reset
```dart
void reset()
```
重置状态。

## 使用示例

### 基本使用

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
  return Text('User: ${userData.value?.name}');
}
```

### 自动加载

```dart
class UserProfile extends StatelessWidget {
  final userData = AsyncSignal<UserData>(
    () => fetchUserData(),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userData.load(),
      builder: (context, snapshot) {
        if (userData.isLoading) {
          return CircularProgressIndicator();
        }
        
        if (userData.hasError) {
          return ErrorView(
            error: userData.error,
            onRetry: () => userData.load(),
          );
        }

        return UserView(user: userData.value!);
      },
    );
  }
}
```

### 错误处理

```dart
final data = AsyncSignal<List<Item>>(
  () => fetchItems(),
);

// 处理特定错误
if (data.hasError) {
  if (data.error is NetworkError) {
    return NetworkErrorView();
  } else if (data.error is AuthError) {
    return AuthErrorView();
  } else {
    return GenericErrorView();
  }
}
```

### 组合使用

```dart
class UserStore {
  final userData = AsyncSignal<UserData>(
    () => fetchUserData(),
  );
  
  final userSettings = AsyncSignal<UserSettings>(
    () => fetchUserSettings(),
  );

  Future<void> refreshAll() async {
    await Future.wait([
      userData.load(),
      userSettings.load(),
    ]);
  }
}
```

## 最佳实践

1. **错误处理**
   - 提供清晰的错误信息
   - 实现重试机制
   - 处理特定类型的错误

2. **加载状态**
   - 显示加载指示器
   - 提供加载进度
   - 处理加载超时

3. **状态管理**
   - 合理组织异步状态
   - 避免状态冲突
   - 及时清理资源

4. **用户体验**
   - 提供加载反馈
   - 实现错误恢复
   - 保持界面响应性 