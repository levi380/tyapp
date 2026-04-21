
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果 日期筛选  组件 DateWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果 日期筛选  组件 DateWidget
    - DateWidget
    ```
    DateWidget(
      title: controller.dateList[index].date,
      isSelected: controller.dateIndex == index ? true : false,
      isDark: context.isDarkMode,
      titleIndex: widget.titleIndex,
    )
    ```
    】】】
 *
 */

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
    this.onTap,
    required this.titleIndex,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final VoidCallback? onTap;
  final int titleIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w),
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? isSelected ? const Color(0xFF127DCC) :  Color(0xFFFFFFFF).withValues(alpha:0.5) : isSelected ? const Color(0xFF179CFF) : const Color(0xFF7981A3),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            if (titleIndex == 0 || titleIndex == 2)
              isSelected
                  ? Container(
                      width: 30.w,
                      height: 2.h,
                      decoration: ShapeDecoration(
                        color: isDark ? const Color(0xFF127DCC) : const Color(0xFF179CFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                    )
                  : Container(),
          ],
        ));
  }
}
