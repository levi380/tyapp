import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import 'package:flutter_ty_app/app/utils/format_date_util.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 比分+队伍+赛事阶段】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛事阶段橄榄球 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 橄榄球
    ```
    // 显示比赛时间的阶段
    List<String> mmpArr = ['6', '7', '41', '42'];
    // 赛事进行时间
    int showTime = 0;
    // 上下半场
    List<String> mmpArr1 = ["31", "33"];
    ```
    】】】
 *
 */
class StageChild14 extends StatefulWidget {
  const StageChild14(
      {super.key,
      required this.isPinnedAppbar,
      required this.match,
      required this.isMatchSelect});

  final bool isPinnedAppbar;
  final MatchEntity match;
  final bool isMatchSelect;

  @override
  State<StageChild14> createState() => _StageChild14State();
}

class _StageChild14State extends State<StageChild14> {
  /// 定时器
  Timer? timer;

  // 显示比赛时间的阶段
  List<String> mmpArr = ['6', '7', '41', '42'];

  // 赛事进行时间
  int showTime = 0;

  // 上下半场
  List<String> mmpArr1 = ["31", "33"];

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
        // 根据mle字段 0、2 代表正计时  1 代表倒计时
        if (widget.match.mle == 0 || widget.match.mle == 2) {
          calculateGraph(true);
        } else {
          calculateGraph(false);
        }
        getSyncMatchTime();
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant StageChild14 oldWidget) {
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
    if (matchResultState()) {
      return AutoSizeText(
        LocaleKeys.match_info_match_over.tr,
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
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            "mmp_14_${widget.match.mmp}".tr,
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
          Row(
            children: [
              // 赛事计时器
              if (mmpArr.contains(widget.match.mmp) && showTime != 0)
                AutoSizeText(
                  FormatDate.formatMgtTime(showTime),
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
                ).marginOnly(left: 4.w),
              if (widget.match.mmp == "0")
                AutoSizeText(
                  "00:00",
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
                ).marginOnly(left: 4.w),
            ],
          ),
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
      MatchDetailController detailController = Get.find<MatchDetailController>(tag: widget.match.mid);
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
      // 根据mle字段 0、2 代表正计时  1 代表倒计时
      if (widget.match.mle == 0 || widget.match.mle == 2) {
        calculateGraph(true);
      } else {
        calculateGraph(false);
      }
    }
  }

  ///@description 时间倒计时
  ///@param {Number} 赛事进行时间
  calculateGraph(bool isForward) {
    if (isForward) {
      showTime += 1;
    } else {
      if (showTime <= 0) {
        showTime = 0;
      } else {
        showTime -= 1;
      }
    }

    saveMatchTime();
  }
}
