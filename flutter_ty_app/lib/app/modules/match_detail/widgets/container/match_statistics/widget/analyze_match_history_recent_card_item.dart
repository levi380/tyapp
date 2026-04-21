import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/main.dart';

import '../../../../../../services/models/res/statistics_team_vs_other_team_entity.dart';

/// 近期战绩卡片 - 单行列表项
///
/// 展示一场历史比赛：日期/赛事、比分、主客队名、结果/盘路/大小三列
/// [teamName] 用于高亮当前侧队伍名称
class AnalyzeMatchHistoryRecentCardItem extends StatelessWidget {
  final StatisticsTeamVsOtherTeam item;
  final String teamName;
  final SeasonStatisticController controller;

  const AnalyzeMatchHistoryRecentCardItem({
    super.key,
    required this.item,
    required this.teamName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                FormatDate.formatDate(
                                  int.tryParse(item.beginTime) ?? 0,
                                ),
                                style: TextStyle(
                                  fontSize: isIPad ? 15.sp : 11.sp,
                                  color: Get.theme.tabPanelSelectedColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.tournamentName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: isIPad ? 15.sp : 11.sp,
                                  color: Get.theme.tabPanelSelectedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${item.homeTeamScore}',
                                style: TextStyle(
                                  fontSize: isIPad ? 15.sp : 11.sp,
                                  color: Get.theme.tabPanelSelectedColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.w),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${item.awayTeamScore}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: isIPad ? 15.sp : 11.sp,
                                  color: Get.theme.tabPanelSelectedColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: Get.theme.betPanelUnderlineColor,
                        ),
                        left: BorderSide(
                          width: 1,
                          color: Get.theme.betPanelUnderlineColor,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _teamNameCell(item.homeTeamName),
                        SizedBox(height: 4.w),
                        _teamNameCell(item.awayTeamName),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _resultCell(
                  controller.resultFilter(
                    'resultwinlose',
                    item.result.toInt(),
                  ),
                  controller.getWinResultTextColor(
                    controller.getWinResultStr(item.result),
                  ),
                ),
                _resultCell(
                  controller.resultFilter(
                    'resultwinlose',
                    item.handicapResult.toInt(),
                  ),
                  controller.getWinResultTextColor(
                    controller.getWinResultStr1(item.handicapResult),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      controller.resultFilter(
                        'overunderLabel',
                        item.overunderResult.toInt(),
                      ),
                      style: TextStyle(
                        fontSize: isIPad ? 15.sp : 11.sp,
                        color: controller.getWinResultTextColor(
                          controller.getWinResultStr2(item.overunderResult),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamNameCell(String name) {
    final isCurrentTeam = name == teamName;
    return Container(
      padding: EdgeInsets.only(left: 4.w),
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: isIPad ? 15.sp : 11.sp,
          fontWeight: isCurrentTeam ? FontWeight.w600 : FontWeight.w300,
          color: Get.theme.tabPanelSelectedColor,
        ),
      ),
    );
  }

  Widget _resultCell(String text, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1,
              color: Get.theme.betPanelUnderlineColor,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: color,
          ),
        ),
      ),
    );
  }
}
