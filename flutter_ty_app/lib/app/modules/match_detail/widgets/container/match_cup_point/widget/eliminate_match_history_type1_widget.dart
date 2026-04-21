import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../../services/models/res/knockout_info_bean_entity.dart';

import '../../../../../match_detail/widgets/common_widget/analysis_common_widget/item/analyze_divider.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球小组赛-杯赛类型1
    】】】
 *
 */
class EliminateMatchHistoryType1WidgetWidget extends StatelessWidget {
  final KnockoutInfoBeanEntity? entity;
  final String tag;

  EliminateMatchHistoryType1WidgetWidget(this.entity,
      {super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    if (entity == null) {
      return Container();
    }

    String scores = entity?.scores ?? "";
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
            color: Get.theme.tabPanelHeadColor,
            borderRadius: BorderRadius.all(Radius.circular(4.w))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entity?.homeName ?? "",
                            style: TextStyle(
                                color:
                                    Get.theme.secondTabPanelSelectedFontColor,
                                fontSize: (12.sp))),
                        Row(
                          children: [
                            if ((rateA1 == null) &&
                                (rateA2 == null) &&
                                (rateA3 == null))
                              Text(
                                "-",
                                style: TextStyle(
                                    color: Get.theme.tabPanelSelectedColor,
                                    fontSize: (12.sp)),
                              ),
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
                    ),
                    SizedBox(
                      height: 6.w,
                    ),
                    AnalyzeDivider(),
                    SizedBox(
                      height: 6.w,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entity?.awayName ?? "",
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
                    ),
                  ],
                )),
          ],
        ));
  }
}
