import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/widget/analyze_match_history_recent_card.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../login/login_head_import.dart';
import 'basket_ball_recent_war_header_widget.dart';

/// 篮球近期战绩整体组件
/// 用于展示球队的近期对战记录，包括头部和近期战绩卡片
class BasketBallRecentWarWidget {
  /// 构建近期战绩整体视图
  /// [controller] 赛季统计控制器，包含近期战绩数据
  /// [tag] 控制器标签
  /// 返回包含头部和近期战绩卡片的卡片组件
  static Widget build({
    required SeasonStatisticController controller,
    required String tag,
  }) {
    String team1 = controller.basketBallTeamNameList.isEmpty
        ? ""
        : controller.basketBallTeamNameList[0];
    String team2 = controller.basketBallTeamNameList.isEmpty
        ? ""
        : controller.basketBallTeamNameList[1];

    return Card(
      color: Get.theme.tabPanelBackgroundColor,
      margin: EdgeInsets.only(top: 10.w),
      child: Container(
        color: Get.theme.tabPanelBackgroundColor,
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            BasketBallRecentWarHeaderWidget.build(
              name: LocaleKeys.analysis_football_matches_recent_record.tr,
              controller: controller,
              tag: tag,
            ),
            _buildRecentWarCards(controller, team1, team2),
          ],
        ),
      ),
    );
  }

  /// 构建近期战绩卡片列表
  /// [controller] 赛季统计控制器
  /// [team1] 主队名称
  /// [team2] 客队名称
  /// 返回包含主客队近期战绩卡片的列组件
  static Widget _buildRecentWarCards(
    SeasonStatisticController controller,
    String team1,
    String team2,
  ) {
    return Column(
      children: [
        AnalyzeMatchHistoryRecentCard(
          controller.state.home,
          team1,
          controller.getPlayImage(team1),
          controller.state.homeVSHistoryMap,
          true,
          controller: controller,
        ),
        AnalyzeMatchHistoryRecentCard(
          controller.state.away,
          team2,
          controller.getPlayImage(team2),
          controller.state.awayVSHistoryMap,
          false,
          controller: controller,
        ),
        SizedBox(height: 30.w),
      ],
    );
  }
}

