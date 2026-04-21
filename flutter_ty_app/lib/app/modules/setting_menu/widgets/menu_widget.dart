import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import '../../../../main.dart';
import '../../../widgets/image_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 简单文字带更多按钮页面 MenuWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 简单文字带更多按钮页面 MenuWidget
    ```
    MenuWidget(
      onTap: () => controller.toHandicapSettings(),
      title: LocaleKeys.footer_menu_odds_set.tr,
      isDark: controller.isDarkMode,
      imageUrl: '',
      subTitle: TYUserController.to.getCurHandicapName(),
      summary: '',
      dividing: true,
      enabled: !isEuOnly,
      bigFontSize: true,
    )
    ```
    】】】
 *
 */
class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    required this.summary,
    required,
    required this.isDark,
    required this.subTitle,
    required this.dividing,
    this.enabled = true,
    required this.bigFontSize,
  });

  final bool isDark;
  final bool dividing;
  final String title;
  final String subTitle;
  final String summary;
  final String imageUrl;
  final VoidCallback? onTap;
  final bool enabled;
  final bool bigFontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        color: isDark
            ? Colors.white.withValues(alpha:0.03999999910593033)
            : Colors.white,
        child: Container(
          decoration: dividing == true
              ? BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha:0.07999999821186066)
                          : const Color(0xFFF2F2F6),
                      width: 0.50.h,
                    ),
                  ),
                )
              : null,
          margin: EdgeInsets.only(
            left: 14.w,
            right: 14.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 320.w,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: enabled?(isDark
                            ? Colors.white.withValues(alpha:0.8999999761581421)
                            : const Color(0xFF303442)):(isDark
                            ? Colors.white.withValues(alpha:0.30000001192092896)
                            : const Color(0xFFAFB3C8)),
                        fontSize: bigFontSize ? 14.sp.scale :14.sp,
                        fontFamily: 'PingFang SC',
                        height: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: 5.w,
                  ),
                  if (summary.isNotEmpty)
                    Text(
                      summary,
                      style: TextStyle(
                        height: 1,
                        color: isDark
                            ? Colors.white.withValues(alpha:0.30000001192092896)
                            : const Color(0xFFAFB3C8),
                        fontSize: bigFontSize ? 14.sp.scale : 14.sp,
                      ),
                    ),
                ],
              ),
              Expanded(child: SizedBox()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imageUrl.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(right: 0.w),
                      alignment: Alignment.centerRight,
                      child: ImageView(
                        imageUrl,
                        width: 70.w,
                        height: 24.h,
                      ),
                    ),
                  Container(
                    width: 5.w,
                  ),

                  if (subTitle.isNotEmpty)
                    Container(
                      alignment: Alignment.centerRight,
                      width: imageUrl.isEmpty ? isIPad ? 200.w:150.w : null,
                      child: Text(
                        subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          height: 1,
                          color: isDark
                              ? Colors.white.withValues(alpha:0.30000001192092896)
                              : const Color(0xFFAFB3C8),
                          fontSize: bigFontSize ? 14.sp.scale : 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ,
                  if (enabled)
                    Container(
                      width: 5.w,
                    ),
                  if (enabled)
                    ImageView(
                      isDark
                          ? "assets/images/icon/icon_arrow_right_grey.png"
                          : "assets/images/icon/icon_arrow_right_grey_light.png",
                      width: 16.w,
                      height: 16.w,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
