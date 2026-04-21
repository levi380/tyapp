import 'dart:collection';
import 'dart:math';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_ball_extensions.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_replay_detail_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/extensions/vr_video_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/player/video_player_plus.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/finished_rank_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/head_sport_finsh/basketball_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/head_sport_finsh/football_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/head_sport_finsh/other_sport_finished_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/widget/ball_realtime_team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/widget/basketball_remain_time_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/head_going_sport_widget/widget/match_video_placeholder.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_dog_horse/dog_horse_rank_row.dart';
import 'package:flutter_ty_app/app/modules/vr/widgets/vr_sport_video_countdown_widget.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/vr_sport_replay_entity.dart';
import 'package:flutter_ty_app/main.dart' show isIPad;

part 'basket_going_sport_widget_ui.dart';
part 'basket_going_sport_widget_logic.dart';
part 'basket_going_sport_widget_helper.dart';

/// VR篮球头部组件，与其他游戏头部进行分开
/// 用于展示VR篮球比赛的视频播放、比分显示等功能
class BasketGoingSportWidget extends StatefulWidget {
  const BasketGoingSportWidget({
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
  });

  /// 比赛类型：1-足球，2-篮球，3-赛马，4-赛狗，5-摩托车，6-泥地摩托车
  final int type;

  /// VR比赛实体数据
  final VrMatchEntity vrMatch;

  /// 下一场比赛数据
  final VrMatchEntity? nextVrMatch;

  /// 获取虚拟回放数据的回调函数
  final Future<VrSportReplayEntity?> Function(VrMatchEntity vrMatch)?
      getVirtualReplay;

  /// 下一场比赛倒计时结束的回调
  final VoidCallback? onNextMatchCountdownEnd;

  /// 视频播放完成的回调
  final VoidCallback? onVideoPlayFinished;

  /// 获取比赛比分的回调函数
  final Function(String mids)? onGetMatchScore;

  /// 是否显示底部项目
  final bool isShowItem;

  /// 视频宽高比
  final double aspectRatio;

  @override
  State<BasketGoingSportWidget> createState() =>
      _BasketGoingSportWidgetState();
}

/// BasketGoingSportWidget的状态类
class _BasketGoingSportWidgetState extends State<BasketGoingSportWidget> {
  /// 回放实体数据
  VrSportReplayEntity? replayEntity;

  /// 视频URL的ValueNotifier
  late final ValueNotifier<String> videoUrl;

  /// 足球、篮球当前选中比赛队伍的索引
  int selTeamIndex = 0;

  /// 点击篮球视频播放页面显示时间进度的ValueNotifier
  late ValueNotifier<bool> showBasketballCountdown;

  /// 当前播放视频的进度：秒
  int videoPosition = 0;

  /// 视频是否播放完成的ValueNotifier
  late ValueNotifier<bool> videoFinished;

  /// 视频播放页回传的队友时间段的比分的ValueNotifier
  late ValueNotifier<VrSportReplayDetailScoreRanking?> scoreInfo;

  /// 用于篮球这种需要更新所有队伍比分的情况的ValueNotifier
  late ValueNotifier<Map<String, VrSportReplayDetailScoreRanking?>?>
      multiScoreInfoMap;

  /// 篮球加载定时器
  Timer? basketballLodTimer;

  @override
  void initState() {
    super.initState();
    AppLogger.debug(
        'vrMatch lod: ${widget.vrMatch.lod}, mmp: ${widget.vrMatch.mmp}, no: ${widget.vrMatch.no}');
    _initializeNotifiers();
    _checkMatchStatus();
  }

  /// 初始化所有的ValueNotifier
  void _initializeNotifiers() {
    videoUrl = ValueNotifier('');
    videoFinished = ValueNotifier(false);
    scoreInfo = ValueNotifier(null);
    multiScoreInfoMap = ValueNotifier(null);
    showBasketballCountdown = ValueNotifier(false);
  }

  /// 检查比赛状态并初始化
  void _checkMatchStatus() {
    final didMatchBegin = widget.vrMatch.didMatchBeginWith(widget.type);
    if (didMatchBegin) {
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
    }
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
    return ValueListenableBuilder(
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
                  _buildWaitingWidget(),
                  _buildVideoArea(),
                  _buildFinishedWidget(),
                  _buildBasketballCountdown(),
                ],
              ),
            ),
            if (widget.isShowItem) _buildRealtimeTeamScoreWidget(),
          ],
        );
      },
    );
  }
}
