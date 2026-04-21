import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/welfareCenter/welfare_item_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/themes/app_newcolor.dart';
import '../controllers/welfare_center_controller.dart';


class DialogrewrdView extends StatefulWidget {
  final WelfareItemModel item;

  const DialogrewrdView({super.key, required this.item});

  @override
  State<StatefulWidget> createState() {
    return DialogChangeGenderState();
  }
}

class DialogChangeGenderState extends State<DialogrewrdView> {
  WelfareCenterController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360.h + ScreenUtil().bottomBarHeight,
      width: 1.sw,
      decoration: BoxDecoration(color: appnewColors.bg1, borderRadius: BorderRadius.circular(16.w)),
      child: Column(
        children: [
          _buildTitle(),
          _buildContent(),

          Spacer(), // 撑开中间空隙
          _buildBtn(),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20), // 底部安全区
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
        // height: 257.w,
        padding: EdgeInsets.only(top: 10, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 上方信息卡片区域
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildItem(
                    "welfare_amt".tr,
                    controller.symbol(widget.item.currency ?? 0) +
                        "${(double.tryParse(widget.item.amount ?? 0.toString()) ?? 0).toStringAsFixed(2)}",
                    true,
                  ),
                  _buildItem(
                      "roll_req".tr,
                      "${((double.tryParse(widget.item.water ?? 0.toString()) ?? 0) * (double.tryParse(widget.item.amount ?? 0.toString()) ?? 0)).toStringAsFixed(2)}",
                      true),
                  _buildItem(
                      "roll_multi".tr,
                      "${(double.tryParse(widget.item.water ?? 0.toString()) ?? 0).toStringAsFixed(0)}" + "times".tr,
                      false),
                  _buildItem("场馆限制".tr, "${widget.item.platNames}", false),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // 实际到账金额
            if (controller.currencyStr == "100")
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "actual_amt_colon".tr,
                      style: TextStyle(color: Color(0xff6C8FA2), fontSize: 12.sp),
                    ),
                    TextSpan(
                      text: controller.symbolbance(widget.item),
                      style: TextStyle(
                        color: Colors.green[600],
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 12.h),
          ],
        ));
  }

  Widget _buildItem(String title, String value, bool isGree) {
    return Container(
      height: 44.h,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE9E9E9), // 颜色
            width: 1.0, // 粗细
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title + ":",
            style: TextStyle(
              fontSize: 14.sp,
              color: appnewColors.text2,
            ),
          ),
          SizedBox(width: 6.r),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isGree ? appnewColors.tip2 : appnewColors.text1,
              ),
              maxLines: 3,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 10.w, left: 10.w, right: 20.w),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
                // width: 30.w,
                height: 30.w,
                child: Center(
                    child: Text(
                  "领取确认".tr,
                  style: TextStyle(color: appnewColors.text1, fontSize: 16.sp),
                ))),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Container(
                width: 30.w,
                height: 30.w,
                child: Center(
                  child: Image.asset(
                    Assets.mineIconCloes,
                    width: 16.w,
                    height: 16.w,
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBtn() {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: appnewColors.bg, width: 1), // 边框颜色和宽度
                foregroundColor: appnewColors.bg, // 文字颜色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 圆角
                ),
                // 内边距
              ),
              onPressed: () => Get.back(),
              child: Text(
                "cancel".tr,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey; // 禁用时背景色
                  }
                  return appnewColors.bg; // 默认背景色
                }),
                foregroundColor: MaterialStateProperty.all(appnewColors.text4), // 文字颜色
              ),
              onPressed: () {
                controller.memberinsert(widget.item);
                Get.back();
              },
              child: Text(
                "confirm".tr,
                style: TextStyle(fontSize: 14.sp, color: appnewColors.text4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
