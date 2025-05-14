import 'package:flutter/material.dart';

/// 极客头像
/// 
/// 一个自定义的头像组件，支持多种头像样式。
/// 
/// 使用示例：
/// ```dart
/// GeekAvatar(
///   image: NetworkImage('https://example.com/avatar.jpg'),
///   size: GeekAvatarSize.medium,
/// )
/// ```
class GeekAvatar extends StatelessWidget {
  /// 头像图片
  final ImageProvider? image;
  
  /// 头像文本
  final String? text;
  
  /// 头像图标
  final IconData? icon;
  
  /// 头像尺寸
  final GeekAvatarSize size;
  
  /// 头像背景色
  final Color? backgroundColor;
  
  /// 头像文本颜色
  final Color? textColor;
  
  /// 头像图标颜色
  final Color? iconColor;
  
  /// 头像边框
  final Border? border;
  
  /// 创建极客头像
  const GeekAvatar({
    super.key,
    this.image,
    this.text,
    this.icon,
    this.size = GeekAvatarSize.medium,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.border,
  }) : assert(image != null || text != null || icon != null, '必须提供图片、文本或图标');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 根据尺寸获取头像尺寸
    final avatarSize = _getSize();
    
    // 根据尺寸获取文本样式
    final textStyle = _getTextStyle(theme);
    
    // 根据尺寸获取图标尺寸
    final iconSize = _getIconSize();
    
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.primary,
        shape: BoxShape.circle,
        border: border,
      ),
      child: ClipOval(
        child: image != null
            ? Image(
                image: image!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
              )
            : Center(
                child: text != null
                    ? Text(
                        text!,
                        style: textStyle?.copyWith(
                          color: textColor ?? theme.colorScheme.onPrimary,
                        ),
                      )
                    : Icon(
                        icon,
                        size: iconSize,
                        color: iconColor ?? theme.colorScheme.onPrimary,
                      ),
              ),
      ),
    );
  }
  
  /// 获取头像尺寸
  double _getSize() {
    switch (size) {
      case GeekAvatarSize.small:
        return 32;
      case GeekAvatarSize.medium:
        return 40;
      case GeekAvatarSize.large:
        return 48;
    }
  }
  
  /// 获取头像文本样式
  TextStyle? _getTextStyle(ThemeData theme) {
    switch (size) {
      case GeekAvatarSize.small:
        return theme.textTheme.bodySmall;
      case GeekAvatarSize.medium:
        return theme.textTheme.bodyMedium;
      case GeekAvatarSize.large:
        return theme.textTheme.bodyLarge;
    }
  }
  
  /// 获取头像图标尺寸
  double _getIconSize() {
    switch (size) {
      case GeekAvatarSize.small:
        return 16;
      case GeekAvatarSize.medium:
        return 20;
      case GeekAvatarSize.large:
        return 24;
    }
  }
}

/// 极客头像尺寸
enum GeekAvatarSize {
  /// 小尺寸
  small,
  
  /// 中等尺寸
  medium,
  
  /// 大尺寸
  large,
} 