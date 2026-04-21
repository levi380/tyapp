import 'dart:convert';
import 'dart:io';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import 'package:flutter_ty_app/app/services/models/res/odd_report_analyze_data_entity.dart';
import '../../../../core/format/common/module/format-date.dart';
import '../../../home/controllers/home_controller.dart';
import '../../widgets/container/match_market_overview/bean/series_bean.dart';
import '../match_market_overview_utils.dart';
import '../match_market_overview_chart_service.dart';

/**
 * 盘面图表数据服务类
 * 负责处理图表数据转换的详细逻辑
 */
class MatchMarketOverviewChartDataService {
  /**
   * 收集所有时间戳
   * [average] 平均值列表
   * [dataMap] 数据映射
   * 返回排序后的时间戳列表
   */
  static List<String> collectAllTimes(
      List<OddReportAnalyzeDataOddsDataAverageList>? average,
      Map<String, dynamic> dataMap) {
    List<String> allTimes = [];
    // 从平均值中收集时间戳
    for (OddReportAnalyzeDataOddsDataAverageList item in (average ?? [])) {
      if (item.timeMillis?.isNotEmpty == true) {
        if (!allTimes.contains(item.timeMillis ?? "")) {
          allTimes.add(item.timeMillis ?? "");
        }
      }
    }
    // 从数据映射中收集时间戳
    dataMap.forEach((tempKey, value) {
      if (value != null && "$value".isNotEmpty) {
        List<OddReportAnalyzeDataOddsDataFieldOddsValueListG01> dataList =
            (value as List)
                .map((e) =>
                    OddReportAnalyzeDataOddsDataFieldOddsValueListG01.fromJson(e))
                .toList();
        for (OddReportAnalyzeDataOddsDataFieldOddsValueListG01 value
            in dataList) {
          if (value.timeMillis?.isNotEmpty == true) {
            if (!allTimes.contains(value.timeMillis ?? "")) {
              allTimes.add(value.timeMillis ?? "");
            }
          }
        }
      }
    });
    // 日期排序
    allTimes.sort((a, b) {
      return (int.tryParse(a) ?? 0) - (int.tryParse(b) ?? 0);
    });
    return allTimes;
  }

  /**
   * 处理SeriesBean数据
   * [state] 状态对象
   * [key] 键值
   * [value] 数据值
   * [allTimes] 所有时间戳列表
   * [defaultString] 默认配置字符串
   */
  static void processSeriesBeanData(
      MatchMarketOverviewState state,
      String key,
      dynamic value,
      List<String> allTimes,
      String defaultString) {
    Map<String, double?> timesMap = {};
    for (String timeItem in allTimes) {
      timesMap[timeItem] = null;
    }

    if (!isExitSeriesBean(state.seriesBeanList, key)) {
      SeriesBean seriesBean =
          SeriesBean.fromJson(jsonDecode(defaultString));
      seriesBean.name = key;
      seriesBean.data = [];
      seriesBean.itemStyle?.normal?.color?.colorStops =
          state.colorStops.removeLast();
      state.seriesBeanList.add(seriesBean);
    }

    if (state.seriesBeanList.isNotEmpty) {
      SeriesBean? seriesBean = findSeriesBean(state.seriesBeanList, key);

      List<OddReportAnalyzeDataOddsDataFieldOddsValueListG01> dataList =
          (value as List)
              .map((e) => OddReportAnalyzeDataOddsDataFieldOddsValueListG01
                  .fromJson(e))
              .toList();
      dataList.sort((a, b) {
        return (int.tryParse(a.timeMillis ?? "0") ?? 0) -
            (int.tryParse(b.timeMillis ?? "0") ?? 0);
      });

      for (int i = 0; i < dataList.length; i++) {
        OddReportAnalyzeDataOddsDataFieldOddsValueListG01 currentValue =
            dataList[i];

        if (currentValue.oddsValue != null &&
            currentValue.oddsValue?.isNotEmpty == true) {
          double valueData =
              double.tryParse(currentValue.oddsValue ?? "0") ?? 0.0;
          if (valueData > 0) {
            timesMap[currentValue.timeMillis ?? ""] = valueData;
          }
        } else {
          if (seriesBean?.data?.isNotEmpty == true) {
            timesMap[currentValue.timeMillis ?? ""] =
                double.tryParse(currentValue.oddsValue ?? "0") ?? 0.0;
          }
        }
      }

      List<double?> doubleList = [];
      timesMap.forEach((key, value) {
        doubleList.add(value);
      });

      for (int index = 0; index < doubleList.length; index++) {
        double? value = doubleList[index];
        if (value == null || value == 0) {
          double afterValue = findAfterValue(doubleList, index + 1);
          if (afterValue > 0) {
            doubleList[index] = afterValue;
          }
        }
      }
      seriesBean?.data?.clear();
      seriesBean?.data?.addAll(doubleList);
    }
  }

  /**
   * 构建图表配置
   * [state] 状态对象
   * [allTimes] 所有时间戳列表
   * 返回图表配置Map
   */
  static Map<String, dynamic> buildChartMap(
      MatchMarketOverviewState state, List<String> allTimes) {
    return {
      "legend": {
        "type": "scroll",
        "bottom_nav": "0%",
        "itemWidth": 8,
        "itemHeight": 8,
        "icon": "rect",
        "left": 16,
        "textStyle": {
          "color": "#A0A0A0",
        },
        "pageTextStyle": {
          "color": "#A0A0A0",
        }
      },
      "tooltip": {
        "show": true,
        "trigger": "axis",
        "confine": true
      },
      "grid": {"y": 30, "y2": (Platform.isAndroid) ? 180 : 120},
      "xAxis": {
        "type": "category",
        "boundaryGap": false,
        "axisLabel": {
          "fontSize": "12",
          "color":
              "${TyHomeController.to.homeState.isLight ? '#303442' : "#ffffff"}"
        },
        "data": allTimes.map((e) {
          return TYFormatDate.format_utc_time(int.tryParse(e) ?? 0);
        }).toList(),
      },
      "yAxis": [
        {
          "type": "value",
          "minInterval": 0.6,
          "axisTick": {
            "interval": 1,
          },
          "name": "",
          "axisLabel": {
            "show": true,
            "color": '#027eff'
          },
          "nameTextStyle": {
            "color": "#027eff",
          }
        },
      ],
      "series": state.seriesBeanList.map((e) => e.toJson()).toList()
    };
  }
}

