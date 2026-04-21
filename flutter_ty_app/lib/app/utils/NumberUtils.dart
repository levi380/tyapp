import 'dart:math';

import 'package:common_utils/common_utils.dart';

class NumberUtils {
  /// 格式化数字为货币格式
  static String formatAsCurrency(double number, {String currencySymbol = '¥', int decimalDigits = 2}) {
    final formattedNumber = number.toStringAsFixed(decimalDigits).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
    return '$currencySymbol$formattedNumber';
  }

  /// 格式化数字为百分比格式
  static String formatAsPercent(double number, {int decimalDigits = 2}) {
    return '${(number * 100).toStringAsFixed(decimalDigits)}%';
  }

  /// 将数字舍入到指定的小数位数
  static double roundToDecimalPlaces(double number, int decimalPlaces) {
    final factor = pow(10, decimalPlaces);
    return (number * factor).round() / factor;
  }

  /// 将数字限制在指定的最小值和最大值之间
  static double clamp(double number, double min, double max) {
    return number.clamp(min, max);
  }

  /// 将数字转换为字节单位
  static String formatAsBytes(int bytes, {int decimals = 2}) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var index = 0;
    var value = bytes.toDouble();

    while (value >= 1024 && index < suffixes.length - 1) {
      value /= 1024;
      index++;
    }

    return '${value.toStringAsFixed(decimals)} ${suffixes[index]}';
  }
  /// 保留指定小数位
  static String formatNumber(num number, {int decimalDigits = 2}) {
    if (number is int) {
      return number.toStringAsFixed(decimalDigits);
    } else {
      return number.toStringAsFixed(decimalDigits);
    }
  }
  /// 将数字转换为时间格式
  static String formatAsTime(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${secs.toString().padLeft(2, '0')}';
    }
  }

  /// 判断数字是否在指定范围内
  static bool isWithinRange(double number, double min, double max) {
    return number >= min && number <= max;
  }

  /// 将数字转换为序数词
  static String toOrdinal(int number) {
    if (number < 0) {
      return '';
    }

    final ones = number % 10;
    final tens = (number % 100) ~/ 10;

    if (tens == 1) {
      return '$number${const ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'][0]}';
    }

    return '$number${const ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'][ones]}';
  }

  /// 将数字转换为金额格式
  static String formatAsMoney(double amount, {String currencySymbol = '\$', int decimalDigits = 2}) {
    final formattedNumber = amount.toStringAsFixed(decimalDigits).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
    return '$currencySymbol$formattedNumber';
  }

  /// 将数字转换为带单位的字符串
  static String formatAsUnit(double number, {String? unit}) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B${unit ?? ''}';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M${unit ?? ''}';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K${unit ?? ''}';
    } else {
      return '$number${unit ?? ''}';
    }
  }
  ///计算轮数的位数目前是6进1  例如：19.5进位后为20
  static double formatResultNumber(String sr) {
    double rounded = NumUtil.remainderDecStr(sr, "1").toDouble();
    double  result =   rounded>=0.5? (num.parse(sr)- rounded)+1 : num.parse(sr).toDouble();
    return result;
  }
}
