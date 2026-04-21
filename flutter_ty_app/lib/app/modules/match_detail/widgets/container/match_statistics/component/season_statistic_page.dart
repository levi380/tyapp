
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../../../widgets/empty/no_data.dart';
import '../../../../controllers/match_detail_controller.dart';
import '../../../../controllers/match_tools_methods.dart';
import '../../../../controllers/statistic/season_statistic_controller.dart';
import '../../../../states/season_statistic_state.dart';
import 'season_statistic_data_grid.dart';
import 'season_statistic_recent_war.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球 本赛季数据
    】】】
 *
 */
class SeasonStatisticPage extends StatefulWidget {
  SeasonStatisticPage({Key? key, required this.tag}) : super(key: key);
  final String tag;

  @override
  State<SeasonStatisticPage> createState() => _SeasonStatisticPageState();
}

class _SeasonStatisticPageState extends State<SeasonStatisticPage> {
  /// 构建主页面视图
  /// 根据控制器状态展示数据网格和近期战绩
  /// 如果数据为空则显示无数据提示
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SeasonStatisticController>(
      tag: widget.tag,
      init: SeasonStatisticController(tag: widget.tag),
      builder: (controller) {
        MatchDetailController detailController =
            Get.find<MatchDetailController>(tag: controller.tag);

        // 如果数据为空，显示无数据提示
        if (controller.isShowTopEmpty) {
          return NoData(
            top: SeasonStatisticState.noDataTopSpacing.w,
            content: LocaleKeys.common_no_network.tr,
          ).center;
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SeasonStatisticState.pageHorizontalPadding.w,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildSeasonTitle(detailController),
              SeasonStatisticDataGrid.buildDataGrid(controller),
              SeasonStatisticRecentWar.buildRecentWar(controller),
            ],
          ),
        );
      },
    );
  }

  /// 构建赛季标题
  /// [detailController] 赛事详情控制器，用于获取队伍名称
  /// 返回显示当前赛季信息的文本组件
  Widget _buildSeasonTitle(MatchDetailController detailController) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SeasonStatisticState.seasonTitleVerticalPadding.w,
          horizontal: SeasonStatisticState.seasonTitleHorizontalPadding.w,
        ),
        child: Text(
          LocaleKeys.analysis_current_season.tr
              .replaceFirst(
                  "%",
                  getTeamName(
                      type: 1, match: detailController.detailState.match))
              .replaceFirst(
                  "%",
                  getTeamName(
                      type: 2, match: detailController.detailState.match),
                  1),
          style: TextStyle(
            color: Get.theme.orderDateTextColor,
            fontSize: SeasonStatisticState.seasonTitleFontSize.sp,
          ),
        ),
      ),
    );
  }

}
