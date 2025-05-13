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

# Router Kit

一个基于 `go_router` 的 Flutter 路由管理工具包，提供了更简单和更强大的路由管理功能。

## 特性

- 🚀 简单易用的 API
- 🔄 支持路由重定向
- 🎯 支持路由参数传递
- 🏗️ 支持嵌套路由
- 📝 内置日志记录
- 🛡️ 完善的错误处理
- 🔍 路由状态管理
- 🔌 支持自定义日志记录器

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  router_kit: ^0.0.1
```

## 快速开始

### 1. 初始化路由管理器

```dart
void main() {
  final routerManager = RouterManager();
  
  routerManager.init(RouterConfig(
    initialLocation: '/',
    debugLogDiagnostics: true,
  ));
  
  runApp(MyApp());
}
```

### 2. 配置路由

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerManager.router,
      title: 'My App',
    );
  }
}

// 添加路由
routerManager.addRoute(
  path: '/home',
  name: 'home',
  builder: (context, state) => HomePage(),
);

// 添加带参数的路由
routerManager.addRoute(
  path: '/user/:id',
  name: 'user',
  builder: (context, state) => UserPage(
    userId: state.pathParameters['id']!,
  ),
);

// 添加嵌套路由
routerManager.addNestedRoute(
  path: '/settings',
  name: 'settings',
  builder: (context, state) => SettingsPage(),
  routes: [
    GoRoute(
      path: 'profile',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: 'notifications',
      builder: (context, state) => NotificationsPage(),
    ),
  ],
);
```

### 3. 导航

```dart
// 导航到指定路径
routerManager.go('/home');

// 带参数导航
routerManager.go('/user/123');

// 带查询参数导航
routerManager.go('/search?keyword=flutter');

// 带额外数据导航
routerManager.go('/detail', extra: {'id': 123});

// 推入新路由
routerManager.push('/new-page');

// 替换当前路由
routerManager.replace('/replace-page');

// 返回上一页
routerManager.pop();
```

### 4. 获取路由参数

```dart
// 获取路径参数
final userId = routerManager.getParam(context, 'id');

// 获取查询参数
final keyword = routerManager.getQueryParam(context, 'keyword');

// 获取额外数据
final data = routerManager.getExtra<Map<String, dynamic>>(context);
```

## 自定义日志记录器

Router Kit 支持自定义日志记录器，你可以实现自己的日志记录逻辑：

```dart
// 1. 实现 RouterLogger 接口
class CustomLogger implements RouterLogger {
  @override
  void debug(String message) {
    // 实现调试日志记录
  }
  
  @override
  void info(String message) {
    // 实现信息日志记录
  }
  
  @override
  void warning(String message) {
    // 实现警告日志记录
  }
  
  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    // 实现错误日志记录
  }
}

// 2. 在初始化时使用自定义日志记录器
routerManager.init(RouterConfig(
  initialLocation: '/',
  debugLogDiagnostics: true,
  logger: CustomLogger(),
));

// 3. 或者使用默认日志记录器并自定义配置
routerManager.init(RouterConfig(
  initialLocation: '/',
  debugLogDiagnostics: true,
  logger: DefaultRouterLogger(
    logger: Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    ),
  ),
));
```

## API 文档

### RouterManager

路由管理器，负责管理应用的路由配置和导航。

#### 属性

- `router`: 获取路由配置实例
- `currentLocation`: 获取当前路由路径
- `currentParams`: 获取当前路由的查询参数

#### 方法

- `init(RouterConfig config)`: 初始化路由配置
- `addRoute({...})`: 添加路由
- `addNestedRoute({...})`: 添加嵌套路由
- `updateRoutes()`: 更新路由配置
- `go(String location, {Object? extra})`: 导航到指定路径
- `push(String location, {Object? extra})`: 推入新路由
- `replace(String location, {Object? extra})`: 替换当前路由
- `pop()`: 返回上一页
- `getExtra<T>(BuildContext context)`: 获取路由传递的额外参数
- `getParam(BuildContext context, String key)`: 获取路由路径参数
- `getQueryParam(BuildContext context, String key)`: 获取路由查询参数

### RouterConfig

路由配置类，用于配置路由的初始状态和行为。

#### 属性

- `initialLocation`: 初始路由路径
- `routes`: 路由列表
- `observers`: 导航观察者列表
- `debugLogDiagnostics`: 是否启用调试日志
- `errorBuilder`: 错误页面构建器
- `redirect`: 路由重定向函数
- `logger`: 自定义日志记录器

#### 方法

- `copyWith({...})`: 创建当前配置的副本

### RouterUtils

路由工具类，提供路由相关的辅助方法。

#### 方法

- `buildPath(String path, Map<String, dynamic> params)`: 构建带参数的路由路径
- `buildQueryPath(String path, Map<String, dynamic> queryParams)`: 构建带查询参数的路由路径
- `hasRoute(BuildContext context, String routeName)`: 检查当前路由是否匹配指定路由名称
- `getCurrentRoute(BuildContext context)`: 获取当前路由路径
- `getRouteParams(BuildContext context)`: 获取当前路由的路径参数
- `getQueryParams(BuildContext context)`: 获取当前路由的查询参数

### RouterLogger

日志记录器接口，用于自定义日志记录行为。

#### 方法

- `debug(String message)`: 记录调试级别日志
- `info(String message)`: 记录信息级别日志
- `warning(String message)`: 记录警告级别日志
- `error(String message, [dynamic error, StackTrace? stackTrace])`: 记录错误级别日志

## 错误处理

Router Kit 提供了内置的错误处理机制：

1. 路由未找到时显示默认错误页面
2. 可以通过 `RouterConfig` 的 `errorBuilder` 自定义错误页面
3. 所有路由操作都有异常处理

## 日志记录

Router Kit 提供了灵活的日志记录机制：

1. 使用默认的 `logger` 包进行日志记录
2. 支持自定义日志记录器
3. 可以通过 `debugLogDiagnostics` 控制日志输出
4. 支持不同级别的日志记录（debug、info、warning、error）

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
