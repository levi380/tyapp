import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 列表带开关组件 PowerSwitchButtonWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 列表带开关组件   PowerSwitchButtonWidget
    - PowerSwitchButtonWidget
    ```
    PowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_sound_switch.tr,
      isDark: controller.isDarkMode,
      isSwitch: controller.soundSwitch,
      onTap: () => controller.onSoundSwitch(),
      dividing: true,
    )
    ```
    】】】
 *
 */

class PowerSwitchButtonWidget extends StatelessWidget {
  const PowerSwitchButtonWidget({
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
      height: ZrState.titleBarHeight,
      color:
          isDark ? ZrState.cardBgDarkAlpha04 : Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          left: ZrState.space15,
          right: ZrState.space15,
        ),
        decoration: dividing == true
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? ZrState.whiteAlpha008
                        : ZrState.bgColorLight,
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
                      ? ZrState.whiteAlpha09
                      : ZrState.textColorPrimary,
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
                          color: ZrState.primaryBlue,
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
                          color: ZrState.switchOffColor,
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
