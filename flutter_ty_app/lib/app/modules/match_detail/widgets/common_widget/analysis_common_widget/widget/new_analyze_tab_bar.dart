import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 新版tabbar
    】】】
 *
 */
class NewAnalyzeTabBar extends StatefulWidget {
  final List<String> tabs;
  final TabController? tabController;
  final double? widgetWidth;
  final double? widgetHeight;
  final String? fromTabPage;

  NewAnalyzeTabBar(this.tabs, this.tabController,
      {Key? key, this.widgetWidth, this.fromTabPage, this.widgetHeight})
      : super(key: key);

  @override
  State<NewAnalyzeTabBar> createState() => NewAnalyzeTabBarState();
}

class NewAnalyzeTabBarState extends State<NewAnalyzeTabBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.w)),
      child: Container(
        height: widget.widgetHeight ?? 50.w,
        width: widget.widgetWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Get.theme.betPanelUnderlineColor,
        ),
        child: Container(
          height: (widget.widgetHeight ?? 50.w) - 1.w,
          width: (widget.widgetWidth ?? 0) - 1.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              color: Get.theme.betPanelUnderlineColor,
              borderRadius: BorderRadius.all(Radius.circular(8.w))),
          child: TabBar(
            controller: widget.tabController,
            labelColor: Get.theme.analyzeSecondTabPanelSelectedFontColor,
            padding: EdgeInsets.zero,
            labelStyle: TextStyle(
              fontSize: isIPad ? 16.sp : 12.sp,
              height: 16 / 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelColor:
                Get.theme.analyzeSecondTabPanelUnSelectedFontColor,
            unselectedLabelStyle: TextStyle(
              fontSize: isIPad ? 16.sp : 12.sp,
              height: 16 / 12,
            ),
            indicatorPadding: EdgeInsets.zero,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Get.theme.tabPanelBackgroundColor,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            splashBorderRadius: BorderRadius.all(Radius.circular(8.w)),
            tabs: widget.tabs.map(
              (e) {
                return Text(
                  e,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
