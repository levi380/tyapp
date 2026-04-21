part of 'basket_going_sport_widget.dart';

/// UI构建相关的扩展方法
extension BasketGoingSportWidgetUI on _BasketGoingSportWidgetState {
  /// 构建等待倒计时组件
  Widget _buildWaitingWidget() {
    return VrSportVideoCountdownWidget(
      no: widget.vrMatch.no,
      mgt: widget.vrMatch.mgt,
      onCountdownFinished: () {

        if (!showBasketballCountdown.value) {
          // 下一场比赛数据需要过一段时间才会更新
          20.seconds.delay(() {
            if (widget.vrMatch.inGame) return;
            if (mounted) {
              widget.onNextMatchCountdownEnd?.call();
            }
          });
        }
        _getReplay();
      },
    );
  }

  /// 构建视频播放区域
  Widget _buildVideoArea() {
    if (!videoFinished.value) {
      return ValueListenableBuilder(
        valueListenable: videoUrl,
        builder: (context, videoUrlValue, child) {
          final teams = selTeamIndex >= 0
              ? widget.vrMatch.matchTeams[selTeamIndex]
              : <String>[];

          final mid = widget.vrMatch.matchMids[selTeamIndex];
          final replayDetailValue = replayEntity?.detail?[mid];

          return videoUrlValue.isNotEmpty
              ? SizedBox.expand(
                  child: VrVideoPlayerPlus.network(
                    videoUrlValue,
                    key: ValueKey('${videoUrlValue}_$selTeamIndex'),
                    isVrBaseKetball: true,
                    autoPlay: true,
                    seekToSecond: videoPosition,
                    teams: teams,
                    showScoreInfo: widget.type <= 2,
                    curSeconds: widget.type == 2 ? 'LIVE' : '',
                    replayDetailValue: replayDetailValue,
                    replayEntity: replayEntity,
                    onVideoPositionChanged: _onVideoPositionChanged,
                    onBasketballVideoPositionChanged:
                        _onBasketballVideoPositionChanged,
                  ),
                )
              : const SizedBox();
        },
      );
    }
    return const SizedBox();
  }

  /// 构建头部结束页面
  Widget _buildFinishedWidget() {
    return ValueListenableBuilder(
      valueListenable: videoFinished,
      builder: (context, finished, child) {
        if (finished) {
          final score = _teamsScore(selTeamIndex, isFinished: true);
          final teams = widget.vrMatch.matchTeams[selTeamIndex];
          switch (widget.type) {
            case 1:
              return FootballFinishedWidget(
                teams: teams,
                mhlu: widget.vrMatch.matchMhlus[selTeamIndex],
                malu: widget.vrMatch.matchMalus[selTeamIndex],
                score: score,
                nextVrMatch: widget.nextVrMatch,
                onNextMatchCountdownEnd: widget.onNextMatchCountdownEnd,
              );
            case 2:
              return BasketballFinishedWidget(
                teams: teams,
                mhlu: widget.vrMatch.matchMhlus[selTeamIndex],
                malu: widget.vrMatch.matchMalus[selTeamIndex],
                score: score,
                onNextMatchCountdownEnd: widget.onNextMatchCountdownEnd,
              );
          }
          return OtherSportFinishedWidget(
            teams: teams,
            score: score,
            csid: getVrSportCsid(widget.type),
            nextVrMatch: widget.nextVrMatch,
            onNextMatchCountdownEnd: widget.onNextMatchCountdownEnd,
            // 赛狗多等待一段时间
            callbackSeconds: widget.type == 4 ? 20 : 10,
          );
        }
        return const SizedBox();
      },
    );
  }

  /// 构建实时队伍比分组件
  Widget _buildRealtimeTeamScoreWidget() {
    switch (widget.type) {
      case 1:
      case 2:
        return _buildBallTeams();
    }
    return _buildDogHorseGoingRank();
  }

  /// 构建球类（足球、篮球）队伍列表
  Widget _buildBallTeams() {
    return ValueListenableBuilder(
      valueListenable: multiScoreInfoMap,
      builder: (context, multiScoreInfoMapValue, child) {
        return GridView.builder(
          key: ValueKey('teams_${multiScoreInfoMapValue?.length}'),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: isIPad ? 179 / 25 : 179 / 50,
          ),
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: widget.vrMatch.matchTeams.length,
          itemBuilder: (BuildContext context, int index) {
            final isSelected = selTeamIndex == index;
            final teams = widget.vrMatch.matchTeams[index];
            final mid = widget.vrMatch.matchMids[index];

            VrSportReplayDetailScoreRanking? score =
                (isSelected || widget.type == 2)
                    ? (multiScoreInfoMapValue?[mid])
                    : _teamsScore(
                        index,
                        isFinished: videoFinished.value,
                      );

            return BallRealtimeTeamScoreWidget(
              teams: teams,
              score: score,
              isSelected: isSelected,
              onItemTap: () => _onTeamChanged(index),
            );
          },
        );
      },
    );
  }

  /// 构建篮球倒计时组件
  /// 应该是视频播放的时候，点击显示，一段时间后自动隐藏
  Widget _buildBasketballCountdown() {
    return ValueListenableBuilder(
      valueListenable: showBasketballCountdown,
      builder: (context, show, child) {
        if (!show) return const SizedBox();

        return const BasketballRemainTimeWidget();
      },
    );
  }

  /// 构建赛狗赛马进行中的排名列表
  Widget _buildDogHorseGoingRank() {
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
        final newTeamsRanking = _teamsRanking(
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
            childAspectRatio: 364 / 40,
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
              csid: match.csid,
            );
          },
        );
      },
    );
  }
}

