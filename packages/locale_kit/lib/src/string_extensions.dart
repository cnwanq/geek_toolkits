import 'package:flutter/material.dart';
import 'locale_manager.dart';
import 'translations_manager.dart';

/// 字符串扩展
extension StringTranslation on String {
  /// 获取当前语言的翻译
  /// 
  /// [params] 替换参数
  String get tr {
    final localeManager = LocaleManager();
    final translationsManager = TranslationsManager();
    final locale = localeManager.currentLocale ?? const Locale('en');
    return translationsManager.get(this, locale);
  }
  
  /// 获取指定语言的翻译
  /// 
  /// [locale] 目标语言环境
  /// [params] 替换参数
  String trTo(Locale locale, [Map<String, String>? params]) {
    final translationsManager = TranslationsManager();
    return translationsManager.get(this, locale, params);
  }
  
  /// 从源语言翻译到目标语言
  /// 
  /// [sourceLocale] 源语言环境
  /// [targetLocale] 目标语言环境
  String? trFromTo(Locale sourceLocale, Locale targetLocale) {
    final translationsManager = TranslationsManager();
    return translationsManager.findTranslation(this, sourceLocale, targetLocale);
  }
  
  /// 获取带参数的翻译
  /// 
  /// [params] 替换参数
  String trWithParams(Map<String, String> params) {
    final localeManager = LocaleManager();
    final translationsManager = TranslationsManager();
    final locale = localeManager.currentLocale ?? const Locale('en');
    return translationsManager.get(this, locale, params);
  }
} 