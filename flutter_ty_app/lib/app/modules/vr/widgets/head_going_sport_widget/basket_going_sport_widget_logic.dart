part of 'basket_going_sport_widget.dart';

/// 逻辑处理相关的扩展方法
extension BasketGoingSportWidgetLogic on _BasketGoingSportWidgetState {
  /// 队伍切换处理
  /// [index] 选中的队伍索引
  Future<void> _onTeamChanged(int index) async {
    // 不支持点击
    return;
    // if (selTeamIndex == index) return;
    // selTeamIndex = index;
    // _updatePlayingVideo();
    //
    // _getReplay();
  }

  /// 获取回放数据
  Future<void> _getReplay() async {
    if (!mounted) return;

    final res = await widget.getVirtualReplay?.call(widget.vrMatch);
    replayEntity = res;

    // debugPrint('replayEntity lod: ${replayEntity?.lod}');
    // debugPrint('replayEntity lod vrMatch: ${widget.vrMatch.lod}');

    // ) && widgets.vrMatch.lod != 'INGAME'
    if (replayEntity == null || replayEntity?.lod == 'PREGAME') {
      if (widget.vrMatch.lod != 'INGAME') {
        showBasketballCountdown.value = true;
      } else {
        showBasketballCountdown.value = false;
      }
      await _getReplay();
      // return;
    }

    if (replayEntity?.lod == 'INGAME') {
      final matchs = replayEntity?.matchs ?? [];
      Map<String, VrSportReplayDetailScoreRanking> scoreInfoMap = {};
      for (var match in matchs) {
        scoreInfoMap[match.mid] = VrSportReplayDetailScoreRanking.fromJson({
          'away': match.awayScore,
          'home': match.homeScore,
        });
      }

      AppLogger.debug('replayEntity scoreInfoMap: $scoreInfoMap');

      _onBasketballVideoPositionChanged(
        Duration.zero,
        false,
        scoreInfoMap,
      );
    }

    if (replayEntity?.lod == 'INGAME' && widget.vrMatch.lod != 'INGAME') {
      showBasketballCountdown.value = false;
      widget.onNextMatchCountdownEnd?.call();
      // // 下一场比赛数据需要过一段时间才会更新
      // 5.seconds.delay(() {
      //   if (mounted) {
      //     widgets.onNextMatchCountdownEnd?.call();
      //   }
      // });
      // return;
    }

    _updatePlayingVideo();
  }

  /// 更新正在播放的视频
  void _updatePlayingVideo() {
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
    final nowTime = DateTime.now().millisecondsSinceEpoch;

    // 提前 2 秒结束
    if (detail.isFinish) {
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

  /// 视频播放位置变化回调
  /// [position] 当前播放位置
  /// [isFinished] 是否播放完成
  /// [scoreInfo] 比分信息
  void _onVideoPositionChanged(
    Duration position,
    bool isFinished,
    VrSportReplayDetailScoreRanking? scoreInfo,
  ) {
    videoPosition = max(position.inSeconds, videoPosition);
    showBasketballCountdown.value = false;
    if (videoPosition == 20) {
      // 请求一轮数据
      widget.onNextMatchCountdownEnd?.call();
    }
    videoFinished.value = isFinished;
    this.scoreInfo.value = scoreInfo;
    if (isFinished) {
      widget.onVideoPlayFinished?.call();
    }
  }

  /// 篮球视频播放位置变化回调
  /// [position] 当前播放位置
  /// [isFinished] 是否播放完成
  /// [scoreInfoMap] 所有队伍的比分信息映射
  void _onBasketballVideoPositionChanged(
    Duration position,
    bool isFinished,
    Map<String, VrSportReplayDetailScoreRanking?> scoreInfoMap,
  ) {
    try {
      multiScoreInfoMap.value = scoreInfoMap;
    } catch (e) {
      AppLogger.debug('update multiScoreInfoMap error: $e');
    }
  }
}

