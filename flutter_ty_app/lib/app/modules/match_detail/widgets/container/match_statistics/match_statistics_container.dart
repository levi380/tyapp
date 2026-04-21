
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/box_shadow_container.dart';
import '../../../../login/login_head_import.dart';
import '../../common_widget/tabs/analysis_tab.dart';
import '../../common_widget/tabs/analysis_tab_bar.dart';
import '../../common_widget/tabs/analysis_tab_bar_view.dart';
import '../../../controllers/match_statistic_controller.dart';
import '../../../states/match_statistic_state.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 统计 - 足球、篮球
    】】】
 *
 */
class MatchStatisticsContainer extends StatelessWidget {
  MatchStatisticsContainer({super.key, required this.tag});

  final String tag;

  /// 构建统计容器UI
  /// 显示tab视图和对应的内容
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchStatisticController>(
        tag: tag,
        init: MatchStatisticController(tag: tag),
        builder: (controller) {
          final state = controller.state;
          return BoxShadowContainer(
            padding: EdgeInsets.zero,
            color: Get.theme.tabPanelBackgroundColor,
            margin: EdgeInsets.only(
              top: MatchStatisticMatchHistoryState.pageTopMargin.w,
              left: MatchStatisticMatchHistoryState.pageHorizontalMargin.w,
              right: MatchStatisticMatchHistoryState.pageHorizontalMargin.w,
            ),
            child: Column(
              children: [
                _tabView(controller),
                Expanded(
                  child: AnalysisTabBarView(
                    controller: controller.state.tabController,
                    children: state.tabs.map((e) => e.childBuilder(tag)).toList(),
                  ),
                )
              ],
            ),
          );
        });
  }

  /// 构建tab视图
  /// [controller] 统计控制器
  Widget _tabView(MatchStatisticController controller) {
    final state = controller.state;
    if (state.tabs.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MatchStatisticMatchHistoryState.tabHorizontalMargin.w,
        vertical: MatchStatisticMatchHistoryState.tabVerticalMargin.h,
      ),
      child: AnalysisTabBar(
        onTap: (index) {
          state.tabs[index].fetchData?.call();
        },
        tabs: state.tabs.map((e) => AnalysisTab(text: e.title)).toList(),
        controller: controller.state.tabController,
        showIndicator: true,
        autoIndicatorWidth: true,
        isScrollable: true,
        indicatorHeight: MatchStatisticMatchHistoryState.tabIndicatorHeight.h,
        height: MatchStatisticMatchHistoryState.tabHeight.h,
        indicatorColor: AppColor.colorSelectBorder,
        dividerHeight: 0,
        labelPadding: EdgeInsets.symmetric(
          horizontal: MatchStatisticMatchHistoryState.tabLabelPadding.w,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColor.normalHintTextColor,
          fontSize: MatchStatisticMatchHistoryState.tabFontSize.sp,
          fontWeight: FontWeight.w500,
        ),
        labelColor: AppColor.colorSelectBorder,
      ),
    );
  }
}
