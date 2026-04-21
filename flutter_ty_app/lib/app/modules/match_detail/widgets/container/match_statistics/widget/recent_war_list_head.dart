import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 近期战绩列表表头
///
/// 展示四列：日期、主队、比分、客队。
/// 用于赛季统计-近期战绩表格的列标题，与 [RecentWarListItem] 列宽保持一致。
class RecentWarListHead extends StatelessWidget {
  const RecentWarListHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Get.theme.matchHeadContainerBackgroundColor,
        border: Border(
          top: BorderSide(color: Get.theme.betPanelUnderlineColor),
          bottom: BorderSide(color: Get.theme.betPanelUnderlineColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeaderDateColumn(),
          _buildHeaderHomeTeamColumn(),
          _buildHeaderScoreColumn(),
          _buildHeaderAwayTeamColumn(),
        ],
      ),
    );
  }

  /// 日期列标题（左对齐，flex: 3）
  Widget _buildHeaderDateColumn() {
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          LocaleKeys.bet_record_sort2.tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 12.sp,
            color: Get.theme.oddsTeamNameFontColor,
          ),
        ),
      ),
    );
  }

  /// 主队列标题（右对齐，flex: 2）
  Widget _buildHeaderHomeTeamColumn() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 28.w),
          Text(
            LocaleKeys.analysis_team.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isIPad ? 15.sp : 12.sp,
              color: Get.theme.tabPanelSelectedColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 比分列标题（居中，flex: 1）
  Widget _buildHeaderScoreColumn() {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          LocaleKeys.analysis_football_matches_score.tr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 12.sp,
            color: Get.theme.tabPanelSelectedColor,
          ),
        ),
      ),
    );
  }

  /// 客队列标题（左对齐，flex: 2）
  Widget _buildHeaderAwayTeamColumn() {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.analysis_team.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: isIPad ? 15.sp : 12.sp,
              color: Get.theme.tabPanelSelectedColor,
            ),
          ),
          SizedBox(width: 28.w),
        ],
      ),
    );
  }
}
