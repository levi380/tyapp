import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/match_between_score.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/middle/stage/match_stage.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/common_widget/team_logo.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../../main.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';
import '../../../../utils/format_score_util3.dart';
import '../../../../utils/sport.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/scroll_index_widget.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_tools_methods.dart';
import 'middle/football_animation.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-7ace44aa-916a-4027-9661-926a0bee07b1 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 组件拆分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情页区域中部(主副队logo+主副队名+赛事[阶段+时间+比分])
    】】】
 *
 */
class HeaderMiddle extends StatefulWidget {
  const HeaderMiddle(
      {super.key, required this.match, required this.controller});

  final MatchEntity match;
  final MatchDetailController controller;

  @override
  State<HeaderMiddle> createState() => _HeaderMiddleState();
}

class _HeaderMiddleState extends State<HeaderMiddle> {
  /// 定时器
  Timer? timer;

  /// 赛事开始倒计时时间（赛事开始时间-当前时间）
  String longTime = "";

  // 赛事开赛时间倒计时是否显示
  bool startTime = true;

  // 比分和红牌数值变化时设置时间
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

  // 是否显示主队红牌动画
  bool isShowHomeRed = false;

  // 是否显示客队红牌动画
  bool isShowAwayRed = false;

  @override
  void initState() {
    initEvent();

    // 联赛修改触发初始化
    Bus.getInstance().on(EventType.matchTimeInit, (_) {
      initEvent();
    });
    _initRed();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    Bus.getInstance().off(EventType.matchTimeInit);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HeaderMiddle oldWidget) {
    if (oldWidget.match.mgt != widget.match.mgt) {
      initEvent();
    }

    if (widget.match.mid == oldWidget.match.mid && widget.match.csid == "1") {
      _initRed();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double vsTeamTopMargin = obtyAppbarHeight +
        widget.controller.detailState.physicalPaddingTop +
        (isIPad ? 30.h : 5.h);
    double scoreHeight = obtyAppbarHeight +
        widget.controller.detailState.physicalPaddingTop +
        (isIPad ? 30.h : 5.h);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: vsTeamTopMargin,
          // bottom: isIPad ? 68.h : 55.h,
          width: 1.sw,
          child: _buildVsTeam(widget.match, widget.controller),
        ),

        /// 赛事阶段展示
        Positioned(
          ///原布局
          // top: obtyAppbarHeight +
          //     widget.controller.detailState.physicalPaddingTop,
          // height: scoreHeight, // 8.h:底部padding
          ///新布局  比分需要 以赛事图标 + 球队文案第一行  为整体高度  居中显示
          top: vsTeamTopMargin,
          bottom: isIPad ? 68.h : 55.h,
          child: _buildStage(vsTeamTopMargin: scoreHeight),
        ),
        // 进球 动画
        if (widget.match.csid == "1")
          Positioned(
            top: obtyAppbarHeight +
                widget.controller.detailState.physicalPaddingTop,
            child: FootBallAnimation(
              match: widget.match,
            ),
          ),
      ],
    );
  }

  Widget _buildStage({required double vsTeamTopMargin}) {
    String bottomContent =
        matchStageContentBottom(widget.match, startTime, longTime);
    return Container(
      constraints:
          BoxConstraints(minWidth: 87.w, maxWidth: isIPad ? 300.w : 160.w),
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 展示赛事阶段，开赛时间以及倒计时等
          if (widget.match.ms != SportData.sportMs_110)
            MatchStage(
              match: widget.match,
            ),

          SizedBox(height: isIPad ? 8.h : 2.h),
          // 比赛分数or开赛时间
          if (bottomContent.isNotEmpty)
            Column(
              children: [
                Text(
                  bottomContent,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getMatchStageBottomContentFontSize(
                        widget.match.ms, startTime),
                    fontFamily: 'Akrobat',
                    fontWeight: widget.match.ms != SportData.sportMs_110
                        ? FontWeight.w700
                        : FontWeight.w300,
                  ),
                ),
                if (widget.match.ms == SportData.sportMs_110)
                  Column(
                    children: [
                      Text(
                        "VS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      /// 是否中立场 即将开赛不显示中立场
                      if (isMidField(widget.match))
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(23, 156, 255, 1),
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Text(
                            "N",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: isIPad ? 16.sp : 12.sp),
                          ),
                        ),
                    ],
                  ),
              ],
            ),

          /// 局间比分 联赛下拉不展示局间比分
          if (showMatchBetweenScore(widget.match))
            MatchBetweenScore(match: widget.match),
        ],
      ),
    );
  }

  ///赛事详情 队伍名称
  Widget _buildVsTeam(MatchEntity match, MatchDetailController controller) {
    // 点球大战  点球大战轮数增加到24轮   范围（S1701-S1724） 用到的 S1711 S1712 比分key， 替换成 S17101  S17102 (S1711 S1712, 目前在赛事分析使用)
    bool isShootout = (["34", "50", "120"].contains(match.mmp) ||
        match.mscMap.containsKey("S170"));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isIPad
              ? 300.w
              : isShootout
                  ? 130.w
                  : 151.5.w,
          child: _buildTeamItem(match, controller, isShootout, true),
        ),
        SizedBox(
          width: isIPad
              ? 300.w
              : isShootout
                  ? 130.w
                  : 151.5.w,
          child: _buildTeamItem(match, controller, isShootout, false),
        ),
      ],
    );
  }

  Widget _buildTeamItem(MatchEntity match, MatchDetailController controller,
      bool isShootout, bool isHomeTeam) {
    var teamStr = isHomeTeam ? 'mhn' : 'man';
    var teams = isHomeTeam ? match.mhlu : match.malu;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 队徽 type 0表示主队 mhlu主队的url
        TeamLogo(
          isHome: isHomeTeam,
          match: match,
          isDJDetail: controller.detailState.isDJDetail,
          size: 40.w,
          offset: 30.w,
        ),

        SizedBox(height: isIPad ? 12.h : 4.h),
        Container(
          alignment: Alignment.center,
          width: isIPad ? 150.w : 110.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 红牌
              if (isShowAwayRed && !isHomeTeam && widget.match.csid == "1")
                Container(
                  width: isIPad ? 18.w : 9.w,
                  height: isIPad ? 24.w : 12.w,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF53F3F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r)),
                  ),
                  margin: EdgeInsets.only(top: 4.h, right: 4.w),
                  alignment: Alignment.center,
                  child: Text(
                    s11Score(widget.match).safe('away').toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: 10.sp, height: 1.2),
                  ),
                )
              else
                SizedBox.shrink(),
              teams.length > 1
                  ? Flexible(
                      child: Column(
                        children: [
                          Text(
                            getDoubleTeamName(
                                    type: isHomeTeam ? 1 : 0, match: match)
                                .safeFirst!,
                            maxLines: 1,
                            // 有点球大战时显示一行
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isIPad ? 20.sp : 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            getDoubleTeamName(
                                    type: isHomeTeam ? 1 : 0, match: match)
                                .safeLast!,
                            maxLines: 1,
                            // 有点球大战时显示一行
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isIPad ? 20.sp : 14.sp,
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Flexible(
                      child: Text(
                        getTeamName(type: isHomeTeam ? 1 : 0, match: match),
                        maxLines: isShootout ? 1 : 2,
                        // 有点球大战时显示一行
                        softWrap: true,
                        overflow: isShootout
                            ? TextOverflow.ellipsis
                            : TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isIPad ? 20.sp : 14.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    ),
              // 红牌
              if (isShowHomeRed && isHomeTeam && widget.match.csid == "1")
                Container(
                  width: isIPad ? 18.w : 9.w,
                  height: isIPad ? 24.w : 12.w,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF53F3F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.r)),
                  ),
                  margin: EdgeInsets.only(top: 4.h, left: 4.w),
                  alignment: Alignment.center,
                  child: Text(
                    s11Score(widget.match).safe('home').toString(),
                    style: TextStyle(
                        color: Colors.white, fontSize: 10.sp, height: 1.2),
                  ),
                )
              else
                SizedBox.shrink(),
            ],
          ),
        ),
        if (isShootout)
          // 点球大战数据
          // PenaltyShootoutWidget(
          //   match: match,
          //   teamStr: teamStr,
          //   isHomeTeam: isHomeTeam,
          // )
          Container(
            width: 66.w,
            margin: EdgeInsets.only(top: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(5, (i) {
                int index = i + 1;

                if (FormatScore3.isShootout(match, index, teamStr) == "-1") {
                  return ImageView(
                    "assets/images/detail/overtime_goal_default.svg",
                    width: 12.w,
                  );
                }
                if (FormatScore3.isShootout(match, index, teamStr) == "1") {
                  return ImageView(
                    isHomeTeam
                        ? "assets/images/detail/overtime_goal_home.svg"
                        : "assets/images/detail/overtime_goal_away.svg",
                    width: 12.w,
                  );
                }

                if (FormatScore3.isShootout(match, index, teamStr) == "0") {
                  return ImageView(
                    isHomeTeam
                        ? "assets/images/detail/overtime_not_goal_home.svg"
                        : "assets/images/detail/overtime_not_goal_away.svg",
                    width: 12.w,
                  );
                }
                return ImageView(
                  "assets/images/detail/overtime_goal_default.svg",
                  width: 12.w,
                );
              }),
            ),
          )
      ],
    );
  }

  /// 计算赛事开始倒计时时间
  initEvent() {
    // 当前时间戳 1709022665703
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;

    int mgt = int.tryParse(widget.match.mgt) ?? 0;
    // 赛事开始时间 - 当前时间 小于一小时并且大于0时为true
    bool startTimeTemp =
        (mgt - nowTimeStamp) < 3600 * 1000 && (mgt - nowTimeStamp) > 0;

    // 赛事开始倒计时时间(整数)
    int longTimeTemp = (mgt - nowTimeStamp) / 1000 ~/ 60;

    // 赛事开赛时间倒计时为0的时候 让倒计时显示为1分钟
    if (longTimeTemp == 0) {
      longTimeTemp += 1;
    }

    startTime = startTimeTemp;

    // 计算出来的倒计时时间赋值给data的变量显示在页面上
    longTime = longTimeTemp.toString();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted || isScrolling) {
        return;
      }
      setState(() {
        int now = DateTime.now().millisecondsSinceEpoch;
        int mgt = int.tryParse(widget.match.mgt) ?? 0;
        // 判断赛事开始时间-当前时间 小于0的时候 清除定时器
        if (mgt - now < 0) {
          timer.cancel();
          // 不显示倒计时
          startTime = false;
          // 此时同步更新match_stage组件的时间
          Bus.getInstance().emit(EventType.matchNoStart, null);
        }
        // 同上注释
        int newLongTime = ((mgt - now) / 1000 / 60).floor();
        if (newLongTime == 0) {
          newLongTime += 1;
        }
        longTime = newLongTime.toString();
      });
    });
  }

  // 初始化红牌显示
  _initRed() {
    // 红牌
    Map<String, dynamic> newS11Score = s11Score(widget.match);
    // 主客队比分数值变化，则更新对应时间
    if (newS11Score["home"] > 0 || newS11Score["away"] > 0) {
      scoreTime["S11"] = DateTime.now().millisecondsSinceEpoch;
    }

    // 主队
    if (newS11Score["home"] > 0) {
      isShowHomeRed = true;
    } else {
      isShowHomeRed = false;
    }
    // 客队
    if (newS11Score["away"] > 0) {
      isShowAwayRed = true;
    } else {
      isShowAwayRed = false;
    }
  }
}
