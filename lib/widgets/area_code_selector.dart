import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 区号选择器：展示区号文案 + 下拉箭头，点击由外部处理（如弹区号选择弹窗）
class AreaCodeSelector extends StatelessWidget {
  const AreaCodeSelector({
    super.key,
    required this.areaCodeLabel,
    required this.onTap,
  });

  /// 区号展示，如 Obx(() => Text(controller.selAreaCodeText.value ?? '+86', style: ...))
  final Widget areaCodeLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          areaCodeLabel,
          SizedBox(width: 6.w),
          Icon(
            Icons.keyboard_arrow_down,
            color: appnewColors.text1,
            size: 14.w,
          ),
        ],
      ),
    );
  }
}
