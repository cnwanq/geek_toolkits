# StateStore

`StateStore` 用于管理复杂的状态树，支持状态组合和模块化。它提供了一种组织和管理相关状态的方式。

## 特性

- 状态组合
- 模块化设计
- 类型安全
- 资源管理

## API 参考

### 构造函数

```dart
StateStore()
```

### 方法

#### dispose
```dart
void dispose()
```
释放所有资源。

## 使用示例

### 基本使用

```dart
class CounterStore extends StateStore {
  final count = StateSignal<int>(0);
  final doubled = ComputedSignal<int>(() => count.value * 2);

  void increment() {
    count.value++;
  }

  void decrement() {
    count.value--;
  }
}

// 使用
final store = CounterStore();
store.increment();
print(store.doubled.value); // 2
```

### 复杂状态管理

```dart
class UserStore extends StateStore {
  final user = AsyncSignal<UserData>(() => fetchUserData());
  final settings = StateSignal<UserSettings>(UserSettings.defaults());
  final isDarkMode = ComputedSignal<bool>(
    () => settings.value.theme == ThemeMode.dark,
  );

  Future<void> updateSettings(UserSettings newSettings) async {
    settings.value = newSettings;
    await saveSettings(newSettings);
  }

  Future<void> refreshUser() async {
    await user.load();
  }
}
```

### 状态组合

```dart
class AppStore extends StateStore {
  final authStore = AuthStore();
  final userStore = UserStore();
  final settingsStore = SettingsStore();

  final isReady = ComputedSignal<bool>(
    () => authStore.isAuthenticated && userStore.user.value != null,
  );

  @override
  void dispose() {
    authStore.dispose();
    userStore.dispose();
    settingsStore.dispose();
    super.dispose();
  }
}
```

### 状态同步

```dart
class TodoStore extends StateStore {
  final todos = StateSignal<List<Todo>>([]);
  final filter = StateSignal<TodoFilter>(TodoFilter.all);
  
  final filteredTodos = ComputedSignal<List<Todo>>(
    () => todos.value.where((todo) => filter.value.matches(todo)).toList(),
  );

  void addTodo(Todo todo) {
    todos.value = [...todos.value, todo];
  }

  void removeTodo(String id) {
    todos.value = todos.value.where((todo) => todo.id != id).toList();
  }

  void updateFilter(TodoFilter newFilter) {
    filter.value = newFilter;
  }
}
```

## 最佳实践

1. **状态组织**
   - 按功能模块划分状态
   - 保持状态树扁平
   - 避免状态冗余

2. **资源管理**
   - 及时释放资源
   - 正确处理依赖关系
   - 避免内存泄漏

3. **状态更新**
   - 使用不可变数据
   - 批量更新状态
   - 避免状态冲突

4. **模块化**
   - 单一职责原则
   - 高内聚低耦合
   - 可测试性

5. **性能优化**
   - 合理使用计算属性
   - 避免不必要的更新
   - 优化状态依赖 