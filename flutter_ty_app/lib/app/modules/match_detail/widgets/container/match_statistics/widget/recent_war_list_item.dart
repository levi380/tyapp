import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/app/services/models/res/statistics_team_vs_other_team_entity.dart';

/// 近期战绩单行列表项
///
/// 展示一场对战记录：日期、主队名、比分、客队名。
/// 主客队与当前赛事一致时，会通过 [leftUrl]/[rightUrl] 交换保证主队在左、客队在右的图标显示。
class RecentWarListItem extends StatelessWidget {
  /// 本场对战数据（主客队名、比分、开球时间等）
  final StatisticsTeamVsOtherTeam item;
  /// 当前赛事主队名称，用于判断是否交换左右图标
  final String? leftTeam1;
  /// 当前赛事主队图标 URL
  final String? leftUrl;
  /// 当前赛事客队图标 URL
  final String? rightUrl;

  const RecentWarListItem({
    super.key,
    required this.item,
    this.leftTeam1,
    this.leftUrl,
    this.rightUrl,
  });

  @override
  Widget build(BuildContext context) {
    String? finalLeftUrl = leftUrl;
    String? finalRightUrl = rightUrl;
    if ((leftTeam1 ?? '') != item.homeTeamName) {
      finalLeftUrl = rightUrl;
      finalRightUrl = leftUrl;
    }

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      height: 36.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDateColumn(),
          _buildHomeTeamColumn(),
          _buildScoreColumn(),
          _buildAwayTeamColumn(),
        ],
      ),
    );
  }

  /// 日期列：格式 yyyy/MM/dd
  Widget _buildDateColumn() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          FormatDate.formatDate(
            int.tryParse(item.beginTime) ?? 0,
            formatString: 'yyyy/MM/dd',
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 12.sp,
            color: Get.theme.oddsTeamNameFontColor,
          ),
        ),
      ),
    );
  }

  /// 主队名列（右对齐，最大宽度 60.w）
  Widget _buildHomeTeamColumn() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 60.w,
            alignment: Alignment.centerRight,
            child: Text(
              item.homeTeamName,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isIPad ? 15.sp : 12.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 比分列：主队-客队，使用 [MatchStatisticMatchHistoryState.scoreColor]
  Widget _buildScoreColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '${item.homeTeamScore}-${item.awayTeamScore}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: MatchStatisticMatchHistoryState.scoreColor,
          ),
        ),
      ),
    );
  }

  /// 客队名列（左对齐，最大宽度 60.w）
  Widget _buildAwayTeamColumn() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60.w,
            child: Text(
              item.awayTeamName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isIPad ? 15.sp : 12.sp,
                color: Get.theme.tabPanelSelectedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
