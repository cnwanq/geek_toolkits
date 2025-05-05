// lib/core_utils/number_utils.dart

import 'package:intl/intl.dart';

/// 安全将字符串转为 int，失败返回 null
int? tryParseInt(String? value) => int.tryParse(value ?? '');

/// 安全将字符串转为 double，失败返回 null
double? tryParseDouble(String? value) => double.tryParse(value ?? '');

/// 判断数字是否在指定范围内（包含边界）
bool isInRange(num value, num min, num max) => value >= min && value <= max;

/// 保留小数点后 [fractionDigits] 位，返回字符串
String toFixed(num value, int fractionDigits) =>
    value.toStringAsFixed(fractionDigits);

/// 千分位格式化
String formatThousands(num value) =>
    NumberFormat('#,##0', 'en_US').format(value);

/// 百分比格式化（如 0.1234 => 12.34%）
String formatPercent(double value, {int fractionDigits = 2}) =>
    '${(value * 100).toStringAsFixed(fractionDigits)}%';

/// 补零（如 padLeftZero(5, 3) => '005'）
String padLeftZero(int value, int width) =>
    value.toString().padLeft(width, '0');

/// 获取最大值
T maxOf<T extends num>(List<T> list) => list.reduce((a, b) => a > b ? a : b);

/// 获取最小值
T minOf<T extends num>(List<T> list) => list.reduce((a, b) => a < b ? a : b);

/// 四舍五入到最近的 [step]
double roundToStep(double value, double step) =>
    (value / step).round() * step;

/// 向下取整到最近的 [step]
double floorToStep(double value, double step) =>
    (value / step).floor() * step;

/// 向上取整到最近的 [step]
double ceilToStep(double value, double step) =>
    (value / step).ceil() * step;