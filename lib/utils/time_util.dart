import 'package:filbet/utils/fp.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

DateTime convertTimestampToLocalDateTime(int timestampInMilliseconds) {
  // 将时间戳转换为毫秒
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);
  // 转换为本地时间
  return dateTime.toLocal();
}

String formatddDateTimeToString(DateTime dateTime) {
  // 将 DateTime 转换为本地时间

  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String formatDateTimeToString(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

String formatDateTimeToString02(DateTime dateTime) {
  return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
}

String formatrDateTimeToString(DateTime dateTime) {
  // 将 DateTime 转换为本地时间

  return DateFormat('MM-dd HH:mm:ss').format(dateTime);
}

String formatDatemmddToString(DateTime dateTime) {
  return DateFormat('MM/dd').format(dateTime);
}

String formatYYMMDDToString(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

/// 将时间字符串转换为时间戳（毫秒）
///
/// 支持格式：
/// - 'yyyy-MM-dd HH:mm:ss'
/// - 'yyyy-MM-dd'
///
/// 如果解析失败，返回 0
int parseDateTimeStringToTimestamp(String dateTimeString) {
  if (dateTimeString.isEmpty) {
    return 0;
  }
  try {
    // 先尝试完整格式
    final dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
    return dateTime.millisecondsSinceEpoch;
  } catch (e) {}
  return 0;
}

/// 根据类型获取起止时间戳
///
/// - '1'：今日
/// - '2'：昨日
/// - '3'：近7日（默认）
/// - '4'：近30日
({String start, String end}) getTimeRangeByType([String dateValue = '3']) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  late DateTime startDate;
  late DateTime endDate;

  switch (dateValue) {
    case '1': // 今日
      startDate = today;
      endDate = today
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
      break;
    case '2': // 昨日
      startDate = today.subtract(const Duration(days: 1));
      endDate = today.subtract(const Duration(milliseconds: 1));
      break;
    case '3': // 近7日
      startDate = today.subtract(const Duration(days: 7));
      endDate = today
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
      break;
    case '4': // 近30日
      startDate = today.subtract(const Duration(days: 30));
      endDate = today
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
      break;
    case '5': // 全部
      startDate = today.subtract(const Duration(days: 60));
      endDate = today
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
      break;
    default: // 默认近7日
      startDate = today.subtract(const Duration(days: 7));
      endDate = today
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));
  }

  return (
    start: formatDateTimeToString(startDate),
    end: formatDateTimeToString(endDate)
  );
}

String formatTimestampToTime(int timestampInMilliseconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);

  return DateFormat('MM/dd HH:mm:ss').format(dateTime);
}

String formatTimestampToTime01(int timestampInMilliseconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);

  return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
}

String formatTimestampToTime02(int timestampInMilliseconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);

  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

String formatTimestampToTime03(int timestampInMilliseconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String formatTimestampToTime04(int timestampInMilliseconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);
  return DateFormat('HH:mm:ss').format(dateTime);
}

bool isExpired(int timestampInMilliseconds) {
  if (timestampInMilliseconds == 0) {
    return false;
  }
  final now = DateTime.now().millisecondsSinceEpoch;
  return timestampInMilliseconds <= now;
}

bool isLessThan3Days(int timestampInMilliseconds) {
  final now = DateTime.now().millisecondsSinceEpoch;
  const threeDaysInMilliseconds = 3 * 24 * 60 * 60 * 1000; // 3天的毫秒数
  return (timestampInMilliseconds - now) < threeDaysInMilliseconds;
}

String formatTimestampLastToTime(int timestampInMilliseconds) {
  final now = DateTime.now();
  final targetTime =
      DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);

  final difference = targetTime.difference(now);

  if (difference.isNegative) {
    return "";
  }

  final days = difference.inDays;
  final hours = difference.inHours % 24;
  final minutes = difference.inMinutes % 60;
  final inSeconds = difference.inSeconds % 60;

  // return '还剩${days}${"day".tr}${hours}${"hour".tr}${minutes}${'expiration_time'.tr}';
  return '还剩${days}${"day".tr}${hours}:${minutes}:${inSeconds}';
}

String formatTimestampToMonthAndDay(int timestampInMilliseconds) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestampInMilliseconds);
  final localDateTime = dateTime.toLocal();

  // 格式化为 MM月dd日 (本地化)
  final month = localDateTime.month.toString().padLeft(2, '0');
  final day = localDateTime.day.toString().padLeft(2, '0');

  // 获取当前语言环境
  final locale = Get.locale?.languageCode ?? 'zh';

  // 根据语言环境返回不同格式
  switch (locale) {
    case 'zh':
      return '$month${'month'.tr}$day${'ontherday'.tr}';
    case 'en':
    case 'vi':
    default:
      return '$month/$day';
  }
}

extension DateTimeExtension on int {
  String toFormattedDateTimeString() {
    return compose(
      formatDateTimeToString,
      convertTimestampToLocalDateTime,
    )(this);
  }

  String toFormattedDateTimeString02() {
    return compose(
      formatDateTimeToString02,
      convertTimestampToLocalDateTime,
    )(this);
  }

  String totsFormattedDateTimeString() {
    return compose(
      formatddDateTimeToString,
      convertTimestampToLocalDateTime,
    )(this);
  }

  String toFormattedTimeString() {
    return formatTimestampToTime(this);
  }
}
