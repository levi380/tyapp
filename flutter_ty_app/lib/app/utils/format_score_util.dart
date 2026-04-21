import 'dart:core';

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/utils/score_handle.dart';

import '../modules/login/login_head_import.dart';

import '../services/models/res/match_entity.dart';
import 'format_score_util2.dart';

/// format-msc.js 文件
/// 分数格式化
class FormatScore {
  ///@description 根据不同赛事阶段取不同的比分
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  ///@param {String} key 比赛结束显示指定比分
  ///@return {Number} 主队或客队得分
  ///
  ///角球 1001
  static int formatTotalScore(MatchEntity? match, int num,
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
      } else {
        // 第一局比分s371 s372第二局比分
        if (match.csid == "37" && match.mmp == "9") {
          //显示两局总比分
          List<String>? score = [];
          score.add((mscMap["S371"]![0].toNum() + mscMap["S372"]![0].toNum())
              .toString());
          score.add((mscMap["S371"]![1].toNum() + mscMap["S372"]![1].toNum())
              .toString());
          score_ = score;
        } else if (match.csid == "37" && match.mmp == "8") {
          //第一局
          score_ = mscMap["S371"];
        } else {
          score_ = mscMap["S1"];
        }
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

  ///@description 根据不同赛事阶段取不同的比分
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  ///@param {String} key 比赛结束显示指定比分
  ///@return {Number} 主队或客队得分
  ///
  ///角球 1001

  static String formatTotalScoreSpecial(MatchEntity? match, int num,
      {String? key, String? playId}) {
    if (match == null) {
      return 0.toString();
    }
    try {
      if (!(match.msc.isNotEmpty)) return 0.toString();
      Map<String, List<String>> mscMap = {};
      match.msc.forEach((item) {
        List<String> splitItem = item.split("|");
        if (splitItem.length == 2) {
          mscMap[splitItem[0]] = splitItem[1].split(":");
        }
      });

      List<String>? score_ = [];
      // 足球和手球
      mscMap['S1']?.asMap().forEach((index,item){
        var newItem = item + "(${mscMap['S7']![index]})";
        score_.add(newItem);
      });

      if ( score_.length > num) {
        return score_[num];
      } else {
        return 0.toString();
      }
    } catch (error) {
      return 0.toString();
    }
  }

  ///@description 新增加时赛单独展示比分（加时赛比分在前，常规赛比分在后）
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  ///@param {String} key 比赛结束显示指定比分
  ///@return {Number} 主队或客队得分
  ///
  ///角球 1001
  static String formatTotalScoreOvertime(MatchEntity? match, int num,
      {String? key, String? playId}) {
    if (match == null) {
      return 0.toString();
    }
    try {
      if (!(match.msc.isNotEmpty)) return 0.toString();
      Map<String, List<String>> mscMap = {};
      match.msc.forEach((item) {
        List<String> splitItem = item.split("|");
        if (splitItem.length == 2) {
          mscMap[splitItem[0]] = splitItem[1].split(":");
        }
      });
      /// S7为加时赛比分 没有的时候取 【0，0】
      /// S1为常规赛比分 同样没有的时候用【0，0】

      List<String>? score_ = [];

      var overtimeMap = mscMap['S7'] ?? ['0','0'];
      var originalMap = mscMap['S1'] ?? ['0','0'];
      // 足球和手球
      // if (match.mhn == '鬼神童子'){
      //   print('比分');
      //   print('S0- ${mscMap['S0']}');
      //   print('S170- ${mscMap['S170']}');
      //   print('S7- ${mscMap['S7']}');
      //   print('S1- ${mscMap['S1']}');
      // }

      overtimeMap.asMap().forEach((index,item){
        var newItem = overtimeMap[index] + "(${originalMap[index]})";
        score_.add(newItem);
      });
      print(score_);
      if ( score_.length > num) {
        return score_[num];
      } else {
        return 0.toString();
      }
    } catch (error) {
      return 0.toString();
    }
  }

  ///@description 新增点球大战单独展示比分（加时赛比分在前，常规赛比分在后）
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  ///@param {String} key 比赛结束显示指定比分
  ///@return {Number} 主队或客队得分
  ///
  ///角球 1001
  static String formatTotalScorePenalty(MatchEntity? match, int num,
      {String? key, String? playId}) {
    if (match == null) {
      return 0.toString();
    }
    try {
      if (!(match.msc.isNotEmpty)) return 0.toString();
      Map<String, List<String>> mscMap = {};
      match.msc.forEach((item) {
        List<String> splitItem = item.split("|");
        if (splitItem.length == 2) {
          mscMap[splitItem[0]] = splitItem[1].split(":");
        }
      });

      /// S0为总比分
      /// S170为点球大战比分，（常规赛+加时赛）比分没有给出，此处用 S0-S170计算得出
      List<String>? score_ = [];

      var overtimeMap = mscMap['S170'] ?? ['0','0'];
      var originalMap = mscMap['S0'] ?? ['0','0'];
      if (match.mmp == '50') {
        List<String> newArr = [];
        mscMap['S0']?.asMap().forEach((index, item){
          var newValue = item.toInt() - mscMap['S170']![index].toInt();
          newArr.add(newValue.toString());
        });
        originalMap = newArr;
      }
      // 足球和手球
      // if (match.mhn == '鬼神童子'){
      //   print('比分');
      //   print(mscMap);
      //   print(mscMap['S170']);
      //   print(mscMap['S7']);
      //   print('S1- ${mscMap['S1']}');
      // }

      overtimeMap.asMap().forEach((index,item){
        var newItem = overtimeMap[index] + "(${originalMap[index]})";
        score_.add(newItem);
      });
      print(score_);
      if ( score_.length > num) {
        return score_[num];
      } else {
        return 0.toString();
      }
    } catch (error) {
      return 0.toString();
    }
  }

  ///@description 获取板球37队伍出局数
  ///@param {Object} match 赛事数据对象
  ///@param {Number} num 0-主队  1-客队
  static int cricketOutScore(
    MatchEntity? match,
    int num,
  ) {
    if (match == null) {
      return 0;
    }
    if (!(match.msc.isNotEmpty)) return 0;
    try {
      Map<String, List<String>> mscMap = {};
      match.msc.forEach((item) {
        List<String> splitItem = item.split("|");
        if (splitItem.length == 2) {
          mscMap[splitItem[0]] = splitItem[1].split(":");
        }
      });
      List<String>? score_;
      //板球联赛 s373第一句出局数 s374第二局出局数
      if (match.csid == "37" && match.mmp == "8") {
        score_ = mscMap["S373"];
      } else if (match.csid == "37" && match.mmp == "9") {
        //第二句出局数
        score_ = mscMap["S374"];
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

  // 将形如 1:2 的比分字符串转换为 1-2 的格式
  static String scoreFormat(String str) {
    return str.replaceAll(':', '-');
  }

  /// @description: 在match对象上添加  msc_list_dict 数组字段
  /// @param {Map<String, dynamic>} match
  /// @param {List<String>} mscDict
  /// @return {Undefined}
  static fullMsc(MatchEntity match, List<String> mscDict) {
    match.mscListDict = [];
    mscDict.forEach((mscD) {
      String found = "";
      match.msc.forEach((mMsc) {
        if (mMsc.contains('$mscD|')) {
          found = mMsc;
        }
      });
      if (found != "") {
        match.mscListDict.add(found);
      } else {
        match.mscListDict.add('$mscD|-:-');
      }
    });
  }

  /**
   * @description: 格式化比分数据
   * @param {String} str
   * @return {List<String>}
   */
  static List<String> formatMsc(String str) {
    if (str.isEmpty) {
      return [];
    }
    List<String> list_ = str.split(RegExp(r'[:|]'));
    for (int i = 0, l = 3 - list_.length; i < l; i++) {
      list_.add('');
    }
    list_.add('msc_${list_[0]}'.tr);

    return list_;
  }

  /**
   * @description: 格式化比分数据
   * @param {String} str
   * @return {List<String>}
   */
  static List<String> formatMsc2(String str) {
    if (str.isEmpty) {
      return [];
    }
    List<String> list_ = str.split(RegExp(r'[:|]'));
    for (int i = 0, l = 3 - list_.length; i < l; i++) {
      list_.add('');
    }
    return list_;
  }

  /// @description: 比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> scoreSwitchHandle(MatchEntity match) {
    int currentSportId = int.tryParse(match.csid) ?? 0;
    if (match.msc.isEmpty) return [];
    //红牌数
    getPunishScore(match);
    List<List<String>> res = [];
    switch (currentSportId) {
      case 5:
        res = FormatScore2.tennisScoreHandle(match);
        break;
      case 10:
        res = scoreHandle.badmintonScoreHandle(match);
        break;
      case 8:
        res = FormatScore2.pingpongScoreHandle(match);
        break;
      case 7: //斯诺克
        res = scoreHandle.snoockerScoreHandle(match);
        break;
      case 2:
        res = FormatScore2.basketBallScoreHandle(match);
        break;
      case 1:
        res = scoreHandle.footBallScoreHandle(match);
        break;
      // 3、4、6、9棒冰美排
      case 3:
        res = scoreHandle.baseballScoreHandle(match);
        break;
      case 4:
        res = scoreHandle.iceHockeyScoreHandle(match);
        break;
      case 6:
        res = scoreHandle.usFootballScoreHandle(match);
        break;
      case 9:
        res = FormatScore2.volleyballScoreHandle(match);
        break;
      case 11:
        res = scoreHandle.footBallScoreHandle(match);
        break;
      case 12: //拳击
        res = scoreHandle.snoockerScoreHandle(match);
        break;
      case 13:
        res = FormatScore2.volleyballScoreHandle(match);
        break;
      case 14: //英式橄榄球
        res = scoreHandle.footBallScoreHandle(match);
        break;
      case 15: //曲棍球
        // res = hockeyScoreHandle(match);
        break;
      case 16: //水球
      // res = waterPoloScoreHandle(match);
      case 37: //板球
        res = FormatScore2.dotaScoreHandle2(match);
      case 101: //dota比分获取
      case 100: //lol比分获取
      case 102: //Cs go比分获取
      case 103: //王者荣耀比分获取
      case 105: //无畏契约比分获取
        res = scoreHandle.dotaScoreHandle(match);
        break;
    }
    return res;
  }

  /// @description: 获取红牌数
  /// @param {Object} match
  static getPunishScore(MatchEntity match) {
    if (match.msc.isEmpty) return;
    match.msc.forEach((fScore) {
      //红牌
      if (fScore.contains('S11|')) {
        List<String> score2 = fScore.split('S11|')[1].split(':');
        match.homeRedScore = int.parse(score2[0]);
        match.awayRedScore = int.parse(score2[1]);
      }
      //黄牌
      if (fScore.contains('S12|')) {
        List<String> score2 = fScore.split('S12|')[1].split(':');
        match.homeYellowScore = int.parse(score2[0]);
        match.awayYellowScore = int.parse(score2[1]);
      }
    });
  }

}
