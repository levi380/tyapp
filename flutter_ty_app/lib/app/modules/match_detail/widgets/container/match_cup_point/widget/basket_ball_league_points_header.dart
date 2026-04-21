import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球杯赛积分榜头部列表组件
///
/// 包含列：排名(#)、球队名称、胜场、负场、胜率
class BasketBallLeaguePointsHeader extends StatelessWidget {
  const BasketBallLeaguePointsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(color: Get.theme.tabPanelHeadColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "#",
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.virtual_sports_team.tr,
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.analysis_victory.tr,
                  style: TextStyle(
                      fontSize: isIPad ? (15.sp) : 11.sp,
                      color: Get.theme.tabPanelSelectedColor),
                )),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.analysis_negative.tr,
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.home_popular_win_rate.tr,
                style: TextStyle(
                    fontSize: isIPad ? (15.sp) : 11.sp,
                    color: Get.theme.tabPanelSelectedColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
