import 'package:flutter/material.dart';
import '../buttons/geek_button.dart';

/// 极客底部弹出框
/// 
/// 一个自定义的底部弹出框组件，支持多种样式和交互。
/// 
/// 使用示例：
/// ```dart
/// GeekBottomSheet(
///   title: '底部弹出框标题',
///   content: '底部弹出框内容',
///   actions: [
///     GeekBottomSheetAction(
///       text: '取消',
///       onPressed: () {
///         Navigator.of(context).pop();
///       },
///     ),
///     GeekBottomSheetAction(
///       text: '确定',
///       onPressed: () {
///         Navigator.of(context).pop();
///       },
///     ),
///   ],
/// )
/// ```
class GeekBottomSheet extends StatelessWidget {
  /// 底部弹出框标题
  final String? title;
  
  /// 底部弹出框内容
  final Widget? content;
  
  /// 底部弹出框操作按钮
  final List<GeekBottomSheetAction>? actions;
  
  /// 底部弹出框内边距
  final EdgeInsetsGeometry? padding;
  
  /// 底部弹出框圆角
  final double? borderRadius;
  
  /// 底部弹出框背景色
  final Color? backgroundColor;
  
  /// 底部弹出框阴影
  final List<BoxShadow>? shadow;
  
  /// 底部弹出框边框
  final Border? border;
  
  /// 创建极客底部弹出框
  const GeekBottomSheet({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.shadow,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.bottomSheetTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(borderRadius ?? 16),
        ),
        boxShadow: shadow,
        border: border,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
          if (content != null) ...[
            content!,
            const SizedBox(height: 24),
          ],
          if (actions != null && actions!.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = 0; i < actions!.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  actions![i],
                ],
              ],
            ),
        ],
      ),
    );
  }
}

/// 极客底部弹出框操作按钮
class GeekBottomSheetAction extends StatelessWidget {
  /// 按钮文本
  final String text;
  
  /// 按钮点击回调
  final VoidCallback? onPressed;
  
  /// 按钮类型
  final GeekButtonType type;
  
  /// 创建极客底部弹出框操作按钮
  const GeekBottomSheetAction({
    super.key,
    required this.text,
    this.onPressed,
    this.type = GeekButtonType.text,
  });

  @override
  Widget build(BuildContext context) {
    return GeekButton(
      text: text,
      type: type,
      onPressed: onPressed,
    );
  }
} 