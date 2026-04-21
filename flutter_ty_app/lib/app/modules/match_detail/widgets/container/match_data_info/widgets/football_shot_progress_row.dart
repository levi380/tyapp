import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';

import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/item/new_matchline_progress_view.dart';

/// 足球数据底部 - 单行射正/射偏进度条
///
/// 显示标题（如「射正」「射偏」）及主客队对比的线性进度条
class FootballShotProgressRow extends StatelessWidget {
  /// 行标题（多语言后的「射正」或「射偏」）
  final String label;
  /// 主队数值、客队数值（用于进度条中心展示）
  final String leftValue;
  final String rightValue;
  /// 主队/客队进度比例 0~1
  final double leftProgress;
  final double rightProgress;
  /// 主队/客队进度条颜色
  final Color leftColor;
  final Color rightColor;
  /// 进度条宽度（射正 54.w，射偏 60.w）
  final double progressWidth;

  const FootballShotProgressRow({
    super.key,
    required this.label,
    required this.leftValue,
    required this.rightValue,
    required this.leftProgress,
    required this.rightProgress,
    required this.leftColor,
    required this.rightColor,
    this.progressWidth = 54,
  });

  @override
  Widget build(BuildContext context) {
    final w = progressWidth.w;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Get.theme.betItemTextColor,
          ),
        ),
        NewMatchLineProgressView(
          leftValue,
          rightValue,
          leftProgress: leftProgress,
          rightProgress: rightProgress,
          leftColor: leftColor,
          rightColor: rightColor,
          leftBackgroundColor: MatchDataState.progressBackgroundColor,
          rightBackgroundColor: MatchDataState.progressBackgroundColor,
          width: w,
          height: 32.w,
          centerContent: label,
        ),
      ],
    );
  }
}
