
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/historical_performance_p_b_bean_entity.dart';

import '../../../../services/models/res/historical_performance_p_b_bean_entity_electronic_football_entity.dart';
import '../../models/analysis/analysis_model.dart';
import '../match_detail_controller.dart';
import '../../widgets/container/match_market_overview/bean/series_bean.dart';
import 'services/history_performance_data_service.dart';
import 'services/history_performance_chart_service.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 历史表现控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 历史表现控制器
    】】】
 *
 */
class HistoryPerformanceController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String tag;

  HistoryPerformanceController({required this.tag});

  TabController? tabController;
  List<List<SeriesColorStops>> colorStops = [];
  List<String> tabs = [
    LocaleKeys.app_h5_handicap_tutorial_home_team.tr,
    LocaleKeys.app_h5_handicap_tutorial_away_team.tr
  ];

  // 走势图表数据
  List<SeriesBean> seriesBeanList = [];
  List<SeriesBean> seriesBeanList2 = [];

  int tabIndex = 0;

  /// 详情 tag，赛果进来需要传递
  String? tempTag;

  // 历史表现数据
  List<HistoricalPerformancePBBeanEntity> dataList = [];
  List<HistoricalPerformancePBBeanEntityElectronicFootballEntity>
      dataListElectronicFootball = [];

  // 排名
  String rank = "";

  // 联赛名称
  String teamName = "";

  List<GridListDataBean> gridListDataBeans = [
    GridListDataBean(LocaleKeys.analysis_overall.tr, [], "2/3赛事"),
    GridListDataBean(LocaleKeys.analysis_home.tr, [], "2/3赛事"),
    GridListDataBean(LocaleKeys.analysis_away.tr, [], "2/3赛事")
  ];
  // 主队
  List<GridListDataBean> gridListDataBeansElectronicFootball = [
    GridListDataBean(LocaleKeys.analysis_overall.tr, [], "2/3赛事"),
    GridListDataBean(LocaleKeys.analysis_home.tr, [], "2/3赛事"),
    GridListDataBean(LocaleKeys.analysis_away.tr, [], "2/3赛事")
  ];
  // 客队
  List<GridListDataBean> gridListDataBeansElectronicFootball1 = [
    GridListDataBean(LocaleKeys.analysis_overall.tr, [], "2/3赛事"),
    GridListDataBean(LocaleKeys.analysis_home.tr, [], "2/3赛事"),
    GridListDataBean(LocaleKeys.analysis_away.tr, [], "2/3赛事")
  ];

  /// 控制器初始化方法
  /// 初始化tab控制器并设置监听
  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController?.index.toDouble() ==
            tabController?.animation?.value) {
          // state.curMainTab.value = tabController.index;
          tabIndex = tabController?.index ?? 0;
          initPage2Data(flag: "${((tabController?.index ?? 0) + 1)}");
        }
      });
  }

  /// 控制器准备就绪方法
  /// 初始化数据
  @override
  void onReady() {
    initData();
    super.onReady();
  }

  @override
  void onClose() {
    // 释放 TabController
    tabController?.dispose();
    tabController = null;
    super.onClose();
  }

  /// 初始化数据
  /// 初始化页面2的数据
  void initData() async {
    initPage2Data(flag: "1");
  }

  /**
   * 根据类型查找数据
   * [dataList] 历史表现数据列表
   * 根据expressingType（0-全部，1-主场，2-客场）填充对应的数据Bean
   * name2: 前5场比赛的状态数组
   * name4: 平均进球数
   */
  void findByType(List<HistoricalPerformancePBBeanEntity> dataList) {
    Map<String, String> result =
        HistoryPerformanceDataService.findByType(dataList, gridListDataBeans);
    this.dataList = dataList;
    rank = result["rank"] ?? "";
    teamName = result["teamName"] ?? "";
    update();
  }

  /**
   * 根据类型查找电子足球数据
   * [dataList] 电子足球历史表现数据列表
   * 根据tabIndex选择主队或客队数据，填充全部、主场、客场的数据Bean
   * tabIndex == 0: 主队，tabIndex == 1: 客队
   */
  void findByTypeElectronicFootball(
      List<HistoricalPerformancePBBeanEntityElectronicFootballEntity>
          dataList) {
    AppLogger.debug(" entity.summaryAvg  ${dataList.length}");
    HistoryPerformanceDataService.findByTypeElectronicFootball(
        dataList, gridListDataBeansElectronicFootball, tabIndex);
    HistoryPerformanceDataService.findByTypeElectronicFootball(
        dataList, gridListDataBeansElectronicFootball, 0);
    HistoryPerformanceDataService.findByTypeElectronicFootball(
        dataList, gridListDataBeansElectronicFootball1, 1);
    this.dataListElectronicFootball = dataList;
    if (dataList.isNotEmpty) {
      rank = "";
      teamName = "";
    }
    update();
  }

  /// 获取进球数
  /// [entity] 历史表现实体
  /// 统计前5场比赛中状态为0（进球）的场次数量
  int getjinQiu(HistoricalPerformancePBBeanEntity entity) {
    return HistoryPerformanceDataService.getjinQiu(entity);
  }

  /// 初始化额外数据
  /// 根据当前tab索引初始化页面数据
  void initExtraData() {
    initPage2Data(flag: "${tabIndex + 1}");
  }

  /// 初始化页面2数据
  /// [flag] 标志，1为主队，2为客队
  void initPage2Data({String? flag}) {
    bool isElectronicFootball = Get.find<MatchDetailController>(tag: tag)
            .detailState
            .match
            ?.isC01FootBall ??
        false;
    ;
    if (isElectronicFootball) {
      requestHistoricalPerformancePBElectronicFootball(flag: flag);
    } else {
      requestHistoricalPerformancePB(flag: flag);
    }
  }

  bool isTopEmpty = true;

  /// 请求历史表现数据
  /// [flag] 标志，1为主队，2为客队
  void requestHistoricalPerformancePB({String? flag}) {
    AnalyzeDetailApi.instance()
        .getHistoricalPerformancePB(mid: tag, flag: flag ?? "1")
        .then((value) {
      if (value.data?.isNotEmpty == true) {
        isTopEmpty = false;
        update();
      }

      findByType(value.data ?? []);
      convertChartFromOddReportAnalyzeDataData(value.data ?? []);
    });
  }

  /// 请求电子足球历史表现数据
  /// [flag] 标志，1为主队，2为客队
  void requestHistoricalPerformancePBElectronicFootball({String? flag}) {
    AnalyzeDetailApi.instance()
        .getHistoricalPerformancePBElectronicFootball(
            mid: tag, flag: flag ?? "1")
        .then((value) {
      if (value.data?.isNotEmpty == true) {
        isTopEmpty = false;
        // this.dataListElectronicFootball = value.data ?? [];
        update();
      }
      findByTypeElectronicFootball(value.data ?? []);
    });
  }

  /// 判断系列数据是否存在
  /// [seriesBeanList] 系列数据列表
  /// [title] 标题
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

  /// 查找系列数据
  /// [seriesBeanList] 系列数据列表
  /// [title] 标题
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

  /// 将历史表现数据转换为图表数据
  /// [dataList] 历史表现数据列表
  void convertChartFromOddReportAnalyzeDataData(
      List<HistoricalPerformancePBBeanEntity> dataList) {
    ChartDataResult result =
        HistoryPerformanceChartService.convertChartFromOddReportAnalyzeDataData(
            dataList);
    colorStops = result.colorStops;
    seriesBeanList = result.seriesBeanList;
    seriesBeanList2 = result.seriesBeanList2;
    chartMap1 = result.chartMap1;
    chartMap2 = result.chartMap2;
    update();
  }

  Map<String, dynamic>? chartMap1;

  Map<String, dynamic>? chartMap2;
}
