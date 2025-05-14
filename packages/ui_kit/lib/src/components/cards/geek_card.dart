import 'package:flutter/material.dart';

/// 极客卡片
/// 
/// 一个自定义的卡片组件，支持标题、副标题、图标和点击事件。
/// 
/// 使用示例：
/// ```dart
/// GeekCard(
///   title: '卡片标题',
///   subtitle: '卡片副标题',
///   leading: Icon(Icons.star),
///   trailing: Icon(Icons.arrow_forward_ios),
///   onTap: () {
///     print('卡片被点击');
///   },
/// )
/// ```
class GeekCard extends StatelessWidget {
  /// 卡片标题
  final String? title;
  
  /// 卡片副标题
  final String? subtitle;
  
  /// 卡片前导图标
  final Widget? leading;
  
  /// 卡片尾部图标
  final Widget? trailing;
  
  /// 卡片点击回调
  final VoidCallback? onTap;
  
  /// 卡片内边距
  final EdgeInsetsGeometry? padding;
  
  /// 卡片外边距
  final EdgeInsetsGeometry? margin;
  
  /// 卡片圆角
  final double? borderRadius;
  
  /// 卡片阴影
  final List<BoxShadow>? shadow;
  
  /// 卡片背景色
  final Color? backgroundColor;
  
  /// 卡片边框
  final Border? border;
  
  /// 创建极客卡片
  const GeekCard({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.shadow,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: margin ?? const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        side: border?.left ?? BorderSide.none,
      ),
      elevation: shadow != null ? 0 : 1,
      shadowColor: theme.shadowColor.withOpacity(0.1),
      color: backgroundColor ?? theme.cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
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
      ),
    );
  }
} 