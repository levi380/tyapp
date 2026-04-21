import 'package:filbet/src/mine/transactionRecord/models/trade_dict.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/filter/custom_choice_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomTradeDict extends StatelessWidget {
  final RxList<TradeDict> filters;
  final void Function() onConfirm;
  String? title;

  BottomTradeDict({
    super.key,
    required this.filters,
    required this.onConfirm,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height - 100.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 👈 自动根据内容高度自适应
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilter(),

          /// 底部按钮
          Padding(
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFFEEF2FE), width: 1),
                      // 边框颜色和宽度
                      foregroundColor: appnewColors.textSecond,
                      // 文字颜色
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r), // 圆角
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
                      backgroundColor:
                          WidgetStateProperty.resolveWith<Color>((states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Colors.grey; // 禁用时背景色
                        }
                        return appnewColors.bg; // 默认背景色
                      }),
                      elevation: WidgetStateProperty.all(0),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      foregroundColor:
                          WidgetStateProperty.all(appnewColors.text4), // 文字颜色
                    ),
                    onPressed: () {
                      onConfirm();
                      Get.back();
                    },
                    child: Text(
                      "confirm".tr,
                      style:
                          TextStyle(fontSize: 14.sp, color: appnewColors.text4),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
              height: MediaQuery.of(context).padding.bottom + 16.h), // 底部安全区
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // 关键：高度随内容自适应
      children: [
        /// 一级标题
        Padding(
          padding:
              EdgeInsets.only(left: 14.w, right: 14.w, top: 24.r, bottom: 10.w),
          child: Text(
            title ?? 'trade_category'.tr,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: appnewColors.textMain),
          ),
        ),

        /// 一级分类
        Padding(
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Obx(() {
            return Wrap(
              spacing: 8,
              runSpacing: 9,
              children: filters.map((filter) {
                final isSelected = filter.bottomSelected;
                return CustomChoiceChip(
                  label: filter.name ?? '',
                  selected: isSelected,
                  onSelected: (_) {
                    for (var item in filters) {
                      item.bottomSelected = false;
                    }
                    filter.bottomSelected = true;
                    print("object123456");
                    filters.refresh();
                  },
                );
              }).toList(),
            );
          }),
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
