import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球历史交战列表项 - 左侧区域
///
/// 展示日期、赛事名、主客队比分及队伍名称列
class BasketBallHistoryWarItemLeft extends StatelessWidget {
  final AnalyzeTeamVsHistoryEntity entity;

  const BasketBallHistoryWarItemLeft({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          _buildDateAndTournamentColumn(),
          _buildTeamNamesColumn(),
        ],
      ),
    );
  }

  Widget _buildDateAndTournamentColumn() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1,
              color: Get.theme.betPanelUnderlineColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDateText(),
                  SizedBox(height: 4.w),
                  _buildTournamentText(),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildScoreText(entity.homeTeamScore),
                  SizedBox(height: 4.w),
                  _buildScoreText(entity.awayTeamScore),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamNamesColumn() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1,
              color: Get.theme.betPanelUnderlineColor,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTeamNameText(entity.homeTeamName ?? ''),
            SizedBox(height: 4.w),
            _buildTeamNameText(entity.awayTeamName ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildDateText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        FormatDate.formatDate(
          int.tryParse(entity.beginTime ?? '0') ?? 0,
        ),
        style: TextStyle(
          fontSize: isIPad ? 15.sp : 11.sp,
          color: Get.theme.tabPanelSelectedColor,
        ),
      ),
    );
  }

  Widget _buildTournamentText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        entity.tournamentName ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: isIPad ? 15.sp : 11.sp,
          color: Get.theme.tabPanelSelectedColor,
        ),
      ),
    );
  }

  Widget _buildScoreText(String? score) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '$score',
        style: TextStyle(
          fontSize: isIPad ? 15.sp : 11.sp,
          color: Get.theme.tabPanelSelectedColor,
        ),
      ),
    );
  }

  Widget _buildTeamNameText(String teamName) {
    return Container(
      padding: EdgeInsets.only(left: 4.w),
      alignment: Alignment.centerLeft,
      child: Text(
        teamName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: isIPad ? 15.sp : 11.sp,
          color: Get.theme.tabPanelSelectedColor,
        ),
      ),
    );
  }
}
