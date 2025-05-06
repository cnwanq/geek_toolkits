import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// 日志级别枚举
enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
}

/// 日志工具类
class Logger {
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;
  Logger._internal();

  /// 是否启用日志
  bool _enabled = true;

  /// 最小日志级别
  LogLevel _minLevel = LogLevel.verbose;

  /// 设置是否启用日志
  void setEnabled(bool enabled) {
    _enabled = enabled;
  }

  /// 设置最小日志级别
  void setMinLevel(LogLevel level) {
    _minLevel = level;
  }

  /// 记录详细日志
  void v(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.verbose, tag, message, error, stackTrace);
  }

  /// 记录调试日志
  void d(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, tag, message, error, stackTrace);
  }

  /// 记录信息日志
  void i(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.info, tag, message, error, stackTrace);
  }

  /// 记录警告日志
  void w(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, tag, message, error, stackTrace);
  }

  /// 记录错误日志
  void e(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    _log(LogLevel.error, tag, message, error, stackTrace);
  }

  void _log(
    LogLevel level,
    String tag,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!_enabled || level.index < _minLevel.index) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelStr = level.toString().split('.').last.toUpperCase();
    final logMessage = '[$timestamp][$levelStr][$tag] $message';

    if (kDebugMode) {
      developer.log(
        logMessage,
        name: 'GeekToolkits',
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      // 在非调试模式下，可以选择将日志写入文件或发送到服务器
      // TODO: 实现日志持久化
    }
  }
}
