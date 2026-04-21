
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../utils/csid_util.dart';
import '../../../widgets/sport_icon.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 球类类型筛选 组件   TitleWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛球类类型筛选 组件   TitleWidget
    - TitleWidget
    ```
    TypeFilterWidget(
      onTap: () => controller.onTypeFilterIndex(controller.typeFilterIndex,controller.typeFilterList[controller.typeFilterIndex].sportId),
      title: controller.typeFilterList[controller.typeFilterIndex].name,
      miid:controller.typeFilterList[controller.typeFilterIndex].miid,
      isSelected: controller.typeFilterIndex == controller.typeFilterIndex ? true : false,
      isDark: context.isDarkMode,
      index: controller.typeFilterIndex,
      titleIndex: widget.titleIndex,
    )
    ```
    】】】
 *
 */
class TypeFilterWidget extends StatelessWidget {
  const TypeFilterWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isDark,
    required this.index,
    this.onTap,
    required this.titleIndex,
    required this.miid,
  });

  final String title;
  final bool isSelected;
  final bool isDark;
  final int index;
  final VoidCallback? onTap;
  final int titleIndex;
  final int miid;

  @override
  Widget build(BuildContext context) {
    int position = SpriteImagesPosition.data[(miid)] ?? 0;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // JltWidget(miid: miid, selected: isSelected),
            sportIcon(
              index: position,
              width: 24.w,
              height: 24.w,
              isSelected: isSelected,
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
