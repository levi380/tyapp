import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../../../../../../main.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../utils/bus/bus.dart';
import '../../../../../../utils/bus/event_enum.dart';
import '../../../../../../utils/format_score_util.dart';
import '../../../../constants/football_score_constant.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频+动画按钮+详细比分】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部比分条】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 篮球比分模板
    】】】
 *
 */
class ScoreChild2 extends StatefulWidget {
  const ScoreChild2(
      {super.key,
      required this.match,
      required this.isResult,
      this.isResultTitle = false});

  final MatchEntity match;
  final bool isResult;
  final bool isResultTitle;

  @override
  State<ScoreChild2> createState() => _ScoreChild2State();
}

class _ScoreChild2State extends State<ScoreChild2> {
  /// 加时赛比分
  String overtimeScore = "";

  @override
  void initState() {
    validateStage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScoreChild2 oldWidget) {
    validateStage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isResult) {
      // return Container();
      return widget.isResultTitle
          ? Text(
              getResultScoreDetail(widget.match),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.90)
                    : const Color(0xFF303442),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            )
          : Text(
              getResultScoreDetail(widget.match),
              style: TextStyle(
                color: Colors.white,
                fontSize: (12.sp),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ).marginOnly(right: isIPad ? 20.w : 4.w);
    }

    if (widget.match.ms != 111 && widget.match.mle != 73) {
      // 加时赛
      // mmp 32 等待加时  40 加时赛  110加时赛结束
      // msc S7表示公共加时赛比分

      List<String> scoreList = basketballScoreArray(widget.match);
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 上半场，下半场模式
          // mmp  1.上半场 2.下半场 31.中场休息
          if (modelA.contains(widget.match.mmp) &&
              widget.match.mle == 17 &&
              ![Routes.matchResultsDetails].contains(Get.currentRoute))
            ...scoreList.asMap().entries.map((entry) {
              int index = entry.key + 1;
              String e = entry.value;
              return Text(
                "${index}H${FormatScore.scoreFormat(e)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == scoreList.length
                      ? Get.theme.scoreDetailColor
                      : Colors.white,
                  fontSize: Get.theme.fontSize_12,
                  fontFamily: 'Akrobat',
                  fontWeight: index == scoreList.length
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ).marginOnly(right: 10.w);
            }).toList(),

          // 常规4节比赛
          // mmp （13 第一节）（14 301 第二节）（15 302 第三节）（16 303 第四节）
          if (modelB.contains(widget.match.mmp) && widget.match.mo != 1)
            ...scoreList.asMap().entries.map((entry) {
              int index = entry.key + 1;
              String e = entry.value;
              return Text(
                FormatScore.scoreFormat(e),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: index == scoreList.length
                      ? Get.theme.scoreDetailColor
                      : Colors.white,
                  fontSize: Get.theme.fontSize_12,
                  fontFamily: 'Akrobat',
                  fontWeight: index == scoreList.length
                      ? FontWeight.w700
                      : FontWeight.w600,
                ),
              ).marginOnly(right: 10.w);
            }).toList(),

          // 加时赛
          // mmp 32 等待加时  40 加时赛  110加时赛结束
          if (modelC.contains(widget.match.mmp))
            // 赛果
            if (widget.match.mmp == "999")
              // 赛果展示规则
              // 第二节比分未达到展示条件时示例；
              // Q1:18-20  Q2: -  Q3:14-20 Q4:20-21
              // 下半场比分未达到展示条件时示例；
              // 1H 25-26  2H -
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (scoreList.length == 2)
                    Row(
                      children: [
                        ...scoreList.asMap().entries.map((entry) {
                          int index = entry.key + 1;
                          String e = entry.value;
                          return Text(
                            "${index}H ${FormatScore.scoreFormat(e)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w600,
                            ),
                          ).marginOnly(right: 10.w);
                        }).toList(),
                        if (getExtraTime(widget.match) != "")
                          Text(
                            "${LocaleKeys.match_info_add.tr}${FormatScore.scoreFormat(getExtraTime(widget.match))}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Get.theme.scoreDetailColor,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ).marginOnly(right: 10.w),
                      ],
                    ),
                  if (scoreList.length == 4)
                    Row(
                      children: [
                        ...scoreList.asMap().entries.map((entry) {
                          int i = entry.key + 1; // 索引
                          var e = entry.value; // 值
                          return Text(
                            "Q$i:" + FormatScore.scoreFormat(e),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w600,
                            ),
                          ).marginOnly(right: 10.w);
                        }).toList(),
                        if (getExtraTime(widget.match) != "")
                          Text(
                            "${LocaleKeys.match_info_add.tr}(${FormatScore.scoreFormat(getExtraTime(widget.match))})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Get.theme.scoreDetailColor,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ).marginOnly(right: 10.w),
                      ],
                    ),
                ],
              )
            else
              // 区分model_a or model_b
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (scoreList.length == 2)
                    Row(
                      children: [
                        ...scoreList.asMap().entries.map((entry) {
                          int index = entry.key + 1;
                          String e = entry.value;
                          return Text(
                            "${index}H ${FormatScore.scoreFormat(e)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w600,
                            ),
                          ).marginOnly(right: 10.w);
                        }).toList(),
                        if (getExtraTime(widget.match) != "")
                          Text(
                            "${LocaleKeys.match_info_add.tr}${FormatScore.scoreFormat(getExtraTime(widget.match))}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Get.theme.scoreDetailColor,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ).marginOnly(right: 10.w),
                      ],
                    ),
                  if (scoreList.length == 4)
                    Row(
                      children: [
                        ...scoreList.map((e) {
                          return Text(
                            FormatScore.scoreFormat(e),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w600,
                            ),
                          ).marginOnly(right: 10.w);
                        }).toList(),
                        if (getExtraTime(widget.match) != "")
                          Text(
                            "${LocaleKeys.match_info_add.tr}(${FormatScore.scoreFormat(getExtraTime(widget.match))})",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Get.theme.scoreDetailColor,
                              fontSize: Get.theme.fontSize_12,
                              fontFamily: 'Akrobat',
                              fontWeight: FontWeight.w700,
                            ),
                          ).marginOnly(right: 10.w),
                      ],
                    ),
                ],
              ),
        ],
      );
    }
    return Container();
  }

  // 根据赛事阶段显示默认比分
  validateStage() {
    switch (widget.match.mmp) {
      case "301": //301 第一节结束   S20 第二节比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S20|0:0');
        break;
      case "302": //302 第二节结束 S21 第三节比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S21|0:0');
        break;
      case "303": //303  第三节结束 S22 第四节比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S22|0:0');
        break;
      case "31": //31  上半场结束S3下半场比分
        Bus.getInstance().emit(EventType.nativeDetailData, 'S3|0:0');
        break;
    }
  }

  ///@description 篮球比分集合
  ///@return {Array} 篮球比分
  List<String> basketballScoreArray(MatchEntity match) {
    // print(match.msc);
    List<String> scoreArr = [];
    List<String> msc = match.msc;

    // sortBy方法  比分升序排列 取出比分阶段后面的数字作为判断条件 返回是数组
    msc.sort((a, b) {
      int aStage = int.parse(a.split("|")[0].substring(1));
      int bStage = int.parse(b.split("|")[0].substring(1));
      return aStage.compareTo(bStage);
    });

    List<String> mscArray = [];

    // 构建比分阶段到实际比分的映射
    Map<String, String> scoreMap = {};
    for (String item in msc) {
      List<String> parts = item.split("|");
      if (parts.length >= 2) {
        scoreMap[parts[0]] = parts[1];
      }
    }

    switch (match.mmp) {
      case "13": // 第一节
        mscArray = ['S19']; // S19第一节比分
        break;
      case "301": // 第二节
      case "14": // 第二节
        mscArray = ['S19', 'S20']; // S20第二节比分
        break;
      // case "302":// 第二节休息
      case "15": // 第三节
        mscArray = ['S19', 'S20', 'S21']; // S21第三节比分
        break;
      case "303": // 第三节休息
      case "16": // 第四节
        mscArray = ['S19', 'S20', 'S21', 'S22']; // S22第四节比分
        break;
      case "1": // 上半场
        mscArray = ['S2']; // S2上半场比分
        break;
      case "2": // 下半场
        mscArray = ['S2', 'S3']; // S3下半场比分
        break;
      case "999": // 赛事结束
        // 赛果展示规则
        // 第二节比分未达到展示条件时示例；
        // Q1:18-20  Q2: -  Q3:14-20 Q4:20-21
        // 下半场比分未达到展示条件时示例；
        // 1H 25-26  2H -
        if (match.mle == 0 || match.mle == 7) {
          // 篮球比分模式：按节展示
          List<String> quarterScores = ['S19', 'S20', 'S21', 'S22'];
          for (String quarter in quarterScores) {
            if (scoreMap.containsKey(quarter) &&
                scoreMap[quarter] != null &&
                scoreMap[quarter]!.isNotEmpty) {
              scoreArr.add(scoreMap[quarter]!);
            } else {
              scoreArr.add(" - "); // 不存在的比分用-代替
            }
          }
          return scoreArr; // 直接返回，避免后续重复添加
        } else if (match.mle == 17 || match.mle == 73) {
          // 篮球比分模式：上下半场
          List<String> halfScores = ['S2', 'S3'];
          for (String half in halfScores) {
            if (scoreMap.containsKey(half) &&
                scoreMap[half] != null &&
                scoreMap[half]!.isNotEmpty) {
              scoreArr.add(scoreMap[half]!);
            } else {
              scoreArr.add(" - "); // 不存在的比分用-代替
            }
          }
          return scoreArr; // 直接返回，避免后续重复添加
        }
        break;
      default:
        break;
    }

    // 循环只取出接口返回的比分里面符合篮球球阶段的比分
    for (String item in msc) {
      String numIndex = item.split("|")[0];
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    }

    // print(scoreArr);
    return scoreArr;
  }

  ///@description 公共加时赛比分
  ///@return {String} 加时赛比分
  String getExtraTime(MatchEntity match) {
    String extra = "";
    List<String> msc = match.msc;

    for (String item in msc) {
      List<String> splitItem = item.split("|");
      if (splitItem.length >= 2 && splitItem[0] == "S7") {
        extra = splitItem[1];
        break;
      }
    }

    return extra;
  }

  /// 获得某个阶段某个比分 上半场，全场
  String getResultScoreDetail(MatchEntity match) {
    String detail = "";
    String mmp = widget.match.mmp;
    List<String> scoreArray = footballScoreArray(widget.match);

    // 获取各个阶段的比分（安全处理）
    String? firstHalfScore = scoreArray.safe(1); // 上半场/半场
    String? fullTimeScore = scoreArray.safeFirst; // 全场
    bool hasFirstHalf = !ObjectUtil.isEmptyString(firstHalfScore) && firstHalfScore != "-";
    bool hasFullTime = !ObjectUtil.isEmptyString(fullTimeScore) && fullTimeScore != "-";
    bool hasOvertime = !ObjectUtil.isEmptyString(overtimeScore);

    // 构建显示标签
    List<String> labels = [];

    // 上半场/半场标签
    if (hasFirstHalf && collectionA.contains(mmp)) {
      if (widget.isResult) {
        labels.add(LocaleKeys.match_info_half.tr);
      } else {
        labels.add(LocaleKeys.app_h5_detail_half.tr);
      }
    }

    // 全场标签
    if (hasFullTime && collectionB.contains(mmp)) {
      labels.add(LocaleKeys.match_info_full.tr);
    }

    // 加时标签
    if (hasOvertime && collectionC.contains(mmp)) {
      labels.add(LocaleKeys.match_info_add.tr);
    }

    // 用"/"连接标签
    detail = labels.join("/");

    // 构建比分部分
    List<String> scores = [];

    // 上半场/半场比分
    if (hasFirstHalf && collectionA.contains(mmp)) {
      scores.add(FormatScore.scoreFormat(firstHalfScore ?? ""));
    }

    // 全场比分
    if (hasFullTime && collectionB.contains(mmp)) {
      scores.add(FormatScore.scoreFormat(fullTimeScore ?? ""));
    }

    // 加时比分
    if (hasOvertime && collectionC.contains(mmp)) {
      scores.add(FormatScore.scoreFormat(overtimeScore));
    }

    // 如果有比分，添加分隔符和比分
    if (scores.isNotEmpty) {
      if (detail.isNotEmpty) {
        detail += " : ";
      }
      detail += scores.join(" / ");
    }

    return detail;
  }

  /// 足球比分集合
  List<String> footballScoreArray(MatchEntity match) {
    List<String> msc = List.from(widget.match.msc);

    // 按照比分阶段的数字进行升序排列
    msc.sort((a, b) {
      int numA = int.parse(a.split("|")[0].substring(1));
      int numB = int.parse(b.split("|")[0].substring(1));
      return numA.compareTo(numB);
    });

    List<String> scoreArr = [];
    // 循环只取出接口返回的比分里面符合足球阶段的比分
    msc.forEach((item) {
      String numIndex = item.split("|")[0];
      // 加时赛
      if (numIndex == 'S7') {
        overtimeScore = item.split("|")[1];
      }

      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    });

    return scoreArr;
  }
}

// 上半场，下半场
List<String> modelA = ['1', '2', '31'];

// 常规4节比赛
List<String> modelB = ['13', '14', '15', '16', '301', '302', '303'];

// 加时赛比赛
List<String> modelC = ['32', '40', '110', '999'];

// 常规4节比赛的比分
List<String> mscArrayBasketball = ['S19', 'S20', 'S21', 'S22'];

// 上下半场
List<String> mscArray1 = ['S2', 'S3'];
