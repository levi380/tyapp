part of 'basket_going_sport_widget.dart';

/// 帮助方法相关的扩展
extension BasketGoingSportWidgetHelper on _BasketGoingSportWidgetState {
  /// 获取队伍的比分
  /// [index] 队伍索引
  /// [isFinished] 是否已完成
  /// 返回比分排名信息
  VrSportReplayDetailScoreRanking? _teamsScore(
    int index, {
    bool isFinished = false,
  }) {
    if (replayEntity == null) return null;
    if (index >= widget.vrMatch.matchMids.length) return null;

    final mid = widget.vrMatch.matchMids[index];
    final replayDetailValue = replayEntity?.detail?[mid];

    final scoreInfos = replayDetailValue?.list ?? [];

    if (isFinished) {
      return scoreInfos.lastOrNull;
    }

    // 非当前选中视频的默认比分
    int lastScoreIndex = replayDetailValue?.curScoreIndex ?? -1;

    // 其他 item 返回上次的比分
    if (lastScoreIndex != -1 && lastScoreIndex < scoreInfos.length) {
      return scoreInfos[lastScoreIndex];
    }

    return null;
  }

  /// 获取队伍排名
  /// [oriTeamsRanking] 原始队伍排名映射
  /// [rankingInfo] 排名信息
  /// 返回更新后的队伍排名映射
  Map<String, Map<String, String?>?> _teamsRanking(
    Map<String, Map<String, String?>?> oriTeamsRanking,
    VrSportReplayDetailScoreRanking? rankingInfo,
  ) {
    if (replayEntity == null) return oriTeamsRanking;
    if (widget.vrMatch.matchMids.isEmpty) return oriTeamsRanking;

    // 更新排名展示
    if (rankingInfo != null) {
      final ranking1TeamNum = rankingInfo.ranking1;
      final ranking1Team = oriTeamsRanking[ranking1TeamNum];
      final ranking2TeamNum = rankingInfo.ranking2;
      final ranking2Team = oriTeamsRanking[ranking2TeamNum];
      final ranking3TeamNum = rankingInfo.ranking3;
      final ranking3Team = oriTeamsRanking[ranking3TeamNum];
      final ranking4TeamNum = rankingInfo.ranking4;
      final ranking4Team = oriTeamsRanking[ranking4TeamNum];
      final ranking5TeamNum = rankingInfo.ranking5;
      final ranking5Team = oriTeamsRanking[ranking5TeamNum];
      final ranking6TeamNum = rankingInfo.ranking6;
      final ranking6Team = oriTeamsRanking[ranking6TeamNum];
      return SplayTreeMap.from(
        {
          '1': ranking1Team,
          '2': ranking2Team,
          '3': ranking3Team,
          '4': ranking4Team,
          '5': ranking5Team,
          '6': ranking6Team,
        },
      );
    }

    return oriTeamsRanking;
  }

  /// 根据类型获取VR体育的CSID
  /// [type] 比赛类型：1-足球，2-篮球，3-赛马，4-赛狗，5-摩托车，6-泥地摩托车
  /// 返回对应的CSID
  int getVrSportCsid(int type) {
    switch (type) {
      case 1:
        /// 足球
        return 1001;
      case 2:
        /// 篮球
        return 1004;
      case 3:
        /// 赛马
        return 1011;
      case 4:
        /// 赛狗
        return 1002;
      case 5:
        /// 摩托车
        return 1010;
      case 6:
        /// 泥地摩托车
        return 1009;
      default:
        return 1001;
    }
  }
}

