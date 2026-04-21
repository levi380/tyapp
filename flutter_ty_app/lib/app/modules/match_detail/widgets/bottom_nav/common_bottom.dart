import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../routes/app_pages.dart';
import '../../../main_tab/main_tab_controller.dart';
import '../../controllers/match_detail_controller.dart';
import 'chat_input_box.dart';
import 'nav_button.dart';

/// 详情底部导航
class CommonBottom extends StatelessWidget {
  const CommonBottom({
    super.key,
    required this.controller,
    this.tag,
  });

  final MatchDetailController controller;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: obtyBottomHeight,
      padding: EdgeInsets.only(top: 8.h, left: 14.w, right: 14.w, bottom: 8.h),
      decoration: BoxDecoration(
        color: Get.theme.bottomBgColor,
        boxShadow: [
          BoxShadow(
            color: Get.isDarkMode
                ? Colors.black.withAlpha(90)
                : Colors.grey.withAlpha(40),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          height: 36.h,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ChatInputBox(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 赛果
                      NavButton(
                        title: LocaleKeys.menu_itme_name_results.tr,
                        type: NavButtonType.matchResult,
                        onTap: () {
                          Get.toNamed(Routes.matchResults)?.then((e) {
                          });
                        },
                      ),

                      // 未结注单
                      NavButton(
                        title: LocaleKeys.app_unsettled.tr,
                        onTap: MainTabController.to.openOngoingBetsPage,
                      ),

                      // 已结注单
                      NavButton(
                        title: LocaleKeys.app_settled.tr,
                        onTap: MainTabController.to.openClosedBetsPage,
                      ),

                      // 刷新
                      NavButton(
                        type: NavButtonType.refresh,
                        onTap: controller.refreshData,
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
