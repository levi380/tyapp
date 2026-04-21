import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/app/widgets/empty/text_no_data.dart';

import '../../../../../../services/models/res/statistics_team_vs_other_team_entity.dart';
import 'analyze_match_history_recent_card_head.dart';
import 'analyze_match_history_recent_card_item.dart';
import 'analyze_match_history_recent_info_head.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 近期战绩
    】】】
 *
 */
class AnalyzeMatchHistoryRecentCard extends StatelessWidget {
  final List<StatisticsTeamVsOtherTeam> home;
  final Map<String, int> homeVSHistoryMap;
  final String url;
  final String teamName;
  final bool isHome;
  final SeasonStatisticController controller;

  AnalyzeMatchHistoryRecentCard(
    this.home,
    this.teamName,
    this.url,
    this.homeVSHistoryMap,
    this.isHome, {
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnalyzeMatchHistoryRecentInfoHead(
          isHome: isHome,
          teamName: teamName,
          homeVSHistoryMap: homeVSHistoryMap,
          controller: controller,
        ),
        AnalyzeDivider(),
        const AnalyzeMatchHistoryRecentCardHead(),
        _buildRecentHistory(controller),
      ],
    );
  }

  /// 近期战绩列表区域：空数据时显示无数据，否则为分隔列表
  Widget _buildRecentHistory(SeasonStatisticController controller) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Get.theme.betPanelUnderlineColor,
        ))),
        child: Column(
          children: [
            home.isEmpty
                ? TextNoData()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    scrollDirection: Axis.vertical,
                    itemCount: home.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    //列表项构造器

                    itemBuilder: (BuildContext context, int index) {
                      return AnalyzeMatchHistoryRecentCardItem(
                        item: home[index],
                        teamName: teamName,
                        controller: controller,
                      );
                    },
                    //分割器构造器
                    separatorBuilder: (BuildContext context, int index) {
                      return AnalyzeDivider();
                    },
                  )
          ],
        ));
  }

}
