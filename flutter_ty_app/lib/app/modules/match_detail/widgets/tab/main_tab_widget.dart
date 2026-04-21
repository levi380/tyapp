import 'package:flutter_ty_app/app/modules/match_detail/extension/detail_tab_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import '../../../../../main.dart';
import '../../../../services/network/request_interceptor.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-984fca10-b2ba-4eb7-867c-d27d0f659197 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 主功能切换tab】】】
    【【【 AUTO_PARAGRAPH_TITLE 主功能切换tab组件】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 用户切换投注/赛事分析等
    】】】
 *
 */
class MainTabWidget extends StatelessWidget {
  const MainTabWidget({super.key, required this.controller, this.tag});

  final MatchDetailController controller;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 85.h),
      child: GetBuilder<MatchDetailController>(
        tag: tag,
        id: matchBetMainTabGetBuildId,
        builder: (logic) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 投注/赛事分析 切换tab
              if (controller.showMatchTab())
                Flexible(
                  child: Container(
                    height: isIPad ? 60.h : 40.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Get.theme.tabPanelBackgroundColor,
                    ),
                    child: TabBar(
                      // padding: EdgeInsets.symmetric(horizontal: 0),
                      controller: controller.detailState.tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable:true,
                      indicatorPadding: EdgeInsets.only(bottom: 4.h),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 2.h,
                          color: Get.theme.tabIndicatorColor,
                        ),
                      ),
                      labelColor: Get.theme.tabPanelSelectedColor,
                      labelPadding: EdgeInsets.symmetric(horizontal: 14.w),
                      labelStyle: TextStyle(
                          fontSize:
                              ["en", "ru"].contains(getLang()) ? 12.sp : 18.sp,
                          fontWeight: FontWeight.w600),
                      unselectedLabelColor: Get.theme.tabPanelUnSelectedColor,
                      unselectedLabelStyle: TextStyle(
                        fontSize: isIPad
                            ? 18.sp
                            : (['es', "en", "ru"].contains(getLang())
                                ? 12.sp
                                : 16.sp),
                        fontWeight: FontWeight.w400,
                      ),
                      tabs: controller.detailState.mainTabs
                          .map((e) => Tab(
                                child: Text(
                                  e.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onTap: (index) {
                        controller.setCurMainTab(index);
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
