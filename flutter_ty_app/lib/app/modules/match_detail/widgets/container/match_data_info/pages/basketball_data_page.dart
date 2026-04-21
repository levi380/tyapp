import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';

import '../../../../../login/login_head_import.dart';
import '../../../../controllers/match_data_controller.dart';
import '../../../common_widget/analysis_common_widget/widget/analyze_header_widget.dart';
import '../../../common_widget/analysis_common_widget/widget/matchline_progress_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE  篮球重点数据页面】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  篮球重点数据
    - 数据初始化
    - 篮球足球切换
    】】】
 *
 */
class BasketballDataPage extends StatelessWidget {
  const BasketballDataPage({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDataController>(
        tag: tag,
        builder: (controller) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                buildMatchHead(),
                buildMatchInformation(controller),
                buildMatchProgress(controller),
              ],
            ),
          );
        });
  }

  Widget buildMatchHead() {
    return Container(
      height: 57.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          gradient: LinearGradient(
            colors: [
              MatchDataState.headerGradientColor1.withValues(alpha: MatchDataState.headerGradientAlpha),
              MatchDataState.headerGradientColor2.withValues(alpha: MatchDataState.headerGradientAlpha),
              MatchDataState.headerGradientColor3.withValues(alpha: MatchDataState.headerGradientAlpha),
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

  buildMatchInformation(MatchDataController controller) {
    if (controller.state.basketballFreeThrowsResultList.length < 2) {
      return SizedBox();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 8.w),
      child: Row(
        children: [
          Row(
            children: [
              Column(
                children: [
                  ImageView(
                    'assets/images/icon_event_right.png',
                    width: 14.w,
                    height: 14.w,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text(
                    "${controller.state.basketballFreeThrowsResultList[0].home.toInt()}",
                    style: TextStyle(
                        fontSize: MatchDataState.basketballDataPageTextFontSize.sp, color: Get.theme.betItemTitleColor),
                  )
                ],
              ),
              SizedBox(
                width: 32.w,
              ),
              Column(
                children: [
                  ImageView(
                    'assets/images/icon_event_left.png',
                    width: 14.w,
                    height: 14.w,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text(
                    "${controller.state.basketballFreeThrowsResultList[1].home.toInt()}",
                    style: TextStyle(
                        fontSize: MatchDataState.basketballDataPageTextFontSize.sp, color: Get.theme.betItemTitleColor),
                  )
                ],
              )
            ],
          ),
          Spacer(),
          Row(
            children: [
              Column(
                children: [
                  ImageView(
                    'assets/images/icon_event_right.png',
                    width: 14.w,
                    height: 14.w,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text(
                    "${controller.state.basketballFreeThrowsResultList[0].away.toInt()}",
                    style: TextStyle(
                        fontSize: MatchDataState.basketballDataPageTextFontSize.sp, color: Get.theme.betItemTitleColor),
                  )
                ],
              ),
              SizedBox(
                width: 32.w,
              ),
              Column(
                children: [
                  ImageView(
                    'assets/images/icon_event_left.png',
                    width: 14.w,
                    height: 14.w,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text(
                    "${controller.state.basketballFreeThrowsResultList[1].away.toInt()}",
                    style: TextStyle(
                        fontSize: MatchDataState.basketballDataPageTextFontSize.sp, color: Get.theme.betItemTitleColor),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  buildMatchProgress(MatchDataController controller) {
    final state = controller.state;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Column(
            children: controller.state.three.map((e) {
              int total = e.home.toInt() + e.away.toInt();
              return MatchLineProgressView(e.homeAlias ?? "", e.awayAlias ?? "",
                  leftProgress:
                      e.homeAliasValue ?? (e.home > 0 ? (e.home / total) : 0),
                  rightProgress:
                      e.awayAliasValue ?? (e.away > 0 ? (e.away / total) : 0),
                  // leftProgress:0,
                  // rightProgress:0,
                  leftColor: state.manColor,
                  rightColor: state.awayColor,
                  leftBackgroundColor: Colors.black26,
                  rightBackgroundColor: Colors.black26,
                  width: 54.w,
                  height: 54.w,
                  centerContent: e.title);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
