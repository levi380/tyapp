import 'package:common_utils/common_utils.dart' show ObjectUtil;

import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import '../../../../../../services/models/res/statistics_team_vs_other_team_entity.dart';
import '../../../../controllers/match_detail_controller.dart';
import '../../../../controllers/match_tools_methods.dart';
import '../../../../controllers/statistic/season_statistic_controller.dart';
import 'season_statistic_select_tab.dart';
import '../widget/recent_war_list_head.dart';
import '../widget/recent_war_list_item.dart';
import '../widget/recent_war_expand_button.dart';

/// 赛季统计近期战绩组件
/// 用于展示球队的近期对战记录，包括比赛日期、队伍名称、比分等信息
class SeasonStatisticRecentWar {
  /// 构建近期战绩整体视图
  /// [controller] 赛季统计控制器，包含主/客队切换、展开状态及近期战绩数据
  /// 返回：选择标签 + 表头 + 列表主体（含展开按钮）
  static Widget buildRecentWar(SeasonStatisticController controller) {
    return Column(
      children: [
        SeasonStatisticSelectTab.buildSelectTab(controller),
        const RecentWarListHead(),
        buildMatchBodyRecentWarList(controller),
        12.verticalSpace
      ],
    );
  }

  /// 构建近期战绩列表主体
  /// [controller] 赛季统计控制器
  /// 根据选择的队伍（主队/客队）显示对应的近期战绩列表
  /// 返回包含列表项和展开/收起按钮的列组件
  static Widget buildMatchBodyRecentWarList(
      SeasonStatisticController controller) {
    final state = controller.state;
    List<StatisticsTeamVsOtherTeam> teamList = [];

    // 根据选择的队伍索引获取对应的数据列表
    if (state.selectTeamIndex.value == 0) {
      teamList = controller.state.home;
    } else {
      teamList = controller.state.away;
    }

    // 如果列表为空，返回空容器
    if (teamList.isEmpty) {
      return Container();
    }

    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: controller.tag);

    return Column(
      children: [
        _buildRecentWarListItems(controller, teamList, detailController),
        _buildExpandButton(controller, teamList),
      ],
    );
  }

  /// 构建近期战绩列表项
  /// [controller] 赛季统计控制器
  /// [teamList] 队伍列表数据
  /// [detailController] 赛事详情控制器
  /// 返回包含所有列表项的ListView
  static Widget _buildRecentWarListItems(
      SeasonStatisticController controller,
      List<StatisticsTeamVsOtherTeam> teamList,
      MatchDetailController detailController) {
    return Container(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.expand1
            ? teamList.length
            : (teamList.length > 5 ? 5 : teamList.length),
        separatorBuilder: (context, index) {
          return AnalyzeDivider();
        },
        itemBuilder: (context, index) {
          return _buildRecentWarListItem(
              controller, teamList, detailController, index);
        },
      ),
    );
  }

  /// 构建单个近期战绩列表项
  /// [controller] 赛季统计控制器
  /// [teamList] 队伍列表数据
  /// [detailController] 赛事详情控制器
  /// [index] 列表项索引
  /// 返回单个比赛记录的列表项
  static Widget _buildRecentWarListItem(
      SeasonStatisticController controller,
      List<StatisticsTeamVsOtherTeam> teamList,
      MatchDetailController detailController,
      int index) {
    String? url = detailController.detailState.match?.mhlu[0];
    String? url1 = ObjectUtil.isNotEmpty(
            (detailController.detailState.match?.malu as List).safeFirst)
        ? (detailController.detailState.match?.malu as List).safeFirst
        : 'assets/images/detail/default_team_away.svg';

    return buildMatchPageItemRecentWarListItem(
      teamList.length,
      detailController,
      teamList[index],
      leftTeam1: getTeamName(type: 1, match: detailController.detailState.match),
      leftUrl: url,
      leftNumber: "$index",
      rightTeam1: getTeamName(type: 2, match: detailController.detailState.match),
      rightUrl: url1,
      rightNumber: "$index",
    );
  }

  /// 构建展开/收起按钮（仅当 teamList.length > 5 时显示）
  static Widget _buildExpandButton(
      SeasonStatisticController controller, List<StatisticsTeamVsOtherTeam> teamList) {
    if (teamList.isEmpty || teamList.length <= 5) {
      return const SizedBox.shrink();
    }
    return RecentWarExpandButton(
      isExpanded: controller.expand1,
      onToggle: controller.switchExpand,
    );
  }

  /// 构建单行近期战绩项，并委托给 [RecentWarListItem]
  /// 从 detailController 取主客队名与图标 URL，用于与 item 主客队对齐
  static Widget buildMatchPageItemRecentWarListItem(
      int i,
      MatchDetailController detailController,
      StatisticsTeamVsOtherTeam item,
      {String? leftTeam1,
      String? leftUrl,
      String? leftNumber,
      String? rightTeam1,
      String? rightUrl,
      String? rightNumber}) {
    return RecentWarListItem(
      item: item,
      leftTeam1: leftTeam1,
      leftUrl: leftUrl,
      rightUrl: rightUrl,
    );
  }
}

