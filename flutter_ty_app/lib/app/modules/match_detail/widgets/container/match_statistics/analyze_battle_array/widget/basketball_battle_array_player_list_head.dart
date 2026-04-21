import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球球员列表表头
///
/// 列：球员、分钟、篮球、助攻、得分
class BasketballBattleArrayPlayerListHead extends StatelessWidget {
  const BasketballBattleArrayPlayerListHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      height: 34.w,
      decoration: BoxDecoration(
        color: Get.theme.oddsButtonBackgroundColor,
        border: Border.symmetric(
          vertical: BorderSide(color: const Color(0xFFE4E6ED)),
        ),
      ),
      child: Row(
        children: [
          _buildPlayerColumn(),
          _buildColumn('分钟', flex: 1),
          _buildColumn('篮球', flex: 1),
          _buildColumn('助攻', flex: 1),
          _buildColumn('得分', flex: 1),
        ],
      ),
    );
  }

  Widget _buildPlayerColumn() {
    return Expanded(
      flex: 4,
      child: Row(
        children: [
          Container(
            child: Text(
              '球员',
              style: TextStyle(
                color: Get.theme.tabPanelSelectedColor,
                fontSize: MatchStatisticMatchHistoryState.basketBallBattleArrayPlayerItemFontSize.sp,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildColumn(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: Get.theme.tabPanelSelectedColor,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
