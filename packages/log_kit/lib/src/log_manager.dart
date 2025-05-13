import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// 日志级别
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

/// 日志管理器
class LogManager {
  static final LogManager _instance = LogManager._internal();
  factory LogManager() => _instance;
  LogManager._internal();

  /// 是否启用调试日志
  bool _debugEnabled = true;
  
  /// 是否启用控制台输出
  bool _consoleEnabled = true;
  
  /// 是否启用文件输出
  bool _fileEnabled = false;
  
  /// 日志文件路径
  String? _logFilePath;
  
  /// 日志标签
  String _tag = 'LogKit';

  /// 初始化日志管理器
  void init({
    bool debugEnabled = true,
    bool consoleEnabled = true,
    bool fileEnabled = false,
    String? logFilePath,
    String tag = 'LogKit',
  }) {
    _debugEnabled = debugEnabled;
    _consoleEnabled = consoleEnabled;
    _fileEnabled = fileEnabled;
    _logFilePath = logFilePath;
    _tag = tag;
  }

  /// 调试日志
  void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.debug, message, error, stackTrace);
  }

  /// 信息日志
  void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.info, message, error, stackTrace);
  }

  /// 警告日志
  void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.warning, message, error, stackTrace);
  }

  /// 错误日志
  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  /// 记录日志
  void _log(LogLevel level, String message, [dynamic error, StackTrace? stackTrace]) {
    if (level == LogLevel.debug && !_debugEnabled) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelStr = level.toString().split('.').last.toUpperCase();
    final logMessage = '[$timestamp][$_tag][$levelStr] $message';

    if (_consoleEnabled) {
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

    if (_fileEnabled && _logFilePath != null) {
      // TODO: 实现文件日志记录
    }
  }

  /// 设置日志标签
  void setTag(String tag) {
    _tag = tag;
  }

  /// 启用/禁用调试日志
  void setDebugEnabled(bool enabled) {
    _debugEnabled = enabled;
  }

  /// 启用/禁用控制台输出
  void setConsoleEnabled(bool enabled) {
    _consoleEnabled = enabled;
  }

  /// 启用/禁用文件输出
  void setFileEnabled(bool enabled) {
    _fileEnabled = enabled;
  }

  /// 设置日志文件路径
  void setLogFilePath(String path) {
    _logFilePath = path;
  }
} 