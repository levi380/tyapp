import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analyze_vs_info_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/league_points_controller.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球积分榜列表中的单个球队数据行
///
/// 展示：排名徽标、排名数字、队名、胜场、负场、胜率
class BasketBallPointItem extends StatelessWidget {
  final MatchAnalyzeVsInfoEntity analyzeVSInfoEntity;
  final int index;
  final LeaguePointsController controller;
  final List<Color>? listColor;

  const BasketBallPointItem({
    super.key,
    required this.analyzeVSInfoEntity,
    required this.index,
    required this.controller,
    this.listColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LeaguePointsState.basketballTableRowHeight.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: listColor ?? [Colors.transparent, Colors.transparent]),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 排名列：包含颜色标记和排名数字
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: LeaguePointsState.basketballTableRowMarkerWidth.w,
                    height: LeaguePointsState.basketballTableRowMarkerHeight.w,
                    decoration: BoxDecoration(
                      color: controller.state.union[analyzeVSInfoEntity.promotionId]?["color"] ??
                          Colors.transparent,
                    ),
                  ),
                  Text(
                    controller.state.expand
                        ? "${index + 1}"
                        : "${analyzeVSInfoEntity.positionTotal}",
                    style: TextStyle(
                        fontSize: isIPad ? 15.sp : 11.sp,
                        color: Get.theme.tabPanelSelectedColor),
                  )
                ],
              ),
            ),
          ),
          // 队名列
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${analyzeVSInfoEntity.teamName}",
                style: TextStyle(
                    fontSize: isIPad ? 15.sp : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          // 胜场列
          Expanded(
            flex: 1,
            child: Text(
              "${analyzeVSInfoEntity.winTotal.toInt()}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: isIPad ? 15.sp : 11.sp,
                  color: Get.theme.tabPanelSelectedColor),
            ),
          ),
          // 负场列
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${analyzeVSInfoEntity.lossTotal.toInt()}",
                style: TextStyle(
                    fontSize: isIPad ? 15.sp : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          // 胜率列：计算并展示胜率百分比
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                "${_calculateWinRate()}%",
                style: TextStyle(
                    fontSize: isIPad ? 15.sp : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 计算胜率
  String _calculateWinRate() {
    int loss = analyzeVSInfoEntity.lossTotal.toInt();
    int win = analyzeVSInfoEntity.winTotal.toInt();
    if (loss == 0) return "100";
    if (win == 0) return "0";
    return ((win * 100) / (win + loss)).toStringAsFixed(1);
  }
}
