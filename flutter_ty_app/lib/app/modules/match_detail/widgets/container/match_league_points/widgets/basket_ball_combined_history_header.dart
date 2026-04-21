import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/league_points_state.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/main.dart';

/// 篮球赛事历史记录（积分榜）列表的表头组件
///
/// 包含列名：排名(#)、球队、胜、负、胜率
class BasketBallCombinedHistoryHeader extends StatelessWidget {
  const BasketBallCombinedHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: LeaguePointsState.basketballTableHeaderHeight.w,
      padding: EdgeInsets.symmetric(
        horizontal: LeaguePointsState.basketballTableHeaderHorizontalPadding.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderItem(
            flex: 1,
            text: "#",
            alignment: Alignment.center,
          ),
          _buildHeaderItem(
            flex: 3,
            text: LocaleKeys.ouzhou_search_team.tr, // 球队
            alignment: Alignment.centerLeft,
          ),
          _buildHeaderItem(
            flex: 1,
            text: LocaleKeys.analysis_football_matches_victory.tr, // 胜
            alignment: Alignment.center,
          ),
          _buildHeaderItem(
            flex: 3,
            text: LocaleKeys.analysis_football_matches_negative.tr, // 负
            alignment: Alignment.center,
          ),
          _buildHeaderItem(
            flex: 1,
            text: LocaleKeys.home_popular_win_rate.tr, // 胜率
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }

  /// 构建表头单个单元格
  /// [flex] 占据的比例
  /// [text] 显示的文本
  /// [alignment] 对齐方式
  Widget _buildHeaderItem({
    required int flex,
    required String text,
    required Alignment alignment,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: alignment,
        child: Text(
          text,
          textAlign: alignment == Alignment.centerLeft
              ? TextAlign.left
              : (alignment == Alignment.centerRight ? TextAlign.right : TextAlign.center),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isIPad
                ? (15.sp)
                : ['es'].contains(getLang()) && text == "#"
                    ? 10.sp
                    : 11.sp,
            color: Get.theme.dataContainerTextColor,
          ),
        ),
      ),
    );
  }
}
