import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事阶段板球 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 详情页显示板球
    ```
    赛种	阶段id	接入优化后比赛阶段标准	B02阶段描述	G01阶段描述
    板球	0	未开赛PreGame
    板球	8	第一局	Inning 1	1.Home Team - 1st Innings2.Home Team - 2nd Innings3.Away Team - 1st Innings4.Away Team - 2nd Innings
    板球	301	第一局结束	Inning 1 End	1.PostGame2.Home Team - 3rd Innings3.Away Team - 3rd Innings
    板球	9	第二局	Inning 2	1.Home Team - 3rd Innings2.Home Team - 4th Innings3.Away Team - 3rd Innings4.Away Team - 4th Innings
    板球	302	第二局结束	Inning 2 End	1.PostGame2.Home Team - 4th Innings3.Away Team - 4th Innings
    板球	70	比赛暂停BreakInPlay
    板球	80	比赛中断GameAbandoned
    板球	90	比赛放弃GameAbandoned
    板球	100	常规时间比赛结束	Finish	PostGame
    板球	999	比赛结束（通过100，转换来）	Finish	PostGame
    ```
    】】】
 *
 */
class StageChild37 extends StatefulWidget {
  const StageChild37(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  @override
  State<StageChild37> createState() => _StageChild37State();
}

class _StageChild37State extends State<StageChild37> {
  /// 定时器
  Timer? timer;

  // 显示比赛时间的阶段
  List<String> mmpArr = ['8', '9'];

  // 赛事进行时间
  int showTime = 0;

  // 上下半场
  List<String> mmpArr1 = ['8', '9'];

  @override
  void initState() {
    // initEvent();
    // getSyncMatchTime();

    /// 初始化定时器
    // timer?.cancel();
    // timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {
    //     calculateGraph();
    //     getSyncMatchTime();
    //   });
    // });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StageChild37 oldWidget) {
    // 比赛的时候，更新mst时间
    if (mmpArr.contains(widget.match.mmp)) {
      // initEvent();
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
    if (matchResultState()) {
      return AutoSizeText(
        LocaleKeys.match_info_match_over.tr,
        maxLines: 1,
        minFontSize: 8,
        style: TextStyle(
          color: widget.isMatchSelect
              ? Get.theme.subSelectTitleColor
              : Colors.white,
          fontSize: widget.isPinnedAppbar
              ? Get.theme.fontSize_14
              : Get.theme.fontSize_12,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            "mmp_37_${widget.match.mmp}".tr+" "+widget.match.mbcn,
            maxLines: 1,
            minFontSize: 8,
            style: TextStyle(
              color: widget.isMatchSelect
                  ? Get.theme.subSelectTitleColor
                  : Colors.white,
              fontSize: widget.isPinnedAppbar
                  ? Get.theme.fontSize_14
                  : Get.theme.fontSize_12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          // Row(
          //   children: [
          //     // 赛事计时器
          //     if (mmpArr.contains(widget.match.mmp) && showTime != 0)
          //       AutoSizeText(
          //         FormatDate.formatMgtTime(showTime),
          //         maxLines: 1,
          //         minFontSize: 8,
          //         style: TextStyle(
          //           color: widget.isMatchSelect
          //               ? Get.theme.subSelectTitleColor
          //               : Colors.white,
          //           fontSize: widget.isPinnedAppbar
          //               ? Get.theme.fontSize_14
          //               : Get.theme.fontSize_12,
          //           fontFamily: 'PingFang SC',
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ).marginOnly(left: 4.w),
          //     if (widget.match.mmp == "0")
          //       AutoSizeText(
          //         "00:00",
          //         maxLines: 1,
          //         minFontSize: 8,
          //         style: TextStyle(
          //           color: widget.isMatchSelect
          //               ? Get.theme.subSelectTitleColor
          //               : Colors.white,
          //           fontSize: widget.isPinnedAppbar
          //               ? Get.theme.fontSize_14
          //               : Get.theme.fontSize_12,
          //           fontFamily: 'PingFang SC',
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ).marginOnly(left: 4.w),
          //   ],
          // ),
        ],
      );
    }
  }

  /// 获取同步的赛事时间
  getSyncMatchTime() {
    if (widget.isPinnedAppbar) {
      if (Get.isRegistered<MatchDetailController>(tag: widget.match.mid)) {
        MatchDetailController detailController =
            Get.find<MatchDetailController>(tag: widget.match.mid);

        final matchTimeMap = detailController.detailState.matchTimes;
        if (matchTimeMap.containsKey(widget.match.mid) &&
            matchTimeMap[widget.match.mid] != "") {
          int? temp = int.tryParse(matchTimeMap[widget.match.mid] ?? "");
          if (temp != null) {
            showTime = temp;
          }
        }
      }
    }
  }

  /// 同步赛事时间
  saveMatchTime() {
    if (widget.isPinnedAppbar) return;
    if (Get.isRegistered<MatchDetailController>(tag: widget.match.mid)) {
      MatchDetailController detailController =
          Get.find<MatchDetailController>(tag: widget.match.mid);
      detailController.detailState.matchTimes[widget.match.mid] =
          showTime.toString();
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

  // *@description 美足赛事阶段显示
  // *@param {Undefined}
  // *@return {String} 赛事阶段
  detailDataMmp() {
    // 前端做兼容处理 赛事阶段未开赛+赛事状态进行中 默认显示第一节
    if (widget.match.mmp == '0' && widget.match.ms == 1) {
      // mmp=13 代表第一节
      return '13';
    } else {
      return widget.match.mmp;
    }
  }

  ///@description 判断赛事是暂停||开始
  initEvent() {
    if (widget.match.mess == 0 && !mmpArr1.contains(widget.match.mmp)) {
      showTime = int.parse(widget.match.mst);
      saveMatchTime();
    } else {
      initRestTime();
    }
  }

  ///@description 重置时间
  ///@param {Number} 赛事进行时间
  initRestTime() {
    // 比赛进行时; 6, 上半场， 7，下半场, 41 加时赛上半场， 42 加时下半场；
    if (widget.match.mmp == '6' ||
        widget.match.mmp == '7' ||
        widget.match.mmp == '41' ||
        widget.match.mmp == '42') {
      showTime = int.parse(widget.match.mst);
      // 正在比赛阶段时间正计时
      calculateGraph();
    }
  }

  ///@description 时间倒计时
  ///@param {Number} 赛事进行时间
  calculateGraph() {
    showTime += 1;
    saveMatchTime();
  }
}
