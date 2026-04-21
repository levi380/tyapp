

import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/new_analyze_tab_bar.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/basketball_battle_array_map.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/basketball_battle_array_player_list.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_statistics/analyze_battle_array/widget/basketball_battle_array_footer.dart';
import '../../../../controllers/statistic/battle_array_controller.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../states/battle_array_state.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 阵容页面-篮球
    】】】
 *
 */
class BasketballBattleArrayPage extends StatefulWidget {
  BasketballBattleArrayPage({Key? key, required this.tag}) : super(key: key);
  final String tag;

  @override
  State<BasketballBattleArrayPage> createState() =>
      _BasketballBattleArrayPageState();
}

class _BasketballBattleArrayPageState extends State<BasketballBattleArrayPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BattleArrayController>(
      tag: widget.tag,
      init: BattleArrayController(tag: widget.tag),
      builder: (controller) {
        return Column(
          children: [
            _buildTab(controller),
            SizedBox(
              height: BattleArrayState.basketballTabBottomSpacing.w,
            ),
            Expanded(
              child: TabBarView(
                controller: controller.state.tabController,
                children: controller.state.teamsNames
                    .map((e) => buildContent(controller))
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  /**
   * 阵容页面-篮球-切换Tab
   * 构建主队/客队切换标签栏
   */
  Widget _buildTab(BattleArrayController controller) {
    List<String> _tabs = controller.state.teamsNames;
    return NewAnalyzeTabBar(
      _tabs,
      controller.state.tabController,
      widgetWidth: ScreenUtil().screenWidth * BattleArrayState.basketballTabWidthRatio,
      widgetHeight: BattleArrayState.basketballTabHeight.w,
    );
  }

  /**
   * 阵容页面-篮球-内容Content
   * 构建主要内容区域，包括阵容图、球员列表和底部按钮
   */
  Widget buildContent(BattleArrayController controller) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 阵容图
        BasketballBattleArrayMap(controller: controller),
        // 阵容列表（展开时显示）
        if (controller.state.expand)
          BasketballBattleArrayPlayerList(controller: controller),
        // 底部展开/收起按钮
        BasketballBattleArrayFooter(controller: controller),
        SizedBox(
          height: BattleArrayState.basketballBottomSpacing.w,
        ),
      ],
    );
  }

}
