import 'package:flutter/material.dart';

/// 极客按钮类型
enum GeekButtonType {
  /// 主要按钮
  primary,
  
  /// 次要按钮
  secondary,
  
  /// 文本按钮
  text,
  
  /// 图标按钮
  icon,
}

/// 极客按钮尺寸
enum GeekButtonSize {
  /// 小尺寸
  small,
  
  /// 中等尺寸
  medium,
  
  /// 大尺寸
  large,
}

/// 极客按钮
/// 
/// 一个自定义的按钮组件，支持多种类型和尺寸。
/// 
/// 使用示例：
/// ```dart
/// GeekButton(
///   onPressed: () {},
///   text: '点击我',
///   type: GeekButtonType.primary,
///   size: GeekButtonSize.medium,
/// )
/// ```
class GeekButton extends StatelessWidget {
  /// 按钮点击回调
  final VoidCallback? onPressed;
  
  /// 按钮文本
  final String? text;
  
  /// 按钮图标
  final IconData? icon;
  
  /// 按钮类型
  final GeekButtonType type;
  
  /// 按钮尺寸
  final GeekButtonSize size;
  
  /// 是否加载中
  final bool loading;
  
  /// 是否禁用
  final bool disabled;
  
  /// 自定义样式
  final ButtonStyle? style;
  
  /// 创建极客按钮
  const GeekButton({
    super.key,
    this.onPressed,
    this.text,
    this.icon,
    this.type = GeekButtonType.primary,
    this.size = GeekButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.style,
  }) : assert(text != null || icon != null, '必须提供文本或图标');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 根据类型获取按钮样式
    final buttonStyle = _getButtonStyle(theme);
    
    // 根据尺寸获取内边距
    final padding = _getPadding();
    
    // 构建按钮内容
    Widget child;
    if (loading) {
      child = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == GeekButtonType.primary 
                ? theme.colorScheme.onPrimary 
                : theme.colorScheme.primary,
          ),
        ),
      );
    } else if (icon != null && text != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: 8),
          Text(text!),
        ],
      );
    } else if (icon != null) {
      child = Icon(icon, size: _getIconSize());
    } else {
      child = Text(text!);
    }
    
    // 根据类型构建不同的按钮
    switch (type) {
      case GeekButtonType.primary:
        return ElevatedButton(
          onPressed: disabled ? null : onPressed,
          style: buttonStyle,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
        
      case GeekButtonType.secondary:
        return OutlinedButton(
          onPressed: disabled ? null : onPressed,
          style: buttonStyle,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
        
      case GeekButtonType.text:
        return TextButton(
          onPressed: disabled ? null : onPressed,
          style: buttonStyle,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
        
      case GeekButtonType.icon:
        return IconButton(
          onPressed: disabled ? null : onPressed,
          icon: child,
          style: buttonStyle,
        );
    }
  }
  
  /// 获取按钮样式
  ButtonStyle _getButtonStyle(ThemeData theme) {
    if (style != null) return style!;
    
    final colorScheme = theme.colorScheme;
    
    switch (type) {
      case GeekButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.primary.withOpacity(0.5),
          disabledForegroundColor: colorScheme.onPrimary.withOpacity(0.5),
        );
        
      case GeekButtonType.secondary:
        return OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.primary.withOpacity(0.5),
        );
        
      case GeekButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.primary.withOpacity(0.5),
        );
        
      case GeekButtonType.icon:
        return IconButton.styleFrom(
          foregroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.primary.withOpacity(0.5),
        );
    }
  }
  
  /// 获取按钮内边距
  EdgeInsets _getPadding() {
    switch (size) {
      case GeekButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case GeekButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case GeekButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }
  
  /// 获取图标尺寸
  double _getIconSize() {
    switch (size) {
      case GeekButtonSize.small:
        return 16;
      case GeekButtonSize.medium:
        return 20;
      case GeekButtonSize.large:
        return 24;
    }
  }
} 