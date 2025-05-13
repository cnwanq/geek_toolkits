import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:logger/logger.dart';
import 'locale_config.dart';
import 'locale_logger.dart';

/// 国际化管理器，负责管理应用的语言和本地化设置
class LocaleManager {
  static final LocaleManager _instance = LocaleManager._internal();
  factory LocaleManager() => _instance;
  LocaleManager._internal();

  late final LocaleLogger _logger;
  late final SharedPreferences _prefs;
  final _localeController = StreamController<Locale>.broadcast();
  
  /// 当前语言环境
  Locale? _currentLocale;
  
  /// 获取当前语言环境
  Locale? get currentLocale => _currentLocale;
  
  /// 语言环境变化流
  Stream<Locale> get localeStream => _localeController.stream;

  /// 初始化国际化管理器
  /// 
  /// [config] 国际化配置对象
  Future<void> init(LocaleConfig config) async {
    _logger = config.logger ?? DefaultLocaleLogger();
    _prefs = await SharedPreferences.getInstance();
    
    // 从持久化存储中恢复上次使用的语言
    final savedLocale = _prefs.getString('locale');
    if (savedLocale != null) {
      _currentLocale = Locale(savedLocale);
    } else {
      _currentLocale = config.defaultLocale;
    }
    
    _logger.info('Locale manager initialized with locale: ${_currentLocale?.languageCode}');
  }

  /// 切换语言
  /// 
  /// [locale] 目标语言环境
  Future<void> setLocale(Locale locale) async {
    if (_currentLocale?.languageCode == locale.languageCode) {
      return;
    }
    
    _currentLocale = locale;
    await _prefs.setString('locale', locale.languageCode);
    _localeController.add(locale);
    
    _logger.info('Locale changed to: ${locale.languageCode}');
  }

  /// 获取支持的语言列表
  /// 
  /// 返回支持的语言环境列表
  List<Locale> getSupportedLocales() {
    return const [
      Locale('en'), // English
      Locale('zh'), // Chinese
      Locale('ja'), // Japanese
      Locale('ko'), // Korean
      Locale('fr'), // French
      Locale('de'), // German
      Locale('es'), // Spanish
      Locale('ru'), // Russian
    ];
  }

  /// 获取语言名称
  /// 
  /// [locale] 语言环境
  /// 
  /// 返回语言的本地化名称
  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'es':
        return 'Español';
      case 'ru':
        return 'Русский';
      default:
        return locale.languageCode;
    }
  }

  /// 释放资源
  void dispose() {
    _localeController.close();
  }
} 