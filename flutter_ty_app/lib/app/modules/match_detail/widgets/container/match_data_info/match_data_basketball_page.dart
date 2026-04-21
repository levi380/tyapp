
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/box_shadow_container.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import '../../../../login/login_head_import.dart';
import '../../common_widget/tabs/analysis_tab.dart';
import '../../common_widget/tabs/analysis_tab_bar.dart';
import '../../common_widget/tabs/analysis_tab_bar_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球数据控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据  篮球页面
    】】】
 *
 */
class MatchDataBasketballPage extends StatelessWidget {
  MatchDataBasketballPage({super.key, required this.tag}) {}
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDataController>(
      tag: tag,
      init: MatchDataController(tag: tag),
      builder: (controller) {
        final state = controller.state;
        return BoxShadowContainer(
          padding: EdgeInsets.only(bottom: MatchDataState.basketballPageBottomPadding.h),
          margin: EdgeInsets.symmetric(
            horizontal: MatchDataState.basketballPageHorizontalMargin.w,
            vertical: MatchDataState.basketballPageVerticalMargin.h,
          ),
          color: Get.theme.tabPanelBackgroundColor,
          child: Column(
            children: [
              _tabView(controller),
              Expanded(
                child: AnalysisTabBarView(
                  controller: state.tabController,
                  children: state.basketballTabs
                      .map((e) => e.childBuilder(tag))
                      .toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _tabView(MatchDataController controller) {
    final state = controller.state;
    if (state.basketballTabs.isEmpty) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MatchDataState.basketballTabHorizontalMargin.w,
        vertical: MatchDataState.basketballTabVerticalMargin.h,
      ),
      child: AnalysisTabBar(
        onTap: (index) {
          state.basketballTabs[index].fetchData?.call();
        },
        tabs: state.basketballTabs
            .map((e) => AnalysisTab(text: e.title))
            .toList(),
        controller: state.tabController,
        showIndicator: true,
        autoIndicatorWidth: true,
        isScrollable: true,
        indicatorHeight: MatchDataState.basketballTabIndicatorHeight.h,
        height: MatchDataState.basketballTabHeight.h,
        indicatorColor: AppColor.colorSelectBorder,
        dividerHeight: 0,
        labelPadding: EdgeInsets.symmetric(
          horizontal: MatchDataState.basketballTabLabelPadding.w,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColor.normalHintTextColor,
          fontSize: MatchDataState.basketballTabFontSize.sp,
          fontWeight: MatchDataState.basketballTabFontWeight,
        ),
        labelColor: AppColor.colorSelectBorder,
      ),
    );
  }
}
