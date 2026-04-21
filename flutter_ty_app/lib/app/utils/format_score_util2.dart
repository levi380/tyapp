import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/sport.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../services/models/res/match_entity.dart';
import 'format_score_util.dart';

extension FormatScore2 on FormatScore {
  /// @description: 网球比分处理
  /// @param {Map<String, dynamic>} match 赛事对象
  static List<List<String>> tennisScoreHandle(MatchEntity match) {
    List<String> mscDict = ['S1', 'S23', 'S39', 'S55']; //全场大比分 第一盘 第二盘 第三盘比分
    FormatScore.fullMsc(match, mscDict);
    List<List<String>> mscList = [], dictMscList = [];
    String currentScoreSplit = 'S1|';
    if (match.msc.isNotEmpty) {
      match.msc.forEach((fScore) {
        if (fScore.contains(currentScoreSplit)) {
          List<String> score2 = fScore.split(currentScoreSplit)[1].split(':');
          match.homeScore = score2[0];
          match.awayScore = score2[1];
        } else {
          String code = fScore.split('|')[0];
          if (['S23', 'S39', 'S55', 'S71', 'S87'].contains(code)) {
            mscList.add(FormatScore.formatMsc(fScore));
          }
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
      if (match.homeScore == "") match.homeScore = "0";
      if (match.awayScore == "") match.awayScore = "0";
      match.mscFormat = mscList;
    }
    if (match.mscListDict.isNotEmpty) {
      match.mscListDict.forEach((dict) {
        dictMscList.add(FormatScore.formatMsc(dict));
      });
    }
    match.mscSFormat = dictMscList;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        mscList.isNotEmpty) {
      List<List<String>> foundValidMsc = [];
      mscList.forEach((msc) {
        if (msc.length > 1) {
          if (msc[1] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1);
    }
    return mscList;
  }

  /// @description: 篮球比分处理
  /// @param {Object} match 赛事对象
  /// @return {List<List<String>>}
  static List<List<String>> basketBallScoreHandle(MatchEntity match) {
    // 全场比分/1/2/上半场/3/4/下半场;
    List<String> mscDict = ["S1", "S2", "S3"];
    // 标准四节比分S2 = S19 + S20  S3 = S21 + S22
    // S2/S3 上下半场
    bool isFourSections = false; //按四节返回比分
    if (match.msc.isNotEmpty) {
      match.msc.forEach((msxD) {
        if (msxD.contains('S19|') ||
            msxD.contains('S20|') ||
            msxD.contains('S21|') ||
            msxD.contains('S22|')) {
          isFourSections = true;
        }
      });
    }
    if (isFourSections) {
      mscDict = ["S19", "S20", "S21", "S22", "S7"];
    } else {
      mscDict = ["S2", "S3", "S7"];
    }
    //中场休息
    if (match.mmp == "31") {
      mscDict = ["S2"];
    }
    if (match.mle == 73) {
      mscDict = ["S1", "S2", "S3"];
    }
    FormatScore.fullMsc(match, mscDict);
    List<List<String>> result = footBasketBall(match); // 篮球足球比分处理
    if (match.mscSFormat.length > 2) {
      List<List<String>> sorted = [];
      mscDict.forEach((key) {
        List<String>? r = match.mscSFormat.firstWhereOrNull(
          (mscS) => mscS.isNotEmpty && mscS[0] == key,
        );
        r ??= [key, '', '', ''];
        sorted.add(r);
      });
      match.mscSFormat = sorted;
    } else {
      match.mscSFormat = mscDict.map((dic) {
        String title = 'msc_$dic'.tr;
        return [dic, '', '', title];
      }).toList();
    }
    match.mscFormat = match.mscSFormat;

    // 标准版只显示当前局比分
    if (
        // getNewerStandardEdition.value == 2 &&
        result.length > 1) {
      List<List<String>> foundValidMsc = [];
      result.forEach((msc) {
        if (msc.length > 1) {
          if (msc[1] != '-') {
            foundValidMsc.add(msc);
          }
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1);
    }

    // O01 电子篮球 只显示当前节比分  mmp  "13": "第一节", "14": "第二节", "15": "第三节", "16": "第四节",
    if (match.csid == "2" && match.cds == 'O01') {
      final mmpConfig = {"13": 1, "14": 2, "15": 3, "16": 4};
      final length = mmpConfig[match.mmp.toString()] ?? 0;
      if (length == 0) return [];
      result = List<List<String>>.from(result).sublist(0, length);
    }

    return result;
  }

  /// @description: 足球篮球
  /// @param {Map<String, dynamic>} match
  /// @return {List<List<String>>}
  static List<List<String>> footBasketBall(MatchEntity match) {
    if (match.msc.isNotEmpty) {
      //常规赛全场(S1)比分
      String split = 'S1|';
      int mmp = int.parse(match.mmp);
      if ([41, 32, 33, 42, 110].contains(mmp)) {
        split = 'S7|';
      } else if ([34, 50, 120].contains(mmp)) {
        split = 'S170|';
      }
      // if (match['csid'] == 1 || match['csid'] == 11) {
      //   if (footerSubMenuId.value == 114) { // 角球玩法
      //     split = 'S5|';
      //   }
      //   if (getCurrentMenu.value['main']['menuType'] == 28) { //赛果只显示S1 单号8410
      //     split = 'S1|';
      //   }
      // }
      bool foundFullScore = false;
      match.msc.forEach((fScore) {
        if (fScore.contains(split)) {
          List<String> sliced = FormatScore.formatMsc(fScore);
          match.homeScore = sliced[1];
          match.awayScore = sliced[2];
          foundFullScore = true;
        }
      });
      if (!foundFullScore) {
        match.homeScore = '0';
        match.awayScore = '0';
      }
    }

    List<List<String>> mscListDict = [];
    if (match.mscListDict.isNotEmpty) {
      match.mscListDict.forEach((fScore) {
        List<String> formattedMsc = FormatScore.formatMsc(fScore);
        formattedMsc = footballScoreNo(match, formattedMsc);
        mscListDict.add(formattedMsc);
      });
      match.mscSFormat = mscListDict;
    }
    match.mscFormat = mscListDict;
    return mscListDict;
  }

  /// 附加足球比分编号
  /// @param {Map<String, dynamic>} match 赛事对象
  /// @param {List<String>} list_ 比分列表
  /// @return {List<String>}
  static List<String> footballScoreNo(MatchEntity match, List<String> list_) {
    if ([SportData.sportCsid_1, SportData.sportCsid_11, SportData.sportCsid_14, SportData.sportCsid_15, SportData.sportCsid_16].contains(int.parse(match.csid))) {
      // 角球
      if (list_[0] == 'S5') {
        list_.add('KK');
      }
      // 上半场进球数
      else if (list_[0] == 'S2') {
        list_.add('HT');
      }
      //上下半场总进球数
      else if (list_[0] == 'S1') {
        list_.add('FT');
      }
      //加时赛比分
      else if (list_[0] == 'S7') {
        list_.add('OT');
      }
      //点球大战比分
      else if (list_[0] == 'S170') {
        list_.add('PEN');
      }
    }
    return list_;
  }

  /// @description: 排球比分处理
  /// @param {Map<String, dynamic>} match 赛事对象
  static List<List<String>> volleyballScoreHandle(MatchEntity match) {
    List<String> mscDict = [
      'S1',
      'S120',
      'S121',
      'S122',
      'S123',
      'S124'
    ]; // 全场大比分 第一局 第二局 第三局比分

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

      // 获取当前比分
      mscList.forEach((fScore) {
        if (fScore[0] == 'S1') {
          match.homeScore = fScore[1];
          match.awayScore = fScore[2];
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
        if (msc.length > 1 && msc[1] != '-') {
          foundValidMsc.add(msc);
        }
      });
      // match['latest_score'] = foundValidMsc.sublist(foundValidMsc.length - 1);
    }
    return mscList;
  }

  /// @description: 乒乓球比分处理
  /// @param {Object} match 赛事对象
  static List<List<String>> pingpongScoreHandle(MatchEntity match) {
    Map<String, int> scoreIndexMap = {
      "8": 1,
      "301": 2,
      "9": 2,
      "302": 3,
      "10": 3,
      "303": 4,
      "11": 4,
      "304": 5,
      "12": 5,
      "305": 6,
      "441": 6,
      "306": 7,
      "442": 7,
    };

    int maxIndex = scoreIndexMap[int.tryParse(match.mmp)] ?? 0;

    List<String> mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124'];

    // 判断是否为七局五胜制
    bool is7 = false;
    if (match.mft == 7) {
      is7 = true;
    } else {
      if (match.mfo != null) {
        is7 = match.mfo.toString().contains('7') ||
            match.mfo.toString().contains('七');
      }
      if (!is7) is7 = match.msc.length > 7;
    }

    if (is7) {
      mscDict = ['S1', 'S120', 'S121', 'S122', 'S123', 'S124', 'S125', 'S126'];
    }

    FormatScore.fullMsc(match, mscDict);

    List<List<String>> mscList = [];
    List<List<String>> dictMscList = [];

    // 按从小到大顺序获取比分序列
    if (match.msc.isNotEmpty) {
      // 按照球类取出得分(出去犯规比分等)
      mscDict.asMap().forEach((dictIndex, dict) {
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
          if (mscDict[i] != "") {
            String fScore = '${mscDict[i]}|0:0';
            mscList.add(FormatScore.formatMsc(fScore));
          }
        }
      }

      // 如果下一局比分先到达,mmp后到达,则根据比分来确定当前局数mmp的值
      // if (foundDictIndex >= maxIndex && numberCodeMap.containsKey(foundDictIndex)) {
      //   match.mmp = numberCodeMap[foundDictIndex]!;
      // }

      mscList.forEach((fScore) {
        if (fScore[0] == 'S1') {
          match.homeScore = fScore[1];
          match.awayScore = fScore[2];
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

  //板球比分获取
  static List<List<String>> dotaScoreHandle2(MatchEntity match) {
    // 定义出局数和比分的字典
    final List<String> mscDict1 = ['S373', 'S374']; // 出局数
    final List<String> mscDict = ['S371', 'S372']; // 比分
    // 获取出局数和比分
    List<List<String>> mscList2 =
        _getMscList(match, mscDict1, FormatScore.formatMsc2);
    List<List<String>> mscList =
        _getMscList(match, mscDict, FormatScore.formatMsc);

    // 更新 mscList 的值
    if (mscList.isNotEmpty && mscList2.isNotEmpty) {
      _updateMscList(mscList, mscList2, match);
    }

    return mscList; // 返回更新后的 mscList
  }

// 获取 msc 列表的辅助方法
  static List<List<String>> _getMscList(
      MatchEntity match, List<String> mscDict, Function formatFunction) {
    FormatScore.fullMsc(match, mscDict);
    List<List<String>> mscList = [];

    for (String dict in mscDict) {
      String mscCode = '$dict|';
      match.msc.forEach((fScore) {
        if (fScore.contains(mscCode)) {
          mscList.add(formatFunction(fScore));
        }
      });
    }

    return mscList;
  }

// 更新 mscList 的辅助方法
  static void _updateMscList(List<List<String>> mscList,
      List<List<String>> mscList2, MatchEntity match) {
    for (int i = 0; i < 2; i++) {
      if (mscList.length > i &&
          mscList[i].length > 2 &&
          mscList2.length > i &&
          mscList2[i].length > 2) {
        mscList[i][1] =
            '${mscList[i][1]}${int.parse(mscList2[i][1]) >= 10 && (match.mmp == '8' || i == 1) ? LocaleKeys.common_all_out.tr : "/${mscList2[i][1]}"}'; // 下标为1的连接值
        mscList[i][2] =
            '${mscList[i][2]}${int.parse(mscList2[i][2]) >= 10 && (match.mmp == '8' || i == 1) ? LocaleKeys.common_all_out.tr : "/${mscList2[i][2]}"}'; // 下标为2的连接值
      }
    }
  }

}
