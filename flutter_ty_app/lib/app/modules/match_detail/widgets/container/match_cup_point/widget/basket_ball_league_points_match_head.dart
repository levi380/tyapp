import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../common_widget/analysis_common_widget/widget/analyze_header_widget.dart';

/// 篮球杯赛积分 - 比赛头部区域
///
/// 渐变背景 + 主客队信息（队徽、队名等），通过 [AnalyzeHeaderWidget] 展示；
/// [tag] 用于获取 MatchDetailController。
class BasketBallLeaguePointsMatchHead extends StatelessWidget {
  final String tag;

  const BasketBallLeaguePointsMatchHead({super.key, required this.tag});

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
            const Color(0xFF179CFF).withValues(alpha: 0.1),
            const Color(0xFFFFFFFF).withValues(alpha: 0.1),
            const Color(0xFFB1451A).withValues(alpha: 0.1),
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
