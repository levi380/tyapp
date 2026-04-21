import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import '../../../common_widget/analysis_common_widget/widget/analyze_header_widget.dart';

/// 联赛积分篮球页 - 顶部渐变头部（主客队信息）
class LeaguePointsBasketballHeader extends StatelessWidget {
  final String tag;

  const LeaguePointsBasketballHeader({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LeaguePointsState.basketballHeaderHeight.w,
      padding: EdgeInsets.symmetric(
        horizontal: LeaguePointsState.basketballHeaderHorizontalPadding.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(LeaguePointsState.basketballHeaderBorderRadius.w),
        ),
        gradient: LinearGradient(
          colors: [
            LeaguePointsState.basketballHeaderGradientColor1
                .withValues(alpha: LeaguePointsState.basketballHeaderGradientAlpha),
            LeaguePointsState.basketballHeaderGradientColor2
                .withValues(alpha: LeaguePointsState.basketballHeaderGradientAlpha),
            LeaguePointsState.basketballHeaderGradientColor3
                .withValues(alpha: LeaguePointsState.basketballHeaderGradientAlpha),
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
