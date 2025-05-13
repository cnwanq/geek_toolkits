import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'locale_logger.dart';

/// 文案管理器，负责管理多语言文案
class TranslationsManager {
  static final TranslationsManager _instance = TranslationsManager._internal();
  factory TranslationsManager() => _instance;
  TranslationsManager._internal();

  late final LocaleLogger _logger;
  final Map<String, Map<String, String>> _translations = {};
  final Map<String, Map<String, String>> _reverseTranslations = {};
  
  /// 初始化文案管理器
  /// 
  /// [logger] 日志记录器
  Future<void> init(LocaleLogger logger) async {
    _logger = logger;
    await _loadTranslations();
  }

  /// 加载所有语言的翻译文件
  Future<void> _loadTranslations() async {
    try {
      // 加载所有支持的语言
      final supportedLocales = const [
        'en', // English
        'zh', // Chinese
        'ja', // Japanese
        'ko', // Korean
        'fr', // French
        'de', // German
        'es', // Spanish
        'ru', // Russian
      ];

      for (final locale in supportedLocales) {
        final jsonString = await rootBundle.loadString('assets/translations/$locale.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);
        _translations[locale] = jsonMap.map((key, value) => MapEntry(key, value.toString()));
        
        // 创建反向映射
        _reverseTranslations[locale] = {};
        jsonMap.forEach((key, value) {
          _reverseTranslations[locale]![value.toString()] = key;
        });
      }
      
      _logger.info('Translations loaded for ${_translations.length} languages');
    } catch (e, stackTrace) {
      _logger.error('Failed to load translations', e, stackTrace);
    }
  }

  /// 获取文案
  /// 
  /// [key] 文案键名
  /// [locale] 语言环境
  /// [params] 替换参数
  /// 
  /// 返回对应的文案，如果不存在则返回键名
  String get(String key, Locale locale, [Map<String, String>? params]) {
    try {
      final translations = _translations[locale.languageCode];
      if (translations == null) {
        _logger.warning('No translations found for locale: ${locale.languageCode}');
        return key;
      }

      var text = translations[key] ?? key;
      
      // 替换参数
      if (params != null) {
        params.forEach((key, value) {
          text = text.replaceAll('{$key}', value);
        });
      }
      
      return text;
    } catch (e, stackTrace) {
      _logger.error('Failed to get translation for key: $key', e, stackTrace);
      return key;
    }
  }

  /// 通过原文查找翻译
  /// 
  /// [text] 原文
  /// [sourceLocale] 源语言环境
  /// [targetLocale] 目标语言环境
  /// 
  /// 返回目标语言的翻译，如果找不到则返回原文
  String? findTranslation(String text, Locale sourceLocale, Locale targetLocale) {
    try {
      // 先通过原文找到键名
      final sourceReverseMap = _reverseTranslations[sourceLocale.languageCode];
      if (sourceReverseMap == null) {
        _logger.warning('No reverse translations found for locale: ${sourceLocale.languageCode}');
        return null;
      }

      final key = sourceReverseMap[text];
      if (key == null) {
        _logger.warning('No translation key found for text: $text');
        return null;
      }

      // 通过键名找到目标语言的翻译
      final targetTranslations = _translations[targetLocale.languageCode];
      if (targetTranslations == null) {
        _logger.warning('No translations found for locale: ${targetLocale.languageCode}');
        return null;
      }

      return targetTranslations[key];
    } catch (e, stackTrace) {
      _logger.error('Failed to find translation for text: $text', e, stackTrace);
      return null;
    }
  }

  /// 添加自定义翻译
  /// 
  /// [locale] 语言环境
  /// [translations] 翻译映射
  void addTranslations(Locale locale, Map<String, String> translations) {
    _translations[locale.languageCode] = translations;
    
    // 更新反向映射
    _reverseTranslations[locale.languageCode] = {};
    translations.forEach((key, value) {
      _reverseTranslations[locale.languageCode]![value] = key;
    });
    
    _logger.info('Added custom translations for locale: ${locale.languageCode}');
  }
} 