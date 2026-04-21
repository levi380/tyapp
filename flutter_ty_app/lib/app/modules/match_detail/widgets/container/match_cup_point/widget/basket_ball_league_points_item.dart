import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球杯赛积分榜单个球队数据列表项
///
/// 展示：颜色标记、排名、队名、胜场、负场、胜率
class BasketBallLeaguePointsItem extends StatelessWidget {
  final AnalyzeVsInfoNewInfoTeamRankings eventItem;
  final List<Color>? color;
  final MatchCupPointController controller;

  const BasketBallLeaguePointsItem({
    super.key,
    required this.eventItem,
    this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.w,
      decoration: BoxDecoration(gradient: LinearGradient(colors: color ?? [])),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    width: 2.w,
                    height: 43.5.w,
                    decoration: BoxDecoration(
                      color: controller.state.union[eventItem.promotionId]?["color"] ??
                          Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "${eventItem.positionTotal == 0 ? "-" : eventItem.positionTotal}",
                    style: TextStyle(
                        fontSize: isIPad ? (15.sp) : 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${["zh"].contains(getLang()) ? (eventItem.teamCnName) : (eventItem.teamCnName)}",
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
                  "${eventItem.winTotal.toInt()}",
                  style: TextStyle(
                      fontSize: isIPad ? (15.sp) : 11.sp,
                      color: Get.theme.tabPanelSelectedColor),
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${eventItem.lossTotal.toInt()}",
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
                "${((eventItem.winTotal) == 0 && (eventItem.lossTotal) == 0) ? 0 : (100 * (eventItem.winTotal) / ((eventItem.winTotal) + (eventItem.lossTotal))).toStringAsFixed(2)}%",
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
