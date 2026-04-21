import 'package:intl/intl.dart';

/// Created by leon on 2024/02/19.
/// date_util
class DateUtil {
  DateUtil._();

  final DateTime now = DateTime.now();

  String getMonth() => now.month.toString();

  String getDay() => now.day.toString();

  static const String PARAM_FORMAT = "yyyy/MM/dd";
  static const String PARAM_TIME_FORMAT = 'yyyy/MM/dd';
  static const String PARAM_TIME_FORMAT_H = 'yyyy/MM/dd HH';
  static const String PARAM_TIME_FORMAT_H_M_S = 'yyyy/MM/dd HH:mm:ss';
  static const String FORMAT_D_M_H_M_S = 'dd-MM HH:mm:ss';

  ///将时间日期格式转化为时间戳
  ///2018年12月11日
  ///2019-12-11
  ///2018年11月15 11:14分89
  ///结果是毫秒
  static int getTimeStap({formatData = String}) {
    var result = formatData.substring(0, 4) +
        "-" +
        formatData.substring(5, 7) +
        "-" +
        formatData.substring(8, 10);
    if (formatData.toString().length >= 13 &&
        formatData.substring(10, 13) != null) {
      result += " ${formatData.substring(10, 13)}";
    }
    if (formatData.toString().length >= 17) {
      result += ":" + formatData.substring(14, 16);
    }
    if (formatData.toString().length >= 19 &&
        formatData.substring(17, 19) != null) {
      result += ":" + formatData.substring(17, 19);
    }
    var dataTime = DateTime.parse(result);
    return dataTime.millisecondsSinceEpoch;
  }

  ///获取当前日期返回DateTime
  static DateTime getNowDateTime() {
    return DateTime.now();
  }

  ///获取昨天日期返回DateTime
  static DateTime getYesterday() {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch - 24 * 60 * 60 * 1000);
    return dateTime;
  }

  ///获取当前日期返回DateTime
  static DateTime getNowUtcDateTime() {
    return DateTime.now().toUtc();
  }

  ///获取当前日期，返回指定格式
  static String getNowDateTimeFormat(String outFormat) {
    var format = DateFormat(outFormat);
    DateTime date = DateTime.now();
    format.format(date);
    String formatResult = format.format(date);
    return formatResult;
  }

  ///获取当前日期，返回指定格式
  static String getUtcDateTimeFormat(String outFormat) {
    var format = DateFormat(outFormat);
    DateTime date = DateTime.now().toUtc();
    format.format(date);
    String formatResult = format.format(date);
    return formatResult;
  }

  ///格式化时间戳
  ///timeSamp:毫秒值
  ///format:"yyyy年MM月dd hh:mm:ss"  "yyy?MM?dd  hh?MM?dd" "yyyy:MM:dd"......
  ///结果： 2019?08?04  02?08?02
  static getFormatData({timeSamp = int, format = String}) {
    var dataFormat = DateFormat(format);
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timeSamp);
    String formatResult = dataFormat.format(dateTime);
    return formatResult;
  }

  ///格式化
  ///timeSamp:毫秒值
  ///format:"yyyy年MM月dd hh:mm:ss"  "yyy?MM?dd  hh?MM?dd" "yyyy:MM:dd"......
  ///结果： 2019?08?04  02?08?02
  static getFormatStrToStr(String date, String intFormat, String outFormat) {
    var formatInt = DateFormat(intFormat);
    var formatOut = DateFormat(outFormat);
    DateTime dateTime = formatInt.parse(date);
    String formatResult = formatOut.format(dateTime);
    return formatResult;
  }

  ///格式化 国际时区转为本地
  ///timeSamp:毫秒值
  ///format:"yyyy年MM月dd hh:mm:ss"  "yyy?MM?dd  hh?MM?dd" "yyyy:MM:dd"......
  ///结果： 2019?08?04  02?08?02
  static getFormatUtcToLocal(String date, String intFormat, String outFormat) {
    var formatInt = DateFormat(intFormat);
    var formatOut = DateFormat(outFormat);
    DateTime dateTime = formatInt.parse(date);
    var timezoneOffset = dateTime.timeZoneOffset.inHours;
    String formatResult =
        formatOut.format(dateTime.add(Duration(hours: timezoneOffset)));
    return formatResult;
  }

  String getDateMMDD(
    int day, {
    bool isReduceEnable = false,
    bool isReduce = true,
  }) {
    if (isReduceEnable) {
      if (isReduce) {}
    } else {
      return "${getMonth()}/${getDay()}";
    }
    return "";
  }
}
