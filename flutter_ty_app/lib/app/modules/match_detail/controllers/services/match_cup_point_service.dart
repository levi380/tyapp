import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/services/api/analyze_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/api_res.dart';
import 'package:flutter_ty_app/app/services/models/res/knockout_info_bean_entity.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import '../../../../modules/login/login_head_import.dart';
import '../../models/analysis/knockout_info_model.dart';
import '../../states/match_cup_point_state.dart';

/**
 * 杯赛积分服务类
 * 负责处理杯赛积分相关的业务逻辑和API请求
 * 
 * 规范要求：
 * - 所有接口请求必须封装到Service
 * - 接口调用统一命名为 XXXFetch
 */
class MatchCupPointService {
  /**
   * 组装数据
   * [state] 状态对象
   * [pageIndex] 页面索引
   * 根据promotionId（晋级组ID）对数据进行分组，用于图表显示
   */
  static void collectionData(
      MatchCupPointState state, int pageIndex) {
    state.union.clear();

    if (pageIndex >= state.currentCupBasketBallEventDataEvents.length) {
      return;
    }

    List<AnalyzeVsInfoNewInfoTeamRankings> analyzeVsInfoNewInfoTeamRankingss =
        state.currentCupBasketBallEventDataEvents[pageIndex].teamRankings;
    Map<String, List<AnalyzeVsInfoNewInfoTeamRankings>> group = {};
    List<AnalyzeVsInfoNewInfoTeamRankings> other = [];
    // 按promotionId分组
    for (AnalyzeVsInfoNewInfoTeamRankings item
        in analyzeVsInfoNewInfoTeamRankingss) {
      if (item.promotionId.isEmpty == true) {
        continue;
      }
      if (group[item.promotionId] == null) {
        group[item.promotionId] = [];
      }
      group[item.promotionId]?.add(item);
    }

    // 为每个promotionId创建union数据，用于图表显示
    // union包含：key（promotionId）、label（组名）、color（颜色）
    for (AnalyzeVsInfoNewInfoTeamRankings item
        in analyzeVsInfoNewInfoTeamRankingss) {
      if (item.promotionId.isNotEmpty == true) {
        Map? findResult = state.union[item.promotionId];
        if (findResult == null) {
          // 根据语言选择显示中文名或英文名
          state.union[item.promotionId] = ({
            "key": item.promotionId,
            "label": ["zh"].contains(getLang())
                ? item.promotionCnName
                : item.teamCnName,
            "color": MatchCupPointState.colors[state.union.length]
          });
        }
      } else {
        // promotionId为空的数据放入other列表
        other.add(item);
      }
    }
  }

  /**
   * 处理淘汰赛数据
   * [state] 状态对象
   * [data] 接口返回的淘汰赛数据
   * 初始化淘汰赛轮次列表（32强、16强、8强、半决赛、决赛）
   * 根据接口返回的数据填充各轮次的对阵信息
   */
  static void processKnockoutInfo(
      MatchCupPointState state, Map<String, dynamic>? data) {
    // 初始化淘汰赛轮次列表
    state.dataList = MatchCupPointState.knockoutRoundNames
        .map((name) => KnockoutInfo(name: name))
        .toList();
    // 根据key值（1-5）填充对应轮次的数据
    // key: 1-32强, 2-16强, 3-8强, 4-半决赛, 5-决赛
    data?.forEach((key, value) {
      KnockoutInfo knockoutInfo = state.dataList[0];
      knockoutInfo.name = MatchCupPointState.tabList[key] ?? "";
      if (key == "1") {
        List<KnockoutInfoBeanEntity> knockoutInfos = (value as List)
            .map((e) => KnockoutInfoBeanEntity.fromJson(e))
            .toList();
        knockoutInfo.type = key;
        knockoutInfo.list = knockoutInfos;
      }
      if (key == "2") {
        KnockoutInfo knockoutInfo = state.dataList[1];
        List<KnockoutInfoBeanEntity> knockoutInfos = (value as List)
            .map((e) => KnockoutInfoBeanEntity.fromJson(e))
            .toList();
        knockoutInfo.type = key;
        knockoutInfo.list = knockoutInfos;
      }
      if (key == "3") {
        KnockoutInfo knockoutInfo = state.dataList[2];
        List<KnockoutInfoBeanEntity> knockoutInfos = (value as List)
            .map((e) => KnockoutInfoBeanEntity.fromJson(e))
            .toList();
        knockoutInfo.type = key;
        knockoutInfo.list = knockoutInfos;
      }
      if (key == "4") {
        KnockoutInfo knockoutInfo = state.dataList[3];
        List<KnockoutInfoBeanEntity> knockoutInfos = (value as List)
            .map((e) => KnockoutInfoBeanEntity.fromJson(e))
            .toList();
        knockoutInfo.type = key;
        knockoutInfo.list = knockoutInfos;
      }
      if (key == "5") {
        KnockoutInfo knockoutInfo = state.dataList[4];
        List<KnockoutInfoBeanEntity> knockoutInfos = (value as List)
            .map((e) => KnockoutInfoBeanEntity.fromJson(e))
            .toList();
        knockoutInfo.type = key;
        knockoutInfo.list = knockoutInfos;
      }
    });
    // 删除没有数据的轮次（type为"-1"）
    List deleteItem = [];
    for (int index = state.dataList.length - 1; index >= 0; index--) {
      KnockoutInfo knockoutInfo = state.dataList[index];
      if (knockoutInfo.type == "-1") {
        deleteItem.add(knockoutInfo);
      }
    }
    for (KnockoutInfo item in deleteItem) {
      state.dataList.remove(item);
    }
    state.currentIndex = 0;
    if (state.dataList.isNotEmpty) {
      state.currentList = state.dataList[state.currentIndex].list;
    }
  }

  /**
   * 处理VS信息数据
   * [state] 状态对象
   * [dataList] VS信息数据列表
   * 合并所有小组的排名数据，并添加"全部"选项
   */
  static void processVSInfoData(
      MatchCupPointState state, List<AnalyzeVsInfoNewInfoEntity> dataList) {
    state.currentCupBasketBallEventDataEvents = dataList;
    if (state.currentCupBasketBallEventDataEvents.isNotEmpty) {
      // 合并所有小组的排名数据，并添加"全部"选项
      List<AnalyzeVsInfoNewInfoTeamRankings> totalList = [];
      int index = 1;
      for (AnalyzeVsInfoNewInfoEntity item
          in state.currentCupBasketBallEventDataEvents) {
        for (AnalyzeVsInfoNewInfoTeamRankings ranking
            in item.teamRankings) {
          ranking.index = (index++);
        }
        totalList.addAll(item.teamRankings);
      }
      // 在列表开头插入"全部"选项，包含所有小组的合并数据
      state.currentCupBasketBallEventDataEvents.insert(
          0,
          AnalyzeVsInfoNewInfoEntity()
            ..rankingName = LocaleKeys.app_h5_match_all.tr
            ..teamRankings = totalList);
    }
  }

  /**
   * 获取VS信息数据
   * [tag] 比赛ID
   * [pointType] 积分类型，"2"表示使用版本1，否则使用版本2
   * [flag] 标志，不传为杯赛，传为联赛
   * 返回API响应数据
   */
  static Future<ApiRes<List<AnalyzeVsInfoNewInfoEntity>>> vsInfoFetch({
    required String tag,
    String? pointType,
    String? flag,
  }) async {
    try {
      final version = pointType == "2" ? "1" : "2";
      return await AnalyzeDetailApi.instance().vsInfoVersion2(tag, version, flag);
    } catch (e) {
      AppLogger.debug("MatchCupPointService vsInfoFetch error: ${e.toString()}");
      rethrow;
    }
  }

  /**
   * 获取淘汰赛信息数据
   * [stId] 标准赛事ID
   * [mid] 比赛ID
   * 返回API响应数据
   */
  static Future<ApiRes<Map<String, dynamic>?>> knockoutInfoFetch({
    required String? stId,
    required String mid,
  }) async {
    try {
      return await AnalyzeDetailApi.instance().getKnockoutInfo(stId: stId, mid: mid);
    } catch (e) {
      AppLogger.debug("MatchCupPointService knockoutInfoFetch error: ${e.toString()}");
      rethrow;
    }
  }
}

