import 'package:filbet/src/mine/vip/detail/widgets/vip_horizontal_table.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_rebate_controller.dart';
import 'package:filbet/src/mine/vip/detail/views/vip_rules_view.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VipRebateView extends GetView<VipRebateController> {
  const VipRebateView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg5,
      needAppbar: false,
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: EdgeInsets.only(
                    left: 14.w, right: 14.w, top: 10.h, bottom: 6.h),
                color: appColors.textWhiteColor,
                child: Row(
                  children: [
                    Container(
                      width: 3.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                          color: appnewColors.bg,
                          borderRadius: BorderRadius.circular(4.r)),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "VIP ${"rebate_rate".tr}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: appColors.textMainColor),
                    ),
                  ],
                )),
            _buildTabWidget(),
            VipRuleView(),
          ]),
        ),
      ),
    );
  }

  Widget _buildTabWidget() {
    return HorizontalScrollableTable();
  }

}
