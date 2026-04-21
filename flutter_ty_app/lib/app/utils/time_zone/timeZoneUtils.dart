
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';


import '../DateTimeUtils.dart';
import 'package:intl/intl.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE 工具类】】】
    【【【 AUTO_PARAGRAPH_TITLE 时区全局修改区 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 当前时区 默认内部时区数字标识为20    东八区
    -  timeZone 时区Map
    -  getTimeZoneString   获取用户设置的时区  "GMT-时区"
    -  convertTimeToTimestamp  全局根据时区转换方法     输入时间戳 或者 时间字符串（可以选择时区，时间格式）
    ```
    判断传入的是否为时间戳
    bool isMilliseconds = false,
    默认返回字符串 不返回时间戳
    bool returnMilliseconds = false,
    用来传入外部时间格式样式（传参1-13）不传就默认1
    int formatIndex = 1,
    用来传入外部时区样式（传参1-24）
    int externalZoneIndex = 0}) {
    获取时间格式样式，默认"yyyy-MM-dd HH:mm"
    String format = dateTimeFormats[formatIndex];
    外部可以通过传索引,来选择那个时区，默认东八区
    var gmtOffset = "";
    if (externalZoneIndex == 0) {
    gmtOffset = timeZone[zoneIndex];
    } else {
    gmtOffset = timeZone[externalZoneIndex];
    获取不到时区，使用默认时区
    if (gmtOffset.isEmpty) {
    gmtOffset = timeZone[zoneIndex];
    }
    }
    解析 GMT 偏移
    RegExp gmtRegex = RegExp(r'GMT([+-]\d+)');
    Match? match = gmtRegex.firstMatch(gmtOffset);
    if (match == null) {
    AppLogger.debug('convertTimeToTimestamp 时间参数错误');
    return timeString;
    }
    提取偏移小时
    int offsetHours = int.parse(match.group(1)!);
    处理时间字符串或时间戳
    DateTime parsedTime;
    如果是时间戳 并且 是13位的毫秒时间戳
    if ( isMilliseconds && timeString.length == 13) {
    解析时间字符串
    int timestamp = int.parse(timeString);
    parsedTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    } else {
    解析时间字符串
    parsedTime = DateTime.parse(timeString).toUtc();
    }
    根据时区偏移调整时间
    parsedTime = parsedTime.add(Duration(hours: offsetHours));
    if (returnMilliseconds) {
    转换为时间戳
    return parsedTime.millisecondsSinceEpoch;
    }
    DateFormat dateFormat = DateFormat(format);
    返回格式化后的时间字符串
    return dateFormat.format(parsedTime);
    ```
    】】】
 *
 */
class TimeZoneUtils{
  ///当前时区 默认内部时区数字标识为20    东八区
  static int zoneIndex = 20;
  static bool needReload = true;
  static Map<int,dynamic> timeZone = {
    1 : "GMT-11",
    2 : "GMT-10",
    3 : "GMT-9",
    4 : "GMT-8",
    5 : "GMT-7",
    6 : "GMT-6",
    7 : "GMT-5",
    8 : "GMT-4",
    9 : "GMT-3",
    10 : "GMT-2",
    11 : "GMT-1",
    12 : "GMT-0",
    13 : "GMT+1",
    14 : "GMT+2",
    15 : "GMT+3",
    16 : "GMT+4",
    17 : "GMT+5",
    18 : "GMT+6",
    19 : "GMT+7",
    ///默认 内部时区数字标识为20    东八区
    20 : "GMT+8",
    21 : "GMT+9",
    22 : "GMT+10",
    23 : "GMT+11",
    24 : "GMT+12",
  };

  static Map<int, dynamic> dateTimeFormats = {
    1: "yyyy-MM-dd HH:mm:ss", // 2024-11-20 14:30:00
    2: "yyyy-MM-ddTHH:mm:ss", // 2024-11-20T14:30:00
    3: "yyyy-MM-dd HH:mm", // 2024-11-20 14:30
    4: "yyyy-MM-dd", // 2024-11-20
    5: "dd/MM/yyyy", // 20/11/2024
    6: "MM/dd/yyyy", // 11/20/2024
    7: "MMMM dd, yyyy", // November 20, 2024
    8: "HH:mm", // 14:30
    9: "hh:mm a", // 02:30 PM
    10: "HH:mm:ss", // 14:30:00
    11: "hh:mm:ss a", // 02:30:00 PM
    12: "EEEE, MMMM dd, yyyy", // Wednesday, November 20, 2024
    13: "MMM dd, yyyy", // Nov 20, 2024
  };

  ///获取用户设置的时区
  static String getTimeZoneString(){
    return timeZone[zoneIndex]??"";
  }

  ///全局根据时区转换 时间戳 或者 时间字符串（可以选择时区，时间格式）
 static dynamic convertTimeToTimestamp(String timeString,
     {
       // ///外部直接取数据 显示  无需格式化 需要开启keepUTC
       // bool KeepUTC = false,
       ///判断传入的是否为时间戳
       bool isMilliseconds = false,
       ///默认返回字符串 不返回时间戳
      bool returnMilliseconds = false,

      ///用来传入外部时间格式样式（传参1-13）不传就默认1
      int formatIndex = 1,

      ///用来传入外部时区样式（传参1-24）
      int externalZoneIndex = 0}) {
    if(timeString.isEmpty) return 0;
    ///获取时间格式样式，默认"yyyy-MM-dd HH:mm"
    String format = dateTimeFormats[formatIndex];

    ///外部可以通过传索引,来选择那个时区，默认东八区
    var gmtOffset = "";
    if (externalZoneIndex == 0) {
      gmtOffset = timeZone[zoneIndex];
    } else {
      gmtOffset = timeZone[externalZoneIndex];

      ///获取不到时区，使用默认时区
      if (gmtOffset.isEmpty) {
        gmtOffset = timeZone[zoneIndex];
      }
    }

    /// 解析 GMT 偏移
    RegExp gmtRegex = RegExp(r'GMT([+-]\d+)');
    Match? match = gmtRegex.firstMatch(gmtOffset);
    if (match == null) {
      AppLogger.debug('convertTimeToTimestamp 时间参数错误');
      return timeString;
    }

    /// 提取偏移小时
    int offsetHours = int.parse(match.group(1)!) ;

    /// 处理时间字符串或时间戳
    DateTime parsedTime;

    /// 如果是时间戳 并且 是13位的毫秒时间戳
    if ( isMilliseconds && timeString.length == 13) {
      /// 解析时间字符串
      int timestamp = int.parse(timeString);
      parsedTime = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);

    } else {
      /// 解析时间字符串
      parsedTime = DateTime.parse(timeString).toUtc();
    }

    /// 根据时区偏移调整时间
    parsedTime = parsedTime.add(Duration(hours: offsetHours));

    if (returnMilliseconds) {
      /// 转换为时间戳
      return parsedTime.millisecondsSinceEpoch;
    }
    DateFormat dateFormat = DateFormat(format);
    /// 返回格式化后的时间字符串
    return dateFormat.format(parsedTime);
  }

  /// 时区转换 直接返回格式化时间字符串
  static String timeZoneStirngConversion(String time,String MerchantTimeZone, {String pattern = ''}){
    if (pattern.isEmpty) {
      return DateTimeUtils.formatDateTime(timeZoneDateTime(time,MerchantTimeZone));
    } else {
      return DateTimeUtils.formatDateTime(timeZoneDateTime(time,MerchantTimeZone), pattern);
    }
  }
/* /// 时区转换返回时间戳
  static int timeZoneMillisecondsSince(String time){
    return  timeZoneDateTime(time).millisecondsSinceEpoch;
  }*/
  ///返回当前时间
  static DateTime timeZoneDateTime(String time,String MerchantTimeZone){
    int merchantTimeZone = MerchantTimeZone.isNotEmpty ? int.parse(MerchantTimeZone): 8;
    ///默认东八区时间
    int commontimeZone = 8;
    ///默认时间-商户时间=差值
    int currentTime = commontimeZone - merchantTimeZone;
    ///返回当前时间
    DateTime  currentDate  =  currentTime > 0 ?
    DateTimeUtils.parseDateTime(time).subtract( Duration(hours: currentTime)):
    DateTimeUtils.parseDateTime(time).add( Duration(hours: -currentTime));
    return  currentDate;
  }



}