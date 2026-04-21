import 'package:filbet/generated/assets.dart';
import 'package:filbet/http/entity/activity_apply_model.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/time_util.dart';
import 'package:filbet/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CancelDepositDialog extends StatelessWidget {
  CancelDepositDialog({super.key});

  final items = [
    '陌生转账提示风险',
    '收款银行卡冻结/银行卡限额',
    '找不到开户行',
    '不出收款码',
    '不想存款了',
    '其他原因',
  ];
  final checkIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.r),
        decoration: BoxDecoration(
          color: appnewColors.bg1,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleView(),
            subTitleView(),
            contentView(),
            bottomView(),
          ],
        ),
      ),
    );
  }

  Widget titleView() {
    return Container(
      margin: EdgeInsets.only(top: 20.r),
      child: Text(
        '是否取消本次存款？',
        style: TextStyle(
          color: Color(0xFF697B87),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget subTitleView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.r),
      child: Text(
        '如已完成付款，请勿取消！否则导致存款不到账，平台不负责！',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF697B87),
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget contentView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 12.r),
      child: Column(
        spacing: 6.r,
        children: [
          ...items.map((item) {
            int index = items.indexOf(item);
            return InkWell(
              onTap: () {
                checkIndex.value = index;
              },
              child: Obx(() {
                return Container(
                  height: 32.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: checkIndex.value == index
                          ? appnewColors.textBlue
                          : Color(0xFFF3F3F3),
                    ),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: Color(0xFF484D51),
                      fontSize: 14.sp,
                    ),
                  ),
                );
              }),
            );
          })
        ],
      ),
    );
  }

  Widget bottomView() {
    return Container(
      height: 48.r,
      margin: EdgeInsets.only(top: 12.r),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
          ),
        ),
      ),
      child: Row(
        children: [
          bottomItemView('确定取消', () {
            String reason = items[checkIndex.value];
            Get.back(result: reason);
          }),
          Container(
            height: 48.r,
            width: 1,
            color: Color(0xFFEEEEEE),
          ),
          bottomItemView('我再想想', () {
            Get.back();
          }),
        ],
      ),
    );
  }

  Widget bottomItemView(String content, GestureTapCallback? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1D1D1F),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
