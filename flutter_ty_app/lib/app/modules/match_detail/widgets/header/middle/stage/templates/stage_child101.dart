import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/core/MatchListClass.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事阶段曲电竞】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情页 电竞第几局 以及 赛事时间
    】】】
 *
 */
class StageChild101 extends StatefulWidget {
  const StageChild101({
    super.key,
    required this.isPinnedAppbar,
    required this.match,
    required this.isMatchSelect,
    this.djEntrance = false,
  });

  /// 是否是置顶头部
  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  /// dj列表
  final bool djEntrance;

  @override
  State<StageChild101> createState() => _StageChild101State();
}

class _StageChild101State extends State<StageChild101> {
  /// 计时器显示时间
  String countingTime = "00:00";

  /// 计时器步长
  double step = 1.0;

  /// 计时器开始计时时间
  double reduceSecond = 0.0;

  /// 计时器是否暂停或继续
  bool goon = false;

  /// 定时器
  Timer? timer;

  @override
  void initState() {
    // 初始化修正设置步长
    step = MatchListClass.matchVrStep(widget.match, step);
    // 计时器计时时间
    reduceSecond = double.parse(widget.match.mst);
    computeCounter();
    getSyncMatchTime();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        computeCounter();
        getSyncMatchTime();
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StageChild101 oldWidget) {
    if (oldWidget.match.mst != widget.match.mst) {
      // 初始化修正设置步长
      step = MatchListClass.matchVrStep(widget.match, step);
      // 计时器计时时间
      reduceSecond = double.parse(widget.match.mst);
      computeCounter();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          'mmp_${widget.match.csid}_${widget.match.mmp}'.tr,
          maxLines: 1,
          minFontSize: 8,
          style: TextStyle(
            color:
                // widget.isMatchSelect
                // ? Get.theme.subSelectTitleColor
                // :
                context.isDarkMode
                    ? Colors.white.withValues(alpha:0.5)
                    : const Color(0xffAFB3C8),
            fontSize: widget.djEntrance
                ? 12.sp
                : widget.isPinnedAppbar
                    ? Get.theme.fontSize_14
                    : Get.theme.fontSize_12,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        if (showTimeCounting())
          AutoSizeText(
            FormatDate.countingTimeCtrShowFormat(widget.match, countingTime),
            maxLines: 1,
            minFontSize: 8,
            style: TextStyle(
              color:
                  // widget.isMatchSelect
                  //               ? Get.theme.subSelectTitleColor
                  //               :
                  context.isDarkMode
                      ? Colors.white.withValues(alpha:0.5)
                      : const Color(0xffAFB3C8),
              fontSize: widget.djEntrance
                  ? 12.sp
                  : widget.isPinnedAppbar
                      ? Get.theme.fontSize_14
                      : Get.theme.fontSize_12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ).marginOnly(left: 4.w),
      ],
    );
  }

  /// 获取同步的赛事时间
  getSyncMatchTime() {
    if (widget.isPinnedAppbar && !widget.djEntrance) {
      if (Get.isRegistered<MatchDetailController>(tag: widget.match.mid)) {
        MatchDetailController detailController =
            Get.find<MatchDetailController>(tag: widget.match.mid);
        final matchTimeMap = detailController.detailState.matchTimes;
        if (matchTimeMap.containsKey(widget.match.mid) &&
            matchTimeMap[widget.match.mid] != "") {
          countingTime = matchTimeMap[widget.match.mid]!;
        }
      }
    }
  }

  /// 同步赛事时间
  saveMatchTime() {
    if (widget.isPinnedAppbar || widget.djEntrance) return;
    if (Get.isRegistered<MatchDetailController>(tag: widget.match.mid)) {
      MatchDetailController detailController =
          Get.find<MatchDetailController>(tag: widget.match.mid);
      detailController.detailState.matchTimes[widget.match.mid] = countingTime;
    }
  }

  /// 计时器显示实时时间
  computeCounter() {
    // 赛事使用mstrc字段数据
    // if(match?.cds == "1500" && matchmstrc){
    //   detailState.matchDetailData.update((val) {
    //     val?.mst = matchmstrc;
    //   });
    // }
    // 获取当前计时时间
    getCountingTime();
    String csid = widget.match.csid;
    int mess = widget.match.mess;
    String mmp = widget.match.mmp;
    int ms = widget.match.ms;
    if (
        // 暂停 mess = 0
        mess == 0 ||
            // 足球 csid : 1 同时赛事为等待加时
            (csid == "1" && mmp == "32") ||
            // 0：赛事为未开赛则暂停 或局间休息暂停 赛事中断添加mmp:80
            ["0", "80","301", "302", "303", "304", "305", "306"].contains(mmp) ||
            // 全局暂停|中断
            [2, 10].contains(ms)) {
      goon = false;
    } else if (mess == 1) {
      goon = true;
    }
    // 不满足暂停条件则执行
    if (goon) {
      // 是否为累加计时器
      ///冰球  csid = 4 冰球改为递减倒计时  ---- 涉及到业务发板 0728 未上
      if (["1",  "11", "14", "100", "101", "102", "103"].contains(csid)) {
        reduceSecond += step;
        // 是足球时 计算特n , 可视区域数据不多,请求3个mid和1一个mid没有区别 因此直接调用页脚刷新
        //         if(props.matchcsid == 1){
        //           // 15分钟玩法 调用
        //           set_min15(reduce_second,(mmp_15_min)=>{
        //             useMittEmit(MITT_TYPES.EMIT_MENU_CHANGE_FOOTER_CMD, {
        //               text: "mid-refresh", // 只更新对应的mid
        //               mid:props.matchmid
        //             });
        //           });
        //           // 5分钟玩法 调用
        //           set_min5(reduce_second,(mmp_5_min)=>{
        //             useMittEmit(MITT_TYPES.EMIT_MENU_CHANGE_FOOTER_CMD, {
        //               text: "mid-refresh", // 只更新对应的mid
        //               mid:props.matchmid
        //             });
        //           });
        //         }
      } else {
        reduceSecond--;
      }
    }
  }

  /// 赛事结束状态
  bool matchResultState() {
    int ms = widget.match.ms;
    int mo = widget.match.mo;
    if (ms == 3 || ms == 4 || mo == 1) {
      return true;
    }
    return false;
  }

  /// 倒计时是否显示逻辑
  bool showTimeCounting() {
    int csid = int.tryParse(widget.match.csid) ?? 0;
    int mmp = int.parse(widget.match.mmp);

    // 网羽乒斯棒球(3)排球(9)不显示倒计时,只显示状态标题
    if ([5, 10, 8, 7, 3, 9, 13].contains(csid)) {
      return false;
    }
    // 足球
    else if (csid == 1) {
    // 赛事中断添加mmp:80
      return ![
        0,
        30,
        31,
        32,
        33,
        34,
        50,
        61,
        80,
        90,
        100,
        110,
        120,
        301,
        302,
        303,
        445
      ].contains(mmp);
    }
    // 冰球
    else if (csid == 4) {
      // return false;  //临时屏蔽冰球倒计时
      if (widget.match.mlet == "") {
        return false;
      }
      // 第一局 第二局 第三局 加时赛 点球大战
      List<int> mmps = [1, 2, 3, 40, 50];
      return mmps.contains(mmp);
    }
    // 美式足球
    else if (csid == 6) {
      if (widget.match.mlet == "") {
        return false;
      }
      if (mmp == 40) {
        if (countingTime == '00:00') {
          return false;
        }
      }
      // 第一节 第二节 第三节 第四节 加时赛
      List<int> mmps = [13, 14, 15, 16, 40];
      return mmps.contains(mmp);
    }
    // dota
    else if ([100, 101, 102, 103].contains(csid)) {
      if (mmp > -1) {
        return true;
      }
    } else {
    // 赛事中断添加mmp:80
      return ![
        0,
        30,
        31,
        32,
        33,
        34,
        50,
        61,
        80,
        90,
        100,
        110,
        120,
        301,
        302,
        303,
        445
      ].contains(mmp);
    }
    return false;
  }

  /// @description: 获取计时器时间
  void getCountingTime() {
    if (reduceSecond == 0 || widget.match.mmp == "0") {
      countingTime = '00:00';
      return;
    }

    int secondCount = reduceSecond.toInt();
    String minutes, second;

    minutes = (secondCount ~/ 60).toString().padLeft(2, '0');
    int minutesToSecond = int.parse(minutes) * 60;
    second = (secondCount - minutesToSecond).toString().padLeft(2, '0');

    // 水球
    if (widget.match.csid == "16") {
      String waterPCountingDown =
          LocaleKeys.list_water_polo_countdown.tr; // 这里替换为对应的国际化字符串
      int fMinutes = (secondCount ~/ 60).ceil();
      fMinutes = fMinutes > 0 ? fMinutes : 1;
      countingTime = waterPCountingDown.replaceFirst('S%', fMinutes.toString());
    } else {
      countingTime = '$minutes:$second';
    }

    // 防止时间出现负数
    if (countingTime.startsWith('-')) {
      countingTime = countingTime.substring(1);
      countingTime = (countingTime[1] == ':' ? '0' : '') + countingTime;
    }
    saveMatchTime();
  }
}
