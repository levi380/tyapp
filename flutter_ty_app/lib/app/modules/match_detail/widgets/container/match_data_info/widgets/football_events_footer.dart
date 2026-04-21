import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import '../../../../../vr/vr_sport_detail/import_head.dart';
import 'football_events_footer_expand_btn.dart';
import 'football_events_footer_legend.dart';

/// 足球事件页底部区域
///
/// 当 [currentGeneralEventIndex] < 2 时显示：展开/收起按钮 + 关键事件图例。
class FootballEventsFooter extends StatelessWidget {
  const FootballEventsFooter({super.key, required this.controller});

  /// 数据控制器，用于读取事件列表与展开状态
  final MatchDataController controller;

  /// 构建底部区域 UI。
  ///
  /// - 若 [currentGeneralEventIndex] >= 2（非「全部事件」/「关键事件」Tab），返回空 [SizedBox] 不占位。
  /// - 否则返回 [Column]：有事件数据时显示 [FootballEventsFooterExpandBtn] 与 [FootballEventsFooterLegend]。
  @override
  Widget build(BuildContext context) {
    final state = controller.state;
    if (state.currentGeneralEventIndex >= 2) {
      return const SizedBox();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (state.currentEventDataEvents.isNotEmpty)
          FootballEventsFooterExpandBtn(
            isExpanded: state.isExpandImport,
            onToggle: controller.setExpandImport,
          ),
        if (state.currentEventDataEvents.isNotEmpty)
          FootballEventsFooterLegend(controller: controller),
      ],
    );
  }
}
