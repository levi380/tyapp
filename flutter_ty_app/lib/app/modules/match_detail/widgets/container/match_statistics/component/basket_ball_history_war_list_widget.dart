import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/app/widgets/empty/text_no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../../login/login_head_import.dart';
import 'basket_ball_history_war_item_widget.dart';

/// 篮球历史交战列表组件
/// 用于显示历史交战记录的列表，包括列表头部和列表项
class BasketBallHistoryWarListWidget {
  /// 构建历史交战列表
  /// [controller] 赛季统计控制器，包含历史交战数据
  /// [tag] 控制器标签
  /// 返回包含列表头部和列表项的列组件，如果数据为空则显示无数据提示
  static Widget build({
    required SeasonStatisticController controller,
    required String tag,
  }) {
    return GetBuilder<SeasonStatisticController>(
      id: "buildHistoryWarList",
      tag: tag,
      builder: (controller) {
        if (controller.state.analyzeTeamsList.isEmpty) {
          return TextNoData(
            content: LocaleKeys.analysis_football_matches_no_data.tr,
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Get.theme.betPanelUnderlineColor,
              ),
            ),
          ),
          child: Column(
            children: [
              _buildListItems(controller),
            ],
          ),
        );
      },
    );
  }

  /// 构建列表项
  /// [controller] 赛季统计控制器
  /// 返回包含所有列表项的ListView
  static Widget _buildListItems(SeasonStatisticController controller) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      scrollDirection: Axis.vertical,
      itemCount: controller.state.analyzeTeamsList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return BasketBallHistoryWarItemWidget.build(
          controller.state.analyzeTeamsList[index],
          controller,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return AnalyzeDivider();
      },
    );
  }
}

