import 'package:filbet/src/mine/vip/detail/controllers/vip_detail_controller.dart';
import 'package:filbet/src/mine/vip/detail/views/vip_bonus_view.dart';
import 'package:filbet/src/mine/vip/detail/views/vip_monthly_view.dart';
import 'package:filbet/src/mine/vip/detail/views/vip_rabate_view.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VipDetailView extends GetView<VipDetailController> {
  const VipDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      appBar: CustomAppbar.normalTitle(
        title: 'vip_detail'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: PopScope(
        onPopInvokedWithResult: (didPop, _) {},
        child: _buildPageWithTabbar(),
      ),
    );
  }

  Widget _buildPageWithTabbar() {
    return Obx(() {
      return Column(
        children: [
          _buildTypeTabbar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                VipMonthlyView(),
                VipRebateView(),
                VipBonusView(),
                //  VipRuleView(),
              ],
            ),
          ),
        ],
      );
    });
  }

  ///存/取tabbar
  Widget _buildTypeTabbar() {
    return Container(
      decoration: BoxDecoration(
        color: appnewColors.bg1,
      ),
      height: 46,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        tabs: List.generate(controller.tabs.length, (index) {
          return Tab(
            child: SizedBox(height: 20.h, child: Text(controller.tabs[index])),
          );
        }),
        unselectedLabelStyle: TextStyle(
            color: appnewColors.text2,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600),
        labelStyle: TextStyle(
            color: appnewColors.text7,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600),
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 15.r),
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3.0,
            color: appnewColors.bg,
          ),
        ),
      ),
    );
  }
}
