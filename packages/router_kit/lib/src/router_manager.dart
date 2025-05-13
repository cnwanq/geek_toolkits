// packages/router_kit/lib/src/router_manager.dart
import 'package:flutter/material.dart' hide RouterConfig;
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'router_config.dart';
import 'router_logger.dart';

/// 路由管理器，负责管理应用的路由配置和导航
class RouterManager {
  static final RouterManager _instance = RouterManager._internal();
  factory RouterManager() => _instance;
  RouterManager._internal();

  late final GoRouter _router;
  late final RouterLogger _logger;
  final List<RouteBase> _routes = [];
  final List<NavigatorObserver> _observers = [];
  
  /// 获取路由配置实例
  GoRouter get router => _router;
  
  /// 获取当前路由路径
  String get currentLocation => _router.routerDelegate.currentConfiguration.uri.path;
  
  /// 获取当前路由的查询参数
  Map<String, String> get currentParams => 
      _router.routerDelegate.currentConfiguration.uri.queryParameters;

  /// 初始化路由配置
  /// 
  /// [config] 路由配置对象，包含初始路径、路由列表等配置
  void init(RouterConfig config) {
    _observers.addAll(config.observers);
    
    // 初始化日志记录器
    _logger = config.logger ?? DefaultRouterLogger();
    
    _router = GoRouter(
      initialLocation: config.initialLocation,
      debugLogDiagnostics: config.debugLogDiagnostics,
      observers: _observers,
      routes: config.routes,
      errorBuilder: config.errorBuilder ?? _defaultErrorBuilder,
      redirect: config.redirect,
    );
    
    _logger.info('Router initialized with ${config.routes.length} routes');
  }

  /// 添加路由到配置中
  /// 
  /// [path] 路由路径
  /// [builder] 路由页面构建器
  /// [routes] 子路由列表
  /// [name] 路由名称
  /// [redirect] 重定向函数
  void addRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    List<RouteBase>? routes,
    String? name,
    GoRouterRedirect? redirect,
  }) {
    final route = GoRoute(
      path: path,
      name: name,
      builder: builder,
      routes: routes ?? [],
      redirect: redirect,
    );
    _routes.add(route);
    _logger.debug('Added route: $path');
  }

  /// 添加嵌套路由到配置中
  /// 
  /// [path] 路由路径
  /// [builder] 路由页面构建器
  /// [routes] 子路由列表
  /// [name] 路由名称
  /// [redirect] 重定向函数
  void addNestedRoute({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    List<RouteBase>? routes,
    String? name,
    GoRouterRedirect? redirect,
  }) {
    final nestedRoute = ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: path,
          name: name,
          builder: builder,
          routes: routes ?? [],
          redirect: redirect,
        ),
      ],
    );
    _routes.add(nestedRoute);
    _logger.debug('Added nested route: $path');
  }

  /// 更新路由配置
  /// 
  /// 使用当前路由状态和已添加的路由重新创建路由配置
  void updateRoutes() {
    final config = _router.routerDelegate.currentConfiguration;
    _router = GoRouter(
      initialLocation: config.uri.path,
      debugLogDiagnostics: true,
      observers: _observers,
      routes: _routes,
      errorBuilder: _defaultErrorBuilder,
      redirect: null,
    );
    _logger.info('Routes updated with ${_routes.length} routes');
  }

  /// 导航到指定路径
  /// 
  /// [location] 目标路径
  /// [extra] 额外参数
  void go(String location, {Object? extra}) {
    _logger.debug('Navigating to: $location');
    _router.go(location, extra: extra);
  }

  /// 将新路由推入导航栈
  /// 
  /// [location] 目标路径
  /// [extra] 额外参数
  void push(String location, {Object? extra}) {
    _logger.debug('Pushing to: $location');
    _router.push(location, extra: extra);
  }

  /// 替换当前路由
  /// 
  /// [location] 目标路径
  /// [extra] 额外参数
  void replace(String location, {Object? extra}) {
    _logger.debug('Replacing with: $location');
    _router.replace(location, extra: extra);
  }

  /// 返回上一级路由
  void pop() {
    _logger.debug('Popping current route');
    _router.pop();
  }

  /// 获取路由传递的额外参数
  /// 
  /// [context] 构建上下文
  /// 
  /// 返回指定类型的额外参数，如果不存在则返回 null
  T? getExtra<T>(BuildContext context) {
    return GoRouterState.of(context).extra as T?;
  }

  /// 获取路由路径参数
  /// 
  /// [context] 构建上下文
  /// [key] 参数键名
  /// 
  /// 返回指定键名的参数值，如果不存在则返回 null
  String? getParam(BuildContext context, String key) {
    return GoRouterState.of(context).pathParameters[key];
  }

  /// 获取路由查询参数
  /// 
  /// [context] 构建上下文
  /// [key] 参数键名
  /// 
  /// 返回指定键名的查询参数值，如果不存在则返回 null
  String? getQueryParam(BuildContext context, String key) {
    return GoRouterState.of(context).uri.queryParameters[key];
  }

  /// 默认错误页面构建器
  /// 
  /// [context] 构建上下文
  /// [state] 路由状态
  /// 
  /// 返回错误页面组件
  Widget _defaultErrorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    );
  }
}