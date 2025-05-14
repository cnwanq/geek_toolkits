import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' show min, max;

/// 屏幕适配工具类
class GeekScreen {
  static final GeekScreen _instance = GeekScreen._internal();
  factory GeekScreen() => _instance;
  GeekScreen._internal();

  /// 设计稿尺寸
  static const double _designWidth = 375.0;
  static const double _designHeight = 812.0;

  /// 当前屏幕尺寸
  late MediaQueryData _mediaQuery;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;
  late double _pixelRatio;
  late double _textScaleFactor;
  late Orientation _orientation;

  /// 初始化
  void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _screenWidth = _mediaQuery.size.width;
    _screenHeight = _mediaQuery.size.height;
    _statusBarHeight = _mediaQuery.padding.top;
    _bottomBarHeight = _mediaQuery.padding.bottom;
    _pixelRatio = _mediaQuery.devicePixelRatio;
    _textScaleFactor = _mediaQuery.textScaleFactor;
    _orientation = _mediaQuery.orientation;
  }

  /// 获取屏幕宽度
  double get screenWidth => _screenWidth;

  /// 获取屏幕高度
  double get screenHeight => _screenHeight;

  /// 获取状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// 获取底部安全区域高度
  double get bottomBarHeight => _bottomBarHeight;

  /// 获取设备像素比
  double get pixelRatio => _pixelRatio;

  /// 获取文字缩放比例
  double get textScaleFactor => _textScaleFactor;

  /// 获取屏幕方向
  Orientation get orientation => _orientation;

  /// 是否横屏
  bool get isLandscape => _orientation == Orientation.landscape;

  /// 是否竖屏
  bool get isPortrait => _orientation == Orientation.portrait;

  /// 根据屏幕宽度适配尺寸
  double w(double size) {
    return size * _screenWidth / _designWidth;
  }

  /// 根据屏幕高度适配尺寸
  double h(double size) {
    return size * _screenHeight / _designHeight;
  }

  /// 根据屏幕宽度和高度适配尺寸（取较小值）
  double r(double size) {
    return size * min(_screenWidth / _designWidth, _screenHeight / _designHeight);
  }

  /// 根据屏幕宽度和高度适配尺寸（取较大值）
  double m(double size) {
    return size * max(_screenWidth / _designWidth, _screenHeight / _designHeight);
  }

  /// 设置状态栏样式
  static void setStatusBarStyle({
    Brightness brightness = Brightness.dark,
    Color? backgroundColor,
    bool translucent = false,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: backgroundColor ?? Colors.transparent,
        statusBarIconBrightness: brightness,
        statusBarBrightness: brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );
    if (translucent) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  /// 设置屏幕方向
  static void setOrientation(List<DeviceOrientation> orientations) {
    SystemChrome.setPreferredOrientations(orientations);
  }

  /// 设置全屏
  static void setFullScreen(bool fullScreen) {
    if (fullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  /// 获取安全区域
  EdgeInsets get safeArea => _mediaQuery.padding;

  /// 获取安全区域宽度
  double get safeAreaWidth => _screenWidth - _mediaQuery.padding.horizontal;

  /// 获取安全区域高度
  double get safeAreaHeight => _screenHeight - _mediaQuery.padding.vertical;

  /// 获取键盘高度
  double get keyboardHeight => _mediaQuery.viewInsets.bottom;

  /// 是否显示键盘
  bool get isKeyboardVisible => _mediaQuery.viewInsets.bottom > 0;

  /// 获取设备信息
  String get deviceInfo {
    return '屏幕尺寸: ${_screenWidth.toStringAsFixed(0)}x${_screenHeight.toStringAsFixed(0)}\n'
        '像素比: ${_pixelRatio.toStringAsFixed(2)}\n'
        '文字缩放: ${_textScaleFactor.toStringAsFixed(2)}\n'
        '状态栏高度: ${_statusBarHeight.toStringAsFixed(0)}\n'
        '底部安全区: ${_bottomBarHeight.toStringAsFixed(0)}\n'
        '屏幕方向: ${_orientation.toString().split('.').last}';
  }
} 