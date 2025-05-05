// lib/core_utils/string_utils.dart
class StringUtils {
  /// 判断字符串是否为 null 或空
  static bool isNullOrEmpty(String? s) => s == null || s.isEmpty;

  /// 判断字符串是否为 null、空或全是空白字符
  static bool isBlank(String? s) => s == null || s.trim().isEmpty;

  /// 首字母大写
  static String capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  /// 首字母小写
  static String decapitalize(String s) =>
      s.isEmpty ? s : s[0].toLowerCase() + s.substring(1);

  /// 去除字符串首尾空白
  static String trim(String s) => s.trim();

  /// 去除所有空白字符
  static String removeAllWhitespace(String s) =>
      s.replaceAll(RegExp(r'\s+'), '');

  /// 字符串反转
  static String reverse(String s) => s.split('').reversed.join();

  /// 截取字符串，超出部分用省略号代替
  static String ellipsis(String s, int maxLength) =>
      (s.length <= maxLength) ? s : '${s.substring(0, maxLength)}...';

  /// 安全截取字符串，防止越界
  static String safeSubstring(String s, int start, [int? end]) {
    if (start < 0 || start >= s.length) return '';
    end = (end == null || end > s.length) ? s.length : end;
    return s.substring(start, end);
  }

  /// 分割字符串为 List
  static List<String> split(String s, String pattern) => s.split(pattern);

  /// 拼接字符串列表
  static String join(List<String> list, [String separator = '']) =>
      list.join(separator);

  /// 判断字符串是否为数字
  static bool isNumeric(String s) => double.tryParse(s) != null;

  /// 判断字符串是否为整数
  static bool isInt(String s) => int.tryParse(s) != null;

  /// 判断字符串是否为邮箱
  static bool isEmail(String s) =>
      RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(s);

  /// 判断字符串是否为手机号（中国大陆简单校验）
  static bool isPhone(String s) => RegExp(r'^1[3-9]\d{9}$').hasMatch(s);

  /// 字符串格式化（简单实现，支持 {0}、{1} 占位符）
  static String format(String template, List<Object?> args) {
    var result = template;
    for (var i = 0; i < args.length; i++) {
      result = result.replaceAll('{$i}', args[i].toString());
    }
    return result;
  }
}
