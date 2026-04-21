import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-865e55c5-ff96-400e-9c5b-fa97bce48a09-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票设置菜单 开关按钮小组件  CpPowerSwitchButtonWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票设置菜单 开关按钮小组件   CpPowerSwitchButtonWidget
    - CpPowerSwitchButtonWidget
    ```
    CpPowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_cp_legacy.tr,
      isDark: controller.isDarkMode,
      isSwitch: controller.missRemind,
      onTap: () => controller.onLegacyReminders(),
      dividing: true,
    )
    ```
    】】】
 *
 */

class CpPowerSwitchButtonWidget extends StatelessWidget {
  const CpPowerSwitchButtonWidget({
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
      height: CpState.powerSwitchHeight,
      color:
          isDark ? CpState.amountRangeBgColorDark : Colors.white,
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
                        ? CpState.powerSwitchBorderColorDark
                        : CpState.powerSwitchBorderColorLight,
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
                      ? CpState.amountRangeTitleColorDark
                      : CpState.amountRangeTitleColorLight,
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
                          color: CpState.powerSwitchOnColor,
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
                          color: CpState.powerSwitchOffColor,
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
                  )
          ],
        ),
      ),
    );
  }
}
