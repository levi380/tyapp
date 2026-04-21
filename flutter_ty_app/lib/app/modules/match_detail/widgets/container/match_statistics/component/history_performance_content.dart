import 'package:flutter_ty_app/app/widgets/empty/no_data.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../controllers/statistic/history_performance_controller.dart';
import '../../../../states/match_statistic_state.dart';
import '../widget/match_static2_item_chart_head1.dart';
import '../widget/match_static2_item_chart_item1.dart';
import '../widget/match_static2_item_chart_item3.dart';
import 'history_performance_header.dart';
import 'history_performance_chart.dart';

/// 历史表现页面内容组件
/// 负责构建历史表现页面的主要内容区域
class HistoryPerformanceContent {
  /// 构建历史数据页面内容
  /// 
  /// [controller] 历史表现控制器，包含数据列表和图表数据
  /// [tag] 赛事标识
  /// [isElectronicFootball] 是否为电子足球
  /// 
  /// 返回包含头部、数据列表和图表的页面内容 Widget
  static Widget buildPageView1(
    HistoryPerformanceController controller,
    String tag,
    bool isElectronicFootball,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // 数据为空时显示空数据提示
            controller.isTopEmpty
                ? NoData(
                    top: 0,
                    content: LocaleKeys.common_no_data.tr,
                  )
                : Container(
                    child: Column(
                      children: [
                        // 头部信息（队伍图标、名称、排名等）
                        HistoryPerformanceHeader.buildHeadBody1(
                          controller,
                          tag,
                          isElectronicFootball,
                          0
                        ),
                        SizedBox(
                          height: 12.w,
                        ),
                        // 数据列表容器
                        _buildDataListContainer(
                          controller,
                          isElectronicFootball,0
                        ),
                        SizedBox(height: 12.w,),
                        HistoryPerformanceHeader.buildHeadBody1(
                          controller,
                          tag,
                          isElectronicFootball,
                          1
                        ),
                        SizedBox(height: 12.w,),
                        _buildDataListContainer(
                          controller,
                          isElectronicFootball,1
                        ),
                        SizedBox(
                          height: 12.w,
                        ),
                        // 图表区域（仅非电子足球显示）
                        if (!isElectronicFootball) ...[
                          HistoryPerformanceChart.buildMathBarChartHead(),
                          if (controller.chartMap1 != null)
                            HistoryPerformanceChart.getLineChart(
                                controller, true),
                          if (controller.chartMap2 != null)
                            HistoryPerformanceChart.getLineChart(
                                controller, false),
                        ],
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /// 构建数据列表容器
  /// 
  /// [controller] 历史表现控制器，包含数据列表
  /// [isElectronicFootball] 是否为电子足球
  /// 
  /// 返回包含数据列表的容器 Widget
  static Widget _buildDataListContainer(
    HistoryPerformanceController controller,
    bool isElectronicFootball,
      int tabIndex,
  ) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
          border: Border.all(
              color: MatchStatisticMatchHistoryState.borderColor, width: 0.5)),
      child: Column(
        children: [
          // 列表头部
          MatchStatic2ItemChartHead(),
          Divider(
            color: MatchStatisticMatchHistoryState.borderColor,
            height: 1,
          ),
          // 数据列表
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: isElectronicFootball
                  ? (tabIndex==0?controller.gridListDataBeansElectronicFootball.length:controller.gridListDataBeansElectronicFootball1.length)
                  : controller.gridListDataBeans.length,
              itemBuilder: (BuildContext context, int index) {
                return isElectronicFootball
                    ? (MatchStatic2ItemChartItem3(
                    tabIndex==0?controller.gridListDataBeansElectronicFootball[index]:controller.gridListDataBeansElectronicFootball1[index]))

                    : MatchStatic2ItemChartItem1(
                        controller.gridListDataBeans[index]);
              }),
        ],
      ),
    );
  }
}

