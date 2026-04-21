import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../models/analysis/analysis_model.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球阵容图】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 历史表现-Item数据
    】】】
 *
 */
class MatchStatic2ItemChartItem1 extends StatelessWidget {
  final GridListDataBean gridListDataBean;

  MatchStatic2ItemChartItem1(this.gridListDataBean, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
                "${gridListDataBean.name1}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: isIPad ? 15.sp : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 25.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: gridListDataBean.name2.map((e) {
                  return breakColor(e, true);
                }).toList(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    gridListDataBean.name4,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: isIPad ? 15.sp : 11.sp,
                        fontWeight: FontWeight.w700,
                        color: Get.theme.tabPanelSelectedColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container breakColor(num e, bool type) {
    String data = "";

    data = switchOverunderLabelCode(e);
    Color color = MatchStatisticMatchHistoryState.matchResultLossColor;
    Text widget = Text(LocaleKeys.analysis_football_matches_level.tr);
    if (e == 0) {
      color = MatchStatisticMatchHistoryState.matchResultWinColor;
    } else if (e == 1) {
      color = MatchStatisticMatchHistoryState.matchResultDrawColor;
    } else if (e == 2) {
      color = MatchStatisticMatchHistoryState.matchResultLossColor;
    } else if (e == 4) {}

    widget = Text(data,
        style: TextStyle(
            color: Colors.white,
            fontSize: isIPad ? 14.sp : 10.sp,
            height: 1,
            fontWeight: FontWeight.w500));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(4.w))),
      child: widget,
    );
  }

  String switchResultLabelCode(num value) {
    switch (value) {
      case 2:
        return LocaleKeys.analysis_football_matches_level.tr;
      case 3:
        return LocaleKeys.analysis_football_matches_small.tr;
      case 4:
        return LocaleKeys.analysis_football_matches_big.tr;
      default:
        return LocaleKeys.ouzhou_no_data_no_data.tr;
    }
  }

  String switchOverunderLabelCode(num value) {
    switch (value) {
      case 0:
        return LocaleKeys.analysis_victory.tr;
      case 1:
        return LocaleKeys.analysis_flat.tr;
      case 2:
        return LocaleKeys.analysis_negative.tr;
      // return LocaleKeys.analysis_football_matches_lose.tr;
      default:
        return "";
    }
  }
}
