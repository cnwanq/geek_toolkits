import 'package:flutter/material.dart';
import '../plugins/geek_plugin.dart';

/// 极客应用脚手架
/// 
/// 一个自定义的应用脚手架组件，提供主题、路由、本地化等通用设置。
/// 
/// 使用示例：
/// ```dart
/// GeekApp(
///   title: '极客应用',
///   theme: ThemeData.light(),
///   darkTheme: ThemeData.dark(),
///   home: HomePage(),
///   plugins: [
///     MyPlugin(),
///     AnotherPlugin(),
///   ],
///   onPluginsInitialized: () {
///     print('所有插件初始化完成');
///   },
/// )
/// ```
class GeekApp extends StatefulWidget {
  /// 应用标题
  final String title;
  
  /// 应用主题
  final ThemeData? theme;
  
  /// 应用暗色主题
  final ThemeData? darkTheme;
  
  /// 应用主题模式
  final ThemeMode? themeMode;
  
  /// 应用首页
  final Widget? home;
  
  /// 应用路由表
  final Map<String, WidgetBuilder>? routes;
  
  /// 应用初始路由
  final String? initialRoute;
  
  /// 应用路由生成器
  final RouteFactory? onGenerateRoute;
  
  /// 应用路由观察器
  final List<NavigatorObserver>? navigatorObservers;
  
  /// 应用本地化代理
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  
  /// 应用本地化支持语言
  final Iterable<Locale>? supportedLocales;
  
  /// 应用调试横幅
  final bool debugShowCheckedModeBanner;

  /// 插件列表
  final List<GeekPlugin>? plugins;

  /// 插件初始化完成回调
  final VoidCallback? onPluginsInitialized;

  /// 自定义初始化页面构建器
  final Widget Function(BuildContext context, List<GeekPlugin> plugins)? initializingBuilder;

  /// 创建极客应用
  const GeekApp({
    super.key,
    required this.title,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.navigatorObservers,
    this.localizationsDelegates,
    this.supportedLocales,
    this.debugShowCheckedModeBanner = false,
    this.plugins,
    this.onPluginsInitialized,
    this.initializingBuilder,
  });

  @override
  State<GeekApp> createState() => _GeekAppState();
}

class _GeekAppState extends State<GeekApp> {
  final _pluginManager = GeekPluginManager();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlugins();
  }

  @override
  void dispose() {
    _pluginManager.dispose();
    super.dispose();
  }

  Future<void> _initializePlugins() async {
    if (widget.plugins != null && widget.plugins!.isNotEmpty) {
      _pluginManager.addPlugins(widget.plugins!);
      try {
        await _pluginManager.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          widget.onPluginsInitialized?.call();
        }
      } catch (e) {
        debugPrint('插件初始化失败: $e');
      }
    } else {
      _isInitialized = true;
    }
  }

  Widget _buildDefaultInitializingPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              '正在初始化插件...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        theme: widget.theme,
        darkTheme: widget.darkTheme,
        themeMode: widget.themeMode,
        home: widget.initializingBuilder?.call(context, _pluginManager.plugins) ??
            _buildDefaultInitializingPage(context),
      );
    }

    return MaterialApp(
      title: widget.title,
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
      home: widget.home,
      routes: widget.routes ?? const {},
      initialRoute: widget.initialRoute,
      onGenerateRoute: widget.onGenerateRoute,
      navigatorObservers: widget.navigatorObservers ?? const [],
      localizationsDelegates: widget.localizationsDelegates,
      supportedLocales: widget.supportedLocales ?? const [],
      debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
    );
  }
} 