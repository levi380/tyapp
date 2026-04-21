import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import 'package:flutter_ty_app/main.dart';

typedef AnalyzeTabbarListener = Function(int page);
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - tabbar封装
    】】】
 *
 */
class AnalyzeTabbar extends StatefulWidget {
  final List<String> tabs;
  final AnalyzeTabbarListener analyzeTabbarListener;
  final TabController tabController;
  final double? widgetWidth;
  final double? widgetHeight;
  AnalyzeTabbar(this.tabs, this.analyzeTabbarListener, this.tabController,
      {Key? key, this.widgetWidth, this.widgetHeight})
      : super(key: key);

  @override
  State<AnalyzeTabbar> createState() => MSTabbarAnalyzeDemo1State(this.tabs);
}

class MSTabbarAnalyzeDemo1State extends State<AnalyzeTabbar> {
  List<String> tabs = [];
  MSTabbarAnalyzeDemo1State(this.tabs);
  initTeams(List<String> tabs) {
    this.tabs = tabs;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.widgetHeight ?? 50.w,
      width: 1.sw,
      decoration: BoxDecoration(
          // color: Get.theme.tabPanelBackgroundColor,
          ),
      child: Center(
        child: Container(
          height: widget.widgetHeight ?? 50.w,
          width: widget.widgetWidth,
          decoration: BoxDecoration(
              // color: Get.theme.tabPanelBackgroundColor,
              ),
          child: Container(
            height: 16.w,
            padding: EdgeInsets.symmetric(horizontal: 0.w),
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                color: Get.theme.betPanelUnderlineColor,
                borderRadius: BorderRadius.all(Radius.circular(8.w))),
            child: TabBar(
              controller: widget.tabController,
              labelColor: Get.theme.analyzeSecondTabPanelSelectedFontColor,
              labelStyle: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor:
                  Get.theme.analyzeSecondTabPanelUnSelectedFontColor,
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
              ),
              indicatorPadding: EdgeInsets.symmetric(
                  horizontal: getContaineWidth() + 5.w, vertical: 1.w),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8.w),
                color: Get.theme.tabPanelBackgroundColor,
              ),
              tabs: widget.tabs.map((e) {
                return Tab(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 100.w),
                    child: Text(
                      e,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: isIPad ? 16.sp : 12.sp,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  double getContainePadding() {
    if (widget.tabs.length == 4) {
      return 8.w;
    } else if (widget.tabs.length == 3) {
      return 4.w;
    } else if (widget.tabs.length == 2) {
      return -10.w;
    }
    return 0;
  }

  double getContaineWidth() {
    if (widget.tabs.length == 2) {
      return -55.w;
    } else if (widget.tabs.length == 3) {
      return -50.w;
    } else if (widget.tabs.length == 4) {
      return -41.w;
    }
    return 0;
  }
}
