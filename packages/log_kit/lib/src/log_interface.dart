/// 日志接口
abstract class LogInterface {
  /// 调试日志
  void debug(String message, [dynamic error, StackTrace? stackTrace]);

  /// 信息日志
  void info(String message, [dynamic error, StackTrace? stackTrace]);

  /// 警告日志
  void warning(String message, [dynamic error, StackTrace? stackTrace]);

  /// 错误日志
  void error(String message, [dynamic error, StackTrace? stackTrace]);
} 