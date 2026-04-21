import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/tutorial/handicap_strategy/widgets/handicap_widget.dart';
import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../widgets/ball_tab_bar_widget.dart';

import 'handicap_strategy_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 让球攻略 视图页面 HandicapStrategyPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程 让球攻略 视图页面 HandicapStrategyPage
    - HandicapStrategyPage
    ```
    ///头部
    _title(),
    ///内容
    _body(),
    ```
    】】】
 *
 */
class HandicapStrategyPage extends StatefulWidget {
  const HandicapStrategyPage({Key? key}) : super(key: key);

  @override
  State<HandicapStrategyPage> createState() => _HandicapStrategyPageState();
}

class _HandicapStrategyPageState extends State<HandicapStrategyPage> {
  final controller = Get.find<HandicapStrategyController>();
  final logic = Get.find<HandicapStrategyController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HandicapStrategyController>(
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              ///头部
              _title(),
              ///内容
              _body(),
            ],
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return Container(
      height: 30.h,
      margin: EdgeInsets.only(bottom: 16.h),
      alignment: Alignment.center,
      child: TabBar(
        indicatorColor: Colors.transparent,
        indicator: const BoxDecoration(),
        isScrollable: true,
        dividerHeight: 0,
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        labelPadding: EdgeInsets.zero,
        controller: controller.tabController,
        onTap: (index) => controller.changeIndex(index),
        tabs: List<BallTabBarWidget>.generate(logic.tabList.length,
            (index) {
          return BallTabBarWidget(
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
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w),
        child: ListViewObserver(
          controller: controller.listObserverController,
          child: ListView.builder(
              controller: controller.autoScrollController,
              padding: EdgeInsets.zero,
              itemCount: logic.tabList.length,
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return HandicapWidget(
                  isDark: context.isDarkMode,
                  index: index,
                );
              }),
          onObserve: (resultModel) =>
              controller.onObserves(resultModel.firstChild?.index),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HandicapStrategyController>();
    super.dispose();
  }
}
