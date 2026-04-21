import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_statistic_state.dart';
import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';

import '../../../services/models/res/analyze_team_vs_history_entity.dart';
import '../../../services/models/res/match_entity.dart';
import '../../../services/models/res/statistics_front_fight_entity.dart';
import '../../../services/models/res/statistics_tab_switch_entity.dart';
import '../../../services/models/res/statistics_technical_entity.dart';
import '../../login/login_head_import.dart';
import '../models/analysis/analysis_model.dart';
import 'match_detail_controller.dart';
import 'services/match_statistic_tab_service.dart';
import 'services/match_statistic_data_converter_service.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球篮球统计控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘面控制器
    】】】
 *
 */
class MatchStatisticController extends GetxController
    with GetTickerProviderStateMixin {
  final String tag;

  MatchStatisticController({required this.tag});

  MatchStatisticMatchHistoryState state = MatchStatisticMatchHistoryState();

  /// 控制器初始化方法
  /// 初始化tab
  @override
  void onInit() {
    super.onInit();
    initTabs();
  }

  /**
   * 初始化tab
   * 根据权限配置和赛事类型动态创建tab列表
   * 电子足球赛事不走权限验证，直接显示正面交手和历史表现
   * 普通赛事根据权限配置显示：技术统计、阵容、正面交手、历史表现、本赛季数据
   */
  void initTabs() {
    StatisticsTabSwitchEntity? statisticsTabSwitchEntity =
        Get.find<MatchDetailController>(tag: tag)
            .detailState
            .statisticsTabSwitchEntity;

    MatchEntity? matchEntity =
        Get.find<MatchDetailController>(tag: tag).detailState.match;
    state.tabs.clear();

    state.tabs = MatchStatisticTabService.initTabs(
            tag: tag,
      statisticsTabSwitchEntity: statisticsTabSwitchEntity,
      matchEntity: matchEntity,
      fetchFrontFight: fetchFrontFight,
      fetchBasketballTechnical: fetchBasketballTechnical,
    );

    state.tabController = TabController(length: state.tabs.length, vsync: this);
    // 初始化第一个tab的数据
    if (state.tabs.isNotEmpty && state.tabs.safeFirst?.fetchData != null) {
      state.tabs.safeFirst!.fetchData!();
    }
  }

  /// 请求正面交手数据
  /// [isElectronicFootball] 是否为电子足球
  Future<void> fetchFrontFight({required bool isElectronicFootball}) async {
    try {
      if (isElectronicFootball) {
        var res = await AnalyzeDetailApi.instance()
            .getFrontFightPBForElectronicFootball(mid: tag);
        state.electronicFootballPBBeanList = res.data ?? [];
        if (res.data != null) {
          state.isTopDataEmpty = false;
        }
      } else {
        var res = await AnalyzeDetailApi.instance().getFrontFight(mid: tag);
        state.page1FrontFightPBBeanEntity = res.data;

        converFrontFightPBBeanEntityToUI(state.page1FrontFightPBBeanEntity);
        if (res.data != null) {
          state.isTopDataEmpty = false;
        }
      }

      requestTeamsVSInfo();
      update();
    } catch (e) {
      AppLogger.debug("MatchStatisticController fetchFrontFight : " + e.toString());
    }
  }

  /// 获取篮球技术统计数据
  Future<void> fetchBasketballTechnical() async {
    try {
      var res =
          await AnalyzeDetailApi.instance().getTechnicalPBBasketBall(mid: tag);
      if (res.success) {
        state.technicalPBBeanEntitys = res.data ?? [];
        if (state.technicalPBBeanEntitys.length >= 2) {
          StatisticsTechnicalEntity? home =
              findTeamByType(state.technicalPBBeanEntitys, "1");
          StatisticsTechnicalEntity? away =
              findTeamByType(state.technicalPBBeanEntitys, "2");
          state.technicalPBUIBeans = [
            TechnicalPBUIBean(
                centerName: "篮球板总数",
                leftValue: "${home?.rebound ?? 0}",
                rightValue: "${away?.rebound ?? 0}"),
            TechnicalPBUIBean(
                centerName: "进攻篮板球数",
                leftValue: "${home?.offensiveRebound ?? 0}",
                rightValue: "${away?.offensiveRebound ?? 0}"),
            TechnicalPBUIBean(
                centerName: "防守篮板球数",
                leftValue: "${home?.defensiveRebound ?? 0}",
                rightValue: "${away?.defensiveRebound ?? 0}"),
            TechnicalPBUIBean(
                centerName: "助攻次数",
                leftValue: "${home?.assist ?? 0}",
                rightValue: "${away?.assist ?? 0}"),
            TechnicalPBUIBean(
                centerName: "盖帽次数",
                leftValue: "${home?.blockedShots ?? 0}",
                rightValue: "${away?.blockedShots ?? 0}"),
            TechnicalPBUIBean(
                centerName: "抢断次数",
                leftValue: "${home?.steal ?? 0}",
                rightValue: "${away?.steal ?? 0}"),
            TechnicalPBUIBean(
                centerName: "失误次数",
                leftValue: "${home?.turnover ?? 0}",
                rightValue: "${away?.turnover ?? 0}"),
            TechnicalPBUIBean(
                centerName: "内线得分",
                leftValue: "${home?.score ?? 0}",
                rightValue: "${away?.score ?? 0}"),
            TechnicalPBUIBean(
                centerName: "个人犯规次数",
                leftValue: "${home?.fouls ?? 0}",
                rightValue: "${away?.fouls ?? 0}"),
          ];
        }
        update();
      }

      // requestTeamsVSInfo();
    } catch (e) {
      AppLogger.debug(
          "MatchStatisticController fetchBasketballTechnical:" + e.toString());
    }
  }

  /// 根据类型查找队伍技术统计数据
  /// [list] 技术统计数据列表
  /// [type] 队伍类型（1主队，2客队）
  StatisticsTechnicalEntity? findTeamByType(
      List<StatisticsTechnicalEntity> list, String type) {
    StatisticsTechnicalEntity? technicalPBBeanEntity;
    for (StatisticsTechnicalEntity item in list) {
      if (item.homeAway == type) {
        technicalPBBeanEntity = item;
        break;
      }
    }
    return technicalPBBeanEntity;
  }

  /// 获取团队VS历史记录
  /// [day] 天数，默认15天
  /// [flag] 标志，默认"0"
  void requestTeamsVSInfo({String day = "15", String flag = "0"}) async {
    try {
      var res = await AnalyzeDetailApi.instance().teamVSHistory(tag, flag, day);
      if (res.success) {
        state.analyzeTeamsList = res.data ?? [];

        state.pageList.clear();
        for (int i = 0; i < state.analyzeTeamsList.length; i++) {
          List<AnalyzeTeamVsHistoryEntity> list = [];
          AnalyzeTeamVsHistoryEntity analyzeTeamVsHistoryEntity =
              state.analyzeTeamsList[i];
          list.add(analyzeTeamVsHistoryEntity);
          state.pageList.add(list);
        }
        update();
      }
    } catch (e) {
      AppLogger.debug("MatchStatisticController requestTeamsVSInfo" + e.toString());
    }
  }

  /**
   * 将正面交手数据转换为UI显示数据
   * [page1frontFightPBBeanEntity] 正面交手数据实体
   * 转换包括：大于1球、大于2球、大于3球、总进球、主队不败、客队不败的百分比和场次
   * 以及胜平负的百分比和场次
   */
  void converFrontFightPBBeanEntityToUI(
      StatisticsFrontFightEntity? page1frontFightPBBeanEntity) {
    MatchStatisticDataConverterService.converFrontFightPBBeanEntityToUI(
      state,
      page1frontFightPBBeanEntity,
      tag,
    );
  }

  /// 切换展开/收起状态
  void switchExpand() {
    state.expand1 = !state.expand1;
    update();
  }

  @override
  void onClose() {
    // 释放 TabController
    state.tabController?.dispose();
    state.tabController = null;
    super.onClose();
  }
}
