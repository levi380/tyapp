import 'dart:math';

class StringUtils {
  /// 判断字符串是否为空
  static bool isEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  /// 判断字符串是否不为空
  static bool isNotEmpty(String? str) {
    return !isEmpty(str);
  }

  /// 去除字符串两端的空白字符
  static String trim(String str) {
    return str.trim();
  }

  /// 将字符串转换为驼峰命名
  static String toCamelCase(String str) {
    if (isEmpty(str)) return '';

    final words = str.split(RegExp(r'[_\s-]'));
    if (words.isEmpty) return '';

    final firstWord = words[0].toLowerCase();
    final restWords = words.skip(1).map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });

    return firstWord + restWords.join('');
  }

  /// 将字符串转换为下划线命名
  static String toSnakeCase(String str) {
    if (isEmpty(str)) return '';

    return str
        .replaceAllMapped(
            RegExp(r'([A-Z])'), (match) => '_${match.group(1)?.toLowerCase()}')
        .replaceAll(RegExp(r'[\s-]+'), '_')
        .toLowerCase()
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  /// 截断字符串并添加省略号
  static String truncate(String str, int maxLength, {String suffix = '...'}) {
    if (isEmpty(str) || str.length <= maxLength) return str;
    return str.substring(0, maxLength) + suffix;
  }

  /// 格式化文件大小
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  /// 隐藏手机号中间四位
  static String maskPhoneNumber(String phone) {
    if (isEmpty(phone) || phone.length != 11) return phone;
    return '${phone.substring(0, 3)}****${phone.substring(7)}';
  }

  /// 隐藏邮箱中间部分
  static String maskEmail(String email) {
    if (isEmpty(email)) return email;

    final parts = email.split('@');
    if (parts.length != 2) return email;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) return email;

    final maskedUsername = '${username[0]}***${username[username.length - 1]}';
    return '$maskedUsername@$domain';
  }
}
