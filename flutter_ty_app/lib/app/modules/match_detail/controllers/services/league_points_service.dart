import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/services/models/res/analyze_vs_info_new_info_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_analyze_vs_info_entity.dart';
import 'package:flutter_ty_app/app/services/network/request_interceptor.dart';
import '../../states/league_points_state.dart';

/**
 * 联赛积分服务类
 * 负责处理联赛积分相关的业务逻辑
 */
class LeaguePointsService {
  /**
   * 处理VS信息数据（Version2版本）
   * [state] 状态对象
   * [dataList] VS信息数据列表
   * 合并所有小组的排名数据，并设置索引
   */
  static void processVSInfoVersion2Data(
      LeaguePointsState state, List<AnalyzeVsInfoNewInfoEntity> dataList) {
    state.currentCupBasketBallEventDataEvents = dataList;
    if (state.currentCupBasketBallEventDataEvents.isNotEmpty) {
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
    }
  }

  /**
   * 组装数据
   * [state] 状态对象
   * [pageIndex] 页面索引，默认为0
   * 根据版本类型组装不同的数据结构
   */
  static void collectionData(LeaguePointsState state, {int pageIndex = 0}) {
    state.union.clear();
    if (state.version == LeaguePointVersion.version2) {
      if (pageIndex >= state.currentCupBasketBallEventDataEvents.length) {
        return;
      }
      List<AnalyzeVsInfoNewInfoTeamRankings> analyzeVsInfoNewInfoTeamRankingss =
          state.currentCupBasketBallEventDataEvents[pageIndex].teamRankings;
      Map<String, List<AnalyzeVsInfoNewInfoTeamRankings>> group = {};
      List<AnalyzeVsInfoNewInfoTeamRankings> other = [];
      for (AnalyzeVsInfoNewInfoTeamRankings item
          in analyzeVsInfoNewInfoTeamRankingss) {
        if (item.promotionId.isEmpty == true) {
          continue;
        }
        String promotionId = item.promotionId;
        if (group[promotionId] == null) {
          group[promotionId] = [];
        }
        group[promotionId]?.add(item);
      }

      for (AnalyzeVsInfoNewInfoTeamRankings item
          in analyzeVsInfoNewInfoTeamRankingss) {
        if (item.promotionId.isNotEmpty == true) {
          Map? findResult = state.union[item.promotionId];
          if (findResult == null) {
            state.union[item.promotionId] = ({
              "key": item.promotionId,
              "label": ["zh"].contains(getLang())
                  ? item.promotionCnName
                  : item.teamCnName,
              "color": state.colors[state.union.length]
            });
          }
        } else {
          other.add(item);
        }
      }
    } else if (state.version == LeaguePointVersion.version3) {
      List<MatchAnalyzeVsInfoEntity> analyzeVsInfoNewInfoTeamRankings =
          state.version3MatchAnalyzeVsInfoDataList;
      Map<String, List<MatchAnalyzeVsInfoEntity>> group = {};
      List<MatchAnalyzeVsInfoEntity> other = [];
      for (MatchAnalyzeVsInfoEntity item in analyzeVsInfoNewInfoTeamRankings) {
        if (item.promotionId.isEmpty == true) {
          continue;
        }
        String promotionId = item.promotionId;
        if (group[promotionId] == null) {
          group[promotionId] = [];
        }
        group[promotionId]?.add(item);
      }
      analyzeVsInfoNewInfoTeamRankings.sort((a, b) {
        int aValue = a.promotionId.isEmpty == true ? 100 : (a.positionTotal);
        int bValue = b.promotionId.isEmpty == true ? 100 : (b.positionTotal);
        return aValue - bValue;
      });
      // 颜色值
      List<Color> colors = [
        Color(0xFF4176FA),
        Color(0xFFFEAE2C),
        Color(0xFF00B42A),
        Color(0xFF7DA1FC),
        Color(0xFFFDB1B1)
      ];
      for (MatchAnalyzeVsInfoEntity item in analyzeVsInfoNewInfoTeamRankings) {
        if (item.promotionId.isNotEmpty) {
          String promotionId = item.promotionId;
          Map? findResult = state.union[promotionId];
          if (findResult == null) {
            state.union[promotionId] = ({
              "key": item.promotionId,
              "label": item.promotionCnName,
              "color": colors[state.union.length >= colors.length
                  ? (colors.length - 1)
                  : state.union.length]
            });
          }
        } else {
          other.add(item);
        }
      }
    }
  }
}

