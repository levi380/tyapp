import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球杯赛积分 - 分组选择器
///
/// 横向展示当前杯赛的各分组（如 A 组、B 组），选中项高亮；
/// 点击切换 [controller] 的 currentCupBasketBallEventPageIndex。
class BasketBallLeaguePointsSelectBtn extends StatelessWidget {
  final MatchCupPointController controller;

  const BasketBallLeaguePointsSelectBtn({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final events = controller.state.currentCupBasketBallEventDataEvents;
    final currentIndex = controller.state.currentCupBasketBallEventPageIndex;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.w),
      padding: EdgeInsets.symmetric(vertical: 4.w),
      decoration: BoxDecoration(
        color: Get.theme.analsTextTabBgColor,
        borderRadius: BorderRadius.all(Radius.circular(8.w)),
      ),
      child: Row(
        children: events.map((e) {
          final isSelected = currentIndex == events.indexOf(e);
          return Expanded(
            child: InkWell(
              onTap: () => controller.setCurrentCupBasketBallEventPageIndex(e),
              child: Container(
                alignment: Alignment.center,
                height: 25.w,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                decoration: isSelected
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(8.w),
                        color: Get.theme.tabPanelBackgroundColor,
                      )
                    : null,
                child: Text(
                  e.rankingName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: isIPad ? 14.sp : 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Get.theme.analyzeSecondTabPanelSelectedFontColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
