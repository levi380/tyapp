import 'dart:math';

import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_data_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_data_state.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/analysis_common_widget/widget/box_shadow_container.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/events_item.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/football_bottom_ratio.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/football_category_tabs.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/football_circle_progress_row.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/football_events_footer.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/football_line_chart.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/container/match_data_info/widgets/football_select_buttons.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_live_video_live_event_entity_entity.dart';
import 'package:flutter_ty_app/app/utils/extension.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 数据】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球数据控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据 足球页面
    】】】
 *
 */
class MatchDataFootballPage extends StatefulWidget {
  MatchDataFootballPage({super.key, required this.tag});

  final String tag;

  @override
  State<MatchDataFootballPage> createState() => _MatchDataFootballPageState();
}

class _MatchDataFootballPageState extends State<MatchDataFootballPage> {
  /// 构建足球数据页面的主界面
  /// 
  /// 该方法负责构建完整的足球赛事数据展示页面，包括：
  /// 1. 使用GetBuilder监听MatchDataController的状态变化
  /// 2. 监听DataStoreController的赛事数据变化
  /// 3. 使用CustomScrollView构建可滚动的数据展示区域，包含：
  ///    - 加时赛分类标签（如果显示加时赛数据）
  ///    - 环形进度条行（显示各项数据对比）
  ///    - 折线图（显示数据趋势）
  ///    - 底部比率数据（显示详细数据对比）
  ///    - 选择按钮（固定在顶部，用于切换数据类型）
  ///    - 事件列表（显示比赛中的关键事件）
  ///    - 事件底部信息
  /// 
  /// 参数：
  /// - context: 构建上下文
  /// 
  /// 返回：
  /// - Widget: 返回包含所有数据组件的BoxShadowContainer容器
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchDataController>(
      tag: widget.tag,
      init: MatchDataController(tag: widget.tag),
      builder: (controller) {
        return BoxShadowContainer(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(
            top: MatchDataState.footballPageTopMargin.w,
            left: MatchDataState.footballPageHorizontalMargin.w,
            right: MatchDataState.footballPageHorizontalMargin.w,
          ),
          child: GetBuilder<DataStoreController>(
            id: DataStoreController.to.getMatchId(widget.tag),
            builder: (dataController) {
              final events = controller.state.currentEventDataEvents;
              return CustomScrollView(
                slivers: [
                  if (controller.state.showOvertime)
                    FootballCategoryTabs(controller: controller).sliver,
                  if (controller.state.ringData.isNotEmpty)
                    // 拆分FootballCircleProgressRow 控件
                    FootballCircleProgressRow(
                      controller: controller,
                      awayColor: MatchDataState.footballAwayColor,
                      manColor: MatchDataState.footballManColor,
                    ).sliver,
                  FootballLineChart(controller: controller).sliver,
                  // 拆分FootballCircleProgressRow 下滑控件
                  FootballBottomRatio(
                    controller: controller,
                    dataController: dataController,
                    manColor: MatchDataState.footballManColor,
                    awayColor: MatchDataState.footballAwayColor,
                  ).sliver,
                  SliverPersistentHeader(
                    delegate: _SliverDelegate(
                      minHeight: MatchDataState.footballSelectButtonMinHeight.w,
                      maxHeight: MatchDataState.footballSelectButtonMaxHeight.w,
                      child: FootballSelectButtons(controller: controller),
                    ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        AnalyzeLiveVideoLiveEventEntityDataEvents eventItem =
                            events[index];
                        return EventsItem(eventItem: eventItem, controller: controller);
                      },
                      childCount: events.length,
                    ),
                  ),
                  FootballEventsFooter(controller: controller).sliver,
                  MatchDataState.footballEventListVerticalSpacing.w.verticalSpaceFromWidth.sliver,
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _SliverDelegate extends SliverPersistentHeaderDelegate {
  _SliverDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child;

  /// 获取最小高度
  /// 
  /// 返回SliverPersistentHeader的最小高度值
  /// 
  /// 返回：
  /// - double: 最小高度值
  @override
  double get minExtent => minHeight;

  /// 获取最大高度
  /// 
  /// 返回SliverPersistentHeader的最大高度值，确保不小于最小高度
  /// 
  /// 返回：
  /// - double: 最大高度值（maxHeight和minHeight中的较大值）
  @override
  double get maxExtent => max(maxHeight, minHeight);

  /// 构建SliverPersistentHeader的内容
  /// 
  /// 该方法在滚动过程中被调用，用于构建固定在顶部的头部组件：
  /// - 使用SizedBox.expand让子组件填满可用空间
  /// - shrinkOffset表示当前滚动偏移量（未使用）
  /// - overlapsContent表示是否与其他内容重叠（未使用）
  /// 
  /// 参数：
  /// - context: 构建上下文
  /// - shrinkOffset: 当前滚动偏移量
  /// - overlapsContent: 是否与其他内容重叠
  /// 
  /// 返回：
  /// - Widget: 返回展开的子组件
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  /// 判断是否需要重建
  /// 
  /// 该方法用于优化性能，判断当delegate更新时是否需要重建头部：
  /// - 如果最大高度、最小高度或子组件发生变化，则需要重建
  /// - 否则可以复用之前的组件，避免不必要的重建
  /// 
  /// 参数：
  /// - oldDelegate: 旧的delegate对象，用于比较
  /// 
  /// 返回：
  /// - bool: true表示需要重建，false表示可以复用
  @override
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
