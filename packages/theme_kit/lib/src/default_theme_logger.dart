import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'theme_logger.dart';

/// 默认主题日志实现
class DefaultThemeLogger implements ThemeLogger {
  final String _tag;

  /// 创建默认主题日志实现
  DefaultThemeLogger([this._tag = 'ThemeKit']);

  @override
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _log('DEBUG', message, error, stackTrace);
  }

  @override
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _log('INFO', message, error, stackTrace);
  }

  @override
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _log('WARNING', message, error, stackTrace);
  }

  @override
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log('ERROR', message, error, stackTrace);
  }

  void _log(String level, String message, [dynamic error, StackTrace? stackTrace]) {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp][$_tag][$level] $message';

    if (kDebugMode) {
      developer.log(
        logMessage,
        name: _tag,
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      print(logMessage);
      if (error != null) print('Error: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }
} 