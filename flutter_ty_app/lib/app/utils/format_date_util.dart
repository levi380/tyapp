import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:intl/intl.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ffe85c7-9af6-48bf-87f6-d3907f1ee344-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  赛事显示倒计时优化显示  】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事显示倒计时优化显示  FormatDate 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛事显示倒计时优化显示  FormatDate
    - FormatDate
    ```
    /// @description 赛事显示倒计时优化显示
    /// @param match 赛事信息
    /// @param counting_time 需要显示的时间
    /// @return String
    ```
    】】】
 *
 */
class FormatDate {

  static String countingTimeCtrShowFormat(
      MatchEntity? match, String countingTime) {
    if (match == null) {
      return countingTime;
    }
    // countingTime 格式为 00:00
    String countingTime_ = countingTime;

    /// C01赛事只显示分钟不显示秒 ------> 调整 C01电子赛事计算逻辑不变，比赛走表时间需要加上:00
    if (match.cds == 'C01' &&
        match.csid == "1" &&
        !ObjectUtil.isEmptyString(countingTime)) {
      ///电子赛事 走表补00
      countingTime_ = countingTime_.split(':')[0] + ":00";
    } else if (match.ctt == 1 &&
        ["1", "2"].contains(match.csid) &&
        !ObjectUtil.isEmptyString(countingTime)) {
      countingTime_ = countingTime_.split(':')[0];
    }
    return countingTime_;
  }

  // 格式 20:00
  static String formatHHMM(int? payload) {
    if (payload == null) return "";

    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload, isUtc: true);

    return DateFormat('HH:mm').format(time);
  }

  // 格式 2024-1-23
  static String formatDate(int? payload,{String formatString="yyyy-MM-dd"}) {
    if (payload == null) return "";
    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat(formatString).format(time);
  }

  // 格式 2024-1-23
  static String formatDate2(int? payload) {
    if (payload == null) return "";
    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);

    return DateFormat('yyyy\nMM.dd').format(time);
  }

  // 示例： 23:30
  static String formatMgtTime(int num) {
    String m = (num ~/ 60).toString().padLeft(2, '0');
    String s = (num % 60).toInt().toString().padLeft(2, '0');
    return '$m:$s';
  }

  // 示例： 23:30
  static String formatMgtTimeMD(int payload) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);
    return DateFormat('MM月dd日 HH:mm').format(time);
  }

  // 格式 20:00:00
  static String formatHHMMSS(int? payload) {
    if (payload == null) return "";
    DateTime time = DateTime.fromMillisecondsSinceEpoch(payload);
    return DateFormat('HH:mm:ss').format(time);
  }

  // 格式化分钟时间
  static String formatMinTime(int num) {
    int m = (num / 60).ceil();
    return '$m';
  }

  /// 将秒格式化为：分：秒
  /// [second] 秒
  /// [model] 分隔符类型
  /// 返回 分：秒
  static String formatSecondMs(int second, {String model = "default"}) {
    String res = '';

    if (second == 0) {
      res = model == 'minute' ? "0'" : '00:00';
    } else if (second > 0) {

      int m = (second / 60).truncate(); // 使用truncate()更接近parseInt
      int s = second % 60;

      String mStr = m.toString().padLeft(2, '0');
      String sStr = s.toString().padLeft(2, '0');

      String date;
      if (model == "default") {
        date = '$mStr:$sStr';
      } else {
        date = '$mStr\'$sStr"';
      }

      if (model == "minute") {
        // 解决0<second<60 时显示为0的BUG
        int d = m == 0 ? 1 : m;
        if (second == 0) {
          d = 0;
        }
        date = '$d\'';
      }

      res = date.isNotEmpty ? date : '00:00';
    }

    return res;
  }
}
