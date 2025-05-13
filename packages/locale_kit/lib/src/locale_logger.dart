import 'package:logger/logger.dart';

/// 国际化日志记录器接口
abstract class LocaleLogger {
  /// 记录调试级别日志
  void debug(String message);
  
  /// 记录信息级别日志
  void info(String message);
  
  /// 记录警告级别日志
  void warning(String message);
  
  /// 记录错误级别日志
  void error(String message, [dynamic error, StackTrace? stackTrace]);
}

/// 默认的国际化日志记录器实现
class DefaultLocaleLogger implements LocaleLogger {
  final Logger _logger;
  
  DefaultLocaleLogger({
    Logger? logger,
  }) : _logger = logger ?? Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );
  
  @override
  void debug(String message) {
    _logger.d(message);
  }
  
  @override
  void info(String message) {
    _logger.i(message);
  }
  
  @override
  void warning(String message) {
    _logger.w(message);
  }
  
  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
} 