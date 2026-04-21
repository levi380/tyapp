import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/main.dart';

/// 足球杯赛积分 - 单行数据项
///
/// 展示一支队伍在当前分组的积分数据：排名标识、队名、赛、胜/平/负、进/失球、净胜球、积分。
/// [currentCupBasketBallEventPageIndex] 为 0 时显示 [index]，否则显示 [positionTotal]。
class FootballLeaguePointsItem extends StatelessWidget {
  final AnalyzeVsInfoNewInfoTeamRankings entity;
  final Map<String, Map> union;
  final int currentCupBasketBallEventPageIndex;
  final List<Color>? color;

  const FootballLeaguePointsItem({
    super.key,
    required this.entity,
    required this.union,
    required this.currentCupBasketBallEventPageIndex,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: color ?? [Colors.transparent]),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildRankColumn(),
          _buildTeamColumn(),
          _buildMatchCountColumn(),
          _buildWinDrawLossColumn(),
          _buildGoalsForColumn(),
          _buildGoalsAgainstColumn(),
          _buildGoalDiffColumn(),
          _buildPointsColumn(),
        ],
      ),
    );
  }

  /// 排名列：左侧颜色条 + 排名数字（首组显示 index，否则 positionTotal）
  Widget _buildRankColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              width: 2.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: union[entity.promotionId]?['color'] ?? Colors.transparent,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              currentCupBasketBallEventPageIndex == 0
                  ? (entity.index == 0 ? '-' : '${entity.index}')
                  : (entity.positionTotal == 0 ? '-' : '${entity.positionTotal}'),
              style: TextStyle(
                fontSize: isIPad ? 15.sp : 11.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamColumn() {
    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          entity.teamCnName ?? '',
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCountColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${entity.matchCount.toInt()}',
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }

  /// 胜/平/负 格式：胜/平/负
  Widget _buildWinDrawLossColumn() {
    return Expanded(
      flex: 4,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${entity.winTotal.toInt()}/${entity.drawTotal.toInt()}/${entity.lossTotal.toInt()}',
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }

  /// 进球数（带背景色块）
  Widget _buildGoalsForColumn() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: 18.w,
          height: 18.w,
          decoration: BoxDecoration(
            color: MatchCupPointState.goalsForBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4.w)),
          ),
          child: Text(
            '${entity.goalsForTotal.toInt()}',
            style: TextStyle(
              fontSize: isIPad ? 15.sp : 11.sp,
              color: MatchCupPointState.goalsTextColor,
            ),
          ),
        ),
      ),
    );
  }

  /// 失球数（带背景色块）
  Widget _buildGoalsAgainstColumn() {
    return Expanded(
      flex: 1,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: 18.w,
          height: 18.w,
          decoration: BoxDecoration(
            color: MatchCupPointState.goalsAgainstBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(4.w)),
          ),
          child: Text(
            '${entity.goalsAgainstTotal.toInt()}',
            style: TextStyle(
              fontSize: isIPad ? 15.sp : 11.sp,
              color: MatchCupPointState.goalsTextColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalDiffColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${entity.goalDiffTotal.toInt()}',
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPointsColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${entity.pointsTotal.toInt()}',
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }
}
