import 'package:flutter/material.dart';

/// 极客空状态
/// 
/// 一个自定义的空状态组件，支持多种空状态样式。
/// 
/// 使用示例：
/// ```dart
/// GeekEmpty(
///   text: '暂无数据',
///   icon: Icons.inbox,
///   action: GeekButton(
///     text: '刷新',
///     onPressed: () {},
///   ),
/// )
/// ```
class GeekEmpty extends StatelessWidget {
  /// 空状态提示文本
  final String? text;
  
  /// 空状态图标
  final IconData? icon;
  
  /// 空状态操作按钮
  final Widget? action;
  
  /// 空状态内边距
  final EdgeInsetsGeometry? padding;
  
  /// 空状态外边距
  final EdgeInsetsGeometry? margin;
  
  /// 空状态背景色
  final Color? backgroundColor;
  
  /// 空状态圆角
  final double? borderRadius;
  
  /// 空状态阴影
  final List<BoxShadow>? shadow;
  
  /// 空状态边框
  final Border? border;
  
  /// 创建极客空状态
  const GeekEmpty({
    super.key,
    this.text,
    this.icon,
    this.action,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.shadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        boxShadow: shadow,
        border: border,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
          ],
          if (text != null)
            Text(
              text!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
          if (action != null) ...[
            const SizedBox(height: 24),
            action!,
          ],
        ],
      ),
    );
  }
} 