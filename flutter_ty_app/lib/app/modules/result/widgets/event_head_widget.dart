
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 菜单组件 EventHeadWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情 菜单组件 EventHeadWidget
    - EventHeadWidget
    ```
    ///精选赛事
    EventHeadWidget(
      onTap: () => onEventHeadIndex(1),
      title: LocaleKeys.match_info_select_event.tr,
      isSelected: eventHeadIndex == 1 ? true : false,
      isDark: context.isDarkMode,
    )
    ```
    】】】
 *
 */

class EventHeadWidget extends StatelessWidget {
  const EventHeadWidget({
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
    return Container(
      margin: EdgeInsets.only(
        left: 20.w,
      ),
      child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.5)
                      : isSelected
                          ? const Color(0xFF303442)
                          : const Color(0xFF303442),
                  fontSize: isIPad? isSelected? 18.sp: 16.sp: isSelected? 16.sp: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (isSelected)
                Container(
                  width: 70.w,
                  height: 3.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF179CFF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                  ),
                )
            ],
          )),
    );
  }
}
