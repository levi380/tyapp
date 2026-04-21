import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_cup_point/widget/analyze_tip_dialog.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球小组赛-赛事分析头部heade控件
    】】】
 *
 */
class EliminateMatchHistoryBoardHeader extends StatelessWidget {
  EliminateMatchHistoryBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      color: Get.theme.tabPanelHeadColor,
      height: 26.w,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            flex: 1,
            child:  Center(
              child: InkWell(
                onTap: () {
                  Get.dialog(
                    AnalyzeTipDialog(
                      callback: () {},
                      isCup: true,
                    ),
                    barrierColor: Colors.black.withValues(alpha: 0.5),
                  );
                },
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.w)),
                      color: AppColor.normalBgColor),
                  alignment: Alignment.center,
                  child:Container(
                    child: ImageView(
                      "assets/images/bets/analyze_question2.png",
                      width: 14.w,
                      height: 14.w,
                    ),

                  ),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.analysis_football_matches_team.tr,
                style: TextStyle(
                    fontSize: isIPad?(15.sp):11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.cerocup_changci.tr,
                  style: TextStyle(
                      fontSize: isIPad?(15.sp):11.sp,
                      color: Get.theme.tabPanelSelectedColor),
                )),
          ),
          Expanded(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "胜/负/平",
                style: TextStyle(
                    fontSize: isIPad?(15.sp):11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.match_result_goal.tr,
                style: TextStyle(
                    fontSize: isIPad?(15.sp):11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.cerocup_lost.tr,
                style: TextStyle(
                    fontSize: isIPad?(15.sp):11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.match_net_win.tr,
                style: TextStyle(
                    fontSize: isIPad?(15.sp):11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_integral.tr,
                style: TextStyle(
                    fontSize: isIPad?(15.sp):11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
        ],

      ),
    );
  }
}
