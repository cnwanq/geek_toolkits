import 'package:flutter/foundation.dart';

/// 插件初始化优先级
enum GeekPluginPriority {
  /// 最高优先级，最先初始化
  highest,
  
  /// 高优先级
  high,
  
  /// 普通优先级
  normal,
  
  /// 低优先级
  low,
  
  /// 最低优先级，最后初始化
  lowest,
}

/// 插件初始化器接口
abstract class GeekPlugin {
  /// 插件名称
  String get name;
  
  /// 插件版本
  String get version;
  
  /// 插件优先级
  GeekPluginPriority get priority => GeekPluginPriority.normal;
  
  /// 插件描述
  String? get description;
  
  /// 初始化插件
  Future<void> initialize();
  
  /// 销毁插件
  Future<void> dispose();
}

/// 插件管理器
class GeekPluginManager {
  final List<GeekPlugin> _plugins = [];
  bool _isInitialized = false;
  
  /// 添加插件
  void addPlugin(GeekPlugin plugin) {
    if (_isInitialized) {
      throw StateError('插件管理器已经初始化，无法添加新插件');
    }
    _plugins.add(plugin);
  }
  
  /// 添加多个插件
  void addPlugins(List<GeekPlugin> plugins) {
    if (_isInitialized) {
      throw StateError('插件管理器已经初始化，无法添加新插件');
    }
    _plugins.addAll(plugins);
  }
  
  /// 初始化所有插件
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }
    
    // 按优先级排序插件
    _plugins.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    
    try {
      for (final plugin in _plugins) {
        debugPrint('正在初始化插件: ${plugin.name} (${plugin.version})');
        await plugin.initialize();
        debugPrint('插件初始化完成: ${plugin.name}');
      }
      _isInitialized = true;
    } catch (e) {
      debugPrint('插件初始化失败: $e');
      rethrow;
    }
  }
  
  /// 销毁所有插件
  Future<void> dispose() async {
    if (!_isInitialized) {
      return;
    }
    
    // 按优先级倒序销毁插件
    for (final plugin in _plugins.reversed) {
      try {
        await plugin.dispose();
        debugPrint('插件销毁完成: ${plugin.name}');
      } catch (e) {
        debugPrint('插件销毁失败: ${plugin.name} - $e');
      }
    }
    
    _plugins.clear();
    _isInitialized = false;
  }
  
  /// 获取所有插件
  List<GeekPlugin> get plugins => List.unmodifiable(_plugins);
  
  /// 获取已初始化的插件
  bool get isInitialized => _isInitialized;
} 