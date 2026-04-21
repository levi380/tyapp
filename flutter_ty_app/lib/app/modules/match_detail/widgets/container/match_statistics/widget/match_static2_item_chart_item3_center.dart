import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../../models/analysis/analysis_model.dart';

/// 历史表现 Item 行 - 中间色块列（胜/平/负等标签）
///
/// 根据 [GridListDataBean.name2] 数值列表生成带背景色的小标签
class MatchStatic2ItemChartItem3Center extends StatelessWidget {
  final GridListDataBean bean;

  const MatchStatic2ItemChartItem3Center({super.key, required this.bean});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        height: 25.w,
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: MatchStatisticMatchHistoryState.borderColor,
              width: 1,
            ),
            right: BorderSide(
              color: MatchStatisticMatchHistoryState.borderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bean.name2.map((e) => _buildChip(e)).toList(),
        ),
      ),
    );
  }

  static Widget _buildChip(num value) {
    final label = _overunderLabelCode(value);
    final color = _colorByValue(value);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(4.w)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: isIPad ? 14.sp : 10.sp,
          height: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Color _colorByValue(num value) {
    if (value == 0) return MatchStatisticMatchHistoryState.matchResultLossColor;
    if (value == 1) return MatchStatisticMatchHistoryState.matchResultWinColor;
    if (value == 2) return MatchStatisticMatchHistoryState.matchResultDrawColor;
    return MatchStatisticMatchHistoryState.matchResultLossColor;
  }

  static String _overunderLabelCode(num value) {
    switch (value) {
      case 0:
        return LocaleKeys.analysis_negative.tr;
      case 1:
        return LocaleKeys.analysis_victory.tr;
      case 2:
        return LocaleKeys.analysis_flat.tr;
      default:
        return '';
    }
  }
}
