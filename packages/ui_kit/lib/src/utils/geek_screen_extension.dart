import 'package:flutter/material.dart';
import 'geek_screen.dart';

/// 数字类型扩展
extension GeekScreenExtension on num {
  /// 根据屏幕宽度适配
  double get w => GeekScreen().w(toDouble());

  /// 根据屏幕高度适配
  double get h => GeekScreen().h(toDouble());

  /// 根据屏幕宽高比适配（取较小值）
  double get r => GeekScreen().r(toDouble());

  /// 根据屏幕宽高比适配（取较大值）
  double get m => GeekScreen().m(toDouble());

  /// 根据屏幕宽度适配并四舍五入
  int get wInt => GeekScreen().w(toDouble()).round();

  /// 根据屏幕高度适配并四舍五入
  int get hInt => GeekScreen().h(toDouble()).round();

  /// 根据屏幕宽高比适配并四舍五入（取较小值）
  int get rInt => GeekScreen().r(toDouble()).round();

  /// 根据屏幕宽高比适配并四舍五入（取较大值）
  int get mInt => GeekScreen().m(toDouble()).round();
}

/// EdgeInsets 扩展
extension GeekEdgeInsetsExtension on EdgeInsets {
  /// 根据屏幕宽度适配
  EdgeInsets get w => copyWith(
        left: left.w,
        right: right.w,
        top: top.w,
        bottom: bottom.w,
      );

  /// 根据屏幕高度适配
  EdgeInsets get h => copyWith(
        left: left.h,
        right: right.h,
        top: top.h,
        bottom: bottom.h,
      );

  /// 根据屏幕宽高比适配（取较小值）
  EdgeInsets get r => copyWith(
        left: left.r,
        right: right.r,
        top: top.r,
        bottom: bottom.r,
      );

  /// 根据屏幕宽高比适配（取较大值）
  EdgeInsets get m => copyWith(
        left: left.m,
        right: right.m,
        top: top.m,
        bottom: bottom.m,
      );
}

/// BorderRadius 扩展
extension GeekBorderRadiusExtension on BorderRadius {
  /// 根据屏幕宽度适配
  BorderRadius get w => BorderRadius.only(
        topLeft: Radius.circular(topLeft.x.w),
        topRight: Radius.circular(topRight.x.w),
        bottomLeft: Radius.circular(bottomLeft.x.w),
        bottomRight: Radius.circular(bottomRight.x.w),
      );

  /// 根据屏幕高度适配
  BorderRadius get h => BorderRadius.only(
        topLeft: Radius.circular(topLeft.x.h),
        topRight: Radius.circular(topRight.x.h),
        bottomLeft: Radius.circular(bottomLeft.x.h),
        bottomRight: Radius.circular(bottomRight.x.h),
      );

  /// 根据屏幕宽高比适配（取较小值）
  BorderRadius get r => BorderRadius.only(
        topLeft: Radius.circular(topLeft.x.r),
        topRight: Radius.circular(topRight.x.r),
        bottomLeft: Radius.circular(bottomLeft.x.r),
        bottomRight: Radius.circular(bottomRight.x.r),
      );

  /// 根据屏幕宽高比适配（取较大值）
  BorderRadius get m => BorderRadius.only(
        topLeft: Radius.circular(topLeft.x.m),
        topRight: Radius.circular(topRight.x.m),
        bottomLeft: Radius.circular(bottomLeft.x.m),
        bottomRight: Radius.circular(bottomRight.x.m),
      );
}

/// TextStyle 扩展
extension GeekTextStyleExtension on TextStyle {
  /// 根据屏幕宽度适配字体大小
  TextStyle get w => copyWith(fontSize: fontSize?.w);

  /// 根据屏幕高度适配字体大小
  TextStyle get h => copyWith(fontSize: fontSize?.h);

  /// 根据屏幕宽高比适配字体大小（取较小值）
  TextStyle get r => copyWith(fontSize: fontSize?.r);

  /// 根据屏幕宽高比适配字体大小（取较大值）
  TextStyle get m => copyWith(fontSize: fontSize?.m);
} 