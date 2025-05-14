import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 极客输入框
/// 
/// 一个自定义的文本输入框组件，支持多种输入类型和验证。
/// 
/// 使用示例：
/// ```dart
/// GeekTextField(
///   label: '用户名',
///   hint: '请输入用户名',
///   prefixIcon: Icons.person,
///   validator: (value) {
///     if (value?.isEmpty ?? true) {
///       return '请输入用户名';
///     }
///     return null;
///   },
/// )
/// ```
class GeekTextField extends StatefulWidget {
  /// 输入框标签
  final String? label;
  
  /// 输入框提示文本
  final String? hint;
  
  /// 输入框控制器
  final TextEditingController? controller;
  
  /// 输入框焦点节点
  final FocusNode? focusNode;
  
  /// 输入框前缀图标
  final IconData? prefixIcon;
  
  /// 输入框后缀图标
  final IconData? suffixIcon;
  
  /// 输入框后缀图标点击回调
  final VoidCallback? onSuffixIconTap;
  
  /// 输入框类型
  final TextInputType? keyboardType;
  
  /// 输入框输入格式化器
  final List<TextInputFormatter>? inputFormatters;
  
  /// 输入框验证器
  final String? Function(String?)? validator;
  
  /// 输入框值变化回调
  final ValueChanged<String>? onChanged;
  
  /// 输入框提交回调
  final ValueChanged<String>? onSubmitted;
  
  /// 是否密码输入框
  final bool obscureText;
  
  /// 是否自动对焦
  final bool autofocus;
  
  /// 是否启用
  final bool enabled;
  
  /// 最大行数
  final int? maxLines;
  
  /// 最小行数
  final int? minLines;
  
  /// 最大字符数
  final int? maxLength;
  
  /// 自定义装饰
  final InputDecoration? decoration;
  
  /// 创建极客输入框
  const GeekTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.autofocus = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.decoration,
  });

  @override
  State<GeekTextField> createState() => _GeekTextFieldState();
}

class _GeekTextFieldState extends State<GeekTextField> {
  bool _obscureText = false;
  
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 构建输入框装饰
    final decoration = widget.decoration ?? InputDecoration(
      labelText: widget.label,
      hintText: widget.hint,
      prefixIcon: widget.prefixIcon != null 
          ? Icon(widget.prefixIcon)
          : null,
      suffixIcon: _buildSuffixIcon(theme),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.outline,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: theme.colorScheme.error,
          width: 2,
        ),
      ),
      filled: true,
      fillColor: widget.enabled 
          ? theme.colorScheme.surface 
          : theme.colorScheme.surface.withOpacity(0.5),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    );
    
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      obscureText: _obscureText,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      decoration: decoration,
    );
  }
  
  /// 构建后缀图标
  Widget? _buildSuffixIcon(ThemeData theme) {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    
    if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(
          widget.suffixIcon,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        onPressed: widget.onSuffixIconTap,
      );
    }
    
    return null;
  }
} 