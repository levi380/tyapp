import 'package:filbet/src/mine/vip/detail/controllers/vip_rules_controller.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VipRuleView extends GetView<VipRulesController> {
  const VipRuleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 20.h),
      color: appColors.textWhiteColor,
      child: SingleChildScrollView(
        child: Column(children: [
          Row(
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
              Expanded(
                child: Text(
                  "general_terms".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: appnewColors.textMain),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Obx(() {
            return Column(
              children: List.generate(controller.rulesData.length, (index) {
                Map<String, dynamic> data = controller.rulesData[index];
                String title = data["title"];
                String content = data["content"];
                return Container(
                  margin: EdgeInsets.only(bottom: 15.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 18.w,
                        height: 18.w,
                        margin: EdgeInsets.only(top: 3.w),
                        decoration: BoxDecoration(
                            color: appColors.textMain2Color,
                            borderRadius: BorderRadius.circular(9.w)),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: appColors.textWhiteColor),
                          ),
                        )),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: appColors.textMainColor),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                              width: Get.width - 60.w,
                              child: Text(
                                content,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: appColors.inputTextStyleColor),
                              ))
                        ],
                      )
                    ],
                  ),
                );
              }),
            );
          }),
          Row(
            children: [
              SizedBox(
                width: 26.w,
              ),
              Expanded(
                child: Text(
                  "keep_explain_content".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: appColors.textMain2Color),
                ),
              )
            ],
          ),
          SizedBox(
            height: 40.h,
          )
        ]),
      ),
    );
  }
}
