import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_model.dart'; // 这里引入你定义的 FilterModel / SubFilterModel / FilterType
import 'custom_choice_chip.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<FilterModel> filters;
  final void Function(List<FilterModel>) onConfirm;

  const FilterBottomSheet({
    super.key,
    required this.filters,
    required this.onConfirm,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 👈 自动根据内容高度自适应
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 可滚动区域
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.filters.length,
              itemBuilder: (context, index) {
                return _buildFilter(widget.filters[index]);
              },
            ),
          ),

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
                      foregroundColor: appnewColors.text2,
                      // 文字颜色
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // 圆角
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
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey; // 禁用时背景色
                        }
                        return appnewColors.bg; // 默认背景色
                      }),
                      foregroundColor:
                          MaterialStateProperty.all(appnewColors.text4), // 文字颜色
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 圆角
                        ),
                      ),
                    ),
                    onPressed: () {
                      resetInvalidSelections(widget.filters);
                      widget.onConfirm(widget.filters);
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

  void resetInvalidSelections(List<FilterModel> filters) {
    for (var filter in filters) {
      //这里有问题，还有子分类可以不同,已做如下修改
      // if (filter.selectModel != null &&
      //     filter.selectModel!.value != filter.currentModel.value) {
      if (filter.selectModel != null) {
        filter.currentModel = filter.selectModel!;
        filter.selectIndex = filter.list?.indexOf(filter.selectModel!) ?? 0;
        if (filter.selectModel?.filterModel != null) {
          filter.currentModel.filterModel?.currentModel =
              filter.selectModel!.filterModel!.selectModel!;
          filter.currentModel.filterModel?.selectIndex = filter
              .currentModel.filterModel!.list!
              .indexOf(filter.selectModel!.filterModel!.selectModel!);
        }
      }
    }
  }

  Widget _buildFilter(FilterModel filter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // 关键：高度随内容自适应
      children: [
        /// 一级标题
        Padding(
          padding:
              EdgeInsets.only(left: 14.w, right: 14.w, top: 10.w, bottom: 10.w),
          child: Text(
            filter.title,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: appnewColors.text1),
          ),
        ),

        /// 一级分类
        Padding(
          padding: EdgeInsets.only(left: 14.w, right: 14.w),
          child: Wrap(
            spacing: 8,
            runSpacing: 9,
            children: filter.list!.map((sub) {
              final isSelected = filter.selectModel?.value == sub.value;

              return CustomChoiceChip(
                label: sub.showName ?? sub.name,
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    filter.selectModel = sub;
                    filter.selectIndex = filter.list!.indexOf(sub);
                  });
                },
              );
            }).toList(),
          ),
        ),

        /// 二级分类（带标题）
        if (filter.selectModel?.filterModel != null) ...[
          const SizedBox(height: 12),
          Container(
            color: appnewColors.bg10,
            width: double.infinity,
            padding:
                EdgeInsets.only(left: 14.w, right: 14.w, bottom: 5.h, top: 5.h),
            child: Text(
              filter.selectModel!.filterModel!.title,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: appnewColors.text2),
            ),
          ),
          Container(
            width: double.infinity,
            color: appnewColors.bg10,
            padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 12.h),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filter.selectModel!.filterModel!.list!.map((subItem) {
                final isSubSelected =
                    filter.selectModel!.filterModel!.selectModel?.value ==
                        subItem.value;

                return CustomChoiceChip(
                  label: subItem.showName ?? subItem.name,
                  selected: isSubSelected,
                  onSelected: (_) {
                    setState(() {
                      filter.selectModel!.filterModel!.selectModel = subItem;
                      filter.selectModel!.filterModel!.selectIndex = filter
                          .selectModel!.filterModel!.list!
                          .indexOf(subItem);
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
        SizedBox(height: 16.h),
      ],
    );
  }
}
