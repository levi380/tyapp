import 'dart:io';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../../../../../../../generated/locales.g.dart';
import '../../../../controllers/statistic/history_performance_controller.dart';

/// 历史表现图表组件
/// 包含图表渲染和图表头部显示功能
class HistoryPerformanceChart {
  /// 构建历史表现 ECharts 折线图
  /// 
  /// [controller] 历史表现控制器，包含图表数据
  /// [first] 是否为第一个图表（true: 显示 chartMap1, false: 显示 chartMap2）
  /// 
  /// 返回包含 ECharts 图表的容器 Widget
  static Widget getLineChart(
      HistoryPerformanceController controller, bool first) {
    return Container(
      width: 1.sw,
      height: 200.w,
      child: Platform.isWindows
          ? SizedBox()
          : Echarts(
              option: jsonEncode(
                  first ? controller.chartMap1 : controller.chartMap2),
            ),
    );
  }

  /// 构建历史表现图表头部
  /// 
  /// 显示图表图例，包括：
  /// - 总体（Overall）：紫色渐变
  /// - 主场（Home）：蓝色渐变
  /// - 客场（Away）：橙色渐变
  /// 
  /// 返回包含图例的容器 Widget
  static Widget buildMathBarChartHead() {
    return Container(
      height: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.analysis_statistics1.tr,
            style: TextStyle(
                fontSize: 14.w,
                fontWeight: FontWeight.w400,
                color: Get.theme.tabPanelSelectedColor),
          ),
          Row(children: [
            // 总体图例
            _buildLegendItem(
              gradientColors: [
                MatchStatisticMatchHistoryState.chartGradientColor1Start,
                MatchStatisticMatchHistoryState.chartGradientColor1End
              ],
              label: LocaleKeys.analysis_overall.tr,
            ),
            SizedBox(
              width: 8.w,
            ),
            // 主场图例
            _buildLegendItem(
              gradientColors: [
                MatchStatisticMatchHistoryState.chartGradientColor2Start,
                MatchStatisticMatchHistoryState.chartGradientColor2End
              ],
              label: LocaleKeys.analysis_home.tr,
            ),
            SizedBox(
              width: 8.w,
            ),
            // 客场图例
            _buildLegendItem(
              gradientColors: [
                MatchStatisticMatchHistoryState.chartGradientColor3Start,
                MatchStatisticMatchHistoryState.chartGradientColor3End
              ],
              label: LocaleKeys.analysis_away.tr,
            ),
          ])
        ],
      ),
    );
  }

  /// 构建单个图例项
  /// 
  /// [gradientColors] 渐变色数组，包含起始色和结束色
  /// [label] 图例文本标签
  /// 
  /// 返回包含颜色块和文本的 Row Widget
  static Widget _buildLegendItem({
    required List<Color> gradientColors,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2.w)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors)),
          child: SizedBox(),
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(label,
            style: TextStyle(
                fontSize: (12.sp),
                fontWeight: FontWeight.w400,
                color: Get.theme.resultTextColor)),
      ],
    );
  }
}

