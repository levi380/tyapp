import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_cup_point_controller.dart';

/// 足球杯赛积分 - 小组/分组选择器
///
/// 横向滚动的一组 Tab：每个 Tab 对应一个分组（如 A 组、B 组），
/// 点击切换 [currentCupBasketBallEventPageIndex]，与下方积分列表联动。
class FootballLeaguePointsGroupSelector extends StatelessWidget {
  final String tag;

  const FootballLeaguePointsGroupSelector({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchCupPointController>(
      id: 'currentCupBasketBallEventPageIndex',
      tag: tag,
      builder: (controller) {
        final state = controller.state;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: state.currentCupBasketBallEventDataEvents.map((e) {
              final isSelected = state.currentCupBasketBallEventPageIndex ==
                  state.currentCupBasketBallEventDataEvents.indexOf(e);
              return InkWell(
                onTap: () => controller.setCurrentCupBasketBallEventPageIndex(e),
                child: Container(
                  alignment: Alignment.center,
                  height: 25.w,
                  width: 66.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: isSelected
                      ? BoxDecoration(
                          border: Border.all(
                            color: Get.theme.betItemTabSelectedColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.w)),
                        )
                      : BoxDecoration(
                          border: Border.all(color: Get.theme.tabAnaysisBgColor),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.w)),
                        ),
                  child: Text(
                    e.rankingName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: isIPad ? 14.sp : 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Get.theme.betItemTabSelectedColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
