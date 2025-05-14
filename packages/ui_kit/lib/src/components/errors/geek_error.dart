import 'package:flutter/material.dart';

/// 极客错误状态
/// 
/// 一个自定义的错误状态组件，支持多种错误状态样式。
/// 
/// 使用示例：
/// ```dart
/// GeekError(
///   text: '加载失败',
///   error: '网络连接异常',
///   action: GeekButton(
///     text: '重试',
///     onPressed: () {},
///   ),
/// )
/// ```
class GeekError extends StatelessWidget {
  /// 错误状态提示文本
  final String? text;
  
  /// 错误状态详细信息
  final String? error;
  
  /// 错误状态操作按钮
  final Widget? action;
  
  /// 错误状态内边距
  final EdgeInsetsGeometry? padding;
  
  /// 错误状态外边距
  final EdgeInsetsGeometry? margin;
  
  /// 错误状态背景色
  final Color? backgroundColor;
  
  /// 错误状态圆角
  final double? borderRadius;
  
  /// 错误状态阴影
  final List<BoxShadow>? shadow;
  
  /// 错误状态边框
  final Border? border;
  
  /// 创建极客错误状态
  const GeekError({
    super.key,
    this.text,
    this.error,
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
          Icon(
            Icons.error_outline,
            size: 48,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          if (text != null)
            Text(
              text!,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
          if (error != null) ...[
            const SizedBox(height: 8),
            Text(
              error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 24),
            action!,
          ],
        ],
      ),
    );
  }
} 