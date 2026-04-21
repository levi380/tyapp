import 'dart:async';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import '../../../../../main.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';

import '../../../../utils/format_score_util3.dart';
import '../../../../widgets/image_view.dart';
import '../../../../widgets/scroll_index_widget.dart';
import '../../constants/theme_constant.dart';
import '../../controllers/match_tools_methods.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 组件拆分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情页区域中部(主副队logo+主副队名+赛事[阶段+时间+比分])
    】】】
 *
 */

class MatchSelectWidgetCellDetail extends StatefulWidget {
  const MatchSelectWidgetCellDetail(
      {super.key, required this.match, required this.controller});

  final MatchEntity match;
  final MatchDetailController controller;

  @override
  State<MatchSelectWidgetCellDetail> createState() => _MatchSelectWidgetCellDetailState();
}

class _MatchSelectWidgetCellDetailState extends State<MatchSelectWidgetCellDetail> {
  /// 定时器
  Timer? timer;

  /// 赛事开始倒计时时间（赛事开始时间-当前时间）
  String longTime = "";

  // 赛事开赛时间倒计时是否显示
  bool startTime = true;

  @override
  void initState() {
    _initEvent();

    // 联赛修改触发初始化
    Bus.getInstance().on(EventType.matchTimeInit, (_) {
      _initEvent();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    Bus.getInstance().off(EventType.matchTimeInit);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MatchSelectWidgetCellDetail oldWidget) {
    if (oldWidget.match.mgt != widget.match.mgt) {
      _initEvent();
    }
    super.didUpdateWidget(oldWidget);
  }

  _initEvent() {
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

  @override
  Widget build(BuildContext context) {
    // 点球大战
    bool isShootout = (["34", "50", "120"].contains(widget.match.mmp) ||
        widget.match.mscMap.containsKey("S170"));
    String homeLogo = ObjectUtil.isNotEmpty(
        (widget.match.mhlu as List).safeFirst)
        ? (widget.match.mhlu as List).safeFirst
        : 'assets/images/home/home_team_logo.svg';
    String awayLogo = ObjectUtil.isNotEmpty(
        (widget.match.malu as List).safeFirst)
        ? (widget.match.malu as List).safeFirst
        : 'assets/images/home/default_team_away.svg';


    ///赛事详情 队伍名称

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isIPad ? 300.w : 151.5.w,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 队徽 type 0表示主队 mhlu主队的url
              // 双打情况
              widget.match.mhlu.length > 1
                  ? SizedBox(
                width: isIPad ? 114.w : 74.w,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: isIPad ? 84.w : 44.w,
                        height: isIPad ? 84.w : 44.w,
                        alignment: Alignment.center,
                        child: ImageView(
                          homeLogo,
                          width: isIPad ? 76.36.w : 40.w,
                          height: isIPad ? 76.36.w : 40.w,
                          cdn: true,
                          errorWidget: ImageView(
                            'assets/images/detail/default_team_home.svg',
                            width: isIPad ? 76.36.w : 40.w,
                            height: isIPad ? 76.36.w : 40.w,
                          ),
                          // errorWidget:
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30.w,
                      child: Container(
                        width: isIPad ? 84.w : 44.w,
                        height: isIPad ? 84.w : 44.w,
                        alignment: Alignment.center,
                        child: ImageView(
                          homeLogo,
                          width: isIPad ? 76.36.w : 40.w,
                          height: isIPad ? 76.36.w : 40.w,
                          cdn: true,
                          errorWidget: ImageView(
                            'assets/images/detail/default_team_home.svg',
                            width: isIPad ? 76.36.w : 40.w,
                            height: isIPad ? 76.36.w : 40.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : // 单打
              Container(
                width: isIPad ? 84.w : 44.w,
                height: isIPad ? 84.w : 44.w,
                alignment: Alignment.center,
                child: widget.controller.detailState.isDJDetail
                    ? ImageView(
                  homeLogo,
                  width: isIPad ? 76.36.w : 40.w,
                  height: isIPad ? 76.36.w : 40.w,
                  dj: true,
                  errorWidget: ImageView(
                    'assets/images/detail/default_team_home.svg',
                    width: isIPad ? 76.36.w : 40.w,
                    height: isIPad ? 76.36.w : 40.w,
                  ),
                )
                    : ImageView(
                  homeLogo,
                  width: isIPad ? 76.36.w : 40.w,
                  height: isIPad ? 76.36.w : 40.w,
                  cdn: true,
                  errorWidget: ImageView(
                    'assets/images/detail/default_team_home.svg',
                    width: isIPad ? 76.36.w : 40.w,
                    height: isIPad ? 76.36.w : 40.w,
                  ),
                ),
              ),

              SizedBox(height: isIPad ? 12.h : 4.h),
              Container(
                alignment: Alignment.center,
                width: isIPad ? 150.w : 100.w,
                child: Text(
                  getTeamName(type: 1, match: widget.match),
                  maxLines: isShootout ? 1 : 2,
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
              ),
              if (isShootout)
              // 点球大战数据
                Container(
                  width: 66.w,
                  margin: EdgeInsets.only(top: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(5, (i) {
                      int index = i + 1;
                      return Container(
                        width: 10.w,
                        height: 10.w,
                        alignment: Alignment.center,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: (widget.match.mscMap['S170$index']?.safeFirst ==
                              "-1" ||
                              widget.match.mscMap['S170$index']?.safeFirst == null)
                              ? BoxDecoration(
                            shape: BoxShape.circle, // 圆形
                            color: Colors.transparent, // 内部透明
                            border: Border.all(
                              color: Colors.white, // 边框为白色
                              width: 1.3.w, // 边框宽度
                            ),
                          )
                              : ShapeDecoration(
                            color: FormatScore3.isShootout(
                                widget.match, index, 'mhn') ==
                                "1"
                                ? ThemeConstant.shootoutSuccessColor
                                : FormatScore3.isShootout(
                                widget.match, index, 'mhn') ==
                                "0"
                                ? ThemeConstant.shootoutFailureColor
                                : Colors.transparent,
                            shape: const OvalBorder(),
                          ),
                        ),
                      );
                    }),
                  ),
                )
            ],
          ),
        ),
        SizedBox(
          width: isIPad ? 300.w : 151.5.w,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 双打情况
              widget.match.malu.length > 1
                  ? SizedBox(
                width: isIPad ? 114.w : 74.w,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: isIPad ? 84.w : 44.w,
                        height: isIPad ? 84.w : 44.w,
                        alignment: Alignment.center,
                        child: ImageView(
                          awayLogo,
                          width: isIPad ? 76.36.w : 40.w,
                          height: isIPad ? 76.36.w : 40.w,
                          cdn: true,
                          errorWidget: ImageView(
                            'assets/images/detail/default_team_away.svg',
                            width: isIPad ? 76.36.w : 40.w,
                            height: isIPad ? 76.36.w : 40.w,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30.w,
                      child: Container(
                        width: isIPad ? 84.w : 44.w,
                        height: isIPad ? 84.w : 44.w,
                        alignment: Alignment.center,
                        child: ImageView(
                          awayLogo,
                          width: isIPad ? 76.36.w : 40.w,
                          height: isIPad ? 76.36.w : 40.w,
                          cdn: true,
                          errorWidget: ImageView(
                            'assets/images/detail/default_team_away.svg',
                            width: isIPad ? 76.36.w : 40.w,
                            height: isIPad ? 76.36.w : 40.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : // 单打
              Container(
                width: isIPad ? 84.w : 44.w,
                height: isIPad ? 84.w : 44.w,
                alignment: Alignment.center,
                child: widget.controller.detailState.isDJDetail
                    ? ImageView(
                  awayLogo,
                  width: isIPad ? 76.36.w : 40.w,
                  height: isIPad ? 76.36.w : 40.w,
                  dj: true,
                  errorWidget: ImageView(
                    'assets/images/detail/default_team_away.svg',
                    width: isIPad ? 76.36.w : 40.w,
                    height: isIPad ? 76.36.w : 40.w,
                    cdn: true,
                  ),
                )
                    : ImageView(
                  awayLogo,
                  width: isIPad ? 76.36.w : 40.w,
                  height: isIPad ? 76.36.w : 40.w,
                  cdn: true,
                  errorWidget: ImageView(
                    'assets/images/detail/default_team_away.svg',
                    width: isIPad ? 76.36.w : 40.w,
                    height: isIPad ? 76.36.w : 40.w,
                  ),
                ),
              ),
              SizedBox(height: isIPad ? 12.h : 4.h),
              Container(
                alignment: Alignment.center,
                width: isIPad ? 150.w : 100.w,
                child: Text(
                  getTeamName(type: 2, match: widget.match),
                  maxLines: isShootout ? 1 : 2,
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
              ),
              if (isShootout)
              // 点球大战数据
                Container(
                  width: 66.w,
                  margin: EdgeInsets.only(top: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(5, (i) {
                      int index = i + 1;
                      return Container(
                        width: 10.w,
                        height: 10.w,
                        alignment: Alignment.center,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: (widget.match.mscMap['S170$index']?.safeLast ==
                              "-1" ||
                              widget.match.mscMap['S170$index']?.safeLast == null)
                              ? BoxDecoration(
                            shape: BoxShape.circle, // 圆形
                            color: Colors.transparent, // 内部透明
                            border: Border.all(
                              color: Colors.white, // 边框为白色
                              width: 1.3.w, // 边框宽度
                            ),
                          )
                              : ShapeDecoration(
                            color: FormatScore3.isShootout(
                                widget.match, index, 'man') ==
                                "1"
                                ? ThemeConstant.shootoutSuccessColor
                                : FormatScore3.isShootout(
                                widget.match, index, 'man') ==
                                "0"
                                ? ThemeConstant.shootoutFailureColor
                                : Colors.transparent,
                            shape: const OvalBorder(),
                          ),
                        ),
                      );
                    }),
                  ),
                )
            ],
          ),
        ),
      ],
    );

  }
}

