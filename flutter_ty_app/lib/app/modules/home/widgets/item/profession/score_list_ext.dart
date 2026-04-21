

import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/widgets/header/score/templates/score_child3.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../login/login_head_import.dart';
import '../../../../match_detail/widgets/header/score/templates/score_child4.dart';

mixin ScoreListState {

  ///当前最新的盘/局比分
  String lastListScore = '';

  ///比分转换为数组的数据
  List<List<String>> mscConverted = [];

  bool showLeftTriangle = false;
  bool showRightTriangle = false;

  /// 右侧附加信息区域
  Widget buildExtraInfoArea(bool isCricket,bool isBaseball,MatchEntity match) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// 板球
        if (isCricket)
          _buildCricketTotalScore(match),

        /// 棒球
        if (isBaseball)
          _buildBaseballInfo(match),
      ],
    );
  }

  /// ----------------------
  /// 板球总分
  /// ----------------------
  Widget _buildCricketTotalScore(MatchEntity match) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${match.mfo} | ${LocaleKeys.list_total_pp_score_count.tr}",
          style: TextStyle(
            fontSize: 10.sp,
            color: Get.isDarkMode
                ? const Color.fromRGBO(175, 179, 200, 1)
                : const Color.fromRGBO(0, 0, 0, 0.8),
          ),
        ).marginOnly(left: 10.w),
      ],
    );
  }


  /// 棒球制式信息
  Widget _buildBaseballInfo(MatchEntity match) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 12.w,
          height: 12.w,
          child: CustomPaint(
            painter: BaseballDiamondPainter(
              mbolp: match.mbolp == "1",
              mbthlp: match.mbthlp == "1",
              mbtlp: match.mbtlp == "1",
              mbColor: const Color.fromRGBO(18, 125, 204, 1),
              normalColor: const Color.fromRGBO(201, 205, 219, 0.8),
            ),
          ),
        ).marginOnly(right: 8.w),
        Text(
          "${LocaleKeys.match_info_strike_out.tr} ${match.mbcn}",
          style: TextStyle(
              color: Get.isDarkMode
                  ? const Color.fromRGBO(255, 255, 255, 0.3)
                  : const Color.fromRGBO(175, 179, 200, 1),
              fontSize: 12.sp),
        ),
      ],
    ).marginOnly(left: 8.w);
  }
  /// 通用样式
  Widget scoreTipIcon() {
    return ImageView(
      'assets/images/score_tip.svg',
      width: 10.w,
      height: 10.w,
      svgColor: Get.isDarkMode
          ? Colors.white.withValues(alpha: 0.5)
          : const Color(0xFF787E9E),
    );
  }

  TextStyle quarterScoreStyle(int i) {
    return TextStyle(
      color: (i == mscConverted.length - 1)
          ? const Color.fromRGBO(23, 156, 255, 1)
          : Get.isDarkMode
          ? const Color.fromRGBO(175, 179, 200, 1)
          : const Color.fromRGBO(0, 0, 0, 0.8),
      fontSize: 10.sp,
    );
  }

  TextStyle normalScoreStyle() {
    return TextStyle(
      color: Get.isDarkMode
          ? const Color.fromRGBO(175, 179, 200, 1)
          : const Color.fromRGBO(0, 0, 0, 0.8),
      fontSize: 10.sp,
    );
  }


  /// 判断单个比分是否显示
  /// @param match 赛事对象
  /// @param score 比分数组
  /// @return bool
  bool isShowScore(MatchEntity match, List<String> score) {
    bool f = false;
    if (score.isNotEmpty) {
      /// 赛事屏蔽角球总比分S5,黄牌比分S12,红牌比分S11,点球比分S10
      if (match.cds == 'RC' &&
          match.csid == "1" &&
          ['S5', 'S10', 'S11', 'S12'].contains(score[0])) {
        return f;
      }
      if (score.length > 2 && score[1] != '-' && score[2] != '-') {
        if (SportData.getSportsCsid([
          SportData.sportCsid_1,
          SportData.sportCsid_11,
          SportData.sportCsid_14,
          SportData.sportCsid_15,
          SportData.sportCsid_16
        ])!
            .contains(int.tryParse(match.csid))) {
          f = true;
        }
        if ((match.csid != SportData.sportCsid_1.toString() ||
            match.csid != SportData.sportCsid_11.toString()) &&
            score[0] != 'S1') {
          f = true;
        }
      }
    }

    return f;
  }

  /// @description: 获取最新比分赋值给last_list_score
  getLastListScore(MatchEntity match) {
    List<List<String>> mscConverted = getMscConverted(match);
    int i = mscConverted.length - 1;
    int h = 0, a = 0;
    try {
      if (mscConverted[i][1] != "-") {
        h = int.tryParse(mscConverted[i][1].toString()) ?? 0;
      }
      if (mscConverted[i][2] != "-") {
        a = int.tryParse(mscConverted[i][2].toString()) ?? 0;
      }
    } catch (e) {}
    if (!h.isNaN && !a.isNaN) {
      lastListScore = '$h-$a';
    }
  }

  /// 所有盘/局加起来的总比分
  String getTotalScores(MatchEntity match) {
    ///4冰球 8乒乓球 9排球 10羽毛球 13 16不统计S1
    int csid = int.tryParse(match.csid) ?? 0;

    List<List<String>> mscFormat = getMscConverted(match);
    int home = int.tryParse(match.homeScore) ?? 0;
    int away = int.tryParse(match.awayScore) ?? 0;

    if (mscFormat.isNotEmpty) {
      int total = home + away;
      String totalSum = total != 0 ? "($total)" : '';

      // Handling specific csid values
      if (SportData.getSportsCsid(
          [SportData.sportCsid_7, SportData.sportCsid_12])!
          .contains(csid)) {
        // return getSnookerScoreSpaceData();
      } else if (SportData.getSportsCsid([
        SportData.sportCsid_2,
        SportData.sportCsid_4,
        SportData.sportCsid_5,
        SportData.sportCsid_6
      ])!
          .contains(csid)) {
        return total.toString();
      } else if (SportData.getSportsCsid(
          [SportData.sportCsid_14, SportData.sportCsid_15])!
          .contains(csid)) {
        String? found =
        match.msc.firstWhereOrNull((score) => score.contains('S1|'));
        if (found != null) {
          String scoreStr = found.split('S1|')[1];
          List<String> scores = scoreStr.split(':');
          home = int.tryParse(scores[0]) ?? 0;
          away = int.tryParse(scores[1]) ?? 0;
          total = home + away;
          totalSum = total != 0 ? "[$total]" : '';
        } else {
          home = 0;
          away = 0;
          totalSum = "0";
        }
      }

      String result = '';
      if (home == 0 && away == 0 && totalSum.isEmpty) {
        result = "0";
      } else {
        result = '$home-$away$totalSum';
      }

      if (SportData.getSportsCsid([14])!.contains(csid)) {
        result = totalSum;
      }

      return result;
    }
    return '';
  }

  List<List<String>> getMscConverted(MatchEntity match) {
    List<String> msc = match.msc;
    List<List<String>> r0 = [];

    if (msc.isNotEmpty) {
      List<List<String>> f = FormatScore.scoreSwitchHandle(match);
      // if (widgets.match.csid == "7" || widgets.match.csid == "12") {
      //   if (f != null && f.isNotEmpty) {
      //     r0 = f;
      //   }
      //   if (s1Score != null) {
      //     snoockerS1.value = s1Score;
      //   }
      // } else {
      //   if (f != null && f.isNotEmpty) {
      //     r0 = f;
      //   }
      // }
      if (f.isNotEmpty) {
        r0 = f;
      }
      mscConverted = f.where((element) => (element[1] != '-')).toList();
    }

    if (mscConverted.isEmpty) {
      mscConverted = [
        ["0", "0", "0"]
      ];
    }
    if (r0.isEmpty) {
      r0 = [
        ["0", "0", "0"]
      ];
    }

    if (mscConverted.isEmpty) {
      showRightTriangle = false;
    }

    return r0;
  }

  ///是否是发球方
  bool set_serving_side(item, side) {
    return item.ms == 1 && item.mat == side;
  }

  /// @description 总局数
  String totalGames() {
    int length = mscConverted.length;
    if (length < 1) return '';
    int homeGame = 0;
    int awayGame = 0;
    mscConverted.forEach((t) {
      /// 修复乒乓球总分计算错误
      if (t[0] != 'S1') {
        homeGame += int.tryParse(t[1]) ?? 0;
        awayGame += int.tryParse(t[2]) ?? 0;
      }
    });
    return '$homeGame-$awayGame (${homeGame + awayGame})';
  }

  /// 判断是否是篮球上半场或者下半场
  bool isLqSX(String csid,String mmp) {
    // // 如果是篮球的  小节玩法，则转成 上半场
    if (csid == '2' &&
        ([2, 1].contains(mmp.toInt()))) {
      return true;
    } else {
      return false;
    }
  }

  /// @description: 比分区域是否显示
  /// @param {Object} match 赛事对象
  /// @return {Boolean} 比分区域是否显示
  showScoreMatchLine(MatchEntity match) {
    // 网斯乒羽(5,7,8,10)  棒冰美排(3、4、6、9)
    int csid = int.tryParse(match.csid) ?? 0;
    bool result = false;
    result =
        match.ms == 1 &&
            SportData.getSportsCsid([
              // 1,
              SportData.sportCsid_2,
              SportData.sportCsid_3,
              SportData.sportCsid_4,
              SportData.sportCsid_5,
              SportData.sportCsid_7,
              SportData.sportCsid_8,
              SportData.sportCsid_9,
              SportData.sportCsid_10,
              SportData.sportCsid_11,
              SportData.sportCsid_12,
              SportData.sportCsid_13,
              SportData.sportCsid_14,
              SportData.sportCsid_15,
              SportData.sportCsid_16,
              SportData.sportCsid_37
            ])!
                .contains(csid);
    return result;
  }

  ///冰球加时赛 需要添加“加:”
  bool isIceExtraTime(MatchEntity match) {
    List<int>? iceCsidList = SportData.getSportsCsid(
        [
          /// 冰球
          SportData.sportCsid_4
        ]);
    if (iceCsidList == null || !iceCsidList.contains(int.tryParse(match.csid))) {
      return false;
    }

    return match.msc.any((item) {
      final parts = item.split('|');
      return parts.length >= 2 && parts[0] == stageExtraTime;
    });
  }
}