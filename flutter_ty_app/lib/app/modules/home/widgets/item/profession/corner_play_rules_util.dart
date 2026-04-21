import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/sport.dart';

/// 处理角球/15分钟/6分钟玩法的规则文案与弹窗逻辑
class CornerPlayRulesUtil {
  static final List _titleList15Min = [
    {'value': 0, 'title': LocaleKeys.football_playing_way_hps15_title_0.tr},
    {'value': 1, 'title': LocaleKeys.football_playing_way_hps15_title_1.tr},
    {'value': 2, 'title': LocaleKeys.football_playing_way_hps15_title_2.tr},
    {'value': 3, 'title': LocaleKeys.football_playing_way_hps15_title_3.tr},
    {'value': 4, 'title': LocaleKeys.football_playing_way_hps15_title_4.tr},
    {'value': 5, 'title': LocaleKeys.football_playing_way_hps15_title_5.tr},
  ];

  static final List _titleList6Min = [
    {'value': 0, 'title': LocaleKeys.basketball_playing_way_hps6_title_0.tr},
    {'value': 1, 'title': LocaleKeys.basketball_playing_way_hps6_title_1.tr},
    {'value': 2, 'title': LocaleKeys.basketball_playing_way_hps6_title_2.tr},
    {'value': 3, 'title': LocaleKeys.basketball_playing_way_hps6_title_3.tr},
    {'value': 4, 'title': LocaleKeys.basketball_playing_way_hps6_title_4.tr},
    {'value': 5, 'title': LocaleKeys.basketball_playing_way_hps6_title_5.tr},
    {'value': 6, 'title': LocaleKeys.basketball_playing_way_hps6_title_6.tr},
    {'value': 7, 'title': LocaleKeys.basketball_playing_way_hps6_title_7.tr},
  ];

  /// 获取显示的规则标题
  static String getRuleTitle({
    required String playId,
    required MatchEntity match,
    required List<MatchHps> hps,
    required String currentHSpecial,
  }) {
    if (playId == playIdConfig.hps15Minutes) {
      if (match.ms != SportData.sportMs_1 || int.parse(match.mst) == 0) {
        return LocaleKeys.football_playing_way_hps15_title_0.tr;
      } else {
        // 使用外部传入或计算好的 hSpecial 查找标题
        List result = _titleList15Min
            .where((element) => element['value'] == num.parse(currentHSpecial))
            .toList();
        return result.isNotEmpty ? result.first['title'] : "";
      }
    } else if (playId == playIdConfig.hpsPunish) {
      return LocaleKeys.football_playing_way_penalty_cards.tr;
    } else if (playId == playIdConfig.hpsPenalty) {
      return LocaleKeys.football_playing_way_penalty_shootout.tr;
    } else if (playId == playIdConfig.hpsOvertime) {
      return LocaleKeys.football_playing_way_overtime.tr;
    }
    return "";
  }

  /// 计算15分钟玩法的 hSpecial 值
  static String calculate15MinHSpecial(List<MatchHps> hps, int eventIndex) {
    String hSpecial = "0";
    if ((hps.length / 3).ceil() >= 2) {
      if (eventIndex == 1) {
        hSpecial = hps.isNotEmpty
            ? NumUtil.subtract(num.parse(hps[1].hSpecial), 1).toInt().obs.string
            : "0";
      } else {
        hSpecial = hps.isNotEmpty
            ? NumUtil.subtract(num.parse(hps[0].hSpecial), 1).toInt().obs.string
            : "0";
      }
    } else {
      hSpecial = hps.isNotEmpty
          ? NumUtil.subtract(num.parse(hps[0].hSpecial), 1).toInt().obs.string
          : "0";
    }

    int val = num.parse(hSpecial).toInt();
    if (val == 2) hSpecial = "3";
    if (val > 4) hSpecial = "4"; //容错 下标不能大于4 最大特5
    if (val < 0) hSpecial = "0";

    return hSpecial;
  }

  /// 计算6分钟玩法的 hSpecial 值
  static String calculate6MinHSpecial(List<MatchHps> hps, int eventIndex) {
    String hSpecial = "0";
    if ((hps.length / 3).ceil() >= 2) {
      if (eventIndex == 1) {
        hSpecial = hps.length > 1 ? hps[1].hSpecial : "0";
      } else {
        hSpecial = hps.isNotEmpty ? hps[0].hSpecial : "0";
      }
    } else {
      hSpecial = hps.isNotEmpty ? hps[0].hSpecial : "0";
    }

    int val = num.parse(hSpecial).toInt();
    if (val > 7) hSpecial = "7"; //容错
    if (val < 0) hSpecial = "0";

    return hSpecial;
  }

  /// 根据 hSpecial 获取具体的时段标题 (15分钟或6分钟)
  static String getPeriodTitle(String playId, String hSpecial) {
    if (playId == playIdConfig.hps15Minutes) {
      List result = _titleList15Min
          .where((element) => element['value'] == num.parse(hSpecial))
          .toList();
      return result.isNotEmpty ? result.first['title'] : "";
    } else if (playId == playIdConfig.hps6Minutes) {
      List result = _titleList6Min
          .where((element) => element['value'] == num.parse(hSpecial))
          .toList();
      return result.isNotEmpty ? result.first['title'] : "";
    }
    return "";
  }

  /// 构建规则弹窗内容
  static Widget buildRulePopup(
      BuildContext context, String playId, bool isDarkMode) {
    if (playId == playIdConfig.hps15Minutes) {
      return _buildTablePopup(
        isDarkMode,
        [
          {
            'title': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_0_title.tr,
            'content': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_0_content.tr,
          },
          {
            'title': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_1_title.tr,
            'content': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_1_content.tr,
          },
          {
            'title': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_2_title.tr,
            'content': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_2_content.tr,
          },
          {
            'title': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_3_title.tr,
            'content': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_3_content.tr,
          },
          {
            'title': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_4_title.tr,
            'content': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_4_content.tr,
          },
          {
            'title': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_5_title.tr,
            'content': LocaleKeys.football_playing_way_hps_fifteen_minutes_details_5_content.tr,
          },
        ],
      );
    } else if (playId == playIdConfig.hps6Minutes) {
      // 6分钟数据构建逻辑... (此处为了节省篇幅，逻辑与上面相同，只是数据源不同)
      List<Map<String, String>> list6 = [];
      for(int i=0; i<=7; i++) {
        list6.add({
          'title': "${LocaleKeys.list_6minutes.tr}-${_getTitle6(i)}",
          'content': _getContent6(i),
        });
      }
      return _buildTablePopup(isDarkMode, list6);
    } else if (playId == playIdConfig.hpsPunish ||
        playId == playIdConfig.hpsPenalty) {
      return SizedBox(
        width: 200,
        child: Text(
          playId == playIdConfig.hpsPunish
              ? LocaleKeys.play_way_info_5.tr
              : LocaleKeys.play_way_info_2.tr,
          maxLines: 4,
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withValues(alpha: 0.8999999761581421)
                : const Color(0xff949AB6),
            fontSize: 10.sp,
          ),
        ),
      );
    }
    return const SizedBox(width: 200, height: 50);
  }

  // 内部辅助方法：构建表格
  static Widget _buildTablePopup(bool isDarkMode, List<Map> data) {
    return Container(
      color: Colors.white,
      child: Table(
        textBaseline: TextBaseline.alphabetic,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: data.map((show) {
          return TableRow(children: [
            Container(
              color: isDarkMode ? const Color(0xff2E3846) : Colors.white,
              padding: EdgeInsets.all(5.w),
              child: Text(
                show['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xff949AB6),
                    fontSize: 10.sp),
              ),
            ),
            Container(
                color: isDarkMode ? const Color(0xff2E3846) : Colors.white,
                padding: EdgeInsets.all(5.w),
                child: Text(
                  show['content'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.8999999761581421)
                          : const Color(0xff949AB6),
                      fontSize: 10.sp),
                ))
          ]);
        }).toList(),
        border: TableBorder.all(color: const Color(0xff949AB6), width: 0.5),
      ),
    );
  }

  // 辅助获取key的简化方法
  static String _getTitle6(int index) {
    switch(index){
      case 0: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_0_title.tr;
      case 1: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_1_title.tr;
      case 2: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_2_title.tr;
      case 3: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_3_title.tr;
      case 4: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_4_title.tr;
      case 5: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_5_title.tr;
      case 6: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_6_title.tr;
      case 7: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_7_title.tr;
      default: return "";
    }
  }
  static String _getContent6(int index) {
    switch(index){
      case 0: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_0_content.tr;
      case 1: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_1_content.tr;
      case 2: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_2_content.tr;
      case 3: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_3_content.tr;
      case 4: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_4_content.tr;
      case 5: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_5_content.tr;
      case 6: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_6_content.tr;
      case 7: return LocaleKeys.basketball_playing_way_hps_six_minutes_details_7_content.tr;
      default: return "";
    }
  }
}