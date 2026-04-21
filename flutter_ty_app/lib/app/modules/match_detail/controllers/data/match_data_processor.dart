import 'package:flutter/scheduler.dart';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/models/analysis/analysis_data_model.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../match_data_controller.dart';
import '../match_detail_controller.dart';
import 'match_data_basketball_handler.dart';
import 'services/match_data_processor_service.dart';

/**
 * 数据处理模块
 * 负责赛事数据的计算、处理和转换
 */
extension MatchDataProcessor on MatchDataController {
  /**
   * 初始化从详情拿 更新从数据仓库
   * 获取并处理赛事数据，包括环形数据、进度条数据等
   * @param matchEntity 可选的赛事实体，如果为null则从详情控制器获取
   */
  Future<void> getData({MatchEntity? matchEntity}) async {
    MatchEntity? match = matchEntity;
    // 初始化从详情拿数据 后续更新由数据仓库驱动
    if (matchEntity == null) {
      match = Get.find<MatchDetailController>(tag: tag).detailState.match;
    }
    // 环形数据计算
    if (state.currentTitlePageIndex == 1) {
      //  90分钟
      state.ringData = MatchDataProcessorService.getDanger(["S1041", "S811", "S1051"], match);
    } else if (state.currentTitlePageIndex == 2) {
      //   加时赛
      state.ringData = MatchDataProcessorService.getDanger(["S1042", "S812", "S1052"], match);
    } else {
      //   全场
      state.ringData = MatchDataProcessorService.getDanger(["S104", "S8", "S105"], match);
    }

    // 进度条 足球（射正、射偏）
    state.totalThreeListData.clear();
    if (match?.csid == "2") {
      state.totalThreeListData.add(getBasketBallMatch(match));
      state.basketballFreeThrowsResultList =
          MatchDataProcessorService.findNewAnalyzeMatchResultItemByList(
              state.basketballFreeThrowsList, match);
    } else {
      initSecondListData(match);
      initThreeListData(match);
    }
    MatchDataProcessorService.sumCircleNumber(state.four_statistics, match, fourList: state.four);

    ///构建(build)完成后调用 刷新 不然 页面会卡死
    SchedulerBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }


  /// 初始化加时赛数据
  /// [match] 赛事实体
  /// 初始化角球、红牌、黄牌以及射正、射偏数据
  initOverlayTime(MatchEntity? match) {
    initSecondListData(match);
    initThreeListData(match);
  }

  /**
   * 初始化角球、红牌、黄牌数据
   * [match] 赛事实体
   * 获取常规赛和加时赛的角球、红牌、黄牌数据
   * S5/S11/S12: 常规赛角球/红牌/黄牌
   * S555/S11001/S12001: 常规赛角球/红牌/黄牌（另一种格式）
   * S500/S503/S506: 加时赛角球/红牌/黄牌
   */
  initSecondListData(MatchEntity? match) {
    state.totalSecondListData.clear();
    // 常规赛角球、红牌、黄牌
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemSecondList =
        MatchDataProcessorService.getBallDataMatch(match, ['S5', 'S11', 'S12'],
            iconList: ["corner", "yellow_card", "red_card"]);
    state.totalSecondListData.add(newAnalyzeMatchResultItemSecondList);
    // 常规赛角球、红牌、黄牌（另一种格式）
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemSecondList1 =
        MatchDataProcessorService.getBallDataMatch(match, ['S555', 'S11001', 'S12001'],
            iconList: ["corner", "yellow_card", "red_card"]);
    state.totalSecondListData.add(newAnalyzeMatchResultItemSecondList1);
    // 加时赛角球、红牌、黄牌
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemSecondList2 =
        MatchDataProcessorService.getBallDataMatch(match, ['S500', 'S503', 'S506'],
            iconList: ["corner", "yellow_card", "red_card"]);
    state.totalSecondListData.add(newAnalyzeMatchResultItemSecondList2);
  }

  /**
   * 初始化射正、射偏数据
   * [match] 赛事实体
   * 获取常规赛和加时赛的射正、射偏数据，用于显示主客队百分比
   * S18/S17: 常规赛射正/射偏
   * S1811/S1711: 常规赛射正/射偏（另一种格式）
   * S1712/S1812: 加时赛射偏/射正
   */
  initThreeListData(MatchEntity? match) {
    state.totalThreeListData.clear();
    // 常规赛射正、射偏
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemSecondList =
        MatchDataProcessorService.getBallDataMatch(
      match,
      ['S18', 'S17'],
    );
    state.totalThreeListData.add(newAnalyzeMatchResultItemSecondList);
    // 常规赛射正、射偏（另一种格式）
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemSecondList1 =
        MatchDataProcessorService.getBallDataMatch(
      match,
      ['S1811', 'S1711'],
    );
    state.totalThreeListData.add(newAnalyzeMatchResultItemSecondList1);
    // 加时赛射偏、射正
    List<NewAnalyzeMatchResultItem> newAnalyzeMatchResultItemSecondList2 =
        MatchDataProcessorService.getBallDataMatch(
      match,
      ['S1712', 'S1812'],
    );
    state.totalThreeListData.add(newAnalyzeMatchResultItemSecondList2);
  }
}

