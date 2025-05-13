import 'package:flutter/material.dart';
import 'locale_manager.dart';
import 'translations_manager.dart';

/// 自动翻译文本组件
class AutoTranslatedText extends StatelessWidget {
  /// 原文
  final String text;
  
  /// 源语言环境
  final Locale? sourceLocale;
  
  /// 文本样式
  final TextStyle? style;
  
  /// 文本对齐方式
  final TextAlign? textAlign;
  
  /// 最大行数
  final int? maxLines;
  
  /// 文本溢出处理方式
  final TextOverflow? overflow;

  /// 创建自动翻译文本组件
  const AutoTranslatedText(
    this.text, {
    super.key,
    this.sourceLocale,
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
        final targetLocale = snapshot.data ?? const Locale('en');
        final sourceLocale = this.sourceLocale ?? targetLocale;
        
        // 如果源语言和目标语言相同，直接显示原文
        if (sourceLocale.languageCode == targetLocale.languageCode) {
          return Text(
            text,
            style: style,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
          );
        }
        
        // 查找翻译
        final translatedText = translationsManager.findTranslation(
          text,
          sourceLocale,
          targetLocale,
        );
        
        return Text(
          translatedText ?? text,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
} 