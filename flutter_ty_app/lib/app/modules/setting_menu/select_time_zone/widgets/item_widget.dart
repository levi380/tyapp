import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/image_view.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-92b5c1c1-aea9-4179-92a5-95a0e2cbaa93-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 时区】】】
    【【【 AUTO_PARAGRAPH_TITLE 时区 列表Item组件 ItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 时区 列表Item组件 ItemWidget
    - ItemWidget
    ```
    ///列表Item组件
    ItemWidget(
      isDark: context.isDarkMode,
      onTap: () => controller.onSelect(index),
      title: TimeZoneUtils.timeZone.values.toList()[index],
      isSelected: TimeZoneUtils.zoneIndex ==
      TimeZoneUtils.timeZone.keys.toList()[index]
      ? true
      : false,
      dividing: true,
    )
    ```
    】】】
 *
 */
class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    this.onTap,
    required this.isDark,
    required this.isSelected,
    required this.dividing,
  });

  final bool isDark;
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool dividing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 46.h,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDark
                      ? isSelected
                      ? const Color(0xFF179CFF)
                      : Colors.white.withValues(alpha:0.5)
                      : isSelected
                      ? const Color(0xFF179CFF)
                      : const Color(0xFF7981A3),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isSelected)
                ImageView(
                  "assets/images/language/selected.png",
                  width: 20.w,
                  height: 20.w,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
