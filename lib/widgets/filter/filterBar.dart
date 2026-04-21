import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'filter_model.dart'; // 这里引入你定义的 FilterModel / SubFilterModel / FilterType
import 'package:filbet/generated/assets.dart';

class FilterBar extends StatelessWidget {
  final List<FilterModel> filters;
  final VoidCallback onTapFilter;
  final BoxDecoration? decoration;
  final Color? textColor;

  const FilterBar({
    super.key,
    required this.filters,
    required this.onTapFilter,
    this.decoration,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.w,
      color: appnewColors.bg1,
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      child: Row(
        children: [
          /// 左边已选条件标签
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((filter) {
                  // 优先显示 showName，其次 name
                  final text = filter.currentModel.showName ?? filter.currentModel.name;

                  return InkWell(
                      onTap: () {
                        onTapFilter();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: decoration ??
                            BoxDecoration(
                              color: appnewColors.bg4,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: textColor??appnewColors.text1,
                          ),
                        ),
                      ));
                }).toList(),
              ),
            ),
          ),

          /// 右边筛选按钮
          GestureDetector(
            onTap: () {
              onTapFilter();
            },
            child: Row(
              children: [
                Text(
                  "filter".tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  Assets.loginArrowDown,
                  width: 14.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
