import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 正面交手列表表头
///
/// 显示列标题：时间、队伍、比分、队伍（与 [MatchStatisticListItem] 列对齐）
class MatchStatisticListHead extends StatelessWidget {
  const MatchStatisticListHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.footer_menu_time.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad ? 15.sp : 12.sp,
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
                Text(
                  LocaleKeys.ouzhou_search_team.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isIPad ? 15.sp : 12.sp,
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
                SizedBox(width: 6.w),
                Container(width: 24.w, height: 24.w, alignment: Alignment.center),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_football_matches_score.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isIPad ? 15.sp : 11.sp,
                  color: Get.theme.tabPanelSelectedColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: 24.w, height: 24.w, alignment: Alignment.center),
                SizedBox(width: 6.w),
                Text(
                  LocaleKeys.ouzhou_search_team.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isIPad ? 15.sp : 12.sp,
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
