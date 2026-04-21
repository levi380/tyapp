import 'package:filbet/src/mine/vip/detail/widgets/vip_horizontal_table.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_monthly_controller.dart';
import 'package:filbet/src/mine/vip/detail/controllers/vip_rebate_controller.dart';
import 'package:filbet/src/mine/vip/detail/widgets/vip_monthly_horizontal_table.dart';
import 'package:filbet/src/mine/vip/detail/views/vip_rules_view.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VipMonthlyView extends GetView<VipMonthlyController> {
  const VipMonthlyView({super.key});

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
            titleView(),
            _buildTabWidget(),
            VipRuleView(),
          ]),
        ),
      ),
    );
  }

  Widget titleView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.only(
                left: 14.w, right: 14.w, top: 10.h, bottom: 2.h),
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
                  "VIP ${"weekly_redpacket".tr}",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: appColors.textMainColor),
                ),
              ],
            )),
        Container(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 6.h),
            color: appColors.textWhiteColor,
            child: Row(
              children: [
                SizedBox(
                  width: 13.w,
                ),
                Expanded(
                  child: Text(
                    "有效投注满足要求,则可以在周六至周三领取每周红包至以下场馆。",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: appnewColors.textSecond),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _buildTabWidget() {
    return VipMonthlyHorizontalTable();
  }
}
