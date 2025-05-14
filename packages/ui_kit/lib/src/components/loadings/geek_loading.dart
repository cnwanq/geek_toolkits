import 'package:flutter/material.dart';

/// 极客加载指示器
/// 
/// 一个自定义的加载指示器组件，支持多种加载样式。
/// 
/// 使用示例：
/// ```dart
/// GeekLoading(
///   text: '加载中...',
///   type: GeekLoadingType.circular,
/// )
/// ```
class GeekLoading extends StatelessWidget {
  /// 加载提示文本
  final String? text;
  
  /// 加载指示器类型
  final GeekLoadingType type;
  
  /// 加载指示器颜色
  final Color? color;
  
  /// 加载指示器尺寸
  final double? size;
  
  /// 加载指示器线宽
  final double? strokeWidth;
  
  /// 创建极客加载指示器
  const GeekLoading({
    super.key,
    this.text,
    this.type = GeekLoadingType.circular,
    this.color,
    this.size,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIndicator(theme),
        if (text != null) ...[
          const SizedBox(height: 16),
          Text(
            text!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ],
    );
  }
  
  /// 构建加载指示器
  Widget _buildIndicator(ThemeData theme) {
    final color = this.color ?? theme.colorScheme.primary;
    final size = this.size ?? 24.0;
    final strokeWidth = this.strokeWidth ?? 2.0;
    
    switch (type) {
      case GeekLoadingType.circular:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: strokeWidth,
          ),
        );
        
      case GeekLoadingType.linear:
        return SizedBox(
          width: size * 2,
          height: strokeWidth,
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: color.withOpacity(0.2),
          ),
        );
    }
  }
}

/// 极客加载指示器类型
enum GeekLoadingType {
  /// 圆形加载指示器
  circular,
  
  /// 线性加载指示器
  linear,
} 