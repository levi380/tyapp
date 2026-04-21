import 'package:common_utils/common_utils.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';

import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import 'package:flutter_ty_app/main.dart';

/// 近期战绩卡片 - 顶部信息区（队徽 + 队名 + 胜/平/负统计）
///
/// [isHome] 为 true 时显示主队图标，否则显示客队；[teamName] 为当前侧队名；
/// [homeVSHistoryMap] 提供 success/flat/lose 数量用于展示“X胜 X平 X负”。
class AnalyzeMatchHistoryRecentInfoHead extends StatelessWidget {
  final bool isHome;
  final String teamName;
  final Map<String, int> homeVSHistoryMap;
  final SeasonStatisticController controller;

  const AnalyzeMatchHistoryRecentInfoHead({
    super.key,
    required this.isHome,
    required this.teamName,
    required this.homeVSHistoryMap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final match = Get.find<MatchDetailController>(tag: controller.tag)
        .detailState
        .match;
    final logoUrl = isHome
        ? ((match?.mhlu ?? []) as List).safeFirst
        : ((match?.malu ?? []) as List).safeFirst;
    final defaultLogo = 'assets/images/home/home_team_logo.svg';
    final errorLogo = 'assets/images/detail/default_team_home.svg';

    return Container(
      height: 62.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                alignment: Alignment.center,
                child: ImageView(
                  ObjectUtil.isNotEmpty(logoUrl) ? logoUrl! : defaultLogo,
                  width: isIPad ? 30.w : 40.w,
                  height: isIPad ? 30.w : 40.w,
                  cdn: true,
                  errorWidget: ImageView(
                    errorLogo,
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  teamName,
                  style: TextStyle(
                    fontSize: isIPad ? 16.sp : 14.sp,
                    color: Get.theme.tabPanelSelectedColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '${homeVSHistoryMap["success"] ?? 0}${LocaleKeys.analysis_football_matches_victory.tr}  '
            '${homeVSHistoryMap["flat"] ?? 0}${LocaleKeys.analysis_football_matches_flat.tr}   '
            '${homeVSHistoryMap["lose"] ?? 0}${LocaleKeys.analysis_football_matches_negative.tr}    ',
            style: TextStyle(
              fontSize: 16.sp,
              color: Get.theme.tabPanelSelectedColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
