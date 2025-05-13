import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_config.dart';
import 'theme_logger.dart';

/// 主题管理器
/// 
/// 一个单例类，用于管理应用程序的主题设置，包括：
/// - 主题模式（亮色/暗色/系统）
/// - 主题配置（亮色主题和暗色主题）
/// - 主题持久化存储
/// - 主题变化通知
/// 
/// 使用示例：
/// ```dart
/// // 初始化主题管理器
/// await ThemeManager().init(
///   logger: DefaultThemeLogger(),
///   defaultTheme: ThemeConfig.light(),
/// );
/// 
/// // 切换主题模式
/// await ThemeManager().toggleThemeMode();
/// 
/// // 设置自定义主题
/// ThemeManager().setThemeConfig(
///   ThemeConfig.custom(
///     seedColor: Colors.purple,
///     brightness: Brightness.light,
///   ),
/// );
/// ```
class ThemeManager {
  /// 单例实例
  static final ThemeManager _instance = ThemeManager._internal();
  
  /// 获取单例实例
  factory ThemeManager() => _instance;
  
  /// 私有构造函数
  ThemeManager._internal();

  /// 日志记录器
  late final ThemeLogger _logger;
  
  /// 本地存储实例
  late final SharedPreferences _prefs;
  
  /// 当前主题模式
  /// 
  /// 可以是：
  /// - [ThemeMode.light]：亮色主题
  /// - [ThemeMode.dark]：暗色主题
  /// - [ThemeMode.system]：跟随系统设置
  ThemeMode _themeMode = ThemeMode.system;
  
  /// 当前主题配置
  /// 
  /// 包含亮色主题和暗色主题的配置
  ThemeConfig? _themeConfig;
  
  /// 主题变化流控制器
  /// 
  /// 用于广播主题模式的变化
  final _themeController = StreamController<ThemeMode>.broadcast();
  
  /// 主题变化流
  /// 
  /// 用于监听主题模式的变化
  Stream<ThemeMode> get themeStream => _themeController.stream;
  
  /// 获取当前主题模式
  ThemeMode get themeMode => _themeMode;
  
  /// 获取当前主题配置
  ThemeConfig? get themeConfig => _themeConfig;

  /// 初始化主题管理器
  /// 
  /// [logger] 用于记录主题相关的日志
  /// [defaultTheme] 默认主题配置，如果为 null 则使用 [ThemeConfig.light()]
  Future<void> init({
    required ThemeLogger logger,
    ThemeConfig? defaultTheme,
  }) async {
    _logger = logger;
    _prefs = await SharedPreferences.getInstance();
    
    // 加载保存的主题模式
    final savedThemeMode = _prefs.getString('theme_mode');
    if (savedThemeMode != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedThemeMode,
        orElse: () => ThemeMode.system,
      );
    }
    
    // 设置默认主题
    _themeConfig = defaultTheme ?? ThemeConfig.light();
    
    _logger.info('Theme manager initialized with mode: $_themeMode');
  }

  /// 设置主题模式
  /// 
  /// [mode] 要设置的主题模式
  /// 
  /// 如果新的主题模式与当前模式相同，则不会进行任何操作
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    await _prefs.setString('theme_mode', mode.toString());
    _themeController.add(mode);
    
    _logger.info('Theme mode changed to: $mode');
  }

  /// 设置主题配置
  /// 
  /// [config] 新的主题配置
  /// 
  /// 设置后会通知所有监听者主题已更新
  void setThemeConfig(ThemeConfig config) {
    _themeConfig = config;
    _themeController.add(_themeMode);
    
    _logger.info('Theme config updated');
  }

  /// 获取主题数据
  /// 
  /// [context] 构建上下文
  /// 
  /// 根据当前主题模式和系统设置返回对应的主题数据
  /// 如果主题配置为空，则返回默认的亮色或暗色主题
  ThemeData getThemeData(BuildContext context) {
    final isDark = _themeMode == ThemeMode.dark || 
        (_themeMode == ThemeMode.system && 
         MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    
    return isDark 
        ? _themeConfig?.darkTheme ?? ThemeData.dark()
        : _themeConfig?.lightTheme ?? ThemeData.light();
  }

  /// 切换主题模式
  /// 
  /// 在亮色和暗色主题之间切换
  /// 如果当前是系统主题，则切换到亮色主题
  Future<void> toggleThemeMode() async {
    final newMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// 重置主题设置
  /// 
  /// 将主题模式重置为系统主题
  /// 将主题配置重置为默认的亮色主题
  Future<void> resetTheme() async {
    await setThemeMode(ThemeMode.system);
    _themeConfig = ThemeConfig.light();
    _themeController.add(_themeMode);
    
    _logger.info('Theme settings reset to default');
  }

  /// 释放资源
  /// 
  /// 关闭主题变化流控制器
  void dispose() {
    _themeController.close();
  }
} 