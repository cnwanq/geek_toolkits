import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'dart:math';

class DeviceUtils {
  /// 判断是否为 Android 设备
  static bool isAndroid() => !kIsWeb && Platform.isAndroid;

  /// 判断是否为 iOS 设备
  static bool isIOS() => !kIsWeb && Platform.isIOS;

  /// 判断是否为 Web
  static bool isWeb() => kIsWeb;

  /// 判断是否为桌面端
  static bool isDesktop() =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);

  /// 获取屏幕宽度
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// 获取屏幕高度
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// 获取设备像素比
  static double devicePixelRatio(BuildContext context) =>
      MediaQuery.of(context).devicePixelRatio;

  /// 判断是否为平板
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = sqrt(size.width * size.width + size.height * size.height);
    return diagonal > 1100.0;
  }

  /// 判断当前方向是否为横屏
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  /// 判断当前方向是否为竖屏
  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  /// 获取设备信息（异步）
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      return {
        'browserName': describeEnum(webInfo.browserName),
        'userAgent': webInfo.userAgent,
        'platform': webInfo.platform,
      };
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return {
        'brand': androidInfo.brand,
        'model': androidInfo.model,
        'version': androidInfo.version.release,
        'sdkInt': androidInfo.version.sdkInt,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return {
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
      };
    } else {
      return {'platform': 'unknown'};
    }
  }

  /// 获取应用信息（异步）
  static Future<Map<String, String>> getAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    return {
      'appName': info.appName,
      'packageName': info.packageName,
      'version': info.version,
      'buildNumber': info.buildNumber,
    };
  }
}
