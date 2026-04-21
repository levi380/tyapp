

import 'package:common_utils/common_utils.dart';



import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/match_select_state_bubble.dart';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../../main.dart';
import '../../../../utils/bus/bus.dart';
import '../../../../utils/bus/event_enum.dart';

import '../../../../utils/format_date_util.dart';



import '../../../../utils/format_score_util3.dart';
import '../../../../utils/sport.dart';
import '../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../widgets/scroll_index_widget.dart';
import '../../controllers/match_tools_methods.dart';


import 'middle/stage/match_stage.dart';

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

class MatchSelectWidgetHeader extends StatefulWidget {
  const MatchSelectWidgetHeader(
      {super.key, required this.match, required this.controller});

  final MatchEntity match;
  final MatchDetailController controller;

  @override
  State<MatchSelectWidgetHeader> createState() => _MatchSelectWidgetHeaderState();
}

class _MatchSelectWidgetHeaderState extends State<MatchSelectWidgetHeader> {
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
  void didUpdateWidget(covariant MatchSelectWidgetHeader oldWidget) {
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

Color get _titleColor => !Get.isDarkMode ? Get.theme.matchSelectTitleColor : Colors.white;

@override
Widget build(BuildContext context) {
  // 点球大战
  // bool isShootout = (["34", "50", "120"].contains(widget.match.mmp) ||
  //     widget.match.mscMap.containsKey("S170"));
  String homeLogo = ObjectUtil.isNotEmpty(
      (widget.match.mhlu as List).safeFirst)
      ? (widget.match.mhlu as List).safeFirst
      : 'assets/images/home/home_team_logo.svg';
  String awayLogo = ObjectUtil.isNotEmpty(
      (widget.match.malu as List).safeFirst)
      ? (widget.match.malu as List).safeFirst
      : 'assets/images/home/default_team_away.svg';

  ///赛事详情 队伍名称
  return Container(
    child: Column(
      children: [
        _buildExpandIcon(),
        Container(
          // padding: EdgeInsetsGeometry.only(bottom: 10.h),
          height: 90.w,
          child: Stack(
            children: [
              /// 队名队标
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTeamSection(isHome: true),
                  _buildTeamSection(isHome: false),
                ],
              ),
              /// 赛事阶段/比分
              _buildMiddleInfo(),
              /// 比分header底部阴影
              _buildBottomShadow(context),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildExpandIcon() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: ImageView('assets/images/icon/expands.png', width: 24.w, height: 24.w),
    );
  }

  Widget _buildTeamSection({required bool isHome}) {
    final List logos = (isHome ? widget.match.mhlu : widget.match.malu) as List;
    final name = getTeamName(type: isHome ? 1 : 2, match: widget.match);

    final logoPath = ObjectUtil.isNotEmpty(logos.safeFirst)
        ? logos.safeFirst
        : (isHome ? 'assets/images/home/home_team_logo.svg' : 'assets/images/home/default_team_away.svg');

    return SizedBox(
      width: isIPad ? 300.w : 143.w,
      child: Row(
        mainAxisAlignment: isHome ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isHome) _buildLogo(logos, logoPath!, false),
          Container(
            width: isIPad ? 150.w : 100.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: _titleColor, fontSize: isIPad ? 20.sp : 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          if (isHome) _buildLogo(logos, logoPath!, true),
        ],
      ),
    );
  }

  Widget _buildLogo(dynamic logos, String path, bool isHome) {
    final size = isIPad ? 84.w : 25.w;
    final imgSize = isIPad ? 76.36.w : 25.w;
    final errorPath = isHome ? 'assets/images/detail/default_team_home.svg' : 'assets/images/detail/default_team_away.svg';

    return Container(
      width: logos.length > 1 && isIPad ? 114.w : size,
      height: size,
      alignment: Alignment.center,
      child: ImageView(
        path,
        width: imgSize,
        height: imgSize,
        cdn: !widget.controller.detailState.isDJDetail,
        dj: widget.controller.detailState.isDJDetail,
        errorWidget: ImageView(errorPath, width: imgSize, height: imgSize),
      ),
    );
  }

  Widget _buildMiddleInfo() {
    return Positioned.fill(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.match.ms != SportData.sportMs_110) MatchStage(isMatchSelect: true, match: widget.match),
            SizedBox(height: isIPad ? 8.h : 2.h),
            if (matchStageContentBottom().isNotEmpty)
              Text(
                matchStageContentBottom(),
                style: TextStyle(
                  color: _titleColor,
                  fontSize: widget.match.ms == SportData.sportMs_110 ? 13.sp : 18.sp,
                  fontFamily: 'Akrobat',
                  fontWeight: widget.match.ms != SportData.sportMs_110 ? FontWeight.w700 : FontWeight.w300,
                ),
              ),
            if (matchStageContentBottom().isNotEmpty) SizedBox(height: isIPad ? 8.h : 5.h),
            MatchSelectStateBubble(match: widget.match, isHeader: true),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomShadow(BuildContext context) {
    return Positioned(
      left: 0, right: 0, bottom: -12.w,
      child: Container(
        height: 15.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width / 2, 20.w)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_titleColor.withValues(alpha: 0.07), _titleColor.withValues(alpha: 0.02), Colors.transparent],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }

  /// 赛事阶段显示内容 下部分(比赛时间or开赛时间)
  String matchStageContentBottom() {
    int ms = widget.match.ms;
    // 赛事未开赛
    if (ms == SportData.sportMs_0) {
      // 即将开赛的赛事不显示日期
      if (startTime) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        return LocaleKeys.list_after_time_start.tr.replaceAll("{0}", longTime);
      } else {
        // 格式化显示HH:MM
        return FormatDate.formatHHMM(TimeZoneUtils.convertTimeToTimestamp(
            widget.match.mgt,
            isMilliseconds: true,
            returnMilliseconds: true))
            .toString();
      }
    }
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == SportData.sportMs_110) {
      return "ms_$ms".tr;
    } else if ([
      SportData.sportMs_1,
      SportData.sportMs_2,
      SportData.sportMs_3,
      SportData.sportMs_4
    ].contains(ms)) {
      ///比分位置  新增 电竞比分判定中
      if(eSportsScoring(widget.match)){
        return LocaleKeys.mmp_eports_scoring.tr;
      }
      /// 显示比分
      return "${FormatScore3.formatDetailScore(widget.match, 0)} - ${FormatScore3.formatDetailScore(widget.match, 1)}";
    }
    return "";
  }


  /// 赛事阶段显示内容 下部分 字体
  double getMatchStageBottomContentFontSize() {
    int ms = widget.match.ms;
    // 赛事未开赛
    if (ms == 0) {
      // 即将开赛的赛事不显示日期
      if (startTime) {
        // 距离开赛时间小于一个小时 显示倒计时 (分钟)
        return isIPad ? 16.sp : 12.sp;
      } else {
        // 显示HH：mm
        return isIPad ? 40.sp : 30.sp;
      }
    }
    // 赛前切滚球 ms = 110时：显示即将开赛
    else if (ms == 110) {
      return isIPad ? 16.sp : 12.sp;
    } else if ([1, 2, 3, 4].contains(ms)) {
      // 显示比分
      return isIPad ? 40.sp : 30.sp;
    }
    return isIPad ? 40.sp : 30.sp;
  }

  /// 局间比分显示逻辑：滚球阶段ms=1并且对应赛种才显示
  /// ms 0、赛事未开始 1、滚球阶段 2、暂停 3、结束 4、关闭 5、取消 6、比赛放弃 7、延迟 8、未知 9、延期 10、比赛中断
  /// 4--冰球, 5--网球, 7--斯诺克, 8--乒乓球, 9--排球, 10--羽毛球, 13--沙滩排球,14--橄榄球, 15--曲棍球, 16--水球 37 板球
  ///  A代表ACE，就是俗称的发球直接得分！
  bool showMatchBetweenScore() {
    List<String> msc = widget.match.msc;
    if (["3", "4", "5", "7", "6", "8", "9", "10", "13", "14", "15", "16", "37"]
        .contains(widget.match.csid) &&
        widget.match.ms == 1 &&
        msc.isNotEmpty &&
        widget.match.mmp != "999") {
      return true;
    }
    return false;
  }

  /// 足球 比赛暂停 mmp：80
  bool showMatchInterrupted() {
    if (["1"].contains(widget.match.csid) && widget.match.mmp == "80") {
      return true;
    }
    return false;
  }
}

