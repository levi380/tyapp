
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果头部标题组件 组件   TitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果头部标题组件  组件   TitleWidget
    - TitleWidget
    ```
    TitleWidget(
      onTap: () => controller.onTitleIndex(index),
      title: controller.titleList[index],
      isSelected: controller.titleIndex == index ? true : false,
      isDark: context.isDarkMode,
    )
    ```
    】】】
 *
 */
class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
    this.onTap,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: isIPad ? 30.w : 0.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
              ),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.5)
                      : isSelected
                          ? const Color(0xFF303442)
                          : const Color(0xFF7981A3),
                  fontSize: 16.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 2.h,
            ),
            isSelected
                ? Container(
                    margin: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                    ),
                    width: 64.w,
                    height: 2.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF179CFF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
