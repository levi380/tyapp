import 'package:flutter/material.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:filbet/generated/assets.dart';

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    double itemWidth = (ScreenUtil().screenWidth - 14.w * 2 - 8 * 3) / 4;
    return GestureDetector(
      onTap: onSelected != null ? () => onSelected!(selected) : null,
      child: Container(
        height: 36.r,
        width: itemWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: selected ? appnewColors.bg : Color(0xFFEEF2FE),
            width: 1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// 文字
            Container(
              // padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: selected ? appnewColors.bg : appnewColors.textSecond,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),

            /// 右下角角标
            if (selected)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  // ✅ 强制裁剪

                  decoration: BoxDecoration(
                      // color: appnewColors.bg,
                      // borderRadius:  BorderRadius.only(
                      //   topLeft: Radius.circular(99), // 左上角圆角
                      //   //   topRight: Radius.circular(8),
                      //      bottomRight: Radius.circular(7), // 右下角圆角
                      // ),
                      ),
                  width: 15.w,
                  height: 11.w,
                  child: Image.asset(
                    Assets.mineRightChiop,
                    width: 15.w,
                    height: 11.w,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
