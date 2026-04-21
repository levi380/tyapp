import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_market_overview_logic.dart';

/// 足球走势 - 底部说明文案
///
/// 有走势图数据时显示 [LocaleKeys.analysis_football_matches_remark]，无数据时不占位。
class FootballTrendRemark extends StatelessWidget {
  const FootballTrendRemark({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnalyzeMarketOverviewLogic>(
      id: 'getLineChart',
      tag: tag,
      builder: (controller) {
        if (controller.state.chartMap == null) {
          return const SizedBox.shrink();
        }
        return Container(
          height: 40.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          alignment: Alignment.centerLeft,
          child: Text(
            LocaleKeys.analysis_football_matches_remark.tr,
            style: TextStyle(
              fontSize: 12.sp,
              color: Get.theme.tabPanelUnSelectedColor,
            ),
          ),
        );
      },
    );
  }
}
