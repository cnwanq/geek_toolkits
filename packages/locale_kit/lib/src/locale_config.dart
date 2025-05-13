import 'package:flutter/material.dart';
import 'locale_logger.dart';

/// 国际化配置类，用于配置国际化管理器的行为
class LocaleConfig {
  /// 默认语言环境
  final Locale defaultLocale;
  
  /// 自定义日志记录器
  final LocaleLogger? logger;
  
  /// 是否启用调试日志
  final bool debugLogDiagnostics;
  
  /// 创建国际化配置
  /// 
  /// [defaultLocale] 默认语言环境，默认为英语
  /// [logger] 自定义日志记录器
  /// [debugLogDiagnostics] 是否启用调试日志，默认为 false
  const LocaleConfig({
    this.defaultLocale = const Locale('en'),
    this.logger,
    this.debugLogDiagnostics = false,
  });
  
  /// 创建当前配置的副本，可选择性地更新部分属性
  /// 
  /// [defaultLocale] 新的默认语言环境
  /// [logger] 新的日志记录器
  /// [debugLogDiagnostics] 是否启用调试日志
  /// 
  /// 返回一个新的 LocaleConfig 实例，未指定的属性将保持原值
  LocaleConfig copyWith({
    Locale? defaultLocale,
    LocaleLogger? logger,
    bool? debugLogDiagnostics,
  }) {
    return LocaleConfig(
      defaultLocale: defaultLocale ?? this.defaultLocale,
      logger: logger ?? this.logger,
      debugLogDiagnostics: debugLogDiagnostics ?? this.debugLogDiagnostics,
    );
  }
} 