import 'dart:math';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  工具类  】】】
    【【【 AUTO_PARAGRAPH_TITLE 字符串判断  StringUtils 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 字符串判断  StringUtils
    - StringUtils
    】】】
 *
 */
class StringUtils {
  /// 判断字符串是否为空
  static bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  /// 判断字符串是否不为空
  static bool isNotNullAndNotEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  /// 去除字符串前后的空白字符
  static String trim(String? value) {
    return value?.trim() ?? '';
  }

  /// 将字符串截取到指定长度
  static String truncate(String? value, int maxLength, {String truncateAt = '...'}) {
    if (isNullOrEmpty(value) || value!.length <= maxLength) {
      return value ?? '';
    }
    return '${value.substring(0, maxLength - truncateAt.length)}$truncateAt';
  }

  /// 将字符串转换为驼峰格式
  static String toCamelCase(String value) {
    final parts = value.split(' ');
    if (parts.isEmpty) {
      return '';
    }
    final firstPart = parts.first;
    final otherParts = parts.skip(1).map((part) => part[0].toUpperCase() + part.substring(1));
    return '$firstPart${otherParts.join()}';
  }

  /// 将字符串转换为烤串格式
  static String toKebabCase(String value) {
    final parts = value.split(' ');
    return parts.map((part) => part.toLowerCase()).join('-');
  }

  /// 将字符串转换为蛇形格式
  static String toSnakeCase(String value) {
    final parts = value.split(' ');
    return parts.map((part) => part.toLowerCase()).join('_');
  }

  /// 将字符串转换为标题格式
  static String toTitleCase(String value) {
    final parts = value.split(' ');
    return parts.map((part) => part[0].toUpperCase() + part.substring(1).toLowerCase()).join(' ');
  }

  /// 将字符串转换为全大写
  static String toUpperCase(String? value) {
    return value?.toUpperCase() ?? '';
  }

  /// 将字符串转换为全小写
  static String toLowerCase(String? value) {
    return value?.toLowerCase() ?? '';
  }

  /// 替换字符串中的子字符串
  static String replace(String? value, Pattern from, String replace) {
    return value?.replaceAll(from, replace) ?? '';
  }

  /// 检查字符串是否包含子字符串
  static bool contains(String? value, Pattern other) {
    return value?.contains(other) ?? false;
  }

  /// 检查字符串是否以指定的子字符串开头
  static bool startsWith(String? value, Pattern other) {
    return value?.startsWith(other) ?? false;
  }

  /// 检查字符串是否以指定的子字符串结尾
  static bool endsWith(String? value, Pattern other) {
    return value?.endsWith(other.toString()) ?? false;
  }

  /// 将字符串中的 HTML 标签转义
  static String escapeHtml(String? value) {
    if (value == null) {
      return '';
    }
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#039;');
  }

  /// 将字符串中的 HTML 标签反转义
  static String unescapeHtml(String? value) {
    if (value == null) {
      return '';
    }
    return value
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'");
  }

  /// 生成随机字符串
  static String generateRandomString(int length, {bool alphanumeric = true}) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
            (_) => chars.codeUnitAt(random.nextInt(alphanumeric ? chars.length : 52)),
      ),
    );
  }
}
