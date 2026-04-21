import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/battle_array_state.dart';
import 'package:flutter_ty_app/main.dart';

/// 足球阵容页列表区块标题
///
/// 用于「首发阵容」「替补阵容」「伤停名单」等区块的左侧标题行。
class FootballBattleArrayListItemHead extends StatelessWidget {
  const FootballBattleArrayListItemHead({super.key, required this.title});

  /// 区块标题文案（如「首发阵容 4-3-3」「替补阵容」「伤停名单」）
  final String title;

  /// 构建一行标题：左侧留白 [footballListItemHeadLeftSpacing] + [Text]，高度、字号来自 [BattleArrayState]，颜色 [tabPanelSelectedColor]。
  @override
  Widget build(BuildContext context) {
    return Container(
      height: BattleArrayState.footballListItemHeadHeight.w,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: BattleArrayState.footballListItemHeadLeftSpacing.w),
          Text(
            title,
            style: TextStyle(
              color: Get.theme.tabPanelSelectedColor,
              fontSize: isIPad
                  ? BattleArrayState.footballListItemHeadFontSizeIPad.sp
                  : BattleArrayState.footballListItemHeadFontSize.sp,
            ),
          ),
        ],
      ),
    );
  }
}
