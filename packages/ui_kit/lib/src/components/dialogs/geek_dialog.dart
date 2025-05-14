import 'package:flutter/material.dart';
import '../buttons/geek_button.dart';

/// 极客对话框
/// 
/// 一个自定义的对话框组件，支持多种样式和交互。
/// 
/// 使用示例：
/// ```dart
/// GeekDialog(
///   title: '对话框标题',
///   content: '对话框内容',
///   actions: [
///     GeekDialogAction(
///       text: '取消',
///       onPressed: () {
///         Navigator.of(context).pop();
///       },
///     ),
///     GeekDialogAction(
///       text: '确定',
///       onPressed: () {
///         Navigator.of(context).pop();
///       },
///     ),
///   ],
/// )
/// ```
class GeekDialog extends StatelessWidget {
  /// 对话框标题
  final String? title;
  
  /// 对话框内容
  final Widget? content;
  
  /// 对话框操作按钮
  final List<GeekDialogAction>? actions;
  
  /// 对话框内边距
  final EdgeInsetsGeometry? padding;
  
  /// 对话框圆角
  final double? borderRadius;
  
  /// 对话框背景色
  final Color? backgroundColor;
  
  /// 对话框阴影
  final List<BoxShadow>? shadow;
  
  /// 对话框边框
  final Border? border;
  
  /// 创建极客对话框
  const GeekDialog({
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
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        side: border?.left ?? BorderSide.none,
      ),
      backgroundColor: backgroundColor ?? theme.dialogBackgroundColor,
      elevation: shadow != null ? 0 : 24,
      child: Container(
        padding: padding ?? const EdgeInsets.all(24),
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
      ),
    );
  }
}

/// 极客对话框操作按钮
class GeekDialogAction extends StatelessWidget {
  /// 按钮文本
  final String text;
  
  /// 按钮点击回调
  final VoidCallback? onPressed;
  
  /// 按钮类型
  final GeekButtonType type;
  
  /// 创建极客对话框操作按钮
  const GeekDialogAction({
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