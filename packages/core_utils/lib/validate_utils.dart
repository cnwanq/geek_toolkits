// lib/core_utils/validate_utils.dart

/// 校验是否为有效邮箱
bool isEmail(String s) =>
    RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(s);

/// 校验是否为中国大陆手机号
bool isPhone(String s) =>
    RegExp(r'^1[3-9]\d{9}$').hasMatch(s);

/// 校验是否为中国大陆身份证号（15或18位，简单校验）
bool isIdCard(String s) =>
    RegExp(r'(^\d{15}$)|(^\d{17}[\dXx]$)').hasMatch(s);

/// 校验是否为 URL
bool isUrl(String s) =>
    RegExp(r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-._~:/?#[\]@!$&\'()*+,;=]*)?$")
        .hasMatch(s);

/// 校验是否为 IP 地址（IPv4）
bool isIPv4(String s) =>
    RegExp(r'^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)(\.|$)){4}$').hasMatch(s);

/// 校验是否为 IP 地址（IPv6）
bool isIPv6(String s) =>
    RegExp(r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$').hasMatch(s);

/// 校验是否为纯数字
bool isNumeric(String s) => RegExp(r'^\d+$').hasMatch(s);

/// 校验是否为纯字母
bool isAlpha(String s) => RegExp(r'^[A-Za-z]+$').hasMatch(s);

/// 校验是否为字母和数字
bool isAlphaNumeric(String s) => RegExp(r'^[A-Za-z0-9]+$').hasMatch(s);

/// 校验密码强度（最少8位，包含字母和数字）
bool isStrongPassword(String s) =>
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(s);

/// 校验是否为中文
bool isChinese(String s) => RegExp(r'^[\u4e00-\u9fa5]+$').hasMatch(s);

/// 校验是否为空或全是空白字符
bool isBlank(String? s) => s == null || s.trim().isEmpty;