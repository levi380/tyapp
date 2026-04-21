import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 正面交手列表展开/收起按钮
///
/// 列表超过 5 条时显示；点击切换 [isExpanded] 并触发 [onToggle]
class MatchStatisticListExpandButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const MatchStatisticListExpandButton({
    super.key,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        child: isExpanded
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 2.w),
                  Text(
                    LocaleKeys.bet_pack_up.tr,
                    style: TextStyle(
                      color: Get.theme.secondTabPanelSelectedFontColor,
                      fontSize: isIPad ? 16.sp : 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.keyboard_arrow_up,
                    size: 12.w,
                    color: Get.theme.secondTabPanelSelectedFontColor,
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 2.w),
                  Text(
                    LocaleKeys.bet_record_pack_down.tr,
                    style: TextStyle(
                      color: Get.theme.secondTabPanelSelectedFontColor,
                      fontSize: isIPad ? 16.sp : 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 12.w,
                    color: Get.theme.secondTabPanelSelectedFontColor,
                  ),
                ],
              ),
      ),
    );
  }
}
