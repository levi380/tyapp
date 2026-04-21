import 'package:intl/intl.dart';

class DateUtils {
  /// 格式化日期为指定格式
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  /// 获取当前日期
  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  /// 获取本周的开始日期
  static DateTime getStartOfWeek() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
  }

  /// 获取本周的结束日期
  static DateTime getEndOfWeek() {
    final now = DateTime.now();
    return now.add(Duration(days: 7 - now.weekday));
  }

  /// 获取本月的开始日期
  static DateTime getStartOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  /// 获取本月的结束日期
  static DateTime getEndOfMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0);
  }

  /// 判断是否是同一天
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// 获取两个日期之间的天数
  static int getDaysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  /// 获取相对时间描述（例如：刚刚、x分钟前、x小时前等）
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else {
      return '${(difference.inDays / 365).floor()}年前';
    }
  }
}
