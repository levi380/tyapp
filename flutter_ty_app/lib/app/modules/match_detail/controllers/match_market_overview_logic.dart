import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_market_overview_state.dart';
import '../../../utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'match_market_overview_init_service.dart' as init_service;
import 'match_market_overview_selector_service.dart' as selector_service;
import 'match_market_overview_chart_service.dart' as chart_service;
import 'match_market_overview_api_service.dart' as api_service;

/**
 * 盘面控制器
 * 
 * 负责协调盘面相关的所有业务逻辑，包括：
 * - 盘面初始化
 * - 盘面数据管理
 * - 盘面状态管理
 * - 协调各个服务模块
 */
class AnalyzeMarketOverviewLogic extends GetxController
    with GetTickerProviderStateMixin {
  /// 控制器标签
  final String tag;
  
  /// 盘面状态对象
  MatchMarketOverviewState state = MatchMarketOverviewState();
  
  AnalyzeMarketOverviewLogic({required this.tag});

  /// 控制器初始化方法
  /// 初始化Tab、颜色列表和数据
  @override
  void onInit() {
    super.onInit();
    // 初始化Tab
    initTab();
    // 初始化颜色列表
    initColorList();
    // 初始化数据
    initData();
  }

  /// 控制器准备就绪方法
  /// 初始化WebSocket推送监听
  @override
  void onReady() {
    super.onReady();
    // 初始化WebSocket推送
    initBus();
  }

  /// 控制器关闭方法
  /// 释放TabController资源
  @override
  void onClose() {
    super.onClose();
    // 释放TabController
    state.tabController?.dispose();
  }

  /// 控制器销毁方法
  /// 取消WebSocket监听
  @override
  void dispose() {
    // 取消WebSocket监听
    Bus.getInstance().off(EventType.RCMD_C1041);
    super.dispose();
  }

  /**
   * 初始化Tab
   * 
   * 根据配置信息初始化盘面的Tab列表
   */
  void initTab() {
    init_service.initTab(state, tag);
    // 创建TabController
    state.tabController = TabController(length: state.tabs.length, vsync: this);
    // 初始化第一个tab的数据
    if (state.tabs.isNotEmpty && state.tabs.safeFirst?.fetchData != null) {
      state.tabs.safeFirst!.fetchData!();
    }
  }

  /**
   * 初始化数据
   * 
   * 初始化盘面的基础数据
   */
  void initData() async {
    await api_service.requestMatchAnalysiseData(
      state,
      tag,
      "5",
      "${state.curMainTab.value + 1}",
    );
    selector_service.getAllOptions(state, tag);
    update(["analyzeMatchOddsLogic${state.curMainTab.value + 1}"]);
  }

  /**
   * 初始化WebSocket推送
   * 
   * 注册WebSocket推送监听
   */
  void initBus() {
    init_service.initBus(state, (Map<String, dynamic> map) {
      pushMessage(map);
    });
  }

  /**
   * 初始化颜色列表
   * 
   * 初始化图表线条的颜色配置
   */
  void initColorList() {
    chart_service.initColorList(state);
  }

  /**
   * 处理推送消息
   * 
   * 处理WebSocket推送的盘面数据
   * 
   * @param map 推送数据Map
   */
  void pushMessage(Map<String, dynamic> map) {
    chart_service.pushMessage(state, map);
    update(["getLineChart"]);
  }

  /**
   * 设置一级选择器选项
   * 
   * @param index 选择器索引
   */
  void setSelectPlayInfo(int index) {
    selector_service.setSelectPlayInfo(state, index);
    update(["getBuildHead"]);
  }

  /**
   * 设置二级选择器选项
   * 
   * @param index 选择器索引
   */
  void setSelectChildPlayInfo(int index) {
    selector_service.setSelectChildPlayInfo(state, index);
    update(["getBuildHead"]);
  }

  /**
   * 设置三级选择器选项
   * 
   * @param index 选择器索引
   */
  void setSelectThirdChildPlayInfo(int index) {
    selector_service.setSelectThirdChildPlayInfo(state, index);
    update(["getBuildHead"]);
  }

  /**
   * 请求赛事分析数据
   * 
   * @param parentMenuId 父菜单ID
   * @param sonMenuId 子菜单ID
   * @param standardMatchId 标准赛事ID
   * @param updateIndex 更新索引
   */
  void requestMatchAnalysiseData(
    String? parentMenuId,
    String? sonMenuId,
    String? standardMatchId, {
    int updateIndex = 0,
  }) async {
    await api_service.requestMatchAnalysiseData(
      state,
      tag,
      parentMenuId,
      sonMenuId,
      updateIndex: updateIndex,
    );
    update([
      "analyzeMatchOddsLogic$sonMenuId",
    ]);
  }

  /**
   * 请求预期分析数据
   * 
   * @param parentMenuId 父菜单ID
   * @param sonMenuId 子菜单ID
   * @param standardMatchId 标准赛事ID
   */
  void requestMatchData(
    String? parentMenuId,
    String? sonMenuId,
    String? standardMatchId,
  ) {
    api_service.requestMatchData(
      state,
      parentMenuId,
      sonMenuId,
      standardMatchId,
    );
    update([
      "buildList1",
    ]);
  }

  /**
   * 获取走势图数据
   * 
   * 请求走势图所需的数据
   */
  Future<void> fetchTrendChart() async {
    await init_service.fetchTrendChart(state, tag);
    update(["getLineChart"]);
  }

  /**
   * 转换图表数据
   * 
   * 将接口返回的盘面数据转换为图表UI所需的数据模型
   * 
   * @param currentOddReportAnalyzeDataData 当前盘面分析数据
   */
  void convertChartFromOddReportAnalyzeDataData(
      dynamic currentOddReportAnalyzeDataData) {
    chart_service.convertChartFromOddReportAnalyzeDataData(
      state,
      currentOddReportAnalyzeDataData,
    );
    update(["getLineChart"]);
  }

  /**
   * 改变赔率类型
   * 
   * 更新当前选择的赔率类型
   * 
   * @param oddsType 赔率类型
   */
  void changeOddType(String oddsType) {
    selector_service.changeOddType(state, oddsType);
  }
}
