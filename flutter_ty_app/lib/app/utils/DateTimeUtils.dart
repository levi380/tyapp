import 'package:intl/intl.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  时间格式化  】】】
    【【【 AUTO_PARAGRAPH_TITLE 时间格式化  DateTimeUtils 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 时间格式化  DateTimeUtils
    - DateTimeUtils
    】】】
 *
 */
class DateTimeUtils {
  /// 获取当前日期时间
  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  /// 将 DateTime 对象格式化为字符串
  static String formatDateTime(DateTime dateTime,
      [String pattern = 'yyyy-MM-dd HH:mm:ss']) {
    return DateFormat(pattern).format(dateTime);
  }

  /// 将日期时间字符串解析为 DateTime 对象
  static DateTime parseDateTime(String dateTimeString,
      [String pattern = 'yyyy-MM-dd HH:mm:ss']) {
    return DateFormat(pattern).parse(dateTimeString);
  }

  /// 获取当天起始时间 (00:00:00)
  static DateTime getTodayStartDateTime() {
    return DateTime(getCurrentDateTime().year, getCurrentDateTime().month,
        getCurrentDateTime().day);
  }

  /// 获取当天结束时间 (23:59:59)
  static DateTime getTodayEndDateTime() {
    return getTodayStartDateTime()
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1));
  }

  /// 获取昨天起始时间 (00:00:00)
  static DateTime getYesterdayStartDateTime() {
    return getTodayStartDateTime().subtract(const Duration(days: 1));
  }

  /// 获取昨天结束时间 (23:59:59)
  static DateTime getYesterdayEndDateTime() {
    return getYesterdayStartDateTime()
        .add(const Duration(days: 1))
        .subtract(const Duration(seconds: 1));
  }

  /// 计算两个日期之间相差的天数
  static int getDaysDifference(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  /// 在给定日期基础上增加或减少天数
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// 判断给定日期是否为今天
  static bool isToday(DateTime date) {
    final now = getCurrentDateTime();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// 判断给定日期是否为昨天
  static bool isYesterday(DateTime date) {
    final yesterday = getYesterdayStartDateTime();
    final todayStart = getTodayStartDateTime();
    return date.isAfter(yesterday) && date.isBefore(todayStart);
  }
}
