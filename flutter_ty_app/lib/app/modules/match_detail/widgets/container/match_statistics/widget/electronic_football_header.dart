import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 电子足球头部列表组件
///
/// 展示：日期/ID，球队名，比分，球队名
class ElectronicFootballHeader extends StatelessWidget {
  const ElectronicFootballHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MatchStatisticMatchHistoryState.headOnConfrontationHeaderHorizontalPadding.w,
        vertical: MatchStatisticMatchHistoryState.headOnConfrontationHeaderVerticalPadding.w,
      ),
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
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${LocaleKeys.analysis_football_matches_date.tr}/ID",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: isIPad
                      ? MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSizeIPad.sp
                      : MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSize.sp,
                  color: Get.theme.oddsTeamNameFontColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationHeaderSpacing.w,
                ),
                Text(
                  LocaleKeys.analysis_football_matches_teame_name.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: isIPad
                        ? MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSizeIPad.sp
                        : MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSize.sp,
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.analysis_football_matches_score.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isIPad
                          ? MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSizeIPad.sp
                          : MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSize.sp,
                      color: Get.theme.tabPanelSelectedColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.analysis_football_matches_teame_name.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: isIPad
                        ? MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSizeIPad.sp
                        : MatchStatisticMatchHistoryState.headOnConfrontationHeaderFontSize.sp,
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
                SizedBox(
                  width: MatchStatisticMatchHistoryState.headOnConfrontationHeaderSpacing.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
