// ignore_for_file: dead_code
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_ball_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/player/video_player_plus.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/going_sport_widget_ex.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/head_sport_finsh/basketball_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/head_sport_finsh/football_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/widget/match_video_placeholder.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/head_sport_finsh/other_sport_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_video_countdown_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';

///vr其他游戏头部
class GoingSportWidget extends StatefulWidget {
  const GoingSportWidget({
    super.key,
    required this.type,
    required this.vrMatch,
    this.getVirtualReplay,
    this.nextVrMatch,
    this.onNextMatchCountdownEnd,
    this.onVideoPlayFinished,
    this.onGetMatchScore,
    this.isShowItem = true,
    this.aspectRatio = 380 / 190,
    this.isVrDetail = false,
    this.onCount,
  });

  final int type;
  final VrMatchEntity vrMatch;
  final VrMatchEntity? nextVrMatch;
  final Future<VrSportReplayEntity?> Function(VrMatchEntity vrMatch)?
      getVirtualReplay;
  final VoidCallback? onNextMatchCountdownEnd;
  final VoidCallback? onVideoPlayFinished;
  final Function(String mids)? onGetMatchScore;
  final bool isShowItem;
  final double aspectRatio;
  final bool isVrDetail;
  final dynamic onCount;

  @override
  State<GoingSportWidget> createState() => GoingSportWidgetState();
}

class GoingSportWidgetState extends State<GoingSportWidget> {
  VrSportReplayEntity? replayEntity;

  late final ValueNotifier<String> videoUrl;

  // 足球、篮球当前选中比赛队伍
  int selTeamIndex = 0;

  // 点击篮球视频播放页面显示时间进度
  late ValueNotifier<bool> showBasketballCountdown;

  // 当前播放视频的进度：秒
  int videoPosition = 0;
  // 视频是否播放完成
  late ValueNotifier<bool> videoFinished;
  // 视频播放页回传的队友时间段的比分
  late ValueNotifier<VrSportReplayDetailScoreRanking?> scoreInfo;

  // 用于篮球这种需要更新所有队伍比分的情况
  late ValueNotifier<Map<String, VrSportReplayDetailScoreRanking?>?>
      multiScoreInfoMap;

  Timer? basketballLodTimer;

  @override
  void initState() {
    AppLogger.debug(
        'vrMatch lod: ${widget.vrMatch.lod}, mmp: ${widget.vrMatch.mmp}, no: ${widget.vrMatch.no}');
    videoUrl = ValueNotifier('');
    videoFinished = ValueNotifier(false);

    scoreInfo = ValueNotifier(null);
    multiScoreInfoMap = ValueNotifier(null);
    showBasketballCountdown = ValueNotifier(false);

    final didMatchBegin = widget.vrMatch.didMatchBegin;
    if (didMatchBegin) getReplay();

    super.initState();
  }

  @override
  void dispose() {
    videoUrl.dispose();
    videoFinished.dispose();
    scoreInfo.dispose();
    multiScoreInfoMap.dispose();
    showBasketballCountdown.dispose();
    basketballLodTimer?.cancel();
    basketballLodTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.vrSportDetail,
          arguments: {
            'vrMatch': widget.vrMatch,
            'match': widget.vrMatch.matchs.safeFirst,
            'isBalls': widget.type <= 2,
          },
        );
      },
      child: ValueListenableBuilder(
        valueListenable: videoFinished,
        builder: (context, isFinished, child) {
          return Column(
            children: [
              AspectRatio(
                aspectRatio: widget.aspectRatio,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    MatchVideoPlaceholder(type: widget.type),
                    Padding(
                      padding: widget.isVrDetail
                          ? EdgeInsets.only(top: 35.w)
                          : EdgeInsets.zero,
                      child: _buildWaitingWidget(),
                    ),
                    _buildVideoArea(),
                    Padding(
                      padding: widget.isVrDetail
                          ? EdgeInsets.only(top: 35.w)
                          : EdgeInsets.zero,
                      child: _buildFinishedWidget(),
                    ),
                    buildBasketballCountdown(),
                  ],
                ),
              ),
              if (widget.isShowItem) _buildRealtimeTeamScoreWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWaitingWidget() {
    if (widget.vrMatch.didMatchBegin) return const SizedBox();
    return VrSportVideoCountdownWidget(
      no: widget.vrMatch.no,
      mgt: widget.vrMatch.mgt,
      // mgt: widgets.vrMatch.matchs
      //         .firstWhereOrNull((element) => element.mgt.isNotEmpty)
      //         ?.mgt ??
      //     '',
      onCount: widget.onCount,
      onCountdownFinished: () {
        2.seconds.delay(() {
          if (!mounted) return;
          getReplay();
        });
      },
    );
  }

  Widget _buildVideoArea() {
    if (!videoFinished.value) {
      return ValueListenableBuilder(
        valueListenable: this.videoUrl,
        builder: (context, videoUrl, child) {
          // AppLogger.debug('_videoUrl: ${_videoUrl.value}');
          final teams = selTeamIndex >= 0
              ? widget.vrMatch.matchTeams[selTeamIndex]
              : <String>[];

          final mid = widget.vrMatch.matchMids[selTeamIndex];
          final replayDetailValue = replayEntity?.detail?[mid];

          return videoUrl.isNotEmpty
              ? SizedBox.expand(
                  child: VrVideoPlayerPlus.network(
                    videoUrl,
                    key: ValueKey('${videoUrl}_$selTeamIndex'),
                    autoPlay: true,
                    seekToSecond: videoPosition,
                    teams: teams,
                    showScoreInfo: widget.type <= 2,
                    curSeconds: widget.type == 2 ? 'LIVE' : '',
                    replayDetailValue: replayDetailValue,
                    replayEntity: replayEntity,
                    onVideoPositionChanged: onVideoPositionChanged,
                    onBasketballVideoPositionChanged:
                        onBasketballVideoPositionChanged,
                  ),
                )
              : const SizedBox();
        },
      );
    }
    return const SizedBox();
  }

  ///头部结束页面
  Widget _buildFinishedWidget() {
    // vr赛狗(1002)，vr赛马(1011)，vr摩托车(1010)，vr泥地摩托车(1009)
    return ValueListenableBuilder(
      valueListenable: videoFinished,
      builder: (context, finished, child) {
        if (finished) {
          final score = teamsScore(selTeamIndex, isFinished: true);
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

  Widget _buildRealtimeTeamScoreWidget() {
    switch (widget.type) {
      case 1:
      case 2:
        return buildBallTeams();
    }
    return buildDogHorseGoingRank();
  }

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
    /// 赛狗
      case 4:
        return 1002;
    /// 摩托车
      case 5:
        return 1010;
    /// 泥地摩托车
      case 6:
        return 1009;
      default:
        return 1001;
    }
  }
}




