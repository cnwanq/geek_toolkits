/// 主题日志接口
/// 
/// 定义了主题管理器使用的日志记录方法。
/// 实现此接口可以自定义日志记录的方式。
/// 
/// 使用示例：
/// ```dart
/// class CustomThemeLogger implements ThemeLogger {
///   @override
///   void debug(String message, [dynamic error, StackTrace? stackTrace]) {
///     // 实现调试日志记录
///   }
/// 
///   @override
///   void info(String message, [dynamic error, StackTrace? stackTrace]) {
///     // 实现信息日志记录
///   }
/// 
///   @override
///   void warning(String message, [dynamic error, StackTrace? stackTrace]) {
///     // 实现警告日志记录
///   }
/// 
///   @override
///   void error(String message, [dynamic error, StackTrace? stackTrace]) {
///     // 实现错误日志记录
///   }
/// }
/// ```
abstract class ThemeLogger {
  /// 调试日志
  /// 
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void debug(String message, [dynamic error, StackTrace? stackTrace]);

  /// 信息日志
  /// 
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void info(String message, [dynamic error, StackTrace? stackTrace]);

  /// 警告日志
  /// 
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void warning(String message, [dynamic error, StackTrace? stackTrace]);

  /// 错误日志
  /// 
  /// [message] 日志消息
  /// [error] 可选的错误对象
  /// [stackTrace] 可选的堆栈跟踪
  void error(String message, [dynamic error, StackTrace? stackTrace]);
} 