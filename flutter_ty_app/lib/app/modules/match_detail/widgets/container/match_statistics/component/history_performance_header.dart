import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import '../../../../controllers/match_detail_controller.dart';
import '../../../../controllers/match_tools_methods.dart';
import '../../../../controllers/statistic/history_performance_controller.dart';
import 'history_performance_team_image.dart';

/// 历史表现头部组件
/// 包含头部主体和头部图片的构建逻辑
class HistoryPerformanceHeader {
  /// 构建头部主体容器
  /// 
  /// [controller] 历史表现控制器，包含当前选中的标签页索引和排名信息
  /// [tag] 赛事标识
  /// [isElectronicFootball] 是否为电子足球
  /// 
  /// 返回包含队伍信息、排名和联赛名称的头部容器 Widget
  static Widget buildHeadBody(
    HistoryPerformanceController controller,
    String tag,
    bool isElectronicFootball,
  )
  {
    MatchDetailController matchDetailController =
        Get.find<MatchDetailController>(tag: tag);
    return Container(
      height: 71.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: controller.tabIndex == 0
          ? BoxDecoration(
              gradient: LinearGradient(colors: [
              MatchStatisticMatchHistoryState.historyPerformanceHeaderGradient1Start,
              MatchStatisticMatchHistoryState.historyPerformanceHeaderGradient1End,
            ]))
          : BoxDecoration(
              gradient: LinearGradient(colors: [
              MatchStatisticMatchHistoryState.historyPerformanceHeaderGradient2Start,
              MatchStatisticMatchHistoryState.historyPerformanceHeaderGradient2End,
            ])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HistoryPerformanceTeamImage(controller: controller, tag: tag),
          SizedBox(
            width: 16.w,
          ),
          // 队伍信息
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 队伍名称
              Text(
                getTeamName(
                    type: controller.tabIndex == 0 ? 1 : 2,
                    match: matchDetailController.detailState.match),
                style: TextStyle(
                    fontSize: 14.w,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.titleBlack),
              ),
              // 排名信息（仅非电子足球显示）
              if (!isElectronicFootball) ...[
                SizedBox(
                  height: 2.w,
                ),
                Text(
                  "${LocaleKeys.analysis_k_ranking.tr} ${controller.rank}",
                  style: TextStyle(
                      fontSize: 12.w,
                      fontWeight: FontWeight.w400,
                      color: Get.theme.betItemTextColor2),
                ),
              ],
              SizedBox(
                height: 2.w,
              ),
              // 联赛名称
              Text(
                "${matchDetailController.detailState.match?.tn ?? ""}",
                style: TextStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    color: Get.theme.betItemTextColor2),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 构建头部主体（简化版，仅队伍图标 + 队伍名称）
  /// 用于需要紧凑布局的场景；[tabIndex] 显式指定主队(0)或客队(1)，覆盖 controller.tabIndex
  static Widget buildHeadBody1(
      HistoryPerformanceController controller,
      String tag,
      bool isElectronicFootball,
      int tabIndex,
      ) {
    MatchDetailController matchDetailController =
        Get.find<MatchDetailController>(tag: tag);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HistoryPerformanceTeamImage(
            controller: controller,
            tag: tag,
            tabIndex: tabIndex,
          ),
          SizedBox(
            width: 16.w,
          ),
          // 队伍信息
          Text(
            getTeamName(
                type:tabIndex == 0 ? 1 : 2,
                match: matchDetailController.detailState.match),
            style: TextStyle(
                fontSize: 14.w,
                fontWeight: FontWeight.w700,
                color: Get.theme.titleBlack),
          ),
        ],
      ),
    );
  }


}

