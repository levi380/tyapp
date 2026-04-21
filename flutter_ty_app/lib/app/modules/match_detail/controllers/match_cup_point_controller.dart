import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/match_cup_point_state.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../services/models/res/statistics_tab_switch_entity.dart';
import '../../login/login_head_import.dart';
import '../models/analysis/knockout_info_model.dart';
import '../models/match_detail_tab.dart';
import '../widgets/container/match_cup_point/widget/basketball_league_points.dart';
import '../widgets/container/match_cup_point/widget/football_league_points.dart';
import '../widgets/container/match_cup_point/widget/knockout_round.dart';
import 'match_detail_controller.dart';
import 'match_tools_methods.dart';
import 'services/match_cup_point_service.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 积分】】】
    【【【 AUTO_PARAGRAPH_TITLE 杯赛积分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 杯赛积分主控制器主要操作方法
    - 杯赛积分列表
    - 杯赛积分页面切换
    】】】
 *
 */
class MatchCupPointController extends GetxController
    with GetTickerProviderStateMixin {
  final String tag;

  MatchCupPointController({required this.tag});



  MatchCupPointState state = MatchCupPointState();

  /// 控制器初始化方法
  /// 初始化tab
  @override
  void onInit() {
    super.onInit();
    initTab();
  }

  /**
   *
   *
      【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
      【【【 AUTO_DOCUMENT_TITLE 积分】】】
      【【【 AUTO_PARAGRAPH_TITLE 详情主控制器】】】
      【【【 AUTO_PARAGRAPH_CONTENT
      - 联赛选择修改赛事
      】】】
   *
   */
  /**
   * 初始化tab
   * 根据权限配置创建淘汰赛和小组赛tab
   * 淘汰赛：显示淘汰赛轮次信息
   * 小组赛：根据赛事类型显示足球或篮球的积分榜
   */
  initTab() {
    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);

    StatisticsTabSwitchEntity? statisticsTabSwitchEntity =
        detailController.detailState.statisticsTabSwitchEntity;
    state.tabs.clear();
    // 是否显示淘汰赛tab
    if (statisticsTabSwitchEntity?.points?.knockoutStage == "1") {
      state.tabs.add(MatchDetailTab(
        LocaleKeys.virtual_sports_knockout.tr,
        DetailTabType.cupPointKnockoutStage,
        (tag) => KnockoutRound(tag: tag),
        fetchData: fetchKnockoutInfo,
      ));
    }

    // 是否显示小组赛tab（积分榜）
    if (statisticsTabSwitchEntity?.points?.leaguePoints == "1") {
      state.tabs.add(MatchDetailTab(
        LocaleKeys.virtual_sports_group_matches.tr,
        DetailTabType.cupPointLeaguePoints,
        (tag) => detailController.detailState.csid == "1"
            ? FootballLeaguePoints(tag: tag)
            : BasketballLeaguePoints(tag: tag),
        fetchData: () => fetchVSInfo(
            pointType: statisticsTabSwitchEntity?.points?.pointType),
      ));
    }

    state.tabController = TabController(length: state.tabs.length, vsync: this);

    // 初始化第一个tab的数据
    if (state.tabs.isNotEmpty && state.tabs.safeFirst?.fetchData != null) {
      state.tabs.safeFirst!.fetchData!();
    }
  }

  /// 获取VS信息
  /// [flag] 标志，不传为杯赛，传为联赛
  /// [pointType] 积分类型
  /// Controller只负责协调，具体API调用由Service处理
  void fetchVSInfo({String? flag, String? pointType}) async {
    try {
      final res = await MatchCupPointService.vsInfoFetch(
        tag: tag,
        pointType: pointType,
        flag: flag,
      );
      if (res.success && res.data?.isNotEmpty == true) {
        MatchCupPointService.processVSInfoData(state, res.data ?? []);
        if (state.currentCupBasketBallEventDataEvents.isNotEmpty) {
          setCurrentCupBasketBallEventPageIndex(
              state.currentCupBasketBallEventDataEvents[
                  state.currentCupBasketBallEventPageIndex]);
          MatchCupPointService.collectionData(state, state.currentCupBasketBallEventPageIndex);
        }
        update();
      }
    } catch (e) {
      AppLogger.debug("MatchCupPointController fetchVSInfo error: ${e.toString()}");
    }
  }


  /**
   * 获取淘汰赛数据
   * 初始化淘汰赛轮次列表（32强、16强、8强、半决赛、决赛）
   * 根据接口返回的数据填充各轮次的对阵信息
   * Controller只负责协调，具体API调用由Service处理
   */
  Future<void> fetchKnockoutInfo() async {
    try {
      MatchDetailController detailController =
          Get.find<MatchDetailController>(tag: tag);
      MatchEntity? match = detailController.detailState.match;
      
      final res = await MatchCupPointService.knockoutInfoFetch(
        stId: match?.tid,
        mid: tag,
      );
      
      if (res.success) {
        MatchCupPointService.processKnockoutInfo(state, res.data);
        update();
      }
    } catch (e) {
      AppLogger.debug("MatchCupPointController fetchKnockoutInfo error: ${e.toString()}");
    }
  }

  /// 选择列表索引
  /// [indexOf] 索引值
  void selectIndex(int indexOf) {
    state.currentIndex = indexOf;
    state.currentList = state.dataList[state.currentIndex].list;
    update();
  }

  /// 设置展开/收起导入状态
  /// [isExpandImport] 是否展开导入
  void setExpandImport(bool isExpandImport) {
    state.isExpandImport = isExpandImport;

    update();
  }

  /// 获取队伍名称颜色索引
  /// [team] 队伍名称
  /// 返回1表示主队，2表示客队，0表示未找到
  int getTeamNameColorIndex(String team) {
    int result = 0;
    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);
    MatchEntity? match = detailController.detailState.match;
    if (match != null) {
      String homeName = getTeamName(type: 1, match: match);
      if (homeName == team) {
        return 1;
      }
      String awayName = getTeamName(type: 2, match: match);
      if (awayName == team) {
        return 2;
      }
    }
    return result;
  }

  /// 设置当前杯赛篮球事件页面索引
  /// [e] 分析VS信息新信息实体
  void setCurrentCupBasketBallEventPageIndex(AnalyzeVsInfoNewInfoEntity e) {
    int result = -1;
    for (int i = 0; i < state.currentCupBasketBallEventDataEvents.length; i++) {
      AnalyzeVsInfoNewInfoEntity item =
          state.currentCupBasketBallEventDataEvents[i];
      if (e.rankingName == item.rankingName) {
        result = i;
        break;
      }
    }

    if (result < 0) {
      return;
    }
    state.currentCupBasketBallEventPageIndex = result;
    MatchCupPointService.collectionData(state, state.currentCupBasketBallEventPageIndex);

    state.isExpandImport = false;
    update();
  }

  /// 获取数据列表长度
  /// 返回有效数据项的数量
  int getLength() {
    int total = 0;
    for (int i = 0; i < state.dataList.length; i++) {
      KnockoutInfo item = state.dataList[i];
      if (item.type != "-1") {
        total++;
      } else {
        break;
      }
    }

    return total;
  }

  @override
  void onClose() {
    // 释放 TabController
    state.tabController?.dispose();
    state.tabController = null;
    super.onClose();
  }
}
