
import 'dart:math' as math;

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

/// 字符串工具类
class StringUtils {
  /// 生成随机字符串
  static String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = math.Random();
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  /// 反转字符串
  static String reverseString(String input) {
    return input.split('').reversed.join();
  }

  /// 检查是否为回文字符串
  static bool isPalindrome(String input) {
    final cleaned = input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleaned == reverseString(cleaned);
  }

  /// 计算字符串中字符出现次数
  static Map<String, int> countCharacters(String input) {
    final Map<String, int> counts = {};
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      counts[char] = (counts[char] ?? 0) + 1;
    }
    return counts;
  }
}

/// 日期时间工具类
class DateTimeUtils {
  /// 获取当前时间戳
  static int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 格式化时间戳
  static String formatTimestamp(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  /// 计算两个日期之间的天数差
  static int daysBetween(DateTime from, DateTime to) {
    return (to.difference(from).inHours / 24).round();
  }

  /// 判断是否为闰年
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
}

/// 列表工具类
class ListUtils {
  /// 打乱列表
  static List<T> shuffle<T>(List<T> list) {
    final random = math.Random();
    final shuffled = List<T>.from(list);
    for (int i = shuffled.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    return shuffled;
  }

  /// 查找列表中的最大值
  static T? findMax<T extends Comparable>(List<T> list) {
    if (list.isEmpty) return null;
    return list.reduce((a, b) => a.compareTo(b) > 0 ? a : b);
  }

  /// 查找列表中的最小值
  static T? findMin<T extends Comparable>(List<T> list) {
    if (list.isEmpty) return null;
    return list.reduce((a, b) => a.compareTo(b) < 0 ? a : b);
  }

  /// 计算列表平均值
  static double calculateAverage(List<num> list) {
    if (list.isEmpty) return 0.0;
    return list.reduce((a, b) => a + b) / list.length;
  }
}

/// 网络工具类
class NetworkUtils {
  /// 模拟网络延迟
  static Future<void> simulateNetworkDelay(Duration delay) async {
    await Future.delayed(delay);
  }

  /// 模拟网络请求
  static Future<Map<String, dynamic>> simulateApiCall({
    Duration delay = const Duration(seconds: 1),
    bool shouldFail = false,
  }) async {
    await simulateNetworkDelay(delay);

    if (shouldFail) {
      throw Exception('Network request failed');
    }

    return {
      'status': 'success',
      'data': {
        'message': 'Hello from simulated API',
        'timestamp': DateTime.now().toIso8601String(),
      },
    };
  }

  /// 检查网络连接状态（模拟）
  static Future<bool> checkNetworkConnection() async {
    await simulateNetworkDelay(const Duration(milliseconds: 100));
    return math.Random().nextBool();
  }
}

/// 缓存工具类
class CacheUtils {
  static final Map<String, dynamic> _cache = {};

  /// 设置缓存
  static void setCache(String key, dynamic value) {
    _cache[key] = value;
  }

  /// 获取缓存
  static dynamic getCache(String key) {
    return _cache[key];
  }

  /// 删除缓存
  static void removeCache(String key) {
    _cache.remove(key);
  }

  /// 清空所有缓存
  static void clearCache() {
    _cache.clear();
  }

  /// 检查缓存是否存在
  static bool hasCache(String key) {
    return _cache.containsKey(key);
  }

  /// 获取缓存大小
  static int getCacheSize() {
    return _cache.length;
  }
}

/// 日志工具类
class LogUtils {
  /// 打印调试信息
  static void debug(String message) {
    AppLogger.debug('[DEBUG] $message');
  }

  /// 打印信息
  static void info(String message) {
    AppLogger.debug('[INFO] $message');
  }

  /// 打印警告
  static void warning(String message) {
    AppLogger.debug('[WARNING] $message');
  }

  /// 打印错误
  static void error(String message) {
    AppLogger.debug('[ERROR] $message');
  }

  /// 打印严重错误
  static void fatal(String message) {
    AppLogger.debug('[FATAL] $message');
  }
}

/// 验证工具类
class ValidationUtils {
  /// 验证邮箱格式
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// 验证手机号格式
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d\s-]+$');
    return phoneRegex.hasMatch(phone);
  }

  /// 验证密码强度
  static bool isStrongPassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  /// 验证URL格式
  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }
}
