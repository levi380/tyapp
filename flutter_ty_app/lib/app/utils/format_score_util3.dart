import 'format_score_util.dart';
import 'dart:core';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import '../modules/match_detail/widgets/header/score/templates/score_child4.dart';
import '../services/models/res/match_entity.dart';
extension FormatScore3 on FormatScore {

  /*
    *  部分玩法比分*/

  static String formatminScore(MatchEntity? match,
      {int? index, bool isMain = false}) {
    num csid = match?.csid.toNum() ?? 0;
    String score = "";
    // 网球取S103
    if (csid == 5 && currentScore("S103", match!) != "") {
      if (isMain) {
        score = currentScore2("S103", match, index!);
      } else {
        score = formatScore(currentScore("S103", match));
      }
    }
    // 斯诺克, 乒乓球, 羽毛球, 排球, 沙滩排球 取赛事阶段范围内的最大为当前比分
    else if ([7, 8, 9, 10, 13].contains(csid)) {
      score = formatScore(currentScore(currentScoreCommon(match!), match));
    }
    // 冰球三节-局比分
    else if (csid == 4 && mmpArr1.contains(match?.mmp)) {
      score = formatScore(currentScore(currentScoreCommon(match!), match));
    }
    // 冰球+橄榄球+曲棍球 加时赛比分
    else if (['4', '14', '15'].contains(csid) &&
        ['40', '440', '41', '33', '42'].contains(match?.mmp) &&
        currentScore('S7', match!) != "") {
      score = formatScore(currentScore("S7", match));
    }
    // 冰球+橄榄球+曲棍球+水球 点球大战比分
    else if (['4', '14', '15', '16'].contains(csid) &&
        (match?.mmp == "34" || match?.mmp == "50") &&
        currentScore('S170', match!) != "") {
      score = formatScore(currentScore("S170", match));
    }
    return score;
  }

  static String currentScore(String? str, MatchEntity match) {
    String content = "";
    for (var v in match.msc) {
      List<String> splitV = v.split("|");
      if (splitV.length == 2 && splitV[0] == str) {
        content = splitV[1];
        break;
      }
    }
    return content;
  }

  static String currentScore2(String? str, MatchEntity match, int index) {
    String content = "";
    List string = [];
    for (var v in match.msc) {
      List<String> splitV = v.split("|");
      if (splitV.length == 2 && splitV[0] == str) {
        string = splitV[1].split(":");
        content = string[index];
        break;
      }
    }
    return content;
  }

  /// 比分格式设置
  static String formatScore(String res) {
    String str = "";
    if (res.contains("|")) {
      List<String> arr = res.split("|");
      str = arr[1];
    } else if (res.contains(":")) {
      str = res;
    }

    List<String> scoreParts = str.split(":");
    if (scoreParts.length == 2) {
      return '${scoreParts[0]} - ${scoreParts[1]}';
    } else {
      return '';
    }
  }

  static examineMmp(MatchEntity match) {
    // 将休息状态的发球方置空显示，不显示绿色小点;
    if (mmpArr.contains(match.mmp)) {
      match.mat = "";
    }
  }

  static String currentScoreCommon(MatchEntity match) {
    int num = 0;
    match.msc.forEach((v) {
      int current = int.parse(v.split("|")[0].substring(1));
      if (current > num && current >= 120 && current <= 159) {
        num = current;
      }
    });

    if (num != 0 && num != 1) {
      return "S$num";
    } else {
      return "";
    }
  }

  ///@description 角球 红牌 黄牌
  ///@param {Undefined}
  ///@return {Array} 角球 红牌 黄牌数
  static String footballScoreStatusArray(MatchEntity match, int index) {
    List<String> msc = List.from(match.msc);

    String scoreArr = '0';
    for (var item in msc) {
      String numIndex = item.split("|")[0];
      if (numIndex.isNotEmpty && numIndex == 'S11') {
        String score = item.split("|")[1];
        scoreArr = score.split(':')[index];
        break;
      }
    }
    return scoreArr;
  }

  // 点球大战 判断第几个进球 1主队  2客队 -1未知
  // 点球大战  点球大战轮数增加到24轮   范围（S1701-S1724）
  // 用到的 S1711 S1712 比分key， 替换成 S17101  S17102 (S1711 S1712, 目前在赛事分析使用)
  static String isShootout(MatchEntity match, int num, String type) {
    final msc = match.mscMap;
    if (msc.isEmpty) return "-1";
    if (num <= 0) return "-1";
    if (num > 24) return "-2"; // 最大 24 轮

    // 构建 key
    String key;
    if (num == 11) {
      key = "S17101"; // 替换 S1711
    } else if (num == 12) {
      key = "S17102"; // 替换 S1712
    } else {
      // 第3-24轮，使用两位数的轮次编号
      final idx = num.toString().padLeft(2, '0'); // "03" "04" ... "24"
      key = "S17$idx";
    }

    // AppLogger.debug("num=$num, key=$key");

    List<String> obj = msc[key] ?? [];

    if (obj.isEmpty) {
      return "-1";
    }

    final home = obj.first;
    final away = obj.length > 1 ? obj.last : "-1";

    return type == "mhn" ? home : away;
  }

  // 详情比分
  static int formatDetailScore(MatchEntity? match, int num,
      {String? key, String? playId}) {
    if (match == null) {
      return 0;
    }
    try {
      if (!(match.msc.isNotEmpty)) return 0;

      Map<String, List<String>> mscMap = {};
      match.msc.forEach((item) {
        List<String> splitItem = item.split("|");
        if (splitItem.length == 2) {
          mscMap[splitItem[0]] = splitItem[1].split(":");
        }
      });

      List<String>? score_;
      if (match.csid == "1" || match.csid == "11") {
        // 足球和手球
        switch (match.mmp) {
        // ///角球
        // case "6":
        //   // S555
        //   score_ = mscMap["S5"];
        //   break;
        //  41 加时赛上半场  33 加时休息  42 加时下半场 110 加时赛结束
          case "41":
          case "33":
          case "42":
          case "110":
            score_ = mscMap["S7"];

            break;
        // 50 点球大战  120 点球大战结束
          case "50":
          case "120":
            score_ = mscMap["S170"];
            break;
        // 即将加时和等待点球的阶段固定取0
          case "32":
          case "34":
            score_ = ["0", "0"];

            break;
        // 全场结束,取点球大战比分，加时赛比分或者全场比分
          case "999":
            score_ = mscMap["S170"] ?? mscMap["S7"] ?? mscMap["S1"];
            if (key != null && key.contains("S") && mscMap.containsKey(key)) {
              score_ = mscMap[key];
            }

            break;
          default:
            score_ = mscMap["S1"];
            break;
        }
      }
      // 板球
      else if (match.csid == "37") {
        if (mscMap.containsKey('S372')) {
          score_ = mscMap["S372"];
        } else {
          score_ = mscMap["S371"];
        }
      } else {
        score_ = mscMap["S1"];
      }
      if (score_ != null && score_.length > num) {
        return score_[num].toInt();
      } else {
        return 0;
      }
    } catch (error) {
      return 0;
    }
  }
}