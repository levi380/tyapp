import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 正面交手（电子足球）列表 - 展开/收起按钮
///
/// 当列表超过 [MatchStatisticMatchHistoryState.headOnConfrontationMaxDisplayCount] 条时显示
class HeadOnConfrontationExpandButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const HeadOnConfrontationExpandButton({
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
        padding: EdgeInsets.symmetric(
          horizontal: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonHorizontalPadding.w,
          vertical: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonVerticalPadding.w,
        ),
        child: isExpanded ? _buildPackUp() : _buildPackDown(),
      ),
    );
  }

  Widget _buildPackUp() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonSpacing.w),
        Text(
          LocaleKeys.bet_pack_up.tr,
          style: TextStyle(
            color: Get.theme.secondTabPanelSelectedFontColor,
            fontSize: isIPad
                ? MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonFontSizeIPad.sp
                : MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonFontSize.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonSpacing.w),
        Icon(
          Icons.keyboard_arrow_up,
          size: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonIconSize.w,
          color: Get.theme.secondTabPanelSelectedFontColor,
        ),
      ],
    );
  }

  Widget _buildPackDown() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonSpacing.w),
        Text(
          LocaleKeys.bet_record_pack_down.tr,
          style: TextStyle(
            color: Get.theme.secondTabPanelSelectedFontColor,
            fontSize: isIPad
                ? MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonFontSizeIPad.sp
                : MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonFontSize.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonSpacing.w),
        Icon(
          Icons.keyboard_arrow_down,
          size: MatchStatisticMatchHistoryState.headOnConfrontationExpandButtonIconSize.w,
          color: Get.theme.secondTabPanelSelectedFontColor,
        ),
      ],
    );
  }
}
