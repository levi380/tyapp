import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/statistic/season_statistic_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_team_vs_history_entity.dart';

import 'basket_ball_history_war_item_left.dart';
import 'basket_ball_history_war_item_right.dart';

/// 篮球历史交战列表项组件
///
/// 用于显示单条历史交战记录，包括比赛日期、赛事名称、队伍名称、比分和赛果
class BasketBallHistoryWarItemWidget {
  /// 构建历史交战列表项
  /// [analyzeVSInfoEntity] 历史交战数据实体
  /// [controller] 赛季统计控制器，用于获取结果文本和颜色
  static Widget build(
    AnalyzeTeamVsHistoryEntity analyzeVSInfoEntity,
    SeasonStatisticController controller,
  ) {
    return Container(
      height: 48.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          BasketBallHistoryWarItemLeft(entity: analyzeVSInfoEntity),
          BasketBallHistoryWarItemRight(
            entity: analyzeVSInfoEntity,
            controller: controller,
          ),
        ],
      ),
    );
  }
}

