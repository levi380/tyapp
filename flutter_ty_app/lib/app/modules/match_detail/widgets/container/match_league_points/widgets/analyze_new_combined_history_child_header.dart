import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
import '../../match_cup_point/widget/analyze_tip_dialog.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛事分析 】】】
    【【【 AUTO_PARAGRAPH_TITLE 联赛列表 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛事分析盘面页面 联赛积分列表头部
    】】】
 *
 */
class AnalyzeNewCombinedHistoryChildHeader extends StatelessWidget {
  AnalyzeNewCombinedHistoryChildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      decoration: BoxDecoration(
          color: Get.theme.tabPanelBackgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child:  Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 8.w),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    width: 2.w,
                    height: 43.5.w,
                    decoration:null,
                  ),
                  InkWell(
                    onTap: (){
                      Get.dialog(
                        AnalyzeTipDialog(
                          callback: () {
                          },
                          isCup: false,
                        ),
                        barrierColor: Colors.black.withValues(alpha:0.5),
                      );
                    },
                    child: Container(
                      child: ImageView(
                        "assets/images/bets/analyze_question2.png",
                        width: 14.w,
                        height: 14.w,
                      ),

                    ),
                  )
                ],
              ),
            )



          ),
          Expanded(
            flex: 3,
            child: Text(
              LocaleKeys.ouzhou_search_team.tr,

              textAlign: TextAlign.left,
              style:
                  TextStyle(fontSize: isIPad?(15.sp):11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_football_matches_session.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: isIPad?(15.sp):10.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "${  LocaleKeys.analysis_football_matches_victory.tr}/${LocaleKeys.analysis_football_matches_flat.tr}/${LocaleKeys.analysis_football_matches_negative.tr}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: isIPad?(15.sp):11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.match_result_goal.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: isIPad?(15.sp):11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.analysis_k_lost.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: isIPad?(15.sp):11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              LocaleKeys.virtual_sports_goal_difference.tr,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: isIPad?(15.sp):11.sp, color: Get.theme.dataContainerTextColor),
            ),
          ),

          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.virtual_sports_integral.tr,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                  TextStyle(fontSize: isIPad?(15.sp):11.sp, color: Get.theme.dataContainerTextColor),
                ),


              ],
            )
          ),
        ],
      ),
    );
  }
}
