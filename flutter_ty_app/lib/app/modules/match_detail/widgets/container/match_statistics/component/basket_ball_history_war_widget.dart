import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../login/login_head_import.dart';
import 'basket_ball_history_war_header_widget.dart';
import 'basket_ball_team_info_widget.dart';
import 'basket_ball_history_war_list_head_widget.dart';
import 'basket_ball_history_war_list_widget.dart';

/// 篮球历史交战整体组件
/// 用于组合历史交战相关的所有子组件，包括头部、队伍信息、列表头部和列表
class BasketBallHistoryWarWidget {
  /// 构建历史交战整体视图
  /// [controller] 赛季统计控制器，包含历史交战数据
  /// [tag] 控制器标签，用于获取MatchDetailController
  /// 返回包含所有历史交战相关组件的列组件
  static Widget build({
    required SeasonStatisticController controller,
    required String tag,
  }) {
    return Column(
      children: [
        BasketBallHistoryWarHeaderWidget.build(
          name: LocaleKeys.analysis_football_matches_historical_war.tr,
          controller: controller,
        ),
        SizedBox(height: 12.w),
        BasketBallTeamInfoWidget.build(
          controller: controller,
          tag: tag,
        ),
        AnalyzeDivider(),
        BasketBallHistoryWarListHeadWidget.build(),
        BasketBallHistoryWarListWidget.build(
          controller: controller,
          tag: tag,
        ),
      ],
    );
  }
}

