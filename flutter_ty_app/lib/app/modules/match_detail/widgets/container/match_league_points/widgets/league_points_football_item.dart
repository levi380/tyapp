

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import '../../../../../../../../main.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../controllers/league_points_controller.dart';


/**
 * 联赛积分列表项组件
 */
class LeaguePointsFootballItem extends StatelessWidget {
  final AnalyzeVsInfoNewInfoTeamRankings analyzeVSInfoEntity;
  final int index;
  final int selectIndex;
  final LeaguePointsController controller;
  final List<Color>? listColor;
  final bool boldText;

  const LeaguePointsFootballItem({
    super.key,
    required this.analyzeVSInfoEntity,
    required this.index,
    required this.selectIndex,
    required this.controller,
    this.listColor,
    this.boldText = false,
  });

  /// 构建联赛积分列表项UI
  /// 显示队伍排名、比赛场次、胜负平、进球、失球、净胜球和积分
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.w,
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: listColor ?? [])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 2.w,
                    height: 43.5.w,
                    decoration: BoxDecoration(
                      color: controller
                                  .state.union[analyzeVSInfoEntity.promotionId]
                              ?["color"] ??
                          Colors.transparent,
                    ),
                  ),
                  Text(
                    "${index + 1}",
                    style: TextStyle(
                        fontSize: isIPad ? (15.sp) : 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${analyzeVSInfoEntity.teamCnName.isEmpty ? analyzeVSInfoEntity.teamName : analyzeVSInfoEntity.teamCnName}",
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    fontWeight: boldText ? FontWeight.w700 : FontWeight.w400,
                    color: boldText
                        ? Get.theme.titleBlack
                        : Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${analyzeVSInfoEntity.matchCount.toInt()}",
                  style: TextStyle(
                      fontSize: isIPad ? (15.sp) : 11.sp,
                      color: Get.theme.tabPanelSelectedColor),
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.winTotal.toInt()}/${analyzeVSInfoEntity.drawTotal.toInt()}/${analyzeVSInfoEntity.lossTotal.toInt()}",
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: isIPad ? 28.w : 18.w,
                height: isIPad ? 28.w : 18.w,
                decoration: BoxDecoration(
                    color:  Color(0xFF00B42A),
                    borderRadius: BorderRadius.all(Radius.circular(4.w))),
                child: Text(
                  "${analyzeVSInfoEntity.goalsForTotal.toInt()}",
                  style: TextStyle(
                      fontSize: isIPad ? (15.sp) : 11.sp,
                      color:  Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: isIPad ? 28.w : 18.w,
                height: isIPad ? 28.w : 18.w,
                decoration: BoxDecoration(
                    color: Color(0xFFF53F3F),
                    borderRadius: BorderRadius.all(Radius.circular(4.w))),
                child: Text(
                  "${analyzeVSInfoEntity.goalsAgainstTotal.toInt()}",
                  style: TextStyle(
                      fontSize: isIPad ? (15.sp) : 11.sp,
                      color:  Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.goalDiffTotal.toInt()}",
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.pointsTotal.toInt()}",
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabIndicatorColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/// 获取列表项颜色工具函数
/// [context] 上下文
/// [index] 索引，1和2有特殊颜色
List<Color> getLeaguePointsItemColor(BuildContext context, int index) {
  List<Color> list = [Colors.transparent, Colors.transparent];

  if (context.isDarkMode) {
    if ((index == 1)) {
      list = [Color(0xFF24374A), Color(0xFF24374A)];
    } else if (index == 2) {
      list = [Color(0xFF41392A), Color(0xFF41392A)];
    }
  } else {
    if ((index == 1)) {
      list = [Color(0xFFD1ECFF), Color(0xFFD1ECFF)];
    } else if (index == 2) {
      list = [Color(0xFFFEEECC), Color(0xFFFEEECC)];
    }
  }
  return list;
}

