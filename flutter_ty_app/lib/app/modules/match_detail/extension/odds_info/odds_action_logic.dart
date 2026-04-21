import 'package:flutter_ty_app/app/config/analytic/analytics_utils.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/controllers/match_detail_controller.dart';
import 'package:flutter_ty_app/app/services/api/match_detail_api.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/play_top_entity.dart';


import '../../../login/login_head_import.dart';
import '../../constants/detail_constant.dart';
import 'odds_filter_logic.dart';

// 定义常量
const int EXPAND_ALL = 1; // 全展开
const int COLLAPSE_ALL = 2; // 全收起
const int PARTIAL_EXPAND = 3; // 部分展开
const String SHOW_YES = "Yes";
const String SHOW_NO = "No";

/// 盘口交互操作逻辑 (折叠、置顶、更新)
extension OddsActionLogic on MatchDetailController {
  /// 一键折叠/展开
  void changeBtn() {
    String route = Get.currentRoute;
    int currentState = detailState.getFewer.value;

    // 状态切换：如果当前是展开或部分展开，则收起；否则展开
    bool isExpandOrPartial =
        currentState == EXPAND_ALL || currentState == PARTIAL_EXPAND;
    detailState.getFewer.value = isExpandOrPartial ? COLLAPSE_ALL : EXPAND_ALL;
    detailState.toggleAnimate = false;

    // 确定显示状态
    bool shouldShow = detailState.getFewer.value == EXPAND_ALL;
    String showValue = shouldShow ? SHOW_YES : SHOW_NO;

    // 更新oddsInfoList的显示状态
    for (var element in detailState.oddsInfoList) {
      element.hshow = showValue;
      String mapKey = "${element.hpid}_${element.topKey}_${element.hid}";
      detailState.hShowMap[mapKey] = showValue;
    }

    // 特殊处理增值赔率玩法集（非比赛结果页面）
    if (route != Routes.matchResultsDetails) {
      // 处理增值赔率玩法集的Map
      String specialKey =
          "${ADDED_ODDS_CATEGORY_ID}_${ADDED_ODDS_CATEGORY_ID}_${ADDED_ODDS_CATEGORY_ID}";
      detailState.hShowMap[specialKey] = showValue;

      // 查找并设置MatchHps的显示状态
      var matchHps = detailState.filterOddsInfoList.firstWhereOrNull(
              (e) => e is MatchHps && e.hpid == ADDED_ODDS_CATEGORY_ID)
          as MatchHps?;

      if (matchHps != null) {
        matchHps.hshow = showValue;
      }
    }

    // 更新UI
    update([matchOddsInfoGetBuildId]);

    // 埋点
    Analytics.track(AnalyticsEvent.btn_expand_collapse,
        pagePath: '', clickTarget: AnalyticsEvent.btn_expand_collapse.name);
  }

  /// 单个列表项折叠/展开
  void setHShow(MatchHps item) {
    detailState.toggleAnimate = true;

    if (item.hshow == SHOW_YES) {
      item.hshow = SHOW_NO;
    } else {
      item.hshow = SHOW_YES;
      // 只要手动展开了一个，状态变为 3 (部分展开)
      detailState.getFewer.value = 3;
    }

    detailState.hShowMap["${item.hpid}_${item.topKey}_${item.hid}"] =
        item.hshow;
    update(["hpid_${item.hpid}_${item.topKey}_${item.hid}"]);
  }

  /// 列表项置顶/取消置顶
  void setHton(MatchHps hps, int index) {
    detailState.topOpRequest = true;

    if (hps.hton != "0") {
      // 取消置顶
      hps.hton = '0';
      // 从过滤列表中移除（因为位置变了，稍后重新 filter 会加回来）
      // 原逻辑是 removeAt(index)，这里建议依赖 filterOddsInfo 重新排序
      if (index < detailState.filterOddsInfoList.length) {
        detailState.filterOddsInfoList.removeAt(index);
      }

      detailState.playTopList.removeWhere((item) => item.topKey == hps.topKey);
    } else {
      // 置顶：使用当前时间戳排序
      hps.hton = DateTime.now().millisecondsSinceEpoch.toString();

      // 更新或添加到置顶记录列表
      final topItemIndex = detailState.playTopList
          .indexWhere((item) => item.topKey == hps.topKey);
      if (topItemIndex > -1) {
        detailState.playTopList[topItemIndex].hton = hps.hton;
      } else {
        detailState.playTopList.add(
            PlayTopEntity.fromJson({"topKey": hps.topKey, "hton": hps.hton}));
      }
    }

    // 重新排序并刷新
    filterOddsInfo();

    // 发起 API 请求
    final status = hps.hton != "0" ? "0" : "1";
    final topKey = hps.topKey.isEmpty ? hps.hpid : hps.topKey;

    MatchDetailApi.instance()
        .setPlayTop(status, hps.hpid, detailState.mId,
            TYUserController.to.getUid(), topKey)
        .then((_) => detailState.topOpRequest = false);

    update([matchOddsInfoGetBuildId]);
  }

  /// WS推送更新足球基准分
  void updateItemScore(List<dynamic> hls) {
    for (var hl in hls) {
      final String hpid = hl['hpid'] ?? "";
      final String hps = hl['hps'] ?? "";
      final String hid = hl['hid'] ?? "";

      if (hps.isEmpty) continue;

      // 找到匹配的 hpid
      final targets =
          detailState.oddsInfoList.where((e) => e.hpid == hpid).toList();

      for (var element in targets) {
        // 15分钟进球/角球 - 让球
        if (["232", "33"].contains(element.hpid)) {
          if (hpid == element.hpid && hid == element.hid) {
            element.hps = hps;
            update(["hpid_${element.hpid}_${element.topKey}_${element.hid}"]);
          }
        }
        // 其他玩法
        else {
          // 排除特定 id 不更新? 原逻辑：flag 包含这4个，然后 if (!flag) 才更新
          // 原逻辑：bool flag = ["32", "34", "231", "233"].contains(element.hpid);
          //        if (element.hpid == hpid && !flag) ...
          final isExcluded = ["32", "34", "231", "233"].contains(element.hpid);
          if (element.hpid == hpid && !isExcluded) {
            element.hps = hps;
            update(["hpid_${element.hpid}_${element.topKey}_${element.hid}"]);
          }
        }
      }
    }
  }
}
