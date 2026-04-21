import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';

import '../../../../controllers/match_detail_controller.dart';
import '../../../../controllers/match_tools_methods.dart';
import 'basket_ball_team_info_side.dart';
import 'basket_ball_team_info_vs.dart';

/// 篮球队伍信息组件
/// 用于显示对战双方队伍的基本信息，包括队伍名称、队徽和胜负统计
class BasketBallTeamInfoWidget {
  /// 构建队伍信息组件
  /// [controller] 赛季统计控制器，包含队伍对战历史结果数据
  /// [tag] 控制器标签，用于获取MatchDetailController
  /// 返回包含主客队信息的行组件
  static Widget build({
    required SeasonStatisticController controller,
    required String tag,
  }) {
    final state = controller.state;
    final matchDetailController = Get.find<MatchDetailController>(tag: tag);
    final match = matchDetailController.detailState.match;
    final homeResult = (state.teamVsHistoryResult['home'] ?? {}) as Map;
    final awayResult = (state.teamVsHistoryResult['away'] ?? {}) as Map;

    return Container(
      height: 66.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [
          BasketBallTeamInfoSide(
            teamName: getTeamName(type: 1, match: match),
            teamLogo: ((match?.mhlu ?? []) as List).safeFirst,
            win: homeResult['win'] ?? 0,
            draw: homeResult['dogfall'] ?? 0,
            lose: homeResult['lose'] ?? 0,
            isAway: false,
          ),
          const BasketBallTeamInfoVS(),
          BasketBallTeamInfoSide(
            teamName: getTeamName(type: 2, match: match),
            teamLogo: ((match?.malu ?? []) as List).safeFirst,
            win: awayResult['win'] ?? 0,
            draw: awayResult['dogfall'] ?? 0,
            lose: awayResult['lose'] ?? 0,
            isAway: true,
          ),
        ],
      ),
    );
  }
}

