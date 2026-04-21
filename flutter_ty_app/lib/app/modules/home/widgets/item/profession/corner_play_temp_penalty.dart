import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_sport_ext.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/score_list.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secodary_build_body_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secondary_game_play_header.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/team_score_widget_penalty.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


import '../../../../../routes/route_manager.dart';
import '../../../../../utils/hintLanguage.dart';
import '../../../../../utils/match_util.dart';
import '../../../../../utils/route_check_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../utils/utils.dart';
import '../../../../../utils/widget_utils.dart';
import '../../../controllers/collection_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/secondary_expand_controller.dart';
import '../../../models/play_info.dart';
import '../../pin_widget.dart';
import 'bet_group_widget.dart';
import 'secodary/flag_widget.dart';

/// 主玩法，角球玩法，15分钟玩法
class CornerPlayTempPenalty extends StatefulWidget {
  const CornerPlayTempPenalty(
      {super.key,
        required this.match,
        required this.hps,
        required this.plays,
        this.isMainPlay = true,
        this.playId = ''});

  final MatchEntity match;
  final List<MatchHps> hps;
  final bool isMainPlay;
  final String playId;
  final List<PlayInfo> plays;

  @override
  State<CornerPlayTempPenalty> createState() => _CornerPlayTempPenaltyState();
}

class _CornerPlayTempPenaltyState extends State<CornerPlayTempPenalty>
    with SingleTickerProviderStateMixin {
  // 计算15分钟 比分参数
  String hSpecial = "0";
  String minutesTitle = '';
  String language = '';
  double threeBoxHeight = 110;
  int moreleng = 5;
  late final ScrollController scrollController = ScrollController();
  double x = 0; //点击位置
  double y = 0; //点击位置

  // final GlobalKey _menuItemKey = GlobalKey(); //获取计算弹框位置
  // final GlobalKey _menuItemKey2 = GlobalKey(); //获取计算弹框位置
  PlayInfo _playInfo = PlayInfo(
    title: '',
    playId: '',
    pids: '',
  );

  bool isMoreSelect = false; //更多组合
  ///展开还是收起
  bool isSelect = false;
  String moreSelectTitle = "";

  StreamSubscription? _goalSubscription;
  StreamSubscription? _generalSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        ///更新15分钟提示
        if (!widget.isMainPlay && widget.playId == playIdConfig.hps15Minutes) {
          uptitle(SecondaryController.index);
        }
        language = StringKV.language.get() ?? "CN";
      }
    });

    _goalSubscription = WidgetUtils.instance().ShowGoalStream.listen((event) {
      if (mounted){
        // debugPrint("收到C115通知_进球更新动画");
        ShowGoalAnimation(event, widget.match.mid);
      }
    });
    _generalSubscription = WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        if (!widget.isMainPlay && widget.playId == playIdConfig.hps15Minutes) {
          uptitle(SecondaryController.index);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _goalSubscription?.cancel();
    _generalSubscription?.cancel();
    super.dispose();
  }

  // 是否显示伤停补时动画
  bool isShowMststi = false;

  // 是否显示主队红牌动画
  bool isShowHomeRed = false;

  // 是否显示客队红牌动画
  bool isShowAwayRed = false;

  // 是否显示主队进球动画
  bool isShowHomeGoal = false;

  // 是否显示客队进球动画
  bool isShowAwayGoal = false;

  // 是否显示主队var动画
  bool showHomeVar = false;

  // 是否显示客队var动画
  bool showWayVar = false;
  String hit = "";

  @override
  void didUpdateWidget(covariant CornerPlayTempPenalty oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.match.mid == oldWidget.match.mid &&
        [1].contains(widget.match.csid.toInt())) {
      if (!widget.isMainPlay && widget.playId == playIdConfig.hps15Minutes) {
        int difference = (widget.match.mst.toInt() / 60).floor();
        int residue = (difference / 15).floor();
        int olddifference = (oldWidget.match.mst.toInt() / 60).floor();
        int oldresidue = (olddifference / 15).floor();
        if (residue != oldresidue) {
          uptitle(SecondaryController.index);
        }
      }

      //显示红牌动画
      ShowRedAnimation(
        oldWidget.match,
        widget.match,
      );
      //显示提示动画
      ShowHitAnimation(oldWidget.match, widget.match);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 15分钟玩法 1007  罚牌 1003  点球大战
    bool hasRule = widget.playId == playIdConfig.hps15Minutes ||
        widget.playId == playIdConfig.hpsPunish ||
        widget.playId == playIdConfig.hpsPenalty;
    return Stack(
      children: [
        Column(
          children: [
            ///  item分割线
            Divider(
              indent: 8.w,
              endIndent: 8.w,
              height: 0.4.w,
              color: context.isDarkMode
                  ? Colors.white.withAlpha(10)
                  : const Color(0xffE4E6ED),
            ).paddingOnly(
              bottom: 2.w,
            ),

            /// item顶部title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: _buildHeader(context, widget.match),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 125.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //主队队伍名称 分数 进球动画等
                        TeamScoreWidgetPenalty(
                            hint: hit,
                            isShowGoal: isShowHomeGoal,
                            isShowRed: isShowHomeRed,
                            isShowMststi: isShowMststi,
                            isMainPlay: widget.isMainPlay,
                            matchEntity: widget.match,
                            index: 0,
                            playId: widget.playId,
                            hSpecial: hSpecial),
                        2.verticalSpaceFromWidth,
                        //客队队伍名称 分数 进球动画等
                        TeamScoreWidgetPenalty(
                            hint: hit,
                            isShowGoal: isShowAwayGoal,
                            isShowRed: isShowAwayRed,
                            isShowMststi: isShowMststi,
                            isMainPlay: widget.isMainPlay,
                            matchEntity: widget.match,
                            index: 1,
                            playId: widget.playId,
                            hSpecial: hSpecial),

                        const Spacer(),

                        Visibility(
                          visible: hasRule,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///悬浮弹框
                              WidgetUtils.instance().showToolTip(
                                  context.isDarkMode
                                      ? const Color(0xff2E3846)
                                      : Colors.white,
                                  rullGroud(context, context.isDarkMode),
                                  ImageView(
                                    'assets/images/icon/rull.svg',
                                    width: 18.w,
                                    height: 18.w,
                                  ),
                                  arrowColor: context.isDarkMode
                                      ? const Color(0xff2E3846)
                                      : Colors.white),
                              5.horizontalSpace,
                              Expanded(
                                  child: Text(
                                    minutesTitle != "" ? minutesTitle : ruleText(),
                                    style: TextStyle(
                                      color: Color(0xFF7981A4),
                                      fontSize: 11.sp,
                                    ),
                                  ))
                            ],
                          ),
                        ),

                        ///时段和说明
                        const Spacer(),
                        // if (widget.isMainPlay)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => RouteManager.goMatchDetail(
                              mid: widget.match.mid, csid: widget.match.csid),

                          ///状态图标
                          child: FlagWidget(
                            type: 0,
                            matchEntity: widget.match,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: SizedBox(
                    width: 8.w,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BetGroupWidget(
                        matchEntity: widget.match,
                        hps: widget.hps,
                        playId: widget.playId,
                        isMainPlay: widget.isMainPlay,
                      ),
                      // MultiScoreWidget(match),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // 替换为拆分后的组件
                  child: SecondaryGamePlayHeader(
                    match: widget.match,
                    plays: widget.plays,
                    currentPlayInfo: _playInfo,
                    isSelect: isSelect,
                    isMoreSelect: isMoreSelect,
                    onPlaySelected: _handlePlaySelection,
                  ),
                ),
              ],
            ),
            buildBodyWidget(
              match: widget.match,
              playInfo: _playInfo,
              isMoreSelect: isMoreSelect,
              isSelect: isSelect,
              mid: widget.match.mid,
            ),
          ],
        ),

        Positioned(
          right: 8.w,
          bottom: 5.w,
          child: Row(
            children: [
              if (widget.match.mfo != null &&
                  !SportData.getSportsMS(
                      [SportData.sportMs_1, SportData.sportMs_10])!
                      .contains(widget.match.ms) &&
                  SportData.getSportsCsid([
                    SportData.sportCsid_5,
                    SportData.sportCsid_7,
                    SportData.sportCsid_8,
                    SportData.sportCsid_9,
                    SportData.sportCsid_10
                  ])!
                      .contains(int.parse(widget.match.csid)) &&
                  widget.match.ms == 110)
                Text(
                  widget.match.mfo,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
            ],
          ),
        ),

        /// 展示比分区域
        Positioned(
          bottom:
          int.parse(widget.match.csid) == SportData.sportCsid_37 ? -4.h : 0,
          right: 8.w,
          child: ScoreList(
            match: widget.match,
          ),
        ),
      ],
    );
  }

  String title = '';
  final List titleList = [
    {'value': 0, 'title': LocaleKeys.football_playing_way_hps15_title_0.tr},
    {'value': 1, 'title': LocaleKeys.football_playing_way_hps15_title_1.tr},
    {'value': 2, 'title': LocaleKeys.football_playing_way_hps15_title_2.tr},
    {'value': 3, 'title': LocaleKeys.football_playing_way_hps15_title_3.tr},
    {'value': 4, 'title': LocaleKeys.football_playing_way_hps15_title_4.tr},
    {'value': 5, 'title': LocaleKeys.football_playing_way_hps15_title_5.tr},
  ];

  String ruleText() {
    /// 15分钟玩法 1007  罚牌 1003
    if (widget.playId == playIdConfig.hps15Minutes) {
      if (widget.match.ms != SportData.sportMs_1 ||
          int.parse(widget.match.mst) == 0) {
        title = LocaleKeys.football_playing_way_hps15_title_0.tr;
      } else {
        bool hasHps = widget.hps.length > 0;
        int index = (SecondaryController.index == 1 &&
            (widget.hps.length / 3).ceil() >= 2)
            ? 1
            : 0;

        if (hasHps) {
          hSpecial = NumUtil.subtract(num.parse(widget.hps[index].hSpecial), 1)
              .toInt()
              .obs
              .string;
        } else {
          hSpecial = "0";
        }
        if (num.parse(hSpecial).toInt() == 2) {
          hSpecial = "3";
        }
        if (num.parse(hSpecial).toInt() > 4) {
          hSpecial = "4"; //容错 下标不能大于4 最大特5
        }

        if (num.parse(hSpecial).toInt() < 0) {
          hSpecial = "0";
        }

        List result = titleList
            .where((element) => element['value'] == num.parse(hSpecial))
            .toList();
        title = result.first['title'];
      }
    } else if (widget.playId == playIdConfig.hpsPunish) {
      title = LocaleKeys.football_playing_way_penalty_cards.tr;
    } else if (widget.playId == playIdConfig.hpsPenalty) {
      title = LocaleKeys.football_playing_way_penalty_shootout.tr;
    } else if (widget.playId == playIdConfig.hpsOvertime) {
      title = LocaleKeys.football_playing_way_overtime.tr;
    }

    return title;
  }

  ///规则弹框
  Widget rullGroud(context, bool isDarkMode) {
    /// 15分钟玩法 1007  罚牌 1003
if (widget.playId == playIdConfig.hpsPunish ||
        widget.playId == playIdConfig.hpsPenalty) {
      return SizedBox(
        width: 200,
        child: Text(
          widget.playId == playIdConfig.hpsPunish
              ? LocaleKeys.play_way_info_5.tr
              : widget.playId == playIdConfig.hpsPenalty
              ? LocaleKeys.play_way_info_2.tr
              : "",
          maxLines: 4,
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withValues(alpha:0.8999999761581421)
                : const Color(0xff949AB6),
            fontSize: 10.sp,
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 200,
        height: 50,
      );
    }
  }

  /*
  * 更新提示
  * */
  uptitle(int event) {
    if ((widget.hps.length / 3).ceil() >= 2) {
      if (event == 1) {
        hSpecial = widget.hps.length > 0
            ? NumUtil.subtract(num.parse(widget.hps[1].hSpecial), 1)
            .toInt()
            .obs
            .string
            : "0";
      } else {
        hSpecial = widget.hps.length > 0
            ? NumUtil.subtract(num.parse(widget.hps[0].hSpecial), 1)
            .toInt()
            .obs
            .string
            : "0";
      }
    } else {
      hSpecial = widget.hps.length > 0
          ? NumUtil.subtract(num.parse(widget.hps[0].hSpecial), 1)
          .toInt()
          .obs
          .string
          : "0";
    }
    if (num.parse(hSpecial).toInt() == 2) {
      hSpecial = "3";
    }
    if (num.parse(hSpecial).toInt() > 4) {
      hSpecial = "4"; //容错 下标不能大于4 最大特5
    }

    if (num.parse(hSpecial).toInt() < 0) {
      hSpecial = "0";
    }

  }


  Map<String, dynamic> s11Score(MatchEntity match) {
    Map<String, dynamic> score = {
      'home': 0,
      'away': 0,
    };

    for (String item in match.msc) {
      if (item.split("|")[0] == "S11") {
        List<String> scoreValues = item.split("|")[1].split(":");
        score = {
          'home': scoreValues.isNotEmpty ? scoreValues[0].toInt() : 0,
          'away': scoreValues.length > 1 ? scoreValues[1].toInt() : 0,
        };
        break; // 只取第一个符合条件的比分
      }
    }

    return score;
  }

  // 重置
  resetEvent() {
    isShowHomeGoal = false;
    isShowAwayGoal = false;
    isShowHomeRed = false;
    isShowAwayRed = false;
    isShowMststi = false;
  }

  // 比分和红牌数值变化时设置时间
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

  /*
    * 足球比分变化
    *  // 是否显示主队进球动画
     bool isShowHomeGoal = false;
     // 是否显示客队进球动画
     bool isShowAwayGoal = false; */
  ShowGoalAnimation(Map<String, dynamic> wsObj, String oldmid) {
    String eventTime = wsObj["eventTime"];
    String mid = wsObj["mid"];
    String homeAway = wsObj["homeAway"];
    // 主客队比分数值变化，则更新对应时间
    if (eventTime.isNotEmpty &&
        mid.isNotEmpty &&
        homeAway.isNotEmpty &&
        oldmid == mid) {
      // 主队
      if (DateTime.now().millisecondsSinceEpoch <
          NumUtil.add(eventTime.toNum(), 20000).toInt()) {
        resetEvent();
        if (homeAway == "home") {
          isShowHomeGoal = true;
        } else {
          isShowAwayGoal = true;
        }
        5.seconds.delay(() {
          if (mounted) {
            setState(() {
              if (homeAway == "home") {
                isShowHomeGoal = false;
              } else {
                isShowAwayGoal = false;
              }
            });
          }
        });
      } else {
        isShowHomeGoal = false;
        // 客队
        isShowAwayGoal = false;
      }
    }
  }

  /*
    * 红牌动画
    * // 是否显示主队红牌动画
     bool isShowHomeRed = false;
      是否显示客队红牌动画
     bool isShowAwayRed = false;
    * */
  ShowRedAnimation(
      MatchEntity oldmatch,
      MatchEntity match,
      ) {
    if (match.mid == oldmatch.mid &&
        int.parse(match.csid) == SportData.sportCsid_1) {
      // 红牌
      Map<String, dynamic> newS11Score = s11Score(match);
      Map<String, dynamic> oldS11Score = s11Score(oldmatch);
      if (newS11Score["home"] != oldS11Score['home'] ||
          newS11Score["away"] != oldS11Score['away']) {
        // 主客队比分数值变化，则更新对应时间
        if (newS11Score["home"] > 0 || newS11Score["away"] > 0) {
          scoreTime["S11"] = DateTime.now().millisecondsSinceEpoch;
        }
        // 主队
        if (newS11Score["home"] > 0 &&
            newS11Score["home"] >= newS11Score['away']) {
          isShowHomeRed = !isShowHomeGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowHomeRed = false;
              });
            }
          });
        } else {
          isShowHomeRed = false;
        }
        // 客队
        if (newS11Score["away"] > 0 &&
            newS11Score["away"] >= newS11Score['home']) {
          isShowAwayRed = !isShowAwayGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowAwayRed = false;
              });
            }
          });
        } else {
          isShowAwayRed = false;
        }
      }
    }
  }

  ShowHitAnimation(MatchEntity oldmatch, MatchEntity match) {
    ///显示伤停补时动画
    if (oldmatch.mid == match.mid &&
        ObjectUtil.isNotEmpty(match.cmec) &&
        match.cmec != oldmatch.cmec) {
      hit = "";
      for (var e in ConfigController.to.EventInfoList) {
        if (match.cmec == e.nameCode) {
          if (mounted) {
            setState(() {
              hit = HintLanguage.gethint(language, e);
            });
          }
          break; // 只取第一个符合条件的比分
        }
      }
      // 主队
/*          setState(() {
        hit = match.cmec ;
      });*/
      if (ObjectUtil.isNotEmpty(hit)) {
        isShowMststi = false;
        scoreTime["S1"] = DateTime.now().millisecondsSinceEpoch;
        isShowMststi = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
        8.seconds.delay(() {
          if (mounted) {
            setState(() {
              hit = "";
              isShowMststi = false;
            });
          }
        });
      } else {
        hit = "";
        isShowMststi = false;
      }
    }
  }

  Widget _buildHeader(BuildContext context, MatchEntity matchEntity) {
    bool showCountingDown = MatchUtil.showCountingDown(matchEntity);
    return Row(children: [
      if (!TyHomeController.to.homeState.menu.isMatchBet)
        Obx(
              () {
            ///收藏数据开关
            if (ConfigController.to.accessConfig.value.collectSwitch) {
              return GetBuilder<CollectionController>(builder: (logic) {
                bool isFav =
                    (logic.isCollection(matchEntity) || matchEntity.mf) &&
                        RouteCheckUtil.checkIsLogin();
                return InkWell(
                  onTap: () {
                    logic.addOrCancelMatch(matchEntity);
                  },
                  child: ImageView(
                    isFav
                        ? 'assets/images/home/ico_fav_nor_sel.svg'
                        : context.isDarkMode
                        ? 'assets/images/home/ico_fav_nor.png'
                        : 'assets/images/home/ico_fav_nor_light.png',
                    width: 16.w,
                    height: 16.w,
                  ).marginOnly(right: 4.w),
                );

              });
            } else {
              return 0.verticalSpaceFromWidth;
            }
          },
        ),
      Row(
        children: [
          // 1 开赛   110 即将开赛
          //  ms = 1 110 才匹配（已开赛的）其他直接显示时间。
          //  <!--开赛日期 ms != 110 (不为即将开赛)  subMenuType = 13网球(进行中不显示，赛前需要显示)-->
          ///  kyapp 没有显示即将开始 倒计时 这里不需要判断倒计时
          /*       if (matchEntity.ms != 110 &&
                    !showStartCountingDown &&
                    !showCountingDown)*/
          if (!ObjectUtil.isEmptyString(matchEntity.mcid) &&
              TyHomeController.to.isJinZu())
            Text(
              matchEntity.mcid,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp.scale,
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.30000001192092896)
                    : const Color(0xffAFB3C8),
              ),
            ).marginOnly(right: 4.w),

          if (matchEntity.ms != 110 && !showCountingDown)
            Row(
              children: [
                ///列表时区
                Text(
                  DateUtil.formatDateMs(
                    // int.parse(matchEntity.mgt) ?? 0 ,
                      TimeZoneUtils.convertTimeToTimestamp(matchEntity.mgt,
                          isMilliseconds: true,
                          returnMilliseconds: true) ??
                          0,
                      format: isZh()
                          ? LocaleKeys.time11.tr
                          : LocaleKeys.time4.tr,
                      isUtc: true) +
                      "(" +
                      TimeZoneUtils.getTimeZoneString() +
                      ")",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),

          // <!-- 赛事回合数mfo match.ms != 1(不为开赛)-->
          if ((matchEntity.mfo != null &&
              SportData.getSportsMS(
                  [SportData.sportMs_1, SportData.sportMs_110])!
                  .contains(matchEntity.ms) &&
              SportData.getSportsCsid([
                SportData.sportCsid_1,
                SportData.sportCsid_5,
                SportData.sportCsid_7,
                SportData.sportCsid_8,
                SportData.sportCsid_9,
                SportData.sportCsid_10
              ])!
                  .contains(matchEntity.csid.toInt())) ||
              (SportData.getSportsCsid([SportData.sportCsid_37])!
                  .contains(int.parse(matchEntity.csid)) &&
                  matchEntity.ms == 110))
            Row(
              children: [
                Text(
                  matchEntity.mfo,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp.scale,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha:0.30000001192092896)
                        : const Color(0xffAFB3C8),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),

          ///  即将开赛 ms = 110  显示即将开赛
          // if (matchEntity.ms == 110)
          Text(
            'ms_110'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp.scale,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.30000001192092896)
                  : const Color(0xffAFB3C8),
            ),
          ).marginOnly(right: 4.w),

        ],
      ),

      PinWidget(
        matchEntity: matchEntity,
        isLeague: false,
        isDjInCommon: MatchUtil.isEsport(matchEntity),
      ),

      const Spacer(),
      Obx(() {
        return Text(
          ConfigController.to.accessConfig.value.handicapNum
              ? '${matchEntity.mc}+'
              : LocaleKeys.footer_menu_more.tr,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10.sp.scale,
            fontFamily: 'PingFang SC',
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:0.30000001192092896)
                : const Color(0xffAFB3C8),
          ),
        );
      }),

      ImageView(
        context.isDarkMode
            ? 'assets/images/league/ico_arrowright_nor_darkmode.png'
            : 'assets/images/league/ico_arrowright_nor.png',
        width: 12.w,
        height: 12.w,
      ),
    ]);
  }

  /// 集中处理Header组件传回的点击逻辑
  void _handlePlaySelection(PlayInfo info, bool selected, bool moreSelected) {
    final match = widget.match;

    setState(() {
      _playInfo = info;
      isSelect = selected;
      isMoreSelect = moreSelected;

      if (moreSelected) {
        moreSelectTitle = info.title;
        // 如果是更多里的，强制关闭常规选中 (虽然逻辑上 selected 参数已经传了false进来)
        // if (isSelect) { isSelect = false; } 逻辑已合并到参数
      }

      // 构造保存数据
      Map<String, dynamic> map = {
        "playInfo": _playInfo,
        "isSelect": isMoreSelect ? 2 : (isSelect ? 1 : 0),
        "mid": isSelect || isMoreSelect ? match.mid : "", // 取消选中时mid清空逻辑
        "tag": isSelect || isMoreSelect ? _playInfo.playId : '',
      };

      Map savedMap = SecondaryController.map;
      savedMap[match.mid] = map;
    });

    if (selected || moreSelected) {
      TyHomeController.to.getMatchBaseInfo(match, _playInfo);
      TyHomeController.to.setSecondaryName(info.title, match.mid);
    }
  }
}
