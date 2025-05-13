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

# Log Kit

一个简单易用的 Flutter 日志工具包，支持多级别日志、控制台输出、文件输出等功能。

## 特性

- 📝 支持多级别日志（debug、info、warning、error）
- 🖥️ 支持控制台输出
- 📁 支持文件输出
- 🏷️ 支持自定义日志标签
- 🔍 支持调试模式开关
- 📊 支持错误和堆栈跟踪记录
- 🔌 支持自定义日志实现

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  log_kit: ^0.1.0
```

## 快速开始

### 1. 初始化日志管理器

```dart
void main() {
  // 初始化日志管理器
  LogManager().init(
    debugEnabled: true,      // 是否启用调试日志
    consoleEnabled: true,    // 是否启用控制台输出
    fileEnabled: true,       // 是否启用文件输出
    logFilePath: 'logs/app.log', // 日志文件路径
    tag: 'MyApp',           // 日志标签
  );
  
  runApp(const MyApp());
}
```

### 2. 使用默认日志实现

```dart
// 创建日志实例
final logger = DefaultLogger('MyFeature');

// 记录不同级别的日志
logger.debug('调试信息');
logger.info('普通信息');
logger.warning('警告信息');
logger.error('错误信息', error, stackTrace);
```

### 3. 直接使用日志管理器

```dart
// 记录日志
LogManager().info('应用启动');

// 设置日志标签
LogManager().setTag('NewTag');

// 启用/禁用调试日志
LogManager().setDebugEnabled(false);

// 启用/禁用控制台输出
LogManager().setConsoleEnabled(true);

// 启用/禁用文件输出
LogManager().setFileEnabled(true);

// 设置日志文件路径
LogManager().setLogFilePath('logs/new.log');
```

### 4. 自定义日志实现

```dart
class CustomLogger implements LogInterface {
  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    // 实现调试日志记录
  }

  @override
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    // 实现信息日志记录
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    // 实现警告日志记录
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    // 实现错误日志记录
  }
}
```

## API 文档

### LogManager

日志管理器，负责管理日志记录。

#### 属性

- `currentLocale`: 当前语言环境
- `localeStream`: 语言变化流

#### 方法

- `init()`: 初始化日志管理器
- `debug()`: 记录调试日志
- `info()`: 记录信息日志
- `warning()`: 记录警告日志
- `error()`: 记录错误日志
- `setTag()`: 设置日志标签
- `setDebugEnabled()`: 启用/禁用调试日志
- `setConsoleEnabled()`: 启用/禁用控制台输出
- `setFileEnabled()`: 启用/禁用文件输出
- `setLogFilePath()`: 设置日志文件路径

### LogInterface

日志接口，定义基本的日志方法。

#### 方法

- `debug()`: 记录调试日志
- `info()`: 记录信息日志
- `warning()`: 记录警告日志
- `error()`: 记录错误日志

### DefaultLogger

默认日志实现，提供基本的日志记录功能。

#### 属性

- `_tag`: 日志标签

#### 方法

- `debug()`: 记录调试日志
- `info()`: 记录信息日志
- `warning()`: 记录警告日志
- `error()`: 记录错误日志

## 最佳实践

1. 在应用启动时初始化日志管理器
2. 为不同的功能模块创建独立的日志实例
3. 使用合适的日志级别
4. 在发布版本中禁用调试日志
5. 定期清理日志文件
6. 使用有意义的日志标签
7. 记录错误时包含堆栈跟踪

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License
