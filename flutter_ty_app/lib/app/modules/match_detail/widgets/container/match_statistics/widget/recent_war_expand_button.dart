import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';

/// 近期战绩列表的展开/收起按钮
///
/// 当列表超过 5 条时显示；点击后切换 [onToggle] 状态，由外部控制展示条数。
class RecentWarExpandButton extends StatelessWidget {
  /// 当前是否已展开（true=显示“收起”，false=显示“展开”）
  final bool isExpanded;
  /// 点击时回调，由调用方切换 expand 状态并刷新列表
  final VoidCallback onToggle;

  const RecentWarExpandButton({
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
        child: isExpanded ? _buildPackUp() : _buildPackDown(),
      ),
    );
  }

  /// 收起态：文案 + 上箭头
  Widget _buildPackUp() {
    return Row(
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
    );
  }

  /// 展开态：文案 + 下箭头
  Widget _buildPackDown() {
    return Row(
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
    );
  }
}
