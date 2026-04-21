import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';




/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 关闭按钮组件 CloseWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 组件  CloseWidget
    - CloseWidget
    ```
    CloseWidget(
      title: LocaleKeys.common_close.tr,
      isDark: controller.isDarkMode,
      onTap: () => controller.toClose(),
      bigFontSize: false,
    )
    ```
    】】】
 *
 */
class CloseWidget extends StatelessWidget {
  const CloseWidget({
    super.key,
    required this.title,
    required this.isDark,
    this.onTap,
    required this.bigFontSize,
  });

  final String title;
  final bool isDark;
  final VoidCallback? onTap;
  final bool bigFontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: ZrState.settingCloseBtnHeight,
        color: isDark
            ? ZrState.cardBgDarkAlpha04
            : Colors.white,
        margin: EdgeInsets.only(
          top: ZrState.settingCloseBtnTopMargin,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: ZrState.space15,
            right: ZrState.space15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDark
                      ? ZrState.whiteAlpha09
                      : ZrState.textColorPrimary,
                  fontSize: bigFontSize ? 18.sp.scale : 18.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
