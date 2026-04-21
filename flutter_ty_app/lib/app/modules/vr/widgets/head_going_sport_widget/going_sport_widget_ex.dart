import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/going_sport_widget.dart';
import 'dart:collection';
import 'dart:math';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_ball_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_video_extension.dart';

import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/widget/ball_realtime_team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/widget/basketball_remain_time_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_dog_horse/dog_horse_rank_row.dart';


import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/main.dart';

import 'finished_rank_widget.dart';
extension BallsUI on GoingSportWidgetState {
  Widget buildBallTeams() {
    return ValueListenableBuilder(
      valueListenable: multiScoreInfoMap,
      builder: (context, multiScoreInfoMap, child) {
        return GridView.builder(
          key: ValueKey('teams_${multiScoreInfoMap?.length}'),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: isIPad ? 179 / 25 : 179 / 50,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.w),
          itemCount: widget.vrMatch.matchTeams.length,
          itemBuilder: (BuildContext context, int index) {
            final isSelected = selTeamIndex == index;
            final teams = widget.vrMatch.matchTeams[index];
            final mid = widget.vrMatch.matchMids[index];

            // VrSportReplayDetailScoreRanking? score =
            //     (isSelected || widgets.type == 2)
            //         ? (multiScoreInfoMap?[mid])
            //         : teamsScore(
            //             index,
            //             isFinished: videoFinished.value,
            //           );
            VrSportReplayDetailScoreRanking? score = multiScoreInfoMap?[mid];
            // (isSelected || widgets.type == 2)
            //     ? (multiScoreInfoMap?[mid])
            //     : teamsScore(
            //         index,
            //         isFinished: videoFinished.value,
            //       );

            return BallRealtimeTeamScoreWidget(
              teams: teams,
              score: score,
              isSelected: isSelected,
              onItemTap: () => onTeamChanged(index),
            );
          },
        );
      },
    );
  }

  // 应该是视频播放的时候，点击显示，一段时间后自动隐藏
  buildBasketballCountdown() {
    return ValueListenableBuilder(
      valueListenable: showBasketballCountdown,
      builder: (context, show, child) {
        if (!show) return const SizedBox();

        return const BasketballRemainTimeWidget();
      },
    );
  }
}

///vr赛狗 vr赛马 vr摩托车 排名
extension DogHorseUI on GoingSportWidgetState {
  Widget buildDogHorseGoingRank() {
    final match = widget.vrMatch.matchs.firstOrNull;

    if (match == null) return const SizedBox();

    Map<String, Map<String, String?>?> oriTeamsRanking = {};
    for (int i = 0; i < match.teams.length; i++) {
      final key = '${i + 1}';
      oriTeamsRanking[key] = {
        'teamNum': key,
        'teamName': match.teams[i],
      };
    }

    return ValueListenableBuilder(
      valueListenable: scoreInfo,
      builder: (context, rankingInfo, child) {
        final newTeamsRanking = teamsRanking(
          oriTeamsRanking,
          rankingInfo,
        );

        if (videoFinished.value) {
          return FinishedRankWidget(
            match: match,
            championHps: match.championHps,
            topTwoHps: match.topTwoHps,
            topThreeHps: match.topThreeHps,
            oddEvenHps: match.oddEvenHps,
            sizeHps: match.sizeHps,
            teamRankingInfo: newTeamsRanking,
            championOls: match.championOls,
            topTwoOls: match.topTwoOls,
            topThreeOls: match.topThreeOls,
            oddEvenOls: match.oddEvenOls,
            sizeOls: match.sizeOls,
          );
        }

        return GridView.builder(
          key: ValueKey('dog_horse_${rankingInfo?.updateTime}'),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 8.w,
            childAspectRatio: isIPad ? 364 / 20 : 364 / 40,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.all(8.w),
          itemCount: newTeamsRanking.length,
          itemBuilder: (BuildContext context, int index) {
            final teamsMapKey = newTeamsRanking.keys.toList()[index];
            final teamNumNameMap = newTeamsRanking[teamsMapKey];

            final teamNum = teamNumNameMap?['teamNum'] ?? '1';
            final teamName = teamNumNameMap?['teamName'] ?? '';

            return DogHorseRankRow(
                rank: index,
                teamNum: teamNum,
                title: teamName,
                csid:match.csid
            );
          },
        );
      },
    );
  }
}

extension TeamsScoreHelper on GoingSportWidgetState {
  VrSportReplayDetailScoreRanking? teamsScore(
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

  Map<String, Map<String, String?>?> teamsRanking(
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
}

extension GoingSportWidgetStateLogic on GoingSportWidgetState {
  onTeamChanged(int index) async {
    if (!widget.vrMatch.didMatchBegin) {
      // 未开赛不支持点击
      return;
    }
    if (selTeamIndex == index) return;
    selTeamIndex = index;
    updatePlayingVideo();

    // _getReplay();
  }

  Future<void> getReplay() async {
    // AppLogger.debug('replayEntity: ${replayEntity?.toJson()}');
    final judgementNull = widget.type < 2;
    if (judgementNull) {
      if (replayEntity != null) return;
    }

    final res = await widget.getVirtualReplay?.call(widget.vrMatch);
    replayEntity = res;
    // AppLogger.debug('replayEntity: ${replayEntity?.toJson()}');

    updatePlayingVideo();
  }

  void updatePlayingVideo() {
    if (replayEntity == null) return;
    String mid;
    switch (widget.type) {
      case 1:
      case 2:
        if (widget.vrMatch.matchMids.length <= selTeamIndex) return;
        mid = widget.vrMatch.matchMids[selTeamIndex];
      default:
        if (widget.vrMatch.matchMids.isEmpty) return;
        mid = widget.vrMatch.matchMids.first;
    }
    final detail = replayEntity!.detail?[mid];
    if (detail == null) return;

    // 时间戳：毫秒
    final startTime = int.tryParse(detail.mgt) ?? 0;
    // 时间：秒
    final totalTime = double.tryParse(detail.totalTime) ?? 0;
    if (startTime == 0 || totalTime == 0) return;

    // 时间戳：毫秒
    final endTime = startTime.toDouble() + totalTime * 1000;
    final nowTime = DateTime.now().millisecondsSinceEpoch;

    // 提前 2 秒结束
    if (nowTime.toDouble() - 2 * 1000 > endTime) {
      // 已结束
      videoFinished.value = true;
      widget.onVideoPlayFinished?.call();
      return;
    }

    if (mounted) {
      videoPosition =
          ((nowTime.toDouble() - startTime.toDouble()) / 1000).round();
      AppLogger.debug('videoPosition: $videoPosition');
      videoUrl.value = detail.formattedPlayUrlWith(widget.type);
    }
  }


  void onVideoPositionChanged(
      Duration position,
      bool isFinished,
      VrSportReplayDetailScoreRanking? currntScoreInfo,
      ) {
    videoPosition = max(position.inSeconds, videoPosition);
    videoFinished.value = isFinished;
    scoreInfo.value = currntScoreInfo;
    if (isFinished) {
      widget.onVideoPlayFinished?.call();
    }
  }


  void onBasketballVideoPositionChanged(
      Duration position,
      bool isFinished,
      Map<String, VrSportReplayDetailScoreRanking?> scoreInfoMap,
      ) {
    if (position.inSeconds < videoPosition) return;
    multiScoreInfoMap.value = scoreInfoMap;
  }
}