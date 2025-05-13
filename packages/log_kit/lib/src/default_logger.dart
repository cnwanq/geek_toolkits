import 'log_interface.dart';
import 'log_manager.dart';

/// 默认日志实现
class DefaultLogger implements LogInterface {
  final LogManager _logManager = LogManager();
  final String _tag;

  /// 创建默认日志实现
  DefaultLogger([this._tag = 'DefaultLogger']) {
    _logManager.setTag(_tag);
  }

  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logManager.debug(message, error, stackTrace);
  }

  @override
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logManager.info(message, error, stackTrace);
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logManager.warning(message, error, stackTrace);
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logManager.error(message, error, stackTrace);
  }
} 