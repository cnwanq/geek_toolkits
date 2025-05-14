import 'package:flutter/material.dart';

/// 极客开关
/// 
/// 一个自定义的开关组件，支持多种开关样式。
/// 
/// 使用示例：
/// ```dart
/// GeekSwitch(
///   value: true,
///   onChanged: (value) {
///     print('开关状态：$value');
///   },
/// )
/// ```
class GeekSwitch extends StatelessWidget {
  /// 开关状态
  final bool value;
  
  /// 开关状态变化回调
  final ValueChanged<bool>? onChanged;
  
  /// 开关类型
  final GeekSwitchType type;
  
  /// 开关尺寸
  final GeekSwitchSize size;
  
  /// 开关背景色
  final Color? backgroundColor;
  
  /// 开关前景色
  final Color? foregroundColor;
  
  /// 开关边框
  final Border? border;
  
  /// 创建极客开关
  const GeekSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.type = GeekSwitchType.primary,
    this.size = GeekSwitchSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 根据类型获取开关颜色
    final (backgroundColor, foregroundColor) = _getColors(theme);
    
    // 根据尺寸获取开关尺寸
    final switchSize = _getSize();
    
    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: switchSize.width,
        height: switchSize.height,
        decoration: BoxDecoration(
          color: this.backgroundColor ?? backgroundColor,
          borderRadius: BorderRadius.circular(switchSize.height / 2),
          border: border,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: value ? switchSize.width - switchSize.height : 0,
              top: 0,
              child: Container(
                width: switchSize.height,
                height: switchSize.height,
                decoration: BoxDecoration(
                  color: this.foregroundColor ?? foregroundColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 获取开关颜色
  (Color, Color) _getColors(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    switch (type) {
      case GeekSwitchType.primary:
        return (
          colorScheme.primary.withOpacity(0.2),
          colorScheme.primary,
        );
        
      case GeekSwitchType.success:
        return (
          colorScheme.tertiary.withOpacity(0.2),
          colorScheme.tertiary,
        );
        
      case GeekSwitchType.warning:
        return (
          colorScheme.secondary.withOpacity(0.2),
          colorScheme.secondary,
        );
        
      case GeekSwitchType.error:
        return (
          colorScheme.error.withOpacity(0.2),
          colorScheme.error,
        );
        
      case GeekSwitchType.info:
        return (
          colorScheme.outline.withOpacity(0.2),
          colorScheme.outline,
        );
    }
  }
  
  /// 获取开关尺寸
  ({double width, double height}) _getSize() {
    switch (size) {
      case GeekSwitchSize.small:
        return (width: 36, height: 20);
      case GeekSwitchSize.medium:
        return (width: 44, height: 24);
      case GeekSwitchSize.large:
        return (width: 52, height: 28);
    }
  }
}

/// 极客开关类型
enum GeekSwitchType {
  /// 主要开关
  primary,
  
  /// 成功开关
  success,
  
  /// 警告开关
  warning,
  
  /// 错误开关
  error,
  
  /// 信息开关
  info,
}

/// 极客开关尺寸
enum GeekSwitchSize {
  /// 小尺寸
  small,
  
  /// 中等尺寸
  medium,
  
  /// 大尺寸
  large,
} 