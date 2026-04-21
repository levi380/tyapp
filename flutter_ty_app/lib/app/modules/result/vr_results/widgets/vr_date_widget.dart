
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 头部日期删小组件 vRDateWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 头部日期删选组件 vRDateWidget
    - vRDateWidget
    ```
    ///头部日期删选组件
    VrZqItemTeamWidget(
      teamIcon: recordsList[index].awayUrl,
      teamName: recordsList[index].awayName,
      isDark: isDark，
    )
    ```
    】】】
 *
 */
class vRDateWidget extends StatelessWidget {
  const vRDateWidget({
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
                  color: isDark
                      ? isSelected
                          ? const Color(0xFF127DCC)
                          : Color(0xFFFFFFFF).withValues(alpha:0.5)
                      : isSelected
                          ? const Color(0xFF179CFF)
                          : const Color(0xFF7981A3),
                  fontSize: isIPad ? 14.sp : 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ));
  }
}
