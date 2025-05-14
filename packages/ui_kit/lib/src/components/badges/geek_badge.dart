import 'package:flutter/material.dart';

/// 极客徽章
/// 
/// 一个自定义的徽章组件，支持多种徽章样式。
/// 
/// 使用示例：
/// ```dart
/// GeekBadge(
///   text: '99+',
///   type: GeekBadgeType.primary,
///   size: GeekBadgeSize.medium,
/// )
/// ```
class GeekBadge extends StatelessWidget {
  /// 徽章文本
  final String? text;
  
  /// 徽章类型
  final GeekBadgeType type;
  
  /// 徽章尺寸
  final GeekBadgeSize size;
  
  /// 徽章位置
  final GeekBadgePosition position;
  
  /// 徽章偏移
  final Offset? offset;
  
  /// 徽章背景色
  final Color? backgroundColor;
  
  /// 徽章文本颜色
  final Color? textColor;
  
  /// 徽章边框
  final Border? border;
  
  /// 创建极客徽章
  const GeekBadge({
    super.key,
    this.text,
    this.type = GeekBadgeType.primary,
    this.size = GeekBadgeSize.medium,
    this.position = GeekBadgePosition.topRight,
    this.offset,
    this.backgroundColor,
    this.textColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 根据类型获取徽章颜色
    final (backgroundColor, textColor) = _getColors(theme);
    
    // 根据尺寸获取徽章内边距
    final padding = _getPadding();
    
    // 根据尺寸获取文本样式
    final textStyle = _getTextStyle(theme);
    
    // 根据尺寸获取徽章尺寸
    final badgeSize = _getSize();
    
    // 根据位置获取徽章偏移
    final offset = _getOffset();
    
    return Positioned(
      top: offset.dy,
      right: offset.dx,
      child: Container(
        padding: padding,
        constraints: BoxConstraints(
          minWidth: badgeSize,
          minHeight: badgeSize,
        ),
        decoration: BoxDecoration(
          color: this.backgroundColor ?? backgroundColor,
          shape: BoxShape.circle,
          border: border,
        ),
        child: text != null
            ? Center(
                child: Text(
                  text!,
                  style: textStyle?.copyWith(
                    color: this.textColor ?? textColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
  
  /// 获取徽章颜色
  (Color, Color) _getColors(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    
    switch (type) {
      case GeekBadgeType.primary:
        return (
          colorScheme.primary,
          colorScheme.onPrimary,
        );
        
      case GeekBadgeType.success:
        return (
          colorScheme.tertiary,
          colorScheme.onTertiary,
        );
        
      case GeekBadgeType.warning:
        return (
          colorScheme.secondary,
          colorScheme.onSecondary,
        );
        
      case GeekBadgeType.error:
        return (
          colorScheme.error,
          colorScheme.onError,
        );
        
      case GeekBadgeType.info:
        return (
          colorScheme.outline,
          colorScheme.onSurface,
        );
    }
  }
  
  /// 获取徽章内边距
  EdgeInsets _getPadding() {
    switch (size) {
      case GeekBadgeSize.small:
        return const EdgeInsets.all(4);
      case GeekBadgeSize.medium:
        return const EdgeInsets.all(6);
      case GeekBadgeSize.large:
        return const EdgeInsets.all(8);
    }
  }
  
  /// 获取徽章文本样式
  TextStyle? _getTextStyle(ThemeData theme) {
    switch (size) {
      case GeekBadgeSize.small:
        return theme.textTheme.bodySmall;
      case GeekBadgeSize.medium:
        return theme.textTheme.bodyMedium;
      case GeekBadgeSize.large:
        return theme.textTheme.bodyLarge;
    }
  }
  
  /// 获取徽章尺寸
  double _getSize() {
    switch (size) {
      case GeekBadgeSize.small:
        return 16;
      case GeekBadgeSize.medium:
        return 20;
      case GeekBadgeSize.large:
        return 24;
    }
  }
  
  /// 获取徽章偏移
  Offset _getOffset() {
    final offset = this.offset ?? Offset.zero;
    
    switch (position) {
      case GeekBadgePosition.topLeft:
        return Offset(-offset.dx, -offset.dy);
      case GeekBadgePosition.topRight:
        return Offset(offset.dx, -offset.dy);
      case GeekBadgePosition.bottomLeft:
        return Offset(-offset.dx, offset.dy);
      case GeekBadgePosition.bottomRight:
        return Offset(offset.dx, offset.dy);
    }
  }
}

/// 极客徽章类型
enum GeekBadgeType {
  /// 主要徽章
  primary,
  
  /// 成功徽章
  success,
  
  /// 警告徽章
  warning,
  
  /// 错误徽章
  error,
  
  /// 信息徽章
  info,
}

/// 极客徽章尺寸
enum GeekBadgeSize {
  /// 小尺寸
  small,
  
  /// 中等尺寸
  medium,
  
  /// 大尺寸
  large,
}

/// 极客徽章位置
enum GeekBadgePosition {
  /// 左上角
  topLeft,
  
  /// 右上角
  topRight,
  
  /// 左下角
  bottomLeft,
  
  /// 右下角
  bottomRight,
} 