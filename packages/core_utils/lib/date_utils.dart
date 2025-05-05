// lib/core_utils/date_utils.dart

import 'package:intl/intl.dart';

/// 格式化日期为字符串
String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
  return DateFormat(pattern).format(date);
}

/// 解析字符串为日期
DateTime? parseDate(String dateStr, {String pattern = 'yyyy-MM-dd'}) {
  try {
    return DateFormat(pattern).parse(dateStr);
  } catch (_) {
    return null;
  }
}

/// 获取两个日期之间的天数（绝对值）
int daysBetween(DateTime a, DateTime b) {
  return a.difference(b).inDays.abs();
}

/// 判断是否为同一天
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// 获取本周的第一天（周一）
DateTime startOfWeek(DateTime date) {
  return date.subtract(Duration(days: date.weekday - 1));
}

/// 获取本月的第一天
DateTime startOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

/// 获取本月的最后一天
DateTime endOfMonth(DateTime date) {
  final beginningNextMonth = (date.month < 12)
      ? DateTime(date.year, date.month + 1, 1)
      : DateTime(date.year + 1, 1, 1);
  return beginningNextMonth.subtract(const Duration(days: 1));
}

/// 判断日期是否在某个区间内（包含边界）
bool isInRange(DateTime date, DateTime start, DateTime end) {
  return !date.isBefore(start) && !date.isAfter(end);
}

/// 增加天数
DateTime addDays(DateTime date, int days) => date.add(Duration(days: days));

/// 增加小时
DateTime addHours(DateTime date, int hours) => date.add(Duration(hours: hours));

/// 增加分钟
DateTime addMinutes(DateTime date, int minutes) => date.add(Duration(minutes: minutes));