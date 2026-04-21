import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import '../../../common_widget/analysis_common_widget/widget/analyze_header_widget.dart';

/// 篮球事件页 - 顶部头部（渐变背景 + 主客队信息）
class BasketballEventHead extends StatelessWidget {
  final String tag;

  const BasketballEventHead({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
        gradient: LinearGradient(
          colors: [
            MatchDataState.headerGradientColor1.withValues(alpha: MatchDataState.headerGradientAlpha),
            MatchDataState.headerGradientColor2.withValues(alpha: MatchDataState.headerGradientAlpha),
            MatchDataState.headerGradientColor3.withValues(alpha: MatchDataState.headerGradientAlpha),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: AnalyzeHeaderWidget(
        tag: tag,
        showCenter: true,
      ),
    );
  }
}
