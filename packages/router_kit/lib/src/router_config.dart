// packages/router_kit/lib/src/router_config.dart
import 'package:flutter/material.dart' hide RouterConfig;
import 'package:go_router/go_router.dart';
import 'router_logger.dart';

/// 路由配置类，用于配置路由的初始状态和行为
class RouterConfig {
  /// 初始路由路径
  final String initialLocation;
  
  /// 路由列表
  final List<RouteBase> routes;
  
  /// 导航观察者列表
  final List<NavigatorObserver> observers;
  
  /// 是否启用调试日志
  final bool debugLogDiagnostics;
  
  /// 错误页面构建器
  final Widget Function(BuildContext, GoRouterState)? errorBuilder;
  
  /// 路由重定向函数
  final GoRouterRedirect? redirect;

  /// 自定义日志记录器
  final RouterLogger? logger;

  /// 创建路由配置
  /// 
  /// [initialLocation] 初始路由路径，默认为 '/'
  /// [routes] 路由列表，默认为空列表
  /// [observers] 导航观察者列表，默认为空列表
  /// [debugLogDiagnostics] 是否启用调试日志，默认为 false
  /// [errorBuilder] 错误页面构建器
  /// [redirect] 路由重定向函数
  /// [logger] 自定义日志记录器
  const RouterConfig({
    this.initialLocation = '/',
    this.routes = const [],
    this.observers = const [],
    this.debugLogDiagnostics = false,
    this.errorBuilder,
    this.redirect,
    this.logger,
  });

  /// 创建当前配置的副本，可选择性地更新部分属性
  /// 
  /// [initialLocation] 新的初始路由路径
  /// [routes] 新的路由列表
  /// [observers] 新的导航观察者列表
  /// [debugLogDiagnostics] 是否启用调试日志
  /// [errorBuilder] 新的错误页面构建器
  /// [redirect] 新的路由重定向函数
  /// [logger] 新的日志记录器
  /// 
  /// 返回一个新的 RouterConfig 实例，未指定的属性将保持原值
  RouterConfig copyWith({
    String? initialLocation,
    List<RouteBase>? routes,
    List<NavigatorObserver>? observers,
    bool? debugLogDiagnostics,
    Widget Function(BuildContext, GoRouterState)? errorBuilder,
    GoRouterRedirect? redirect,
    RouterLogger? logger,
  }) {
    return RouterConfig(
      initialLocation: initialLocation ?? this.initialLocation,
      routes: routes ?? this.routes,
      observers: observers ?? this.observers,
      debugLogDiagnostics: debugLogDiagnostics ?? this.debugLogDiagnostics,
      errorBuilder: errorBuilder ?? this.errorBuilder,
      redirect: redirect ?? this.redirect,
      logger: logger ?? this.logger,
    );
  }
}