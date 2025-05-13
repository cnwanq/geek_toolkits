// packages/router_kit/lib/src/router_utils.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 路由工具类，提供路由相关的辅助方法
class RouterUtils {
  /// 构建带参数的路由路径
  /// 
  /// [path] 原始路由路径，如 '/user/:id'
  /// [params] 路由参数映射，如 {'id': '123'}
  /// 
  /// 返回构建后的路径，如 '/user/123'
  static String buildPath(String path, Map<String, dynamic> params) {
    if (path.isEmpty) return '';
    if (params.isEmpty) return path;

    String result = path;
    params.forEach((key, value) {
      if (value != null) {
        result = result.replaceAll(':$key', value.toString());
      }
    });
    return result;
  }

  /// 构建带查询参数的路由路径
  /// 
  /// [path] 原始路由路径，如 '/search'
  /// [queryParams] 查询参数映射，如 {'keyword': 'flutter'}
  /// 
  /// 返回构建后的路径，如 '/search?keyword=flutter'
  static String buildQueryPath(String path, Map<String, dynamic> queryParams) {
    if (path.isEmpty) return '';
    if (queryParams.isEmpty) return path;
    
    final queryString = queryParams.entries
        .where((e) => e.value != null)
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');
    
    return queryString.isEmpty ? path : '$path?$queryString';
  }

  /// 检查当前路由是否匹配指定路由名称
  /// 
  /// [context] 构建上下文
  /// [routeName] 要检查的路由名称
  /// 
  /// 返回是否匹配，如果发生错误则返回 false
  static bool hasRoute(BuildContext context, String routeName) {
    if (routeName.isEmpty) return false;
    
    try {
      final currentPath = GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
      
      // 规范化路径
      final normalizedRouteName = _normalizePath(routeName);
      final normalizedCurrentPath = _normalizePath(currentPath);
      
      // 检查完全匹配
      if (normalizedRouteName == normalizedCurrentPath) {
        return true;
      }
      
      // 检查是否是子路由
      if (normalizedCurrentPath.startsWith(normalizedRouteName) && 
          (normalizedRouteName.endsWith('/') || 
           normalizedCurrentPath.substring(normalizedRouteName.length).startsWith('/'))) {
        return true;
      }
      
      return false;
    } catch (e) {
      return false;
    }
  }

  /// 规范化路径
  /// 
  /// [path] 原始路径
  /// 
  /// 返回规范化后的路径
  static String _normalizePath(String path) {
    // 移除多余的斜杠
    String normalized = path.replaceAll(RegExp(r'/+'), '/');
    
    // 确保路径以 / 开头
    if (!normalized.startsWith('/')) {
      normalized = '/$normalized';
    }
    
    // 移除末尾的斜杠（除非是根路径）
    if (normalized != '/' && normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    
    return normalized.toLowerCase();
  }

  /// 获取当前路由路径
  /// 
  /// [context] 构建上下文
  /// 
  /// 返回当前路由路径，如果发生错误则返回 '/'
  static String getCurrentRoute(BuildContext context) {
    try {
      return GoRouterState.of(context).uri.path;
    } catch (e) {
      return '/';
    }
  }

  /// 获取当前路由的路径参数
  /// 
  /// [context] 构建上下文
  /// 
  /// 返回路径参数映射，如果发生错误则返回空映射
  static Map<String, String> getRouteParams(BuildContext context) {
    try {
      return GoRouterState.of(context).pathParameters;
    } catch (e) {
      return {};
    }
  }

  /// 获取当前路由的查询参数
  /// 
  /// [context] 构建上下文
  /// 
  /// 返回查询参数映射，如果发生错误则返回空映射
  static Map<String, String> getQueryParams(BuildContext context) {
    try {
      return GoRouterState.of(context).uri.queryParameters;
    } catch (e) {
      return {};
    }
  }
}