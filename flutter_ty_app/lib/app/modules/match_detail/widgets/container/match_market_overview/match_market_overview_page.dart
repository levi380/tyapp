
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/box_shadow_container.dart';
import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../login/login_head_import.dart';
import '../../common_widget/tabs/analysis_tab.dart';
import '../../common_widget/tabs/analysis_tab_bar.dart';
import '../../common_widget/tabs/analysis_tab_bar_view.dart';
import '../../../controllers/match_market_overview_logic.dart';
import '../../../states/match_market_overview_state.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面 （走势  预期分析 赛事文章 ）
    】】】
 *
 */
class MatchMarketOverview extends StatelessWidget {
  MatchMarketOverview({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
      tag: tag,
      init: AnalyzeMarketOverviewLogic(tag: tag),
      builder: (controller) {
        return BoxShadowContainer(
          padding: EdgeInsets.zero,
          color: Get.theme.detailBackgroundColor,
          margin: EdgeInsets.only(
            top: MatchMarketOverviewState.pageTopMargin.w,
            left: MatchMarketOverviewState.pageHorizontalMargin.w,
            right: MatchMarketOverviewState.pageHorizontalMargin.w,
          ),
          child: Column(
            children: [
              _tabView(controller),
              if(controller.state.tabs.isNotEmpty)
              AnalyzeDivider(
                bgColor: MatchMarketOverviewState.dividerBackgroundColor,
              ),
              Expanded(
                child: AnalysisTabBarView(
                  controller: controller.state.tabController,
                  children:
                      controller.state.tabs.map((e) => e.childBuilder(tag)).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  Widget _tabView(AnalyzeMarketOverviewLogic controller) {
    if (controller.state.tabController == null) {
      return Container();
    }
    if(controller.state.tabs.isEmpty) {
      return NoData(
        top: MatchMarketOverviewState.noDataTopSpacing.h,
        content: LocaleKeys.common_no_data.tr,
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MatchMarketOverviewState.tabHorizontalMargin.w,
        vertical: MatchMarketOverviewState.tabVerticalMargin.h,
      ),
      child: AnalysisTabBar(
        onTap: (index) {
          controller.state.tabs[index].fetchData?.call();
        },
        tabs: controller.state.tabs.map((e) => AnalysisTab(text: e.title)).toList(),
        controller: controller.state.tabController,
        showIndicator: true,
        autoIndicatorWidth: true,
        isScrollable: true,
        indicatorHeight: MatchMarketOverviewState.tabIndicatorHeight.h,
        height: MatchMarketOverviewState.tabHeight.h,
        indicatorColor: AppColor.colorSelectBorder,
        dividerHeight: 0,
        labelPadding: EdgeInsets.symmetric(
          horizontal: MatchMarketOverviewState.tabLabelPadding.w,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColor.normalHintTextColor,
          fontSize: MatchMarketOverviewState.tabFontSize.sp,
          fontWeight: FontWeight.w500,
        ),
        labelColor: AppColor.colorSelectBorder,
      ),
    );
  }
}
