import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/states/battle_array_state.dart';
import 'package:get/get.dart';
import '../../../../services/api/analyze_detail_api.dart';
import '../../../../services/models/res/analyze_array_person_entity.dart';
import 'services/battle_array_formation_service.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3ad0ad43-a950-4b5a-a444-60268ce8fd0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事分析 】】】
    【【【 AUTO_DOCUMENT_TITLE 统计】】】
    【【【 AUTO_PARAGRAPH_TITLE 足球统计控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球统计控制器
    】】】
 *
 */
class BattleArrayController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final String tag;
  BattleArrayState state = BattleArrayState();

  BattleArrayController({required this.tag});

  /// 控制器初始化方法
  /// 初始化tab控制器并设置监听
  @override
  void onInit() {
    super.onInit();

    state.tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (state.tabController?.index.toDouble() ==
            state.tabController?.animation?.value) {
          state.curMainTab = state.tabController?.index ?? 0;
          requestMatchLineUpList(index: state.curMainTab + 1);
        }
      });
  }

  /// 控制器准备就绪方法
  /// 请求阵容列表数据
  @override
  onReady() {
    super.onReady();
    requestMatchLineUpList(index: 1);
  }

  @override
  void onClose() {
    // 释放 TabController
    state.tabController?.dispose();
    state.tabController = null;
    super.onClose();
  }

  /// 请求阵容列表
  /// [index] 索引，1为主队，2为客队
  Future<void> requestMatchLineUpList({int index = 1}) async {
    try {
      var res =
          await AnalyzeDetailApi.instance().getMatchLineupList(tag, "${index}");
      if (res.success) {
        dealData(res.data, index - 1);
        if (index == 1) {
          state.analyzeArrayPersonEntity = res.data;

          for (Up up in (state.analyzeArrayPersonEntity?.layOff ?? [])) {
            (state.analyzeArrayPersonEntity?.up ?? [])
                .removeWhere((e) => e.thirdPlayerName == up.thirdPlayerName);
          }
        } else {
          state.analyzeArrayPersonEntity2 = res.data;
          for (Up up in (state.analyzeArrayPersonEntity2?.layOff ?? [])) {
            (state.analyzeArrayPersonEntity2?.up ?? [])
                .removeWhere((e) => e.thirdPlayerName == up.thirdPlayerName);
          }
        }
        update();
      }
    } catch (e) {
      AppLogger.debug("requestMatchLineUpList: " + e.toString());
    }
  }

  /**
   * 处理数据
   * [data] 分析阵容人员实体
   * [index] 索引，0为主队，1为客队
   * 根据赛事类型（足球/篮球）和队伍类型进行不同的数据处理
   */
  void dealData(AnalyzeArrayPersonEntity? data, int index) {
    MatchDetailController detailController =
        Get.find<MatchDetailController>(tag: tag);
    // 足球赛事（csid == "1"）：需要处理阵型
    if (detailController.detailState.csid == "1") {
      if (index == 0) {
        // 主队：保存数据并过滤主队阵型
        state.line_up_data_home = data;
        BattleArrayFormationService.filterHomeArray(
            state, data?.homeFormation ?? "", index);
      } else {
        // 客队：保存数据并过滤客队阵型
        state.line_up_data_away = data;
        BattleArrayFormationService.filterAwayArray(
            state, data?.awayFormation ?? "", index);
      }
    } else {
      // 篮球赛事：直接使用up数据，主队需要反转顺序
      if (index == 0) {
        state.basketball_data = data?.up?.reversed.toList() ?? [];
      } else {
        state.basketball_data = data?.up;
      }
    }

    update();
  }




  /// 判断是否显示项目（足球）
  /// [first] 是否为主队
  /// [item] 球员信息
  bool showItem(bool first, Up? item) {
    return BattleArrayFormationService.showItem(state, first, item);
  }

  /**
   * 获取首发球员数据
   * 根据当前tab索引返回主队或客队的首发球员列表
   * curMainTab == 0 表示主队，curMainTab == 1 表示客队
   */
  List<Up>? getBodyUpData() {
    if (state.curMainTab == 0) {
      return state.analyzeArrayPersonEntity?.up;
    } else {
      return state.analyzeArrayPersonEntity2?.up;
    }
  }

  /**
   * 获取替补球员数据
   * 根据当前tab索引返回主队或客队的替补球员列表
   */
  List<Up>? getBodyLayOffData() {
    if (state.curMainTab == 0) {
      return state.analyzeArrayPersonEntity?.layOff;
    } else {
      return state.analyzeArrayPersonEntity2?.layOff;
    }
  }

  /**
   * 获取未上场球员数据
   * 根据当前tab索引返回主队或客队的未上场球员列表
   */
  List<Up>? getBodyDownData() {
    if (state.curMainTab == 0) {
      return state.analyzeArrayPersonEntity?.down;
    } else {
      return state.analyzeArrayPersonEntity2?.down;
    }
  }

  /**
   * 获取替补数据
   * 根据当前tab索引返回主队或客队的替补球员列表（与getBodyLayOffData功能相同）
   */
  List<Up>? getLayoffData() {
    if (state.curMainTab == 0) {
      return state.analyzeArrayPersonEntity?.layOff;
    } else {
      return state.analyzeArrayPersonEntity2?.layOff;
    }
  }

  /// 判断替补是否为空
  bool isBodyLayoffEmpty() {
    bool result = true;
    if (state.curMainTab == 0) {
      result = (state.analyzeArrayPersonEntity?.layOff == null ||
          state.analyzeArrayPersonEntity?.layOff?.isEmpty == true);
    } else {
      result = (state.analyzeArrayPersonEntity2?.layOff == null ||
          state.analyzeArrayPersonEntity2?.layOff?.isEmpty == true);
    }
    return result;
  }

  /// 判断首发是否为空
  bool isBodyUpEmpty() {
    bool result = true;
    if (state.curMainTab == 0) {
      result = (state.analyzeArrayPersonEntity?.up == null ||
          state.analyzeArrayPersonEntity?.up?.isEmpty == true);
    } else {
      result = (state.analyzeArrayPersonEntity2?.up == null ||
          state.analyzeArrayPersonEntity2?.up?.isEmpty == true);
    }

    return result;
  }

  /// 判断未上场球员是否为空
  bool isBodyDownEmpty() {
    bool result = true;
    if (state.curMainTab == 0) {
      result = (state.analyzeArrayPersonEntity?.down == null ||
          state.analyzeArrayPersonEntity?.down?.isEmpty == true);
    } else {
      result = (state.analyzeArrayPersonEntity2?.down == null ||
          state.analyzeArrayPersonEntity2?.down?.isEmpty == true);
    }
    return result;
  }


  /// 设置展开/收起状态
  void setExpand() {
    state.expand = !state.expand;
    update();
  }
}
