import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/utils/format_score_util.dart';

import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

/// 赛事阶段内容辅助类
/// 负责处理赛事阶段显示内容的逻辑
class MatchStageContentHelper {
  /// 赛事实体
  final MatchEntity? match;
  
  /// 是否显示倒计时
  final bool startTime;
  
  /// 倒计时时间（分钟）
  final String longTime;

  /// 构造函数
  /// [match] 赛事实体
  /// [startTime] 是否显示倒计时
  /// [longTime] 倒计时时间（分钟）
  MatchStageContentHelper({
    required this.match,
    required this.startTime,
    required this.longTime,
  });

  /// 获取赛事阶段显示内容（下部分）
  /// 返回比赛时间或开赛时间
  /// 返回值：显示的内容字符串
  String getMatchStageContentBottom() {
    int ms = match?.ms ?? 0;
    
    // 赛事未开赛
    if (ms == 0) {
      // 即将开赛的赛事不显示日期
      if (startTime) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        return LocaleKeys.list_after_time_start.tr.replaceAll("{0}", longTime);
      } else {
        // 格式化显示HH:MM
        return FormatDate.formatHHMM(int.tryParse(match?.mgt ?? "0") ?? 0);
      }
    }
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == 110) {
      return "ms_$ms".tr;
    } 
    // 滚球阶段、暂停、结束、关闭状态显示比分
    else if ([1, 2, 3, 4].contains(ms)) {
      // 显示比分
      return "${FormatScore.formatTotalScore(match!, 0)} - ${FormatScore.formatTotalScore(match!, 1)}";
    }
    
    return "";
  }

  /// 获取赛事阶段显示内容的字体大小
  /// 返回值：字体大小（sp单位）
  double getMatchStageBottomContentFontSize() {
    int ms = match?.ms ?? 0;
    
    // 赛事未开赛
    if (ms == 0) {
      // 即将开赛的赛事不显示日期
      if (startTime) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        return isIPad ? 16.sp : 12.sp;
      } else {
        // 显示HH：mm
        return isIPad ? 40.sp : 30.sp;
      }
    }
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == 110) {
      return isIPad ? 16.sp : 12.sp;
    } 
    // 滚球阶段、暂停、结束、关闭状态显示比分
    else if ([1, 2, 3, 4].contains(ms)) {
      // 显示比分
      return isIPad ? 40.sp : 30.sp;
    }
    
    return isIPad ? 40.sp : 30.sp;
  }

  /// 判断是否显示局间比分
  /// 局间比分显示逻辑：滚球阶段ms=1并且对应赛种才显示
  /// ms 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /// 支持的赛种：4--冰球, 5--网球, 7--斯诺克, 8--乒乓球, 9--排球, 10--羽毛球, 13--沙滩排球,14--橄榄球, 15--曲棍球, 16--水球
  /// 返回值：true表示显示，false表示不显示
  bool showMatchBetweenScore() {
    List<String> msc = match?.msc ?? [];
    if (["3", "4", "5", "7", "6", "8", "9", "10", "13", "14", "15", "16"]
            .contains(match?.csid) &&
        match?.ms == 1 &&
        msc.isNotEmpty &&
        match?.mmp != "999") {
      return true;
    }
    return false;
  }

  /// 判断是否显示比赛中断提示
  /// 足球比赛暂停 mmp：80
  /// 返回值：true表示显示，false表示不显示
  bool showMatchInterrupted() {
    if (["1"].contains(match?.csid) && match?.mmp == "80") {
      return true;
    }
    return false;
  }
}