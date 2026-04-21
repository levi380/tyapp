import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_ty_app/app/utils/match_util.dart';
import 'package:get/get.dart';


import '../../../../generated/locales.g.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../services/models/res/get_match_limit_info_by_mids_entity.dart';
import '../../../utils/format_date_util.dart';
import '../../group_bet/bets/widgets/information_view.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(阶段与时间)串关赛事比分展示视图Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能显示赛事阶段、比分和时间，支持实时更新。
    - `RecordMatchInfo`：接收两个参数：
    - `data`：包含赛事记录的对象。
    - `matchInfoList`：赛事信息列表。
    - 使用 `StatefulWidget` 管理组件的状态，包括赛事阶段、比分、时间等。
    - `initFromApi` 方法根据传入的 `matchInfoList` 初始化赛事信息。
    - 通过匹配赛事 ID 获取当前比赛的相关信息。
    - `getTimeMst` 方法根据赛事状态决定是否显示时间，以及如何显示（正计时或倒计时）。
    - 使用 `Timer` 实现实时更新。
    - `_formatBetScore` 方法根据玩法 ID 获取并格式化比分。
    - `didUpdateWidget` 方法在组件更新时重新初始化数据。
    - 在 `build` 方法中，根据 `betShow` 和 `show` 的状态决定是否展示赛事信息。
    - 使用 `InformationView` 显示赛事时间和比分。
    】】】
 *
 */
/// 赛事阶段（阶段与时间）、赛事比分
class RecordMatchSingleTogetherInfo extends StatefulWidget {
  const RecordMatchSingleTogetherInfo({
    super.key,
    required this.datadetailList,
    required this.matchInfoList,
    required this.managerCode,
  });

  final GetH5OrderListDataRecordxDataDetailList datadetailList;
  final List<GetMatchLimitInfoByMidsDataData> matchInfoList;
  final int managerCode;

  @override
  State<RecordMatchSingleTogetherInfo> createState() => _RecordMatchInfoState();
}

class _RecordMatchInfoState extends State<RecordMatchSingleTogetherInfo> {
  // 赛事阶段
  String betStage = "";

  // 赛事比分
  String betScore = "";


  // 赛事时间
  String betTime = "";
  bool betShow = false;
  bool show = false;
  bool noNeedFormat = false;
  Timer? timer;

  @override
  void initState() {
    initFromApi(widget.matchInfoList);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RecordMatchSingleTogetherInfo oldWidget) {
    // 新旧列表对比
    if (!listEquals(oldWidget.matchInfoList, widget.matchInfoList)) {
      initFromApi(widget.matchInfoList);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (betShow && show) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ///赛事时间，比赛倒计时
          InformationView(
            information: LocaleKeys.app_current_info1.tr,
            outcome:
                "$betStage ${noNeedFormat ? betTime : FormatDate.formatSecondMs(int.tryParse(betTime) ?? 0)}",
          ).marginOnly(top: 4.h, bottom: 6.h),

          ///赛事比分，比赛时的比分
          InformationView(
                  information: LocaleKeys.app_current_info2.tr,
                  outcome: betScore,
                  InformationColorType: 2)
              .marginOnly(bottom: 4.h),
        ],
      );
    }
    return Container();
  }

  /// 初始化信息(根据接口初始化信息)
  /// result 当前赛事信息数组
  void initFromApi(List<GetMatchLimitInfoByMidsDataData> result) {
    ///GetH5OrderListDataRecordxDataDetailList? itemData =
    ///    widget.data.detailList.safeFirst;
    if (MatchUtil.is1Or23Csid(widget.datadetailList,widget.managerCode)) {
      // 如果包含当前赛事ID
      final matchId = widget.datadetailList.matchId;
      final playId = widget.datadetailList.playId.toString();
      final childPlayId = widget.datadetailList.childPlayId.toString(); // 15分钟玩法子id

      final index = result.indexWhere((val) => val.mid == matchId);

      if (index > -1) {
        // 初始化信息(当前赛事信息)
        final curMatch = result[index];
        final csid = curMatch.csid;
        final mmp = curMatch.mmp;
        final mpsc = curMatch.mpsc; // [{"32":{"3203":"0:0"}},{"19":"0:0"}]
        final mst = curMatch.mst;
        final mlet = curMatch.mlet;
        final mle = curMatch.mle;
        final mess = curMatch.mess;
        // final ms = curMatch.ms;

        // 比赛阶段(mmp.csid.比赛阶段)
        betStage = 'mmp_${csid}_$mmp'.tr;

        // 比分
        if (mpsc.isNotEmpty) {
          for (final item in mpsc) {
            if (item != null && item[playId] != "" && item[playId] != null) {
              betScore = _formatBetScore(item, playId, childPlayId) ?? "";
              betScore= betScore.replaceAll(":", "-");
              break;
            } else {
              betShow = false;
            }
          }
        }

        // 比赛时间(比赛阶段, 赛事ID, 时间)
        getTimeMst(mmp, csid, mst, mlet, mle, mess);

        // 未开赛或全场结束阶段判断(0, 999)
        noStartOrEnd(mmp);
      } else {
        // 数据为空就都不显示
        show = false;
        if (timer != null) {
          timer?.cancel();
        }
      }
    }
  }

  /// 获取玩法比分
  /// 根据玩法id 赛事id 获取比分
  /// @param playId 玩法ID 1足球 2篮球
  /// @param mst   计算阶段的参数
  /// @param childPlayId 15分钟玩法
  /// @param childPlayIds 5分钟玩法
  String? _formatBetScore(
      Map<String, dynamic> item, String playId, String childPlayId) {
    if (item[playId] is String) {
      // 主玩法
      betShow = true;
      return '(${item[playId]})';
    } else if (item[playId] is Map) {
      // 子玩法
      // 15分钟玩法
      const isPlayId = [32, 33, 34, 231, 232, 233, 370, 371, 372];
      // 5分钟玩法
      const isPlayIds = [361];
      if (isPlayId.contains(playId)) {
        // 15分钟玩法匹配成功，开始计算阶段
        if (item[playId][childPlayId] != null) {
          betShow = true;
          return item[playId][childPlayId].toString();
        } else {
          betShow = false;
          return null;
        }
      }

      if (isPlayIds.contains(playId)) {
        // 5分钟玩法匹配成功，开始计算阶段
        if (item[playId][childPlayId] != null) {
          betShow = true;
          return item[playId][childPlayId].toString();
        } else {
          betShow = false;
          return null;
        }
      }
    } else {
      betShow = false;
      return null;
    }

    return null;
  }

  /// 获取赛事时间
  /// 根据阶段与赛种确定是显示、隐藏、正计时、倒计时
  void getTimeMst(
      String mmp, String csid, String mst, String mlet, int mle, int mess) {
    List<String> hiddenArr = [];

    if (csid == "1") {
      // 足球隐藏时间
      hiddenArr = [
        "31",
        "32",
        "33",
        "34",
        "50",
        "80",
        "90",
        "100",
        "110",
        "120"
      ];
    } else if (csid == "2") {
      // 篮球隐藏时间
      hiddenArr = ["31", "32", "61", "80", "90", "100", "110"];
    }

    if (hiddenArr.contains(mmp)) {
      // 隐藏时间
      timer?.cancel();
      timer = null;
      betTime = "";
    } else {
      // 显示时间
      if (["301", "302", "303"].contains(mmp)) {
        // 展示 mlet, 时间不动
        noNeedFormat = true;
        betTime = mlet;
      } else {
        // 倒计时、正计时
        noNeedFormat = false;

        // 加时要减去 90 分钟
        if (["41", "42"].contains(mmp)) {
          betTime = ((int.tryParse(mst) ?? 0) - 5400).toString();
        } else {
          betTime = mst.toString();
        }

        final step = getInplayTimerStep(csid, mmp, mle, mess);
        startTime(step, csid);
      }
    }
  }

  /// 倒计时、正计时
  void startTime(int num, csid) {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      final currentBetTime = int.tryParse(betTime) ?? 0;

      if (num < 0 && currentBetTime <= 0) {
        timer?.cancel();
        timer = null;
        if (csid == "2") {
          noNeedFormat = true;
          betTime = "00:00";
          setState(() {});
        }
        return;
      }

      betTime = (currentBetTime + num).toString();
      setState(() {});
    });
  }

  /// 未开赛或全场结束
  /// 组件展示问题
  void noStartOrEnd(String mmp) {
    if (mmp == "0" || mmp == "999") {
      // 未开赛或全场结束 隐藏组件
      timer?.cancel(); // 清除计时器
      timer = null;
      show = false; // 隐藏组件
    } else {
      // 从0或999变为其他状态的话，显示组件
      if (!show) {
        show = true; // 显示组件
      }
    }
  }

  /// 倒计时 步长
  int getInplayTimerStep(String csid, String mmp, int mle, int mess) {
    int timerStep = 0;
    int csidInt = int.tryParse(csid) ?? 0;
    int mmpInt = int.tryParse(mmp) ?? 0;
    List<int> mmps = [];

    switch (csidInt) {
      // 足球
      case 1:
        // 上半场,下半场,加时赛上半场,加时赛下半场
        mmps = [6, 7, 41, 42];
        if (mmps.contains(mmpInt)) {
          timerStep = 1;
        }
        break;

      // 篮球
      case 2:
        // 上半场,下半场,第一节,第二节,第三节,第四节,加时赛
        mmps = [1, 2, 13, 14, 15, 16, 40];

        // 篮球 3*3 的 mmp 为 21 也开始计时
        if (mle == 73) {
          mmps.add(21);
        }

        if (mmps.contains(mmpInt)) {
          timerStep = -1;
        }
        break;
    }

    // 如果赛事是暂停状态
    if (mess == 0) {
      timerStep = 0;
    }

    return timerStep;
  }
}
