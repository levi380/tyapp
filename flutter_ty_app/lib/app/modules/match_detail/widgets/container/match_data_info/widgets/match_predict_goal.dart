import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/main.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘面】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球盘面新闻State】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面State控制器
    - 盘面State变量初始化
    - 盘面足球切换变量
    】】】
 *
 */
class MatchPredictInfoModel {
  String? leftTitle;
  String? rightTitle;
  String? centerTitle;

  MatchPredictInfoModel({this.leftTitle, this.rightTitle, this.centerTitle});
}
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE  篮球重点数据页面】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  预期进球、预期失球
    】】】
 */
class MatchPredictGoal extends StatelessWidget {
  final MatchPredictInfoModel data;

  MatchPredictGoal({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 左侧标签
          Positioned(
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MatchDataState.headerGradientColor1,
                    MatchDataState.headerGradientColor1,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(40.w)),
              ),
              constraints: BoxConstraints(minWidth: 26.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.w),
              child: Text(
                "${data.leftTitle ?? "-"}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Get.theme.matchSelectBackgroundColor,
                  fontWeight: MatchDataState.predictGoalLabelFontWeight,
                  fontSize: isIPad
                      ? MatchDataState.predictGoalLabelFontSizeIPad.sp
                      : MatchDataState.predictGoalLabelFontSize.sp,
                ),
              ),
            ),
          ),
          // 中间标题
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60.w), // 给左右留出空间
            child: Text(
              data.centerTitle ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.theme.resultTextColor,
                fontSize: isIPad
                    ? MatchDataState.predictGoalLabelFontSizeIPad.sp
                    : MatchDataState.predictGoalLabelFontSize.sp,
              ),
            ),
          ),
          // 右侧标签
          Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MatchDataState.predictGoalLabelColor,
                    MatchDataState.predictGoalLabelColor
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(40.w)),
              ),
              constraints: BoxConstraints(minWidth: 26.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
              child: Text(
                data.rightTitle ?? "-",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Get.theme.matchSelectBackgroundColor,
                  fontWeight: MatchDataState.predictGoalLabelFontWeight,
                  fontSize: isIPad
                      ? MatchDataState.predictGoalLabelFontSizeIPad.sp
                      : MatchDataState.predictGoalLabelFontSize.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
