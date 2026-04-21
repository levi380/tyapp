
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../services/models/res/analyze_match_information_entity.dart';
import '../../../../../../widgets/empty/no_data.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../controllers/match_market_overview_logic.dart';
import '../../../../states/match_market_overview_state.dart';
import '../../../common_widget/analysis_common_widget/widget/analyze_header_widget.dart';
import '../widget/match_analyze_child_item.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 预期分析
    】】】
 *
 */
class ExpectedAnalysis extends StatefulWidget {
  const ExpectedAnalysis({super.key, required this.tag});

  final String tag;

  @override
  State<ExpectedAnalysis> createState() => _ExpectedAnalysisState();
}

class _ExpectedAnalysisState extends State<ExpectedAnalysis> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
        id: "buildList1",
        tag: widget.tag,
        builder: (controller) {
          return SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (controller.state.dataList.isNotEmpty) buildHead(),
                controller.state.dataList.isEmpty ? NoData(top: 0) : buildList1(),
              ],
            ),
          );
        });
  }

  Widget buildHead() {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
        id: "buildMatchProgress",
        tag: widget.tag,
        builder: (controller) {
          return Container(
            height: 44.w,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.w)),
                gradient: LinearGradient(
                  colors: [
                    MatchMarketOverviewState.expectedAnalysisHeaderGradientColor1
                        .withValues(alpha: MatchMarketOverviewState.expectedAnalysisHeaderGradientAlpha),
                    MatchMarketOverviewState.expectedAnalysisHeaderGradientColor2
                        .withValues(alpha: MatchMarketOverviewState.expectedAnalysisHeaderGradientAlpha),
                    MatchMarketOverviewState.expectedAnalysisHeaderGradientColor3
                        .withValues(alpha: MatchMarketOverviewState.expectedAnalysisHeaderGradientAlpha),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
            child: AnalyzeHeaderWidget(tag: controller.tag),
          );
        });
  }

  buildList1() {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
      id: "buildList1",
      tag: widget.tag,
      builder: (controller) {
        return Container(
          color: controller.state.dataList.isEmpty
              ? Colors.transparent
              : Get.theme.tabPanelBackgroundColor,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            scrollDirection: Axis.vertical,
            itemCount: controller.state.dataList.length,
            shrinkWrap: true,
            //列表项构造器
            itemBuilder: (BuildContext context, int index) {
              AnalyzeMatchInformationEntity e = controller.state.dataList[index];
              return MatchMarketItem(index, e);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox();
            },
          ),
        );
      },
    );
  }
}
