import 'package:flutter/material.dart';
import 'package:theme_kit/theme_kit.dart';

/// 示例应用入口
void main() async {
  // 确保 Flutter 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化主题管理器
  // 1. 使用默认日志记录器
  // 2. 设置默认的亮色主题配置
  await ThemeManager().init(
    logger: DefaultThemeLogger(),
    defaultTheme: ThemeConfig.light(),
  );
  
  runApp(const MyApp());
}

/// 示例应用根组件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Kit Example',
      // 从主题管理器获取亮色主题
      theme: ThemeManager().themeConfig?.lightTheme,
      // 从主题管理器获取暗色主题
      darkTheme: ThemeManager().themeConfig?.darkTheme,
      // 从主题管理器获取当前主题模式
      themeMode: ThemeManager().themeMode,
      home: const MyHomePage(),
    );
  }
}

/// 示例应用主页
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 示例应用主页状态
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Kit Example'),
        // 在应用栏添加主题切换按钮
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              // 切换主题模式（亮色/暗色）
              ThemeManager().toggleThemeMode();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 主题模式切换按钮
            // 点击时在亮色和暗色主题之间切换
            ElevatedButton(
              onPressed: () {
                ThemeManager().toggleThemeMode();
              },
              child: const Text('切换主题模式'),
            ),
            
            const SizedBox(height: 16),
            
            // 自定义主题按钮
            // 点击时设置一个基于紫色的自定义主题
            ElevatedButton(
              onPressed: () {
                ThemeManager().setThemeConfig(
                  ThemeConfig.custom(
                    seedColor: Colors.purple,
                    brightness: Brightness.light,
                  ),
                );
              },
              child: const Text('设置紫色主题'),
            ),
            
            const SizedBox(height: 16),
            
            // 重置主题按钮
            // 点击时恢复默认主题设置
            ElevatedButton(
              onPressed: () {
                ThemeManager().resetTheme();
              },
              child: const Text('重置主题'),
            ),
          ],
        ),
      ),
    );
  }
} 