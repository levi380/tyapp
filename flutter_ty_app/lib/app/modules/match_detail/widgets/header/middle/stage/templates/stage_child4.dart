import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import 'package:flutter_ty_app/app/utils/format_date_util.dart';

import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事阶段+冰球】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 详情页显示冰球赛事第几节以及赛事时间
    】】】
 *
 */
class StageChild4 extends StatefulWidget {
  const StageChild4(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect,
      this.timeLineWrapDisplay = false
      });

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;
  final bool timeLineWrapDisplay;

  @override
  State<StageChild4> createState() => _StageChild4State();
}

class _StageChild4State extends State<StageChild4> {
  /// 定时器
  Timer? timer;

  // 显示比赛时间的阶段
  List<String> mmpArr = ['1', '2', '3', '40', "301", "302"];

  // 赛事进行时间
  int showTime = 0;

  // 业务为节间休息(前端展示为赛事阶段并且时间静止不动)
  List<String> mmpArr1 = ['301', '302'];

  // 赛事休息阶段-前端显示固定时间20分钟
  List<String> mmpRest = ['0', '12', '13', '32', '33'];

  @override
  void initState() {
    initEvent();
    getSyncMatchTime();

    /// 初始化定时器
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) {
        return;
      }
      setState(() {
        calculateGraph();
        getSyncMatchTime();
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StageChild4 oldWidget) {
    // 比赛的时候，更新mst时间
    if (mmpArr.contains(widget.match.mmp)) {
      initEvent();
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
    return
      widget.timeLineWrapDisplay ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            "mmp_4_${widget.match.mmp}".tr,
            maxLines: 1,
            minFontSize: 8,
            style: TextStyle(
              color: widget.isMatchSelect
                  ? Get.theme.subSelectTitleColor
                  : Colors.white,
              fontSize: widget.isPinnedAppbar ? Get.theme.fontSize_14 : Get.theme.fontSize_12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ),
          if (mmpArr.contains(widget.match.mmp) &&
              showTime != 0 &&
              widget.match.mlet != '')
            AutoSizeText(
              FormatDate.formatMgtTime(showTime),
              // FormatDate.formatMgtTime(showTime),
              maxLines: 2,
              minFontSize: 8,
              style: TextStyle(
                color: widget.isMatchSelect
                    ? Get.theme.subSelectTitleColor
                    : Colors.white,
                fontSize: widget.isPinnedAppbar ? Get.theme.fontSize_14 : Get.theme.fontSize_12,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ).marginOnly(left: 4.w),
        ],
      ):
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          "mmp_4_${widget.match.mmp}".tr,
          maxLines: 1,
          minFontSize: 8,
          style: TextStyle(
            color: widget.isMatchSelect
                ? Get.theme.subSelectTitleColor
                : Colors.white,
            fontSize: widget.isPinnedAppbar ? Get.theme.fontSize_14 : Get.theme.fontSize_12,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w500,
          ),
        ),
        if (mmpArr.contains(widget.match.mmp) &&
            showTime != 0 &&
            widget.match.mlet != '')
          AutoSizeText(
            FormatDate.formatMgtTime(showTime),
            // FormatDate.formatMgtTime(showTime),
            maxLines: 2,
            minFontSize: 8,
            style: TextStyle(
              color: widget.isMatchSelect
                  ? Get.theme.subSelectTitleColor
                  : Colors.white,
              fontSize: widget.isPinnedAppbar ? Get.theme.fontSize_14 : Get.theme.fontSize_12,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ).marginOnly(left: 4.w),
      ],
    );
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
      MatchDetailController detailController = Get.find<MatchDetailController>(tag: widget.match.mid);
      detailController.detailState.matchTimes[widget.match.mid] =
          showTime.toString();
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
    // // 显示比赛时间的阶段且时间静止不动 因为是在赛事休息阶段
    if (mmpArr1.contains(widget.match.mmp)) {
      if (mmpRest.contains(widget.match.mle)) {
        showTime = 1200;
      } else {
        showTime = (widget.match.mle == 56)
            ? 600
            : (widget.match.mle == 65)
                ? 240
                : (widget.match.mle == 67)
                    ? 180
                    : 0;
      }
      saveMatchTime();
    } else if (mmpArr.sublist(0, 4).contains(widget.match.mmp)) {
      showTime = int.parse(widget.match.mst);
      // 正在比赛阶段时间正计时
      calculateGraph();
    }
  }

  ///@description 时间倒计时
  ///@param {Number} 赛事进行时间
  calculateGraph() {
    if (showTime <= 0) {
      showTime = 0;
    } else if (widget.match.mess == 1) {
      showTime -= 1;
    }
    saveMatchTime();
  }
}
