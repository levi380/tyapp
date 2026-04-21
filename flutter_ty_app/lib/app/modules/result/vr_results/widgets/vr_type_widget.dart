import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/main.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 球种类型删选组件 VrTypeWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 球种类型删选组件 VrTypeWidget
    - VrTypeWidget
    ```
    ///球种类型删选组件
    VrTypeWidget(
      title: controller.vRMenuListData[index].name,
      isSelected: controller.vRMenuIndex == index ? true : false,
      isDark: context.isDarkMode,
      titleIndex: widget.titleIndex,
      menuId: controller.vRMenuIndex,
      imgUrl: imgUrl,
    )
    ```
    】】】
 *
 */
class VrTypeWidget extends StatelessWidget {
  const VrTypeWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
    this.onTap,
    required this.titleIndex,
    required this.menuId,
    required this.imgUrl,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final VoidCallback? onTap;
  final int titleIndex;
  final int menuId;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageView(
              imgUrl,
              width: 24.w,
              height: 24.w,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 2.h,
              ),
              child: Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha:0.5)
                      : isSelected
                          ? const Color(0xFF303442)
                          : const Color(0xFFAFB3C8),
                  fontSize: isIPad ? 12.sp : 10.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
