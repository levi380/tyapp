import 'package:flutter_ty_app/app/utils/image_util.dart';
import 'dart:ui';

import 'package:flutter_ty_app/app/modules/home/models/match_list_type.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_menu_widget.dart';
import 'package:flutter_ty_app/app/modules/main_tab/widgets/tab_widget.dart';
import '../../../../generated/locales.g.dart';
import '../main_tab_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fd7c406b-7a61-4ad5-8525-78ce9cb69b8d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP底部菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部菜单小组件 rightMenuWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 右侧悬浮底部菜单 rightMenuWidget
    - rightMenuWidget
    ```
    右侧悬浮底部菜单
    ```
    】】】
 *
 */

class rightMenuWidget extends StatelessWidget {
  const rightMenuWidget({
    super.key,
    required this.controller,
    required this.listTyper,
  });

  final MainTabController controller;
  final MatchListType listTyper;

  @override
  Widget build(BuildContext context) {
    return controller.rightMenu == false
        ? Positioned(
            right: -15.w,
            bottom: 40.h,
            child: InkWell(
              onTap: () => controller.onRightMenu(),
              child: ImageView(
                mainTabMenu0,
                width: 48.w,
                height: 68.h,
              ),
            ),
          )
        : Positioned(
            right: -200.w,
            bottom: -190.h,
            width: 430.w,
            height: 440.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: GestureDetector(
                  onTap: () {
                    // 点击事件，防止滑动
                    print('BackdropFilter 点击事件，防止滑动');
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: Colors.white.withValues(alpha: 0.6000000238418579),
                      shape: const OvalBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ///底部悬浮菜单切换
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
                                    onTap: () =>
                                        controller.logicToTargetPage(0),
                                    title: LocaleKeys
                                        .zr_cp_Lottery_Bet_Slips_betting_guide
                                        .tr,
                                    imageUrl: context.isDarkMode
                                        ? mainTab1Night
                                        : mainTab1,
                                    dailyActivities: false,
                                  )
                                :
                                //赛果
                                TabMenuWidget(
                                    top: 10.h,
                                    left: 140.w,
                                    onTap: () =>
                                        controller.logicToTargetPage(0),
                                    title: LocaleKeys.menu_itme_name_results.tr,
                                    imageUrl: mainTabMenu1,
                                  ),

                        ///设置菜单
                        TabMenuWidget(
                          top: 30.h,
                          left: 85.w,
                          onTap: () {
                            controller.logicToTargetPage(1);
                          },
                          title: LocaleKeys.footer_menu_set_menu.tr,
                          imageUrl: mainTabMenu2,
                        ),

                        ///未结注单
                        TabMenuWidget(
                          top: 75.h,
                          left: 35.w,
                          onTap: () => controller.logicToTargetPage(2),
                          title: LocaleKeys.app_h5_cathectic_open_bets.tr,
                          imageUrl: mainTabMenu3,
                        ),

                        ///已结注单
                        TabMenuWidget(
                          top: 130.h,
                          left: 10.w,
                          onTap: () => controller.logicToTargetPage(3),
                          title: LocaleKeys.app_h5_cathectic_closed_bets.tr,
                          imageUrl: mainTabMenu4,
                        ),

                        ///刷新

                        GetBuilder<MainTabController>(
                          id: 'dailyActivities',
                          builder: (controller) {
                            return TabMenuWidget(
                              top: 188.h,
                              left: -15.w,
                              onTap: () => controller.logicToTargetPage(4),
                              title: LocaleKeys.footer_menu_refresh.tr,
                              imageUrl: mainTabMenu5,
                              animation: true,
                              animate: controller.animationController,
                            );
                          },
                        ),

                        Container(
                          width: 53.w,
                          height: 53.w,
                          margin: EdgeInsets.only(right: 90.w, bottom: 80.h),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF8ACDFF),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Colors.white
                                    .withValues(alpha: 0.20000000298023224),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: InkWell(
                            onTap: () => controller.onRightMenu(),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
