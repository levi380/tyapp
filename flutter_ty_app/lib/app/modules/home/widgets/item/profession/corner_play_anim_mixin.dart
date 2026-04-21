import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import '../../../../../utils/hintLanguage.dart';
import '../../../../../utils/sport.dart';

/// 负责处理 CornerPlayTemp 中的进球、红牌、伤停补时动画逻辑
mixin CornerPlayAnimMixin<T extends StatefulWidget> on State<T> {
  // 状态变量
  bool isShowMststi = false;
  bool isShowHomeRed = false;
  bool isShowAwayRed = false;
  bool isShowHomeGoal = false;
  bool isShowAwayGoal = false;
  bool showHomeVar = false;
  bool showWayVar = false;
  String hit = "";

  // 比分和红牌数值变化时的时间记录
  Map<String, int> scoreTime = {"S1": 0, "S11": 0};

  /// 重置所有事件动画状态
  void resetEvent() {
    isShowHomeGoal = false;
    isShowAwayGoal = false;
    isShowHomeRed = false;
    isShowAwayRed = false;
    isShowMststi = false;
  }

  /// 提取S11比分辅助方法
  Map<String, dynamic> _s11Score(MatchEntity match) {
    Map<String, dynamic> score = {'home': 0, 'away': 0};
    for (String item in match.msc) {
      if (item.split("|")[0] == "S11") {
        List<String> scoreValues = item.split("|")[1].split(":");
        score = {
          'home': scoreValues.isNotEmpty ? scoreValues[0].toInt() : 0,
          'away': scoreValues.length > 1 ? scoreValues[1].toInt() : 0,
        };
        break;
      }
    }
    return score;
  }

  /// 处理进球动画 (来自 WebSocket 消息)
  void handleGoalAnimation(Map<String, dynamic> wsObj, String oldmid) {
    String eventTime = wsObj["eventTime"] ?? "";
    String mid = wsObj["mid"] ?? "";
    String homeAway = wsObj["homeAway"] ?? "";

    if (eventTime.isNotEmpty &&
        mid.isNotEmpty &&
        homeAway.isNotEmpty &&
        oldmid == mid) {
      // 检查时间是否有效 (20秒内)
      if (DateTime.now().millisecondsSinceEpoch <
          NumUtil.add(eventTime.toNum(), 20000).toInt()) {
        resetEvent();
        if (mounted) {
          setState(() {
            if (homeAway == "home") {
              isShowHomeGoal = true;
            } else {
              isShowAwayGoal = true;
            }
          });
        }
        5.seconds.delay(() {
          if (mounted) {
            setState(() {
              if (homeAway == "home") isShowHomeGoal = false;
              else isShowAwayGoal = false;
            });
          }
        });
      } else {
        if (mounted) {
          setState(() {
            isShowHomeGoal = false;
            isShowAwayGoal = false;
          });
        }
      }
    }
  }

  /// 处理红牌动画
  void handleRedAnimation(MatchEntity oldmatch, MatchEntity match) {
    if (match.mid == oldmatch.mid &&
        int.parse(match.csid) == SportData.sportCsid_1) {
      Map<String, dynamic> newS11Score = _s11Score(match);
      Map<String, dynamic> oldS11Score = _s11Score(oldmatch);

      if (newS11Score["home"] != oldS11Score['home'] ||
          newS11Score["away"] != oldS11Score['away']) {

        if (newS11Score["home"] > 0 || newS11Score["away"] > 0) {
          scoreTime["S11"] = DateTime.now().millisecondsSinceEpoch;
        }

        bool updateNeeded = false;
        // 主队红牌
        if (newS11Score["home"] > 0 &&
            newS11Score["home"] >= newS11Score['away']) {
          isShowHomeRed = !isShowHomeGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          updateNeeded = true;
        } else {
          isShowHomeRed = false;
        }

        // 客队红牌
        if (newS11Score["away"] > 0 &&
            newS11Score["away"] >= newS11Score['home']) {
          isShowAwayRed = !isShowAwayGoal &&
              (scoreTime["S11"] ?? 0) > (scoreTime["S1"] ?? 0);
          updateNeeded = true;
        } else {
          isShowAwayRed = false;
        }

        if (updateNeeded && mounted) {
          setState(() {}); // 触发更新
          5.seconds.delay(() {
            if (mounted) {
              setState(() {
                isShowHomeRed = false;
                isShowAwayRed = false;
              });
            }
          });
        }
      }
    }
  }

  /// 处理伤停补时/提示语动画
  void handleHitAnimation(MatchEntity oldmatch, MatchEntity match, String language) {
    if (oldmatch.mid == match.mid &&
        ObjectUtil.isNotEmpty(match.cmec) &&
        match.cmec != oldmatch.cmec) {
      hit = "";
      for (var e in ConfigController.to.EventInfoList) {
        if (match.cmec == e.nameCode) {
          hit = HintLanguage.gethint(language, e);
          break;
        }
      }

      if (ObjectUtil.isNotEmpty(hit)) {
        isShowMststi = false;
        scoreTime["S1"] = DateTime.now().millisecondsSinceEpoch;
        isShowMststi = (scoreTime["S1"] ?? 0) > (scoreTime["S11"] ?? 0);
        if (mounted) setState(() {});

        8.seconds.delay(() {
          if (mounted) {
            setState(() {
              hit = "";
              isShowMststi = false;
            });
          }
        });
      } else {
        hit = "";
        isShowMststi = false;
        if (mounted) setState(() {});
      }
    }
  }
}