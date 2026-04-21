import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/cp/cp_betting_tutorial/widgets/cpBettingTutorial_widget.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/oss_util.dart';
import '../../zr/zr_tutorial/widgets/zr_tab_bar_widget.dart';
import '../../zr/zr_tutorial/widgets/zr_title_widget.dart';
import 'cp_betting_tutorial_controller.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6413aae8-8a7e-47c0-9a74-e3720f3aa655-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票盘口教程 视图 CpBettingTutorialPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票盘口教程 视图 CpBettingTutorialPage
    - CpBettingTutorialPage
    - 包含-双面盘-选择彩种-标准盘-玩法选择及其投注区-双面盘-玩法旋转及其投注区-进行投注双面盘-进行投注-标准盘-查看兑换结果-个性化设置
    ```
    ///头部
    _title(),

    ///内容
    _body(),

    ///tab头部
     _tabTitle()

    ///Page 页面
     _page()
    ```
    】】】
 *
 */
class CpBettingTutorialPage extends StatefulWidget {
  const CpBettingTutorialPage({Key? key}) : super(key: key);

  @override
  State<CpBettingTutorialPage> createState() => _CpBettingTutorialPageState();
}

class _CpBettingTutorialPageState extends State<CpBettingTutorialPage> {
  final controller = Get.find<CpBettingTutorialController>();
  final logic = Get.find<CpBettingTutorialController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpBettingTutorialController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            decoration: context.isDarkMode
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        OssUtil.getServerPath(
                          CpState.tutorialBgDark,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  )
                : const BoxDecoration(
                    color: CpState.tutorialBgColorLight,
                  ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  ///头部
                  _title(),

                  ///内容
                  _body(),
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
      title: LocaleKeys.zr_cp_Lottery_Bet_Slips_wagering_tutorial.tr,
      isDark: context.isDarkMode,
    );
  }

  ///内容
  Widget _body() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: CpState.tutorialBodyTopMargin),
        child: Column(
          children: [
            _tabTitle(),
            _page(),
          ],
        ),
      ),
    );
  }

  ///tab头部
  Widget _tabTitle() {
    return Container(
      height: CpState.tutorialTabHeight,
      margin: EdgeInsets.only(bottom: CpState.tutorialTabBottomMargin),
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

  ///Page 页面
  Widget _page() {
    return Expanded(
      child: PageView(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (int page) => controller.onPageChanged(page),
        children: List<CpBettingTutorialWidget>.generate(
            logic.tabList.length, (index) {
          return CpBettingTutorialWidget(
            isDark: context.isDarkMode,
            title: logic.tabList[logic.currentIndex],
            img: controller.getLanguageImg(index),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<CpBettingTutorialController>();
    super.dispose();
  }
}
