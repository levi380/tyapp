
import 'package:flutter_ty_app/app/utils/change_skin_tone_color_util.dart';
import '../../../../login/login_head_import.dart';
import '../../../controllers/match_cup_point_controller.dart';
import '../../../states/match_cup_point_state.dart';
import '../../common_widget/tabs/analysis_tab.dart';
import '../../common_widget/tabs/analysis_tab_bar.dart';
import '../../common_widget/tabs/analysis_tab_bar_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 杯赛积分Page
    - 杯赛积分Button切换
    - 杯赛积分 (足球、 篮球)
    】】】
 *
 */
class MatchCupPage extends StatelessWidget {
  MatchCupPage({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchCupPointController>(
      init: MatchCupPointController(tag: tag),
      tag: tag,
      builder: (controller) {
        final state = controller.state;
        return Container(
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor()
                : Colors.white,
          ),
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(
            top: MatchCupPointState.pageTopMargin.w,
            left: MatchCupPointState.pageHorizontalMargin.w,
            right: MatchCupPointState.pageHorizontalMargin.w,
          ),
          child: Column(
            children: [
              _tabView(controller),
              Expanded(
                child: AnalysisTabBarView(
                  controller: state.tabController,
                  children: state.tabs.map((e) => e.childBuilder(tag)).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _tabView(MatchCupPointController controller) {
    final state = controller.state;
    if (state.tabs.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MatchCupPointState.tabHorizontalMargin.w,
        vertical: MatchCupPointState.tabVerticalMargin.h,
      ),
      child: AnalysisTabBar(
        onTap: (index) {
          state.tabs[index].fetchData?.call();
        },
        tabs: state.tabs.map((e) => AnalysisTab(text: e.title)).toList(),
        controller: state.tabController,
        showIndicator: true,
        autoIndicatorWidth: true,
        isScrollable: true,
        indicatorHeight: MatchCupPointState.tabIndicatorHeight.h,
        height: MatchCupPointState.tabHeight.h,
        indicatorColor: AppColor.colorSelectBorder,
        dividerHeight: 0,
        labelPadding: EdgeInsets.symmetric(
          horizontal: MatchCupPointState.tabLabelPadding.w,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColor.normalHintTextColor,
          fontSize: MatchCupPointState.tabFontSize.sp,
          fontWeight: FontWeight.w500,
        ),
        labelColor: AppColor.colorSelectBorder,
      ),
    );
  }
}
