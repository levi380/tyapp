import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../../main.dart';

import '../../home/models/match_list_type.dart';
import '../main_tab_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 bottomNavigationBarWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 底部菜单 bottomNavigationBarWidget
    - bottomNavigationBarWidget
    ```
    底部菜单
    ```
    】】】
 *
 */

class bottomNavigationBarWidget extends StatelessWidget {
  const bottomNavigationBarWidget({
    super.key,
    required this.controller,
    required this.listTyper,
  });

  final MainTabController controller;
  final MatchListType listTyper;

  @override
  Widget build(BuildContext context) {
    if (bottomHideSwitch == true) {
      return Container(
        height: 0.5,
      );
    } else if (europeanCup == true) {
      return Container(
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
                    ? mainTab1Night
                    : mainTab1,
                dailyActivities: false,
              ),
              //设置菜单
              TabWidget(
                onTap: () {
                  controller.logicToTargetPage(1);
                },
                title: LocaleKeys.footer_menu_set_menu.tr,
                imageUrl: context.isDarkMode
                    ? mainTab2Night
                    : mainTab2,
                dailyActivities: false,
              ),
              GestureDetector(
                onTap: () => controller.toEuropeanCup(),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: ImageView(
                    context.isDarkMode
                        ? europeanCup3
                        : europeanCup1,
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
                    ? mainTab3Night
                    : mainTab3,
                dailyActivities: false,
              ),
              //已结注单
              TabWidget(
                onTap: () => controller.logicToTargetPage(3),
                title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                imageUrl: context.isDarkMode
                    ? mainTab4Night
                    : mainTab4,
                dailyActivities: false,
              ),
            ]),
      );
    } else if (footballBasketballTemplate == true) {
      return Container(
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
                    ? mainTab1Night
                    : mainTab1,
                dailyActivities: false,
              ),
              //设置菜单
              TabWidget(
                onTap: () {
                  controller.logicToTargetPage(1);
                },
                title: LocaleKeys.footer_menu_set_menu.tr,
                imageUrl: context.isDarkMode
                    ? mainTab2Night
                    : mainTab2,
                dailyActivities: false,
              ),
              GestureDetector(
                onTap: () => controller.toFootballBasketballTemplate(),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: ImageView(
                    footballBasketballTemplate1,
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
                    ? mainTab3Night
                    : mainTab3,
                dailyActivities: false,
              ),
              //已结注单
              TabWidget(
                onTap: () => controller.logicToTargetPage(3),
                title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                imageUrl: context.isDarkMode
                    ? mainTab4Night
                    : mainTab4,
                dailyActivities: false,
              ),
            ]),
      );
    } else {
      return Container(
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
              ///底部菜单切换
              listTyper == MatchListType.zr
                  ? TabWidget(
                      onTap: () => controller.logicToTargetPage(0),
                      title: LocaleKeys.zr_cp_footer_menu_zr_title.tr,
                      imageUrl: context.isDarkMode
                          ? mainTab1Night
                          : mainTab1,
                      dailyActivities: false,
                    )
                  : listTyper == MatchListType.cp
                      ? TabWidget(
                          onTap: () => controller.logicToTargetPage(0),
                          title: LocaleKeys
                              .zr_cp_Lottery_Bet_Slips_betting_guide.tr,
                          imageUrl: context.isDarkMode
                              ? mainTab1Night
                              : mainTab1,
                          dailyActivities: false,
                        )
                      :

                      ///赛果
                      TabWidget(
                          onTap: () => controller.logicToTargetPage(0),
                          title: LocaleKeys.menu_itme_name_results.tr,
                          imageUrl: context.isDarkMode
                              ? mainTab1Night
                              : mainTab1,
                          dailyActivities: false,
                        ),
              //设置菜单
              TabWidget(
                onTap: () {
                  controller.logicToTargetPage(1);
                },
                title: LocaleKeys.footer_menu_set_menu.tr,
                imageUrl: context.isDarkMode
                    ? mainTab2Night
                    : mainTab2,
                dailyActivities: false,
              ),
              //未结注单
              TabWidget(
                onTap: () => controller.logicToTargetPage(2),
                title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                imageUrl: controller.isNewYearSwitch.value
                    ? tab2025
                    : context.isDarkMode
                        ? mainTab3Night
                        : mainTab3,
                dailyActivities: false,
              ),
              //已结注单
              TabWidget(
                onTap: () => controller.logicToTargetPage(3),
                title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                imageUrl: context.isDarkMode
                    ? mainTab4Night
                    : mainTab4,
                dailyActivities: false,
              ),
              //刷新
              GetBuilder<MainTabController>(
                id: 'dailyActivities',
                builder: (controller) {
                  return TabWidget(
                    onTap: () => controller.logicToTargetPage(4),
                    title: LocaleKeys.footer_menu_refresh.tr,
                    imageUrl: context.isDarkMode
                        ? mainTab5Light
                        : mainTab5Night,
                    animation: true,
                    dailyActivities: controller.dailyActivities,
                    animate: controller.animationController,
                  );
                },
              ),
            ]),
      );
    }
  }
}
