import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import '../../../../../../services/models/res/knockout_info_bean_entity.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球小组赛-杯赛联赛2
    】】】
 *
 */
class EliminateMatchHistoryType2WidgetWidget extends StatelessWidget {
  final KnockoutInfoBeanEntity entity;

  final bool isFirst = true;

  EliminateMatchHistoryType2WidgetWidget(this.entity, {super.key});

  @override
  Widget build(BuildContext context) {
    String scores = entity.scores ?? "";
    List<String> scoreList = [];
    if (scores.isNotEmpty) {
      try {
        scoreList = (jsonDecode(scores) as List).map((e) => "$e").toList();
      } catch (e) {}
    }
    String? rateA1;
    String? rateA2;
    String? rateA3;
    String? rateB1;
    String? rateB2;
    String? rateB3;
    for (String item in scoreList) {
      if (item.contains("S1|")) {
        //   全场比分
        if (item.contains("|")) {
          if (item.split("|").length > 1 &&
              item.split("|")[1].split(":").length > 1) {
            List<String> A1 = item.split("|")[1].split(":");
            rateA1 = A1[0];
            rateB1 = A1[1];
          }
        }
      } else if (item.contains("S7|")) {
        //   加时赛
        if (item.contains("|")) {
          if (item.split("|").length > 1 &&
              item.split("|")[1].split(":").length > 1) {
            List<String> A1 = item.split("|")[1].split(":");
            rateA2 = A1[0];
            rateB2 = A1[1];
          }
        }
      } else if (item.contains("S170|")) {
        //   点球大战
        if (item.contains("|")) {
          if (item.split("|").length > 1 &&
              item.split("|")[1].split(":").length > 1) {
            List<String> A1 = item.split("|")[1].split(":");
            rateA3 = A1[0];
            rateB3 = A1[1];
          }
        }
      }
    }

    return Container(
        height: 81.w,
        margin: EdgeInsets.only(top: 16.w),
        decoration: BoxDecoration(
            color: MatchCupPointState.knockoutBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4.w))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entity.homeName ?? "",
                            style: TextStyle(
                                color:
                                    Get.theme.secondTabPanelSelectedFontColor,
                                fontSize: (12.sp))),
                        Row(
                          children: [
                            if (rateA1 != null)
                              Text(
                                rateA1,
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              ),
                            if (rateA2 != null)
                              Text(
                                "(${rateA2})",
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              ),
                            if (rateA3 != null)
                              Text(
                                rateA3,
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              )
                          ],
                        ),
                      ],
                    )),
                    ImageView(
                      "assets/images/detail/icon_football_win.png",
                      boxFit: BoxFit.fill,
                      width: 64,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entity.awayName ?? "",
                            style: TextStyle(
                                color: Get.theme.tabPanelSelectedColor,
                                fontSize: (12.sp))),
                        Row(
                          children: [
                            if ((rateB1 == null) &&
                                (rateB2 == null) &&
                                (rateB3 == null))
                              Text(
                                "-",
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              ),
                            if (rateB1 != null)
                              Text(
                                rateB1,
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              ),
                            if (rateB2 != null)
                              Text(
                                "(${rateB2})",
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              ),
                            if (rateB3 != null)
                              Text(
                                rateB3,
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              )
                          ],
                        ),
                      ],
                    ))
                  ],
                )),
          ],
        ));
  }
}
