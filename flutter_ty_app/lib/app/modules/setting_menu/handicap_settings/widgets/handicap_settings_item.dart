import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/image_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5b682c84-d24f-4fa7-830c-023cfe22939a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口设置】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口设置 列表组件 HandicapSettingsItem 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口设置 列表组件 HandicapSettingsItem
    - HandicapSettingsItem
    ```
      HandicapSettingsItem(
      ///Title 名称
      title: item.label.tr,
      ///是否选中
      isSelected: TYUserController.to.curOdds == item.value,
      ///点击方法
      onTap: () =>logic.updateHandicapType(item.handicapType.toInt(), item.value),
      )
    ```
    】】】
 *
 */
class HandicapSettingsItem extends StatelessWidget {
  const HandicapSettingsItem({
    super.key,
    required this.title,
    this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 12.w),
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : Colors.white,
        child: Container(
          height: 38.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(context.isDarkMode ? 0xFF15161B : 0xFFF2F2F6),
                width: 0.50.h,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageUrl != null)
                    ImageView(
                      imageUrl!,
                      width: 25.w,
                      height: 18.w,
                    ).marginOnly(right: 8.w),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Color(isSelected ? 0xFF179CFF : 0xFF7981A4),
                        fontSize: 13.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 10.w),
                child: isSelected
                    ? ImageView(
                        "assets/images/language/selected.png",
                        width: 20.w,
                        height: 20.w,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
