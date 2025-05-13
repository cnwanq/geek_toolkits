import 'package:flutter/material.dart';
import 'locale_manager.dart';
import 'translations_manager.dart';

/// 翻译文本组件
class TranslatedText extends StatelessWidget {
  /// 文案键名
  final String translationKey;
  
  /// 替换参数
  final Map<String, String>? params;
  
  /// 文本样式
  final TextStyle? style;
  
  /// 文本对齐方式
  final TextAlign? textAlign;
  
  /// 最大行数
  final int? maxLines;
  
  /// 文本溢出处理方式
  final TextOverflow? overflow;

  /// 创建翻译文本组件
  const TranslatedText(
    this.translationKey, {
    super.key,
    this.params,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final localeManager = LocaleManager();
    final translationsManager = TranslationsManager();
    
    return StreamBuilder<Locale>(
      stream: localeManager.localeStream,
      initialData: localeManager.currentLocale,
      builder: (context, snapshot) {
        final locale = snapshot.data ?? const Locale('en');
        final text = translationsManager.get(translationKey, locale, params);
        
        return Text(
          text,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
} 