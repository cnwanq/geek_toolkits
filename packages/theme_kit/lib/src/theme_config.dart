import 'package:flutter/material.dart';

/// 主题配置
/// 
/// 用于管理应用程序的亮色和暗色主题配置。
/// 提供了默认主题和自定义主题的创建方法。
/// 
/// 使用示例：
/// ```dart
/// // 创建默认主题配置
/// final defaultConfig = ThemeConfig.light();
/// 
/// // 创建自定义主题配置
/// final customConfig = ThemeConfig.custom(
///   seedColor: Colors.purple,
///   brightness: Brightness.light,
/// );
/// ```
class ThemeConfig {
  /// 亮色主题
  /// 
  /// 用于亮色模式下的主题配置
  final ThemeData lightTheme;
  
  /// 暗色主题
  /// 
  /// 用于暗色模式下的主题配置
  final ThemeData darkTheme;
  
  /// 创建主题配置
  /// 
  /// [lightTheme] 亮色主题配置
  /// [darkTheme] 暗色主题配置
  const ThemeConfig({
    required this.lightTheme,
    required this.darkTheme,
  });
  
  /// 创建默认亮色主题配置
  /// 
  /// 返回一个使用 Material Design 3 的默认主题配置：
  /// - 使用蓝色作为种子颜色
  /// - 包含自定义的应用栏、卡片、按钮和输入框主题
  factory ThemeConfig.light() {
    return ThemeConfig(
      lightTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
  
  /// 创建自定义主题配置
  /// 
  /// [seedColor] 主题的种子颜色
  /// [brightness] 主题的亮度
  /// [lightTheme] 自定义的亮色主题，如果为 null 则使用默认配置
  /// [darkTheme] 自定义的暗色主题，如果为 null 则使用默认配置
  factory ThemeConfig.custom({
    required Color seedColor,
    required Brightness brightness,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    final baseLightTheme = lightTheme ?? ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
    );
    
    final baseDarkTheme = darkTheme ?? ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
    );
    
    return ThemeConfig(
      lightTheme: baseLightTheme,
      darkTheme: baseDarkTheme,
    );
  }
  
  /// 创建主题配置的副本
  /// 
  /// [lightTheme] 新的亮色主题，如果为 null 则保持原值
  /// [darkTheme] 新的暗色主题，如果为 null 则保持原值
  ThemeConfig copyWith({
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) {
    return ThemeConfig(
      lightTheme: lightTheme ?? this.lightTheme,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }
} 