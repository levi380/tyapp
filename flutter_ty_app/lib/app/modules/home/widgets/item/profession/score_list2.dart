import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../match_detail/widgets/header/score/templates/score_child3.dart';

/// 列表比分条
class ScoreList2 extends StatefulWidget {
  const ScoreList2({
    super.key,
    required this.match,
  });

  final MatchEntity match;

  @override
  State<ScoreList2> createState() => _ScoreListState();
}

class _ScoreListState extends State<ScoreList2> {
  //当前最新的盘/局比分
  String lastListScore = '';

  //比分转换为数组的数据
  List<List<String>> mscConverted = [];

  bool showLeftTriangle = false;
  bool showRightTriangle = false;

  /// 判断单个比分是否显示
  /// @param match 赛事对象
  /// @param score 比分数组
  /// @return bool
  bool isShowScore(MatchEntity match, List<String> score) {
    bool f = false;
    if (score.isNotEmpty) {
      // 赛事屏蔽角球总比分S5,黄牌比分S12,红牌比分S11,点球比分S10
      if (match.cds == 'RC' &&
          int.parse(match.csid) == SportData.sportCsid_1 &&
          ['S5', 'S10', 'S11', 'S12'].contains(score[0])) {
        return f;
      }
      if (score.length > 2 && score[1] != '-' && score[2] != '-') {
        if ([
          SportData.sportCsid_1,
          SportData.sportCsid_11,
          SportData.sportCsid_14,
          SportData.sportCsid_15,
          SportData.sportCsid_16
        ].contains(int.tryParse(match.csid))) {
          f = true;
        }
        if ((int.tryParse(match.csid) != SportData.sportCsid_1 ||
                int.tryParse(match.csid) != SportData.sportCsid_11) &&
            score[0] != 'S1') {
          f = true;
        }
      }
    }

    return f;
  }

  /// @description: 获取最新比分赋值给last_list_score
  getLastListScore() {
    List<List<String>> mscConverted = getMscConverted();
    int i = mscConverted.length - 1;
    int h = 0, a = 0;
    try {
      if (mscConverted[i][1] != "-") {
        h = int.tryParse(mscConverted[i][1].toString()) ?? 0;
      }
      if (mscConverted[i][2] != "-") {
        a = int.tryParse(mscConverted[i][2].toString()) ?? 0;
      }
    } catch (e) {
      print(e.toString());
    }
    if (!h.isNaN && !a.isNaN) {
      lastListScore = '$h-$a';
    }
  }

  // 所有盘/局加起来的总比分
  String getTotalScores(MatchEntity match) {
    //4冰球 8乒乓球 9排球 10羽毛球 13 16不统计S1
    int csid = int.tryParse(match.csid) ?? 0;

    List<List<String>> mscFormat = getMscConverted();
    int home = int.tryParse(match.homeScore) ?? 0;
    int away = int.tryParse(match.awayScore) ?? 0;

    if (mscFormat.isNotEmpty) {
      int total = home + away;
      String totalSum = total != 0 ? "($total)" : '';

      // Handling specific csid values
      if ([SportData.sportCsid_7, SportData.sportCsid_12].contains(csid)) {
        // return getSnookerScoreSpaceData();
      } else if ([
        SportData.sportCsid_2,
        SportData.sportCsid_4,
        SportData.sportCsid_5,
        SportData.sportCsid_6
      ].contains(csid)) {
        return total.toString();
      } else if ([SportData.sportCsid_14, SportData.sportCsid_15]
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
          totalSum = '';
        }
      }

      String result = '';
      if (home == 0 && away == 0 && totalSum.isEmpty) {
        result = '';
      } else {
        result = '$home-$away$totalSum';
      }

      if ([SportData.sportCsid_14].contains(csid)) {
        result = totalSum;
      }

      return result;
    }
    return '';
  }

  List<List<String>> getMscConverted() {
    List<String> msc = widget.match.msc;
    List<List<String>> r0 = [];

    if (msc.isNotEmpty) {
      List<List<String>> f = FormatScore.scoreSwitchHandle(widget.match);
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

  /// @description 总局数
  String totalGames() {
    int length = mscConverted.length;
    if (length < 1) return '';
    int homeGame = 0;
    int awayGame = 0;
    mscConverted.forEach((t) {
      homeGame += int.tryParse(t[1]) ?? 0;
      awayGame += int.tryParse(t[2]) ?? 0;
    });
    return '$homeGame-$awayGame (${homeGame + awayGame})';
  }

  /// @description: 比分区域是否显示
  /// @param {Object} match 赛事对象
  /// @return {Boolean} 比分区域是否显示
  _showScoreMatchLine(MatchEntity match) {
    // 网斯乒羽(5,7,8,10)  棒冰美排(3、4、6、9)
    int csid = int.tryParse(match.csid) ?? 0;
    bool result = false;
    result = match.ms == 1 &&
        [
          // 1,
          SportData.sportCsid_2, SportData.sportCsid_3, SportData.sportCsid_4,
          SportData.sportCsid_5, SportData.sportCsid_7, SportData.sportCsid_8,
          SportData.sportCsid_9, SportData.sportCsid_10, SportData.sportCsid_11,
          SportData.sportCsid_12, SportData.sportCsid_13,
          SportData.sportCsid_14,
          SportData.sportCsid_15, SportData.sportCsid_16
        ].contains(csid);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (!_showScoreMatchLine(widget.match)) {
      return Container();
    }
    // 赛事比分变化
    getMscConverted();
    getLastListScore();
    int csid = int.tryParse(widget.match.csid) ?? 0;
    return Row(
      mainAxisAlignment: [SportData.sportCsid_3].contains(csid)
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Row(
          children: [
            // 总分、回合数、总局数
            if ([
              SportData.sportCsid_2,
              SportData.sportCsid_5,
              SportData.sportCsid_6,
              SportData.sportCsid_7,
              SportData.sportCsid_8,
              SportData.sportCsid_9,
              SportData.sportCsid_10,
              SportData.sportCsid_13,
              SportData.sportCsid_14,
              SportData.sportCsid_15,
              SportData.sportCsid_16
            ].contains(csid))
              Row(
                children: [
                  // 赛事回合数mfo
                  if (ObjectUtil.isNotEmpty(widget.match.mfo))
                    Text(
                      widget.match.mfo,
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(175, 179, 200, 1)
                              : const Color.fromRGBO(0, 0, 0, 0.8),
                          fontSize: 10.sp.scale),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).marginSymmetric(horizontal: 4.w),

                  // 总分
                  if ([SportData.sportCsid_6].contains(csid) &&
                      getTotalScores(widget.match) != '')
                    Text(
                      "${LocaleKeys.list_total_pp_score_count.tr} ${getTotalScores(widget.match)}",
                      maxLines: 1,
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(175, 179, 200, 1)
                            : const Color.fromRGBO(0, 0, 0, 0.8),
                        fontSize: 10.sp.scale,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                  if (![
                    SportData.sportCsid_1,
                    SportData.sportCsid_2,
                    SportData.sportCsid_3,
                    SportData.sportCsid_11
                  ].contains(csid))
                    Row(
                      children: [
                        // 总局数
                        if (![
                          SportData.sportCsid_4,
                          SportData.sportCsid_6,
                          SportData.sportCsid_7,
                          SportData.sportCsid_8,
                          SportData.sportCsid_9,
                          SportData.sportCsid_10,
                          SportData.sportCsid_13,
                          SportData.sportCsid_14,
                          SportData.sportCsid_15,
                          SportData.sportCsid_16
                        ].contains(csid))
                          Row(
                            children: [
                              Text(
                                "${LocaleKeys.list_total_play_count.tr} ",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? const Color.fromRGBO(175, 179, 200, 1)
                                        : const Color.fromRGBO(0, 0, 0, 0.8),
                                    fontSize: 10.sp.scale),
                              ),
                              Text(
                                totalGames(),
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(23, 156, 255, 1),
                                    fontSize: 10.sp.scale),
                              ),
                            ],
                          ),
                        // <!-- 总分   5--网球， 5--美式足球， 7--斯诺克， 8--乒乓球， 9--排球， 10--羽毛球，-->
                        if ([
                              SportData.sportCsid_7,
                              SportData.sportCsid_8,
                              SportData.sportCsid_9,
                              SportData.sportCsid_10,
                              SportData.sportCsid_13,
                              SportData.sportCsid_15,
                              SportData.sportCsid_16
                            ].contains(csid) &&
                            getTotalScores(widget.match) != '')
                          Text(
                            "${LocaleKeys.list_total_pp_score_count.tr} ",
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? const Color.fromRGBO(175, 179, 200, 1)
                                    : const Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 10.sp.scale),
                          ),
                        if ([
                              SportData.sportCsid_7,
                              SportData.sportCsid_8,
                              SportData.sportCsid_9,
                              SportData.sportCsid_10,
                              SportData.sportCsid_13,
                              SportData.sportCsid_14,
                              SportData.sportCsid_15,
                              SportData.sportCsid_16
                            ].contains(csid) &&
                            getTotalScores(widget.match) != '')
                          Text(
                            totalGames(),
                            style: TextStyle(
                                color: const Color.fromRGBO(23, 156, 255, 1),
                                fontSize: 10.sp.scale),
                          ),
                      ],
                    ),
                ],
              ),

            //  棒球3 出局 一垒二垒三垒
            if (csid == 3)
              Row(
                children: [
                  SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: RepaintBoundary(
                      child: CustomPaint(
                        painter: BaseballDiamondPainter(
                          mbolp: widget.match.mbolp == "1",
                          mbthlp: widget.match.mbthlp == "1",
                          mbtlp: widget.match.mbtlp == "1",
                          mbColor: const Color.fromRGBO(18, 125, 204, 1),
                          normalColor: const Color.fromRGBO(201, 205, 219, 0.8),
                        ),
                      ),
                    ),
                  ).marginOnly(right: 8.w),
                  Text(
                    "${LocaleKeys.match_info_strike_out.tr} ${widget.match.mbcn}",
                    style: TextStyle(
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 0.3)
                            : const Color.fromRGBO(175, 179, 200, 1),
                        fontSize: 12.sp.scale),
                  ),
                ],
              )
          ],
        ),
        Row(
          children: [
            // 比分 [棒球不显示比分]
            if (![SportData.sportCsid_3].contains(csid))
              ...mscConverted.map((e) {
                int i = mscConverted.indexOf(e);

                return Row(
                  children: [
                    if (i == 4 &&
                        [
                          SportData.sportCsid_7,
                          SportData.sportCsid_8,
                          SportData.sportCsid_5
                        ].contains(csid))
                      Text(
                        "...",
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(175, 179, 200, 1)
                                : const Color.fromRGBO(0, 0, 0, 0.8),
                            fontSize: 10.sp.scale),
                      ).marginOnly(left: 4.w),
                    if ([
                      SportData.sportCsid_7,
                      SportData.sportCsid_8,
                      SportData.sportCsid_5
                    ].contains(csid)
                        ? (isShowScore(widget.match, e) && i < 5)
                        : isShowScore(widget.match, e))
                      Row(
                        children: [
                          // 角球图标
                          if (int.parse(widget.match.csid) ==
                                  SportData.sportCsid_1 &&
                              e[0] == 'S5' &&
                              e.length > 4)
                            Container(),
                          // HT半场或 FT全场 或 OT
                          if (e.length > 4 &&
                              [
                                SportData.sportCsid_1,
                                SportData.sportCsid_11,
                                SportData.sportCsid_14,
                                SportData.sportCsid_15,
                                SportData.sportCsid_16
                              ].contains(csid) &&
                              e[4] != '' &&
                              e[0] != 'S5')
                            Text(e[4]),
                          // 比分
                          if (e.length > 2)
                            Text(
                              '${e[1]}-${e[2]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(175, 179, 200, 1)
                                      : const Color.fromRGBO(0, 0, 0, 0.8),
                                  fontSize: 10.sp.scale),
                            ).marginOnly(left: 4.w),
                        ],
                      )
                  ],
                );
              }).toList(),
          ],
        ).marginSymmetric(horizontal: 4.w),
      ],
    ).marginSymmetric(vertical: 5.h);
  }
}
