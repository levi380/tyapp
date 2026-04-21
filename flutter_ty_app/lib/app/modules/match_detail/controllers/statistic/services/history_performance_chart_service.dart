import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/services/models/res/historical_performance_p_b_bean_entity.dart';
import '../../../widgets/container/match_market_overview/bean/series_bean.dart';

/**
 * 图表数据结果类
 * 用于存储图表转换后的数据
 */
class ChartDataResult {
  final List<List<SeriesColorStops>> colorStops;
  final List<SeriesBean> seriesBeanList;
  final List<SeriesBean> seriesBeanList2;
  final Map<String, dynamic> chartMap1;
  final Map<String, dynamic> chartMap2;

  ChartDataResult({
    required this.colorStops,
    required this.seriesBeanList,
    required this.seriesBeanList2,
    required this.chartMap1,
    required this.chartMap2,
  });
}

/**
 * 历史表现图表服务类
 * 负责将历史表现数据转换为图表数据
 */
class HistoryPerformanceChartService {

  /// 将历史表现数据转换为图表数据
  /// [dataList] 历史表现数据列表
  /// 返回图表数据结果，包含颜色停止点、系列数据列表和图表配置
  static ChartDataResult convertChartFromOddReportAnalyzeDataData(
    List<HistoricalPerformancePBBeanEntity> dataList,
  ) {
    String defaultString =
        "{\"name\":\"${LocaleKeys.analysis_win.tr}\",\"data\":[4,6,3,2,5],\"barWidth\":\"10\",\"type\":\"bar\",\"itemStyle\":{\"normal\":{\"barBorderRadius\":10,\"color\":{\"type\":\"linear\",\"x\":0,\"y\":0,\"x2\":0,\"y2\":1,\"colorStops\":[{\"offset\":0,\"color\":\"#D666FF\"},{\"offset\":1,\"color\":\"#9760F0\"}]}}}}";
    List<double> row1 = [];
    List<double> row2 = [];
    List<double> row3 = [];

    List<double> row4 = [];
    List<double> row5 = [];
    List<double> row6 = [];

    for (HistoricalPerformancePBBeanEntity historicalPerformancePBBeanEntity
        in dataList) {
      if (historicalPerformancePBBeanEntity.expressingType == 0) {
        row1.clear();
        row1.add(historicalPerformancePBBeanEntity.winPercent ?? 0);
        row1.add(historicalPerformancePBBeanEntity.bothGoalPercent ?? 0);
        row1.add(historicalPerformancePBBeanEntity.notLostPercent ?? 0);
        row1.add(historicalPerformancePBBeanEntity.firstGoalPercent ?? 0);
        row4.clear();
        row4.add(historicalPerformancePBBeanEntity.averageGoalPercent ?? 0);
        row4.add(historicalPerformancePBBeanEntity.goalPercent ?? 0);
        row4.add(historicalPerformancePBBeanEntity.lostGoalPercent ?? 0);
        row4.add(historicalPerformancePBBeanEntity.goalXg ?? 0);
        row4.add(historicalPerformancePBBeanEntity.goalXga ?? 0);
      }

      if (historicalPerformancePBBeanEntity.expressingType == 1) {
        row2.clear();
        row2.add(historicalPerformancePBBeanEntity.winPercent ?? 0);
        row2.add(historicalPerformancePBBeanEntity.bothGoalPercent ?? 0);
        row2.add(historicalPerformancePBBeanEntity.notLostPercent ?? 0);
        row2.add(historicalPerformancePBBeanEntity.firstGoalPercent ?? 0);
        row5.clear();
        row5.add(historicalPerformancePBBeanEntity.averageGoalPercent ?? 0);
        row5.add(historicalPerformancePBBeanEntity.goalPercent ?? 0);
        row5.add(historicalPerformancePBBeanEntity.lostGoalPercent ?? 0);
        row5.add(historicalPerformancePBBeanEntity.goalXg ?? 0);
        row5.add(historicalPerformancePBBeanEntity.goalXga ?? 0);
      }
      if (historicalPerformancePBBeanEntity.expressingType == 2) {
        row3.clear();
        row3.add(historicalPerformancePBBeanEntity.winPercent ?? 0);
        row3.add(historicalPerformancePBBeanEntity.bothGoalPercent ?? 0);
        row3.add(historicalPerformancePBBeanEntity.notLostPercent ?? 0);
        row3.add(historicalPerformancePBBeanEntity.firstGoalPercent ?? 0);
        row6.clear();
        row6.add(historicalPerformancePBBeanEntity.averageGoalPercent ?? 0);
        row6.add(historicalPerformancePBBeanEntity.goalPercent ?? 0);
        row6.add(historicalPerformancePBBeanEntity.lostGoalPercent ?? 0);
        row6.add(historicalPerformancePBBeanEntity.goalXg ?? 0);
        row6.add(historicalPerformancePBBeanEntity.goalXga ?? 0);
      }
    }

    List<List<SeriesColorStops>> colorStops = [];
    colorStops.add([
      SeriesColorStops(offset: 0, color: '#D666FF'),
      SeriesColorStops(offset: 0, color: '#9760F0')
    ]);
    colorStops.add([
      SeriesColorStops(offset: 0, color: '#179AFF'),
      SeriesColorStops(offset: 0, color: '#4557FF')
    ]);
    colorStops.add([
      SeriesColorStops(offset: 0, color: '#FFCD54'),
      SeriesColorStops(offset: 0, color: '#FF842A')
    ]);
    
    List<SeriesBean> seriesBeanList = [];
    List<SeriesBean> seriesBeanList2 = [];
    
    SeriesBean seriesBean = SeriesBean.fromJson(jsonDecode(defaultString));
    seriesBean.name = LocaleKeys.analysis_overall.tr;
    seriesBean.data?.clear();
    seriesBean.data = row1;
    seriesBean.itemStyle?.normal?.color?.colorStops = colorStops[0];
    seriesBeanList.add(seriesBean);

    seriesBean = SeriesBean.fromJson(jsonDecode(defaultString));
    seriesBean.name = LocaleKeys.analysis_home.tr;
    seriesBean.data?.clear();
    seriesBean.data = row2;
    seriesBean.itemStyle?.normal?.color?.colorStops = colorStops[1];
    seriesBeanList.add(seriesBean);

    seriesBean = SeriesBean.fromJson(jsonDecode(defaultString));
    seriesBean.name = LocaleKeys.analysis_away.tr;
    seriesBean.data?.clear();
    seriesBean.data = row3;
    seriesBean.itemStyle?.normal?.color?.colorStops = colorStops[2];
    seriesBeanList.add(seriesBean);

    seriesBean = SeriesBean.fromJson(jsonDecode(defaultString));
    seriesBean.name = LocaleKeys.analysis_overall.tr;
    seriesBean.data = row4;
    seriesBean.itemStyle?.normal?.color?.colorStops = colorStops[0];
    seriesBeanList2.add(seriesBean);

    seriesBean = SeriesBean.fromJson(jsonDecode(defaultString));
    seriesBean.name = LocaleKeys.analysis_home.tr;
    seriesBean.data = row5;
    seriesBean.itemStyle?.normal?.color?.colorStops = colorStops[1];
    seriesBeanList2.add(seriesBean);

    seriesBean = SeriesBean.fromJson(jsonDecode(defaultString));
    seriesBean.name = LocaleKeys.analysis_away.tr;
    seriesBean.data = row6;
    seriesBean.itemStyle?.normal?.color?.colorStops = colorStops[2];
    seriesBeanList2.add(seriesBean);

    Map<String, dynamic> chartMap1 = {
      "tooltip": {
        "trigger": 'axis',
        "axisPointer": {"type": 'shadow'}
      },
      "xAxis": {
        "type": "category",
        "axisLabel": {
          "fontSize": "10",
          "color": '#${Get.isDarkMode ? 0xA0FFFFFF : 303442}'
        },
        "data": [
          "${LocaleKeys.analysis_win.tr}",
          "${LocaleKeys.analysis_k_all_scores.tr}",
          "${LocaleKeys.analysis_k_not_lost.tr}",
          "${LocaleKeys.analysis_team.tr}",
        ],
      },
      "yAxis": [
        {
          "type": "value",
          "min": "0",
          "max": "100",
          "alignWithLabel": "false",
          "axisTick": {
            "show": true,
            "interval": "20"
          },
          "name": "",
          "axisLabel": {
            "color": '#027eff',
            "textStyle": {
              "fontSize": 10,
            },
            "formatter": '{value} %'
          },
          "nameTextStyle": {
            "color": "#027eff",
            "fontSize": 10,
          }
        },
      ],
      "series": seriesBeanList.map((e) => e.toJson()).toList(),
      "grid": {"y": 30, "y2": 30},
    };

    Map<String, dynamic> chartMap2 = {
      "tooltip": {"trigger": 'axis', "showDelay": 0},
      "xAxis": {
        "type": "category",
        "axisLabel": {
          "fontSize": "10",
          "color": '#${Get.isDarkMode ? 0xA0FFFFFF : 303442}'
        },
        "data": [
          LocaleKeys.analysis_average.tr,
          LocaleKeys.analysis_score.tr,
          LocaleKeys.analysis_football_matches_expected_goals_xg.tr,
          LocaleKeys.analysis_football_matches_expected_goals.tr,
        ],
      },
      "grid": {"y": 30, "y2": 30},
      "yAxis": [
        {
          "type": "value",
          "alignWithLabel": "false",
          "name": "",
          "axisLabel": {
            "color": '#027eff'
          },
          "nameTextStyle": {
            "color": "#027eff",
          }
        },
      ],
      "series": seriesBeanList2.map((e) => e.toJson()).toList()
    };

    return ChartDataResult(
      colorStops: colorStops,
      seriesBeanList: seriesBeanList,
      seriesBeanList2: seriesBeanList2,
      chartMap1: chartMap1,
      chartMap2: chartMap2,
    );
  }
}

