import 'package:flutter/material.dart';

/// 极客列表
/// 
/// 一个自定义的列表组件，支持多种样式和交互。
/// 
/// 使用示例：
/// ```dart
/// GeekList(
///   items: [
///     GeekListItem(
///       title: '列表项标题',
///       subtitle: '列表项副标题',
///       leading: Icon(Icons.star),
///       trailing: Icon(Icons.arrow_forward_ios),
///       onTap: () {
///         print('列表项被点击');
///       },
///     ),
///   ],
/// )
/// ```
class GeekList extends StatelessWidget {
  /// 列表项
  final List<GeekListItem> items;
  
  /// 列表内边距
  final EdgeInsetsGeometry? padding;
  
  /// 列表外边距
  final EdgeInsetsGeometry? margin;
  
  /// 列表背景色
  final Color? backgroundColor;
  
  /// 列表圆角
  final double? borderRadius;
  
  /// 列表阴影
  final List<BoxShadow>? shadow;
  
  /// 列表边框
  final Border? border;
  
  /// 创建极客列表
  const GeekList({
    super.key,
    required this.items,
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
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        boxShadow: shadow,
        border: border,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1)
              Divider(
                height: 1,
                color: theme.dividerColor,
              ),
          ],
        ],
      ),
    );
  }
}

/// 极客列表项
class GeekListItem extends StatelessWidget {
  /// 列表项标题
  final String? title;
  
  /// 列表项副标题
  final String? subtitle;
  
  /// 列表项前导图标
  final Widget? leading;
  
  /// 列表项尾部图标
  final Widget? trailing;
  
  /// 列表项点击回调
  final VoidCallback? onTap;
  
  /// 列表项内边距
  final EdgeInsetsGeometry? padding;
  
  /// 创建极客列表项
  const GeekListItem({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: theme.textTheme.titleMedium,
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 16),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
} 