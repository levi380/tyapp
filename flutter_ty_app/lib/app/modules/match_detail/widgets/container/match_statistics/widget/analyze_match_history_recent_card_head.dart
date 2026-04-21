import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 近期战绩卡片 - 列表表头
///
/// 三列：结果、盘路、大小（与 [AnalyzeMatchHistoryRecentCardListItem] 列对齐）
class AnalyzeMatchHistoryRecentCardHead extends StatelessWidget {
  const AnalyzeMatchHistoryRecentCardHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.w,
      decoration: BoxDecoration(
        color: Get.theme.tabPanelHeadColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: MatchStatisticMatchHistoryState.commonBorderColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(flex: 3, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _headerCell(LocaleKeys.analysis_football_matches_results.tr),
                _headerCell(LocaleKeys.analysis_football_matches_turn_around.tr),
                _headerCell(LocaleKeys.analysis_football_matches_size.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String text) {
    return Expanded(
      child: Container(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isIPad ? 15.sp : 11.sp,
            color: Get.theme.dataContainerTextColor,
          ),
        ),
      ),
    );
  }
}
