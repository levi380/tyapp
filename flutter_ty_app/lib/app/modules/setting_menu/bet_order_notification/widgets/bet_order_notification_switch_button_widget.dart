import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 注单通知 开关 组件 BetOrderNotificationSwitchButtonWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 注单通知 开关 组件
    - BetOrderNotificationSwitchButtonWidget
    - 设置菜单 注单通知 开关 组件
    】】】
 *
 */

class BetOrderNotificationSwitchButtonWidget extends StatelessWidget {
  const BetOrderNotificationSwitchButtonWidget({
    super.key,
    required this.title,
    required this.isDark,
    this.onTap,
    required this.dividing,
    required this.isSwitch,
  });

  final String title;
  final bool isDark;
  final VoidCallback? onTap;
  final bool dividing;
  final bool isSwitch;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      margin: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
        ),
        decoration: dividing == true
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.07999999821186066)
                        : const Color(0xFFF2F2F6),
                    width: 0.50.h,
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
            isSwitch
                ? Expanded(
                    flex: 0,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        width: 36.w,
                        padding: EdgeInsets.all(2.h),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF179CFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    flex: 0,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        width: 36.w,
                        padding: EdgeInsets.all(2.h),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE4E6ED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 18.w,
                              height: 18.w,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(43.r),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
