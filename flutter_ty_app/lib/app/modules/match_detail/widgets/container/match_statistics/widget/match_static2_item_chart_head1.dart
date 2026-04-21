import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 历史数据-列表头部
    】】】
 *
 */
class MatchStatic2ItemChartHead extends StatelessWidget {
  MatchStatic2ItemChartHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Get.theme.betViewBackgroundColor),
      height: 25.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_state_table.tr,
                style: TextStyle(
                    fontSize: isIPad
                        ? MatchStatisticMatchHistoryState.chartHeadFontSizeIPad.sp
                        : MatchStatisticMatchHistoryState.chartHeadFontSize.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_football_matches_last_5_matches.tr,
                  style: TextStyle(
                      fontSize: isIPad ? 15.sp : 11.sp,
                      color: Get.theme.tabPanelSelectedColor),
                )),
          ),

          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_average_goals_per_match.tr,
                style: TextStyle(
                    fontSize: isIPad
                        ? MatchStatisticMatchHistoryState.chartHeadFontSizeIPad.sp
                        : MatchStatisticMatchHistoryState.chartHeadFontSize.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          //  "${LocaleKeys.bet_record_bet_no_status04.tr}/${LocaleKeys.analysis_flat.tr}/${LocaleKeys.bet_record_bet_fail.tr}",
          //锚点 4月份需求  4月份再上
          if(false)
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${LocaleKeys.bet_record_bet_no_status04.tr}",
                    style: TextStyle(
                        fontSize: isIPad ? 15.sp : 11.sp,
                        color: MatchStatisticMatchHistoryState.matchResultWinColor),
                  ),
                  Text("/",
                      style: TextStyle(
                          color: Get
                              .theme.analyzeSecondTabPanelUnSelectedFontColor,
                          fontSize: isIPad ? 14.sp : 10.sp,
                          height: 1,
                          fontWeight: FontWeight.w500)),
                  Text(
                    "${LocaleKeys.analysis_flat.tr}",
                    style: TextStyle(
                        fontSize: isIPad ? 15.sp : 11.sp,
                        color: MatchStatisticMatchHistoryState.matchResultDrawColor),
                  ),
                  Text("/",
                      style: TextStyle(
                          color: Get
                              .theme.analyzeSecondTabPanelUnSelectedFontColor,
                          fontSize: isIPad ? 14.sp : 10.sp,
                          height: 1,
                          fontWeight: FontWeight.w500)),
                  Text(
                    "${LocaleKeys.bet_record_bet_fail.tr}",
                    style: TextStyle(
                        fontSize: isIPad ? 15.sp : 11.sp,
                        color: MatchStatisticMatchHistoryState.matchResultLossColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
