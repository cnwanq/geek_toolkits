import 'package:flutter/material.dart';

/// 极客标签
/// 
/// 一个自定义的标签组件，支持多种标签样式。
/// 
/// 使用示例：
/// ```dart
/// GeekTag(
///   text: '标签',
///   type: GeekTagType.primary,
///   size: GeekTagSize.medium,
/// )
/// ```
class GeekTag extends StatelessWidget {
  /// 标签文本
  final String text;
  
  /// 标签类型
  final GeekTagType type;
  
  /// 标签尺寸
  final GeekTagSize size;
  
  /// 标签图标
  final IconData? icon;
  
  /// 标签点击回调
  final VoidCallback? onTap;
  
  /// 标签关闭回调
  final VoidCallback? onClose;
  
  /// 创建极客标签
  const GeekTag({
    super.key,
    required this.text,
    this.type = GeekTagType.primary,
    this.size = GeekTagSize.medium,
    this.icon,
    this.onTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 根据类型获取标签样式
    final (backgroundColor, textColor) = _getColors(theme);
    
    // 根据尺寸获取标签内边距
    final padding = _getPadding();
    
    // 根据尺寸获取文本样式
    final textStyle = _getTextStyle(theme);
    
    // 根据尺寸获取图标尺寸
    final iconSize = _getIconSize();
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize,
                color: textColor,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              style: textStyle?.copyWith(color: textColor),
            ),
            if (onClose != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  size: iconSize,
                  color: textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  /// 获取标签颜色
  (Color, Color) _getColors(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    switch (type) {
      case GeekTagType.primary:
        return (
          colorScheme.primary.withOpacity(0.1),
          colorScheme.primary,
        );
        
      case GeekTagType.success:
        return (
          colorScheme.tertiary.withOpacity(0.1),
          colorScheme.tertiary,
        );
        
      case GeekTagType.warning:
        return (
          colorScheme.secondary.withOpacity(0.1),
          colorScheme.secondary,
        );
        
      case GeekTagType.error:
        return (
          colorScheme.error.withOpacity(0.1),
          colorScheme.error,
        );
        
      case GeekTagType.info:
        return (
          colorScheme.outline.withOpacity(0.1),
          colorScheme.outline,
        );
    }
  }
  
  /// 获取标签内边距
  EdgeInsets _getPadding() {
    switch (size) {
      case GeekTagSize.small:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 2);
      case GeekTagSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
      case GeekTagSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 6);
    }
  }
  
  /// 获取标签文本样式
  TextStyle? _getTextStyle(ThemeData theme) {
    switch (size) {
      case GeekTagSize.small:
        return theme.textTheme.bodySmall;
      case GeekTagSize.medium:
        return theme.textTheme.bodyMedium;
      case GeekTagSize.large:
        return theme.textTheme.bodyLarge;
    }
  }
  
  /// 获取标签图标尺寸
  double _getIconSize() {
    switch (size) {
      case GeekTagSize.small:
        return 12;
      case GeekTagSize.medium:
        return 16;
      case GeekTagSize.large:
        return 20;
    }
  }
}

/// 极客标签类型
enum GeekTagType {
  /// 主要标签
  primary,
  
  /// 成功标签
  success,
  
  /// 警告标签
  warning,
  
  /// 错误标签
  error,
  
  /// 信息标签
  info,
}

/// 极客标签尺寸
enum GeekTagSize {
  /// 小尺寸
  small,
  
  /// 中等尺寸
  medium,
  
  /// 大尺寸
  large,
} 