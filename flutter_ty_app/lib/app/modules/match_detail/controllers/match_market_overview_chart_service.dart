

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import 'package:flutter_ty_app/app/services/models/res/odd_report_analyze_data_entity.dart';


import '../../../../generated/locales.g.dart';

import '../widgets/container/match_market_overview/bean/series_bean.dart';
import 'match_market_overview_utils.dart';
import 'services/match_market_overview_chart_data_service.dart';

/**
 * 盘面图表服务
 * 
 * 负责处理图表相关的业务逻辑，包括：
 * - 图表数据转换
 * - 推送消息处理
 * - SeriesBean查找
 */

/**
 * 检查SeriesBean是否存在
 * 
 * 在SeriesBean列表中查找指定名称的SeriesBean
 * 
 * @param seriesBeanList SeriesBean列表
 * @param title 要查找的名称
 * @return 如果存在返回true，否则返回false
 */
bool isExitSeriesBean(List<SeriesBean> seriesBeanList, String title) {
  bool result = false;
  for (SeriesBean seriesBean in seriesBeanList) {
    if (seriesBean.name == title) {
      result = true;
      break;
    }
  }
  return result;
}

/**
 * 查找SeriesBean
 * 
 * 在SeriesBean列表中查找指定名称的SeriesBean对象
 * 
 * @param seriesBeanList SeriesBean列表
 * @param title 要查找的名称
 * @return 找到的SeriesBean对象，未找到返回null
 */
SeriesBean? findSeriesBean(List<SeriesBean> seriesBeanList, String title) {
  SeriesBean? resultBean;
  for (SeriesBean seriesBean in seriesBeanList) {
    if (seriesBean.name == title) {
      resultBean = seriesBean;
      break;
    }
  }
  return resultBean;
}

/**
 * 处理推送消息
 * 
 * 处理WebSocket推送的盘面数据，更新当前盘面数据
 * 
 * @param state 盘面状态对象
 * @param map 推送数据Map
 */
void pushMessage(MatchMarketOverviewState state, Map<String, dynamic> map) {
  Map<String, dynamic> map1 = map["cd"] ?? {};
  OddReportAnalyzeDataOddsDataAverageList
      oddReportAnalyzeDataOddsDataAverageItem =
      OddReportAnalyzeDataOddsDataAverageList.fromJson(
          map1["averageList"] as Map<String, dynamic>);
  Map<String, dynamic> fieldOddsValueList = map1["fieldOddsValueList"];
  
  state.currentOddReportAnalyzeDataData?.odds =
      state.currentOddReportAnalyzeDataData?.odds ??
          OddReportAnalyzeDataOdds.fromJson({});
  state.currentOddReportAnalyzeDataData?.odds?.data =
      state.currentOddReportAnalyzeDataData?.odds?.data ??
          OddReportAnalyzeDataOddsData.fromJson({});
  state.currentOddReportAnalyzeDataData?.odds?.data?.averageList =
      state.currentOddReportAnalyzeDataData?.odds?.data?.averageList ?? [];
  state.currentOddReportAnalyzeDataData?.odds?.data?.averageList
      ?.add(oddReportAnalyzeDataOddsDataAverageItem);
  
  fieldOddsValueList.forEach((tempKey, value) {
    Map<String, dynamic> dataMap = state.currentOddReportAnalyzeDataData?.odds
            ?.data?.fieldOddsValueList ??
        {};
    List listTemp = ((dataMap[tempKey] ?? []) as List);
    listTemp.add(value);
    dataMap[tempKey] = listTemp;
  });
  
  convertChartFromOddReportAnalyzeDataData(
      state, state.currentOddReportAnalyzeDataData);
}

/**
 * 转换图表数据
 * 
 * 将接口返回的盘面数据转换为图表UI所需的数据模型
 * 
 * @param state 盘面状态对象
 * @param currentOddReportAnalyzeDataData 当前盘面分析数据
 */
void convertChartFromOddReportAnalyzeDataData(
    MatchMarketOverviewState state,
    OddReportAnalyzeDataEntity? currentOddReportAnalyzeDataData) {
  initColorList(state);
  String defaultString =
      "{\"barWidth\":\"10%\",\"type\":\"line\",\"connectNulls\":true,\"itemStyle\":{\"normal\":{\"barBorderRadius\":0,\"color\":{\"type\":\"linear\",\"x\":0,\"y\":0,\"x2\":0,\"y2\":1,\"colorStops\":[{\"offset\":0,\"color\":\"#CA6ECC\"},{\"offset\":1,\"color\":\"#CA6ECC\"}]}}}}";
  List<String> titles = [];
  Map<String, dynamic> dataMap =
      currentOddReportAnalyzeDataData?.odds?.data?.fieldOddsValueList ?? {};
  // 平均值
  List<OddReportAnalyzeDataOddsDataAverageList>? average =
      currentOddReportAnalyzeDataData?.odds?.data?.averageList
          ?.where((e) => e.oddsValue?.isNotEmpty == true)
          .toList();
  if (dataMap.isEmpty == true) {
    return;
  }
  
  // 添加平均值到数据映射
  dataMap[LocaleKeys.analysis_football_matches_average_value.tr] =
      average?.map((e) => e.toJson()).toList();
  dataMap.remove("A01");
  dataMap.remove("G01");
  
  // 收集所有时间戳
  List<String> allTimes = MatchMarketOverviewChartDataService.collectAllTimes(
      average, dataMap);

  // 处理每个数据项
  dataMap.forEach((tmpKey, value) {
    String key = convertKey(tmpKey);
    if (value != null && "$value".isNotEmpty) {
      titles.add(key);
      MatchMarketOverviewChartDataService.processSeriesBeanData(
          state, key, value, allTimes, defaultString);
    }
  });
  
  // 构建图表配置
  state.chartMap = MatchMarketOverviewChartDataService.buildChartMap(
      state, allTimes);
}

/**
 * 初始化颜色列表
 * 
 * 初始化图表线条的颜色配置
 * 
 * @param state 盘面状态对象
 */
void initColorList(MatchMarketOverviewState state) {
  state.colorStops.clear();
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#CA6ECC'),
    SeriesColorStops(offset: 0, color: '#CC45BA')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#46C8E5'),
    SeriesColorStops(offset: 0, color: '#00A1E5')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#708BFF'),
    SeriesColorStops(offset: 0, color: '#244CFF')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#878787'),
    SeriesColorStops(offset: 0, color: '#878787')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#34D21C'),
    SeriesColorStops(offset: 0, color: '#279E15')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#FF9E17'),
    SeriesColorStops(offset: 0, color: '#FF5F17')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#46C8E5'),
    SeriesColorStops(offset: 0, color: '#00A1E5')
  ]);
  state.colorStops.add([
    SeriesColorStops(offset: 0, color: '#F2797D'),
    SeriesColorStops(offset: 0, color: '#F29679')
  ]);
}

