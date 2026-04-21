import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_sport_ext.dart';
import 'package:flutter_ty_app/app/modules/home/logic/other_player_name_to_playid.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/score_list.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secodary_build_body_widget.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/secodary/secondary_game_play_header.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/team_score_widget_overtime.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../routes/route_manager.dart';
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
import 'corner_play_anim_mixin.dart';
import 'corner_play_rules_util.dart';
import 'secodary/flag_widget.dart';

/// 主玩法，角球玩法，15分钟玩法
class CornerPlayTempOvertime extends StatefulWidget {
  const CornerPlayTempOvertime(
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
  State<CornerPlayTempOvertime> createState() => _CornerPlayTempOverTimeState();
}

class _CornerPlayTempOverTimeState extends State<CornerPlayTempOvertime>
    with SingleTickerProviderStateMixin, CornerPlayAnimMixin {
  // 计算15分钟 比分参数
  String hSpecial = "0";
  String minutesTitle = '';
  String language = '';
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
        _updateTitles();
        language = StringKV.language.get() ?? "CN";
      }
    });

    _goalSubscription = WidgetUtils.instance().ShowGoalStream.listen((event) {
      if (mounted){
        handleGoalAnimation(event, widget.match.mid);
      }
    });
    _generalSubscription = WidgetUtils.instance().stream.listen((event) {
      if (mounted) {
        _updateTitles();
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

  @override
  void didUpdateWidget(covariant CornerPlayTempOvertime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.match.mid == oldWidget.match.mid &&
        [1].contains(widget.match.csid.toInt()) ) {
      if (!widget.isMainPlay && widget.playId == playIdConfig.hps15Minutes) {
        int difference = (widget.match.mst.toInt() / 60).floor();
        int residue = (difference / 15).floor();
        int olddifference = (oldWidget.match.mst.toInt() / 60).floor();
        int oldresidue = (olddifference / 15).floor();
        if (residue != oldresidue) {
          _update15MinTitle(SecondaryController.index);
        }
      }
      // 使用 Mixin 处理动画
      handleRedAnimation(oldWidget.match, widget.match);
      handleHitAnimation(oldWidget.match, widget.match, language);
    }
  }

  void _updateTitles() {
    if (!widget.isMainPlay) {
      if (widget.playId == playIdConfig.hps15Minutes) {
        _update15MinTitle(SecondaryController.index);
      } else if (widget.playId == playIdConfig.hps6Minutes) {
        _update6MinTitle(SecondaryController.index);
      }
    }
  }

  /// 更新15分钟标题状态
  void _update15MinTitle(int eventIndex) {
    if (mounted) {
      setState(() {
        hSpecial = CornerPlayRulesUtil.calculate15MinHSpecial(
            widget.hps, eventIndex);
        minutesTitle = CornerPlayRulesUtil.getPeriodTitle(
            widget.playId, hSpecial);
      });
    }
  }

  /// 更新6分钟标题状态
  void _update6MinTitle(int eventIndex) {
    if (mounted) {
      setState(() {
        hSpecial = CornerPlayRulesUtil.calculate6MinHSpecial(
            widget.hps, eventIndex);
        minutesTitle = CornerPlayRulesUtil.getPeriodTitle(
            widget.playId, hSpecial);
      });
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
                        TeamScoreWidgetOvertime(
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
                        TeamScoreWidgetOvertime(
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
                                  CornerPlayRulesUtil.buildRulePopup(context, widget.playId, context.isDarkMode),
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
                                    minutesTitle.isNotEmpty
                                        ? minutesTitle
                                        : CornerPlayRulesUtil.getRuleTitle(
                                        playId: widget.playId,
                                        match: widget.match,
                                        hps: widget.hps,
                                        currentHSpecial: hSpecial),
                                    style: TextStyle(
                                      color: widget.playId == playIdConfig.hps6Minutes
                                          ? const Color(0xFFFEAE2C)
                                          : const Color(0xFF7981A4),
                                      fontSize: 11.sp,
                                    ),
                                  )
                              )
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

  // 比分和红牌数值变化时设置时间
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

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
                // Get.log('isFav $isFav ${logic.commonCollectionTidList} ${logic.commonCollectionMidList}');

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
