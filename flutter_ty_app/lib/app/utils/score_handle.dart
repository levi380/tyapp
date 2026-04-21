import 'package:flutter_ty_app/app/utils/format_score_util.dart';
import 'package:flutter_ty_app/app/utils/format_score_util2.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:get/get.dart';
import '../services/models/res/match_entity.dart';
extension scoreHandle on FormatScore{
  /// Dota 赛事比分获取
  static List<List<String>> dotaScoreHandle(MatchEntity match) {
    List<String> mscDict = [
      'S19',
      'S20',
      'S21',
      'S22',
      'S170'
    ]; //第一局 第二局 第三局 第四局 点球比分
    FormatScore.fullMsc(match, mscDict);
    List<List<String>> mscList = [], dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      // 按照球类取出得分(除去犯规比分等)
      mscDict.asMap().forEach((dictIndex, dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            List<String> formatedMsc = FormatScore.formatMsc(fScore);
            formatedMsc = FormatScore2.footballScoreNo(match, formatedMsc);
            mscList.add(formatedMsc);
          }
        });
      });

      match.msc.forEach((fScore) {
        if (fScore.contains('S1|')) {
          List<String> fullScore = FormatScore.formatMsc(fScore);
          match.homeScore = fullScore[1];
          match.awayScore = fullScore[2];
        }
      });

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(FormatScore.formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
    // getNewerStandardEdition.value == 2 &&
    mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  /// @description: 足球比分处理
  static List<List<String>> footBallScoreHandle(MatchEntity match) {
    // 角球:S5 上半场:S2 全场比分:S1 下半场:S3 红牌:S11 黄牌:S12 点球:S10 加时:S7 点球大战:S170
    List<String> mscDict = ["S5", "S2", "S3", "S1", "S7"];
    // 110-加时结束的时候，显示：角球、半场（HT）、全场（FT）、加时比分（OT）
    // 34-等待点球大战的是，显示：角球、半场（HT）、全场（FT）、加时比分（OT）
    // 50-点球大战的时候，显示：角球、半场（HT）、全场（FT）、加时比分（OT）
    int mmp = int.parse(match.mmp);
    if ([110, 34, 50].contains(mmp)) {
      mscDict = ["S5", "S2", "S1", "S7"];
    } else if ([100, 32, 33].contains(mmp)) {
      mscDict = ["S5", "S2", "S1"];
    } else if ([0, 6].contains(mmp)) {
      //上半场 加时赛上半场
      mscDict = ["S5"];
    } else if (mmp == 31) {
      // 中场休息
      mscDict = ["S5", "S2"];
    } else if (mmp == 7) {
      // 下半场
      mscDict = ["S5", "S2"];
    } else if ([41, 42].contains(mmp)) {
      // 加时下半场
      mscDict = ["S5", "S2", "S1"];
    } else if (mmp == 50) {
      // 点球大战
      mscDict = ["S5", "S1", "S7"];
    }
    // 手球 点球大战结束
    if (match.csid == "11") {
      mscDict = ['S2', "S1"];
      if (mmp == 120) {
        mscDict = ['S2', "S1", "S7", "S170"];
      }
    }
    // 英式橄榄球
    if (match.csid == "14") {
      mscDict = ['S2', "S7", "S170", "S1"];
    }
    // 曲棍球
    if (match.csid == "15") {
      mscDict = ['S19', "S20", "S21", "S22", "S7", "S170"];
    }
    // 赛果
    // if (get_current_menu.value['main']['menuType'] == 28) {
    //   String splitedType = footBallScoreType(match);
    //   if (splitedType == "S1|") { //无点球大战无加时赛
    //     mscDict = ["S5", "S2"];
    //   }
    //   else if (splitedType == "S170|") { //有点球大战
    //     mscDict = ["S5", "S2", "S1", "S7", "S170"];
    //   }
    //   else if (splitedType == "S7|") { //有加时赛无点球大战
    //     mscDict = ["S5", "S2", "S1", "S7"];
    //   }
    // }
    FormatScore.fullMsc(match, mscDict);
    List<List<String>> result = FormatScore2.footBasketBall(match);
    if (match.mscSFormat.isNotEmpty) {
      List<List<String>> sorted = [];
      mscDict.forEach((key) {
        List<List<String>> r =
        match.mscSFormat.where((mscS) => key == mscS[0]).toList();
        if (r.isNotEmpty) {
          sorted.add(r[0]);
        }
      });
      match.mscSFormat = sorted;
    } else {
      match.mscSFormat = mscDict.map((dic) {
        String title = "msc_$dic".tr;
        return [dic, '', '', title];
      }).toList();
    }
    // match['latest_score'] = result;
    return result;
  }

  /// @description: 棒球比分处理
  static List<List<String>> baseballScoreHandle(MatchEntity match) {
    List<String> mscDict = [
      'S1', 'S3014', 'S120', 'S121', 'S122', 'S123', 'S124', 'S125',
      'S126', 'S127', 'S128', 'S129', 'S130', 'S131', 'S132', 'S133',
      'S134', 'S135', 'S136', 'S137', 'S138', 'S139', 'S140', 'S141', 'S142',
      'S143', 'S144', 'S145', 'S146'
    ];

    FormatScore.fullMsc(match, mscDict);
    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      mscDict.forEach((dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            mscList.add(FormatScore.formatMsc(fScore));
          }
        });
      });

      List<String>? mscA0;
      match.msc.forEach((fScore) {
        if (fScore.contains('S1|')) {
          mscA0 = FormatScore.formatMsc(fScore);
        }
      });

      // 获取当前比分
      if (mscA0 != null && mscA0!.isNotEmpty) {
        match.homeScore = mscA0![1];
        match.awayScore = mscA0![2];
      } else {
        match.homeScore = '0';
        match.awayScore = '0';
      }

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(FormatScore.formatMsc(dict));
    });
    match.mscSFormat = dictMscList;
    // match['latest_score'] = mscList;
    return mscList;
  }

  /// @description: 冰球比分处理
  static List<List<String>> iceHockeyScoreHandle(MatchEntity match) {
    // S170 点球大战
    List<String> mscDict = [
      'S1', 'S120', 'S121', 'S122', 'S123', 'S124', 'S7','S170'
    ]; // 全场大比分 第一局 第二局 第三局... 以此类推

    Map<String, int> scoreIndexMap = {
      "0": 1, "1": 1, "301": 2, "2": 2, "302": 3, "3": 3
    };

    int maxIndex = scoreIndexMap[match.mmp.toString()] ?? -1;

    FormatScore.fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      // 按照球类取出得分(除去犯规比分等)
      mscDict.forEach((dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            mscList.add(FormatScore.formatMsc(fScore));
          }
        });
      });
      // 赛事到达局间休息时,初始化下一局比分为0-0并显示
      int maxCount = maxIndex + 1;
      if (mscList.length < maxCount) {
        for (int i = mscList.length; i < maxCount; i++) {
          String fScore = '${mscDict[i]}|0:0';
          mscList.add(FormatScore.formatMsc(fScore));
        }
      }

      // 获取当前比分
      if (mscList.isNotEmpty) {
        List<String>? fScore = mscList[0];
        if (fScore.isNotEmpty) {
          match.homeScore = fScore[1];
          match.awayScore = fScore[2];
        }
      } else {
        match.homeScore = '0';
        match.awayScore = '0';
      }

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(FormatScore.formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
    // getNewerStandardEdition.value == 2 &&
    mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] =
      //     foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  /// @description: 美式足球比分处理
  static List<List<String>> usFootballScoreHandle(MatchEntity match) {
    List<String> mscDict = ['S19', 'S20', 'S21', 'S22']; // 第一局 第二局 第三局 第四局比分

    FormatScore.fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      // 按照球类取出得分(除去犯规比分等)
      mscDict.forEach((dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            mscList.add(FormatScore.formatMsc(fScore));
          }
        });
      });

      List<String> s1List = [];
      match.msc.forEach((score) {
        if (score.contains('S1|')) {
          s1List = score.split('S1|')[1].split(':');
        }
      });

      // 获取当前比分
      if (s1List.length > 1) {
        match.homeScore = s1List[0];
        match.awayScore = s1List[1];
      } else {
        match.homeScore = '0';
        match.awayScore = '0';
      }

      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(FormatScore.formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
    // getNewerStandardEdition.value == 2 &&
    mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 2) {
          if (msc[1] != '-' && msc[2] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] =
      //     foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }

  /// @description: 斯诺克比分处理
  static List<List<String>> snoockerScoreHandle(MatchEntity match) {
    List<String> mscArray = [];
    for (int i = 120; i <= 159; i++) {
      mscArray.add('${i}');
    }

    List<String> mscDict = mscArray.map((k) => 'S$k').toList();
    FormatScore.fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<String> s1Score = [];
    List<List<String>> dictMscList = [];
    if (match.msc.isNotEmpty) {
      List<List<String>> scoreList = [];
      match.msc.forEach((fScore) {
        if (fScore.contains('S1|')) {
          s1Score = FormatScore.formatMsc(fScore);
        } else {
          scoreList.add(FormatScore.formatMsc(fScore));
        }
      });
      scoreList.forEach((fScore) {
        String code = fScore[0];
        if (mscArray.contains(code.replaceFirst('S', ''))) {
          mscList.add(fScore);
        }
      });

      mscList.sort((a, b) {
        int aCode = 0, bCode = 0;
        try {
          aCode = int.parse(a[0].split('S')[1]);
          bCode = int.parse(b[0].split('S')[1]);
        } catch (e) {}
        return aCode - bCode;
      });

      if (s1Score.length > 2) {
        match.homeScore = s1Score[1];
        match.awayScore = s1Score[2];
      }

      if (match.homeScore == "") match.homeScore = "0";
      if (match.awayScore == "") match.awayScore = "0";
      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(FormatScore.formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    return mscList;
  }

  /// @description: 羽毛球比分处理
  static List<List<String>> badmintonScoreHandle(MatchEntity match) {
    Map<String, int> scoreIndexMap = {"8": 1, "301": 2, "9": 2, "302": 3,
      "10": 3, "303": 4, "11": 4, "304": 5, "12": 5
    };
    // Map<int, String> numberCodeMap = {
    //   1: '8',
    //   2: '9',
    //   3: '10',
    //   4: '11',
    //   5: '12',
    // };
    int maxIndex = scoreIndexMap[match.mmp.toString()] ?? 0;

    List<String> mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124'];

    //region 判断是否为七局五胜制
    bool is7 = false;
    if (match.mft == 7) {
      is7 = true;
    } else {
      if (match.mfo != null) {
        is7 = match.mfo.indexOf('7') > -1;
        if (!is7) {
          is7 = match.mfo.indexOf('七') > -1;
        }
      }
      if (!is7) is7 = match.msc.length > 7;
    }
    if (is7) {
      mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124', 'S125', 'S126'];
    }
    //endregion

    FormatScore.fullMsc(match, mscDict);

    List<List<String>> mscList = [], dictMscList = [];

    if (match.msc.isNotEmpty) {
      // 按照球类取出得分(除去犯规比分等)
      mscDict.asMap().forEach((dictIndex, dict) {
        String mscCode = '$dict|';
        match.msc.forEach((fScore) {
          if (fScore.contains(mscCode)) {
            mscList.add(FormatScore.formatMsc(fScore));
          }
        });
      });

      // 赛事到达局间休息时，初始化下一局比分为0-0并显示
      int maxCount = maxIndex + 1;
      if (mscList.length < maxCount) {
        for (int i = mscList.length; i < maxCount; i++) {
          String fScore = '${mscDict[i]}|0:0';
          mscList.add(FormatScore.formatMsc(fScore));
        }
      }

      // 如果下一局比分先到达，mmp后到达，则根据比分来确定当前局数mmp的值
      // if (foundDictIndex >= maxIndex) {
      //   match['mmp'] = int.parse(numberCodeMap[foundDictIndex]);
      // }

      //获取当前比分
      int mmpNum = int.tryParse(match.mmp.toString()) ?? 0;
      if ([301, 302, 303, 304, 305, 306].contains(mmpNum)) {
        match.homeScore = "0";
        match.awayScore = "0";
      } else {
        mscList.forEach((fScore) {
          if (fScore[0] == 'S1') {
            match.homeScore = fScore[1];
            match.awayScore = fScore[2];
          }
        });
      }
      match.mscFormat = mscList;
    }

    match.mscListDict.forEach((dict) {
      dictMscList.add(FormatScore.formatMsc(dict));
    });
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
    // getNewerStandardEdition.value == 2 &&
    mscList.length > 1) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 1) {
          if (msc[1] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1, foundValidMsc.length);
    }
    return mscList;
  }
}