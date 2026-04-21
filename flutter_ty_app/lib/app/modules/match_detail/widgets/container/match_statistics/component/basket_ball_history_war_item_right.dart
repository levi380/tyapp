import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球历史交战列表项 - 右侧区域（赛果/让球/大小）
class BasketBallHistoryWarItemRight extends StatelessWidget {
  final AnalyzeTeamVsHistoryEntity entity;
  final SeasonStatisticController controller;

  const BasketBallHistoryWarItemRight({
    super.key,
    required this.entity,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          _buildResultColumn(
            controller.resultFilter(
              'resultwinlose',
              entity.result?.toInt() ?? -1,
            ),
            controller.getWinResultTextColor(
              controller.getWinResultStr(entity.result),
            ),
          ),
          _buildResultColumn(
            controller.resultFilter(
              'resultwinlose',
              entity.handicapResult?.toInt() ?? -1,
            ),
            controller.getWinResultTextColor(
              controller.getWinResultStr1(entity.handicapResult),
            ),
          ),
          _buildResultColumn(
            controller.resultFilter(
              'overunderLabel',
              entity.overunderResult?.toInt() ?? -1,
            ),
            controller.getWinResultTextColor(
              controller.getWinResultStr2(entity.overunderResult),
            ),
            hasBorder: false,
          ),
        ],
      ),
    );
  }

  Widget _buildResultColumn(String text, Color color, {bool hasBorder = true}) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: hasBorder
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: Get.theme.betPanelUnderlineColor,
                  ),
                ),
              )
            : null,
        child: Text(
          text,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: color,
          ),
        ),
      ),
    );
  }
}
