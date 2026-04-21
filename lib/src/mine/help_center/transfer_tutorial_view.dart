import 'package:filbet/generated/assets.dart';
import 'package:filbet/src/mine/help_center/transfer_tutorial_controller.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/custom_scffold.dart';
import 'package:filbet/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransferTutorialView extends GetView<TransferTutorialController> {
  const TransferTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScffold(
      showBgTexture: false,
      backgroundColor: appnewColors.bg15,
      appBar: CustomAppbar.normalTitle(
        bgColor: appnewColors.textWhite,
        title: '转账教程'.tr,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTutorialList(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // 构建教程列表
  Widget _buildTutorialList() {
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 0),
      decoration: BoxDecoration(
        color: appnewColors.bg1,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Obx(() {
        return Column(
          children: List.generate(
            controller.tutorialItems.length,
            (index) {
              final item = controller.tutorialItems[index];
              final isExpanded = controller.expandedStates[index];

              return _buildTutorialItem(
                index: index,
                item: item,
                isExpanded: isExpanded,
              );
            },
          ),
        );
      }),
    );
  }

  // 构建单个教程项
  Widget _buildTutorialItem({
    required int index,
    required TransferTutorialItem item,
    required bool isExpanded,
  }) {
    final isLast = index == controller.tutorialItems.length - 1;

    return Column(
      children: [
        // 问题标题行（可点击）
        InkWell(
          onTap: () => controller.toggleExpanded(index),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: isLast || isExpanded
                  ? null
                  : Border(
                      bottom: BorderSide(
                        color: appnewColors.colorLine,
                        width: 1,
                      ),
                    ),
            ),
            child: Row(
              children: [
                // 问题文本
                Expanded(
                  child: Text(
                    item.question,
                    style: TextStyle(
                      color: appnewColors.text1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // 右箭头图标
                Transform.rotate(
                  angle: isExpanded ? 1.5708 : 0, // 展开时旋转90度（向下）
                  child: Image.asset(
                    Assets.mineIconArrowR,
                    width: 16.r,
                    height: 16.r,
                    color: appnewColors.text2,
                  ),
                ),
              ],
            ),
          ),
        ),
        // 答案内容（展开时显示）
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.topCenter,
          child: isExpanded
              ? Container(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : Border(
                            bottom: BorderSide(
                              color: appnewColors.colorLine,
                              width: 1,
                            ),
                          ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.answer,
                        style: TextStyle(
                          color: appnewColors.text2,
                          fontSize: 14.sp,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (item.imgUrl != null) Image.asset(item.imgUrl ?? ''),
                      if (item.tips != null)
                        Text(
                          item.tips ?? '',
                          style: TextStyle(
                            color: Color(0xFFDA6371),
                            fontSize: 14.sp,
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
