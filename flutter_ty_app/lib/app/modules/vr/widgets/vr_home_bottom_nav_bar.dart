import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_home_controller_ext.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../../widgets/image_view.dart';
import '../vr_home_controller.dart';
import '../vr_sport_state.dart';

class VrHomeBottomNavBar extends StatelessWidget {
  const VrHomeBottomNavBar({
    super.key,
    required this.controller,
  });

  final VrTyHomeController controller;

  @override
  Widget build(BuildContext context) {
    return footballBasketballTemplate == true ? Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xE5181A21)
            : const Color(0xffFFFAFA),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? Colors.black.withAlpha(90)
                : Colors.grey.withAlpha(90),
            blurRadius: 4.r,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //赛果
            TabWidget(
              onTap: () => controller.logicToTargetPage(0),
              title: LocaleKeys.menu_itme_name_results.tr,
              imageUrl: context.isDarkMode
                  ? VRSportState.bottomTab1Dark
                  : VRSportState.bottomTab1Light,
              dailyActivities: false,
            ),
            //设置菜单
            TabWidget(
              onTap: () {
                controller.logicToTargetPage(1);
              },
              title: LocaleKeys.footer_menu_set_menu.tr,
              imageUrl: context.isDarkMode
                  ? VRSportState.bottomTab2Dark
                  : VRSportState.bottomTab2Light,
              dailyActivities: false,
            ),
            GestureDetector(
              onTap: () => controller.toFootballBasketballTemplate(),
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: ImageView(
                  VRSportState.bottomCenterIcon,
                  width: 72.w,
                  height: 30.w,
                ),
              ),
            ),
            //未结注单
            TabWidget(
              onTap: () => controller.logicToTargetPage(2),
              title: LocaleKeys.app_h5_cathectic_open_bets.tr,
              imageUrl: context.isDarkMode
                  ? VRSportState.bottomTab3Dark
                  : VRSportState.bottomTab3Light,
              dailyActivities: false,
            ),
            //已结注单
            TabWidget(
              onTap: () => controller.logicToTargetPage(3),
              title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
              imageUrl: context.isDarkMode
                  ? VRSportState.bottomTab4Dark
                  : VRSportState.bottomTab4Light,
              dailyActivities: false,
            ),
          ]),
    ) : Container(
      height: 75.h,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? const Color(0xE5181A21)
            : const Color(0xffFFFAFA),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode ? Colors.black : Colors.grey,
            blurRadius: 4.r,
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 赛果
          TabWidget(
            onTap: () => controller.logicToTargetPage(0),
            title: LocaleKeys.menu_itme_name_results.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab1_night.svg'
                : 'assets/images/icon/main_tab1.png',
            dailyActivities: false,
          ),
          // 设置菜单
          TabWidget(
            onTap: () {
              controller.logicToTargetPage(1);
            },
            title: LocaleKeys.footer_menu_set_menu.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab2_night.svg'
                : 'assets/images/icon/main_tab2.png',
            dailyActivities: false,
          ),
          // 未结注单
          TabWidget(
            onTap: () => controller.logicToTargetPage(2),
            title: LocaleKeys.app_h5_cathectic_open_bets.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab3_night.svg'
                : 'assets/images/icon/main_tab3.png',
            dailyActivities: false,
          ),
          // 已结注单
          TabWidget(
            onTap: () => controller.logicToTargetPage(3),
            title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
            imageUrl: context.isDarkMode
                ? 'assets/images/icon/main_tab4_night.png'
                : 'assets/images/icon/main_tab4.png',
            dailyActivities: false,
          ),
          // 刷新
          TabWidget(
            onTap: () => controller.logicToTargetPage(4),
            title: LocaleKeys.footer_menu_refresh.tr,
            imageUrl: context.isDarkMode
                ? VRSportState.bottomTab5Dark
                : VRSportState.bottomTab5Light,
            animation: true,
            dailyActivities: controller.dailyActivities,
            animate: controller.animationController,
          ),
        ],
      ),
    );
  }
}
