import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tab_bar_widget.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_title_widget.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_a.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_b.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_c.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_d.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_e.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_f.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_tutorial/widgets/zr_tutorial_g.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/oss_util.dart';
import 'zr_tutorial_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐真人教程 视图 ZrTutorialPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐真人教程 视图 ZrTutorialPage
    - ZrTutorialPage
    - 包含-游戏规则-博牌牌例-点数计算-玩法判定-赔率表-游戏特点-注意事项
    - 等规则玩法
    ```
    ///头部
    Widget _title()

    ///tab头部
    Widget _tabTitle()

    ///游戏规则
    ZrTutorialAWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),

    ///博牌牌例
    ZrTutorialBWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),

    ///点数计算
    ZrTutorialCWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),

    ///玩法判定
    ZrTutorialDWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),

    ///赔率表
    ZrTutorialEWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),

    ///游戏特点
    ZrTutorialFWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),

    ///注意事项
    ZrTutorialGWidget(
      isDark: context.isDarkMode,
      title: controller.tabList[controller.currentIndex],
    ),
    ```
    】】】
 *
 */
class ZrTutorialPage extends StatefulWidget {
  const ZrTutorialPage({Key? key}) : super(key: key);

  @override
  State<ZrTutorialPage> createState() => _ZrTutorialPageState();
}

class _ZrTutorialPageState extends State<ZrTutorialPage> {
  final controller = Get.find<ZrTutorialController>();
  final logic = Get.find<ZrTutorialController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZrTutorialController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          ZrState.tutorialBgDarkAsset,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    color: ZrState.bgColorLight,
                  ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  ///头部
                  _title(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Column(
                        children: [
                          _tabTitle(),
                          _body(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return ZrTitleWidget(
      title: LocaleKeys.zr_cp_footer_menu_zr_title.tr,
      isDark: context.isDarkMode,
    );
  }

  ///tab头部
  Widget _tabTitle() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(bottom: 16.h),
      child: TabBar(
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(),
        isScrollable: true,
        dividerHeight: 0,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        labelPadding: EdgeInsets.zero,
        controller: controller.tabController,
        onTap: (index) => controller.changeIndex(index),
        tabs: List<ZrTabBarWidget>.generate(logic.tabList.length, (index) {
          return ZrTabBarWidget(
            title: logic.tabList[index],
            isSelected: logic.currentIndex == index ? true : false,
            isDark: context.isDarkMode,
          );
        }).toList(),
      ),
    );
  }

  ///内容
  Widget _body() {
    return Expanded(
      child: PageView(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (int page) => controller.onPageChanged(page),
        children: [
          ///游戏规则
          ZrTutorialAWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),

          ///博牌牌例
          ZrTutorialBWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),

          ///点数计算
          ZrTutorialCWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),

          ///玩法判定
          ZrTutorialDWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),

          ///赔率表
          ZrTutorialEWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),

          ///游戏特点
          ZrTutorialFWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),

          ///注意事项
          ZrTutorialGWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ZrTutorialController>();
    super.dispose();
  }
}
