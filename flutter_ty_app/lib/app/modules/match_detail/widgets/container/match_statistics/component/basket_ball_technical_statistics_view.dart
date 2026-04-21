import 'dart:core';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/analyze_header_widget.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_statistic_controller.dart';
import 'package:flutter_ty_app/app/widgets/empty/text_no_data.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../models/analysis/analysis_model.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 篮球】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球技术统计
    】】】
 *
 */
//
class BasketBallTechnicalStatisticsView extends StatelessWidget {
  BasketBallTechnicalStatisticsView({required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchStatisticController>(
        tag: tag,
        builder: (controller) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            child: ListView(
              children: [
                buildMatchHead(),
                buildBasketBallTechnicalStatisticsList(controller),
                SizedBox(
                  height: 80.w,
                )
              ],
            ),
          );
        });
  }

  // 设置赛事头信息
  Widget buildMatchHead() {
    return Container(
      height: 57.w,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          gradient: LinearGradient(
            colors: [
              MatchStatisticMatchHistoryState.headerGradientColor1
                  .withValues(alpha: MatchStatisticMatchHistoryState.headerGradientAlpha),
              MatchStatisticMatchHistoryState.headerGradientColor2
                  .withValues(alpha: MatchStatisticMatchHistoryState.headerGradientAlpha),
              MatchStatisticMatchHistoryState.headerGradientColor3
                  .withValues(alpha: MatchStatisticMatchHistoryState.headerGradientAlpha),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: AnalyzeHeaderWidget(
        tag: tag,
        showCenter: true,
      ),
    );
  }

  /**
   * 篮球技术统计- 队伍统计
   */
  buildBasketBallTechnicalStatisticsList(MatchStatisticController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Container(
            height: 40.w,
            alignment: Alignment.centerLeft,
            child: Text(
              "队伍统计数据",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Get.theme.oddsButtonValueFontColor,
                  fontWeight: FontWeight.w600),
            ),
          ),
          controller.state.technicalPBUIBeans.isEmpty
              ? TextNoData()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.state.technicalPBUIBeans.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  //列表项构造器
                  itemBuilder: (BuildContext context, int index) {
                    return buildHistoryWarListItem(
                        controller.state.technicalPBUIBeans[index]);
                  },
                )
        ],
      ),
    );
  }
  /**
   * 篮球技术统计- 近期战役
   */
  buildHistoryWarListItem(TechnicalPBUIBean entity) {
    return Container(
      height: 40.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 31.w,
            height: 20.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
                color: MatchStatisticMatchHistoryState.primaryColor),
            alignment: Alignment.center,
            child: Text(
              entity.leftValue ?? "",
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.topCenter,
            child: Text(
              entity.centerName ?? "",
              style: TextStyle(
                  fontSize: 12.sp,
                  color: MatchStatisticMatchHistoryState.technicalStatisticsTextColor),
            ),
          )),
          Container(
            width: 31.w,
            height: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
                color: MatchStatisticMatchHistoryState.technicalStatisticsMarkerColor),
            child: Text(
              entity.rightValue ?? "",
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
