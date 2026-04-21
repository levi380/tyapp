import 'package:filbet/src/activity/lottery_record/lottery_record_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/utils/num_util.dart';
import 'package:filbet/utils/time_util.dart';

import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:filbet/widgets/custom_scffold.dart';

class LotteryRecordView extends GetView<LotteryRecordController> {
  const LotteryRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg1,
      appBar: CustomAppbar.normalTitle(
        title: '抽奖记录'.tr,
        bgColor: appnewColors.bg1,
      ),
      body: SafeArea(
        child: Column(
          children: [
            tabView(),
            totalView(),
            Expanded(child: SingleChildScrollView(child: dataView())),
          ],
        ),
      ),
    );
  }

  Widget tabView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.r),
      child: Row(
        children: [
          tabItemView('明细记录', 0),
          tabItemView('统计数据', 1),
        ],
      ),
    );
  }

  Widget totalView() {
    return Container(
      height: 40.r,
      padding: EdgeInsets.symmetric(horizontal: 14.r),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return titleAndContentView(
              '奖品总计：',
              '${controller.winnerRecord.where((item) => item.rewardType == 1).length}',
              '个',
              contentColor: appnewColors.textBlue,
            );
          }),
          Obx(() {
            return titleAndContentView(
              '礼金总计：',
              controller.summary.value.cashAmount?.toFixed2() ?? '--',
              '元',
              contentColor: appnewColors.text14,
            );
          }),
        ],
      ),
    );
  }

  Widget dataView() {
    return Container(
      margin: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: appnewColors.colorLine2, width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Obx(() {
            int index = controller.tabIndex.value;
            return dataTitleView('序号', index == 0 ? '中奖时间' : '抽中奖励',
                index == 0 ? '抽中奖励' : '总计数量');
          }),
          dataListView(),
        ],
      ),
    );
  }

  Expanded tabItemView(String title, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.changeTabIndex(index);
        },
        child: SizedBox(
          height: 44.r,
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: controller.tabIndex.value == index
                        ? appnewColors.textMain
                        : appnewColors.textSecond,
                    fontSize: 14.sp,
                    fontWeight: controller.tabIndex.value == index
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
                Container(
                  height: 3.r,
                  width: 30.r,
                  margin: EdgeInsets.only(top: 8.r),
                  color: controller.tabIndex.value == index
                      ? appnewColors.bgBlue
                      : Colors.transparent,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget titleAndContentView(String title, String content, String unit,
      {Color? contentColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: appnewColors.textMain,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            color: contentColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          unit,
          style: TextStyle(
            color: appnewColors.textMain,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget dataTitleView(String title1, String title2, String title3,
      {bool needDivider = true,
      bool needBgColor = true,
      bool isTitle = true,
      bool isBottom = false}) {
    return Container(
      height: 40.r,
      decoration: BoxDecoration(
        color: needBgColor ? Color(0xffF6F7FA) : null,
        borderRadius: BorderRadius.vertical(
          top: isTitle ? Radius.circular(16.r) : Radius.zero,
          bottom: isBottom ? Radius.circular(16.r) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 72.r,
            alignment: Alignment.center,
            child: Text(
              title1,
              style: TextStyle(
                color: appnewColors.textMain,
                fontWeight: isTitle ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
          if (needDivider)
            Container(
              height: 25.r,
              width: 1,
              color: Color(0xffE8E8E8),
            ),
          Expanded(
            child: Text(
              title2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appnewColors.textMain,
                fontWeight: isTitle ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
          if (needDivider)
            Container(
              height: 25.r,
              width: 1,
              color: Color(0xffE8E8E8),
            ),
          Container(
            width: 122.r,
            alignment: Alignment.center,
            child: Text(
              title3,
              style: TextStyle(
                color: appnewColors.textMain,
                fontWeight: isTitle ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dataListView() {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          String str1 = '';
          String str2 = '';
          if (controller.tabIndex.value == 0) {
            var model = controller.winnerRecord[index];
            str1 = formatDateTimeToString(DateTime.fromMillisecondsSinceEpoch(
                model.createdAt?.toInt() ?? 0));
            str2 = model.rewardType == 2
                ? model.rewardAmount ?? ''
                : "${model.rewardAmount ?? ''}元礼金";
          } else {
            var model = controller.rewardTotals[index];
            str1 = model.rewardType == 2
                ? model.rewardAmount ?? ''
                : "${model.rewardAmount ?? ''}元礼金";
            str2 = '${model.count ?? ''}';
          }
          return dataTitleView(
            '${index + 1}',
            str1,
            str2,
            needDivider: false,
            needBgColor: index % 2 == 1,
            isTitle: false,
            isBottom: index == 2,
          );
        },
        itemCount: controller.tabIndex.value == 0
            ? controller.winnerRecord.length
            : controller.rewardTotals.length,
      );
    });
  }
}
