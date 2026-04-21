import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';

import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../services/models/res/match_entity.dart';
import '../../../../../../utils/format_score_util.dart';
import '../../../../../../widgets/image_view.dart';
import '../../../../constants/football_score_constant.dart';
import '../../../../controllers/match_tools_methods.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 视频+动画按钮+详细比分】】】
    【【【 AUTO_PARAGRAPH_TITLE 底部比分条】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 足球比分模板
    】】】
 *
 */
class ScoreChild1 extends StatefulWidget {
  const ScoreChild1(
      {super.key,
      required this.match,
      required this.isResult,
      this.isResultTitle = false});

  final MatchEntity match;
  final bool isResult;
  final bool isResultTitle;

  @override
  State<ScoreChild1> createState() => _ScoreChild1State();
}

class _ScoreChild1State extends State<ScoreChild1> {
  /// 加时赛比分
  String overtimeScore = "";

  /// 点球大战比分
  String shootScore = "";

  // 赛果详情不显示文案[黄牌 红牌 等]   // matchResultsDetails
  // 详情显示
  bool showLabel = ![Routes.matchResultsDetails].contains(Get.currentRoute);

  @override
  Widget build(BuildContext context) {
    if (widget.isResult) {
      return widget.isResultTitle
          ? Text(
              getResultFootballScoreDetail(widget.match),
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
              getResultFootballScoreDetail(widget.match),
              style: TextStyle(
                color: Colors.white,
                fontSize: (12.sp),
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ).marginOnly(right: isIPad ? 20.w : 4.w);
    }
    // 赛果详情、 加时赛 不显示文案[黄牌 红牌 等]
    // 详情显示
    bool showLabel = ![Routes.matchResultsDetails].contains(Get.currentRoute) &&
        !widget.match.mscMap.containsKey("S7");

    String scoreStr = scoreDisplay().trim();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 上半场，全场，加时赛，点球大战
        if (scoreStr != "" && displayLabel() != "")
          Text(
            displayLabel() + " " + scoreDisplay(),
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.theme.matchDetailScoreFontSize_10,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w500,
            ),
          ).marginOnly(right: isIPad ? 20.w : 4.w),

        // 角球、黄牌、红牌
        Visibility(
          visible: displayCards(),
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageView(
                    'assets/images/sport/ico_cornerkick.svg',
                    width: 16.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    (showLabel ? LocaleKeys.match_result_corner_kick.tr : ' ') +
                        FormatScore.scoreFormat(
                            footballScoreStatusArray(widget.match)[0]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.theme.matchDetailScoreFontSize_10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: isIPad ? 20.w : 4.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 9.w,
                    height: 12.h,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFEAE2B),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.r)),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    (showLabel ? LocaleKeys.match_result_yellow_card.tr : " ") +
                        FormatScore.scoreFormat(
                            footballScoreStatusArray(widget.match)[2]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.theme.matchDetailScoreFontSize_10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: isIPad ? 20.w : 4.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 9.w,
                    height: 12.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF53F3F),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.r)),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    (showLabel ? LocaleKeys.match_result_red_card.tr : " ") +
                        FormatScore.scoreFormat(
                            footballScoreStatusArray(widget.match)[1]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.theme.matchDetailScoreFontSize_10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        // 加时赛比分
        if (widget.match.mscMap.containsKey("S7"))
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.football_playing_way_overtime.tr +
                    " " +
                    overtimeScoreDisplay(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Get.theme.matchDetailScoreFontSize_10,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
              ).marginOnly(right: isIPad ? 20.w : 4.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageView(
                    'assets/images/detail/jiao_add.svg',
                    width: 14.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    ' ' +
                        FormatScore.scoreFormat(
                            footballScoreStatusArray(widget.match)[3]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.theme.matchDetailScoreFontSize_10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: isIPad ? 20.w : 4.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageView(
                    'assets/images/detail/yellow_add.png',
                    width: 14.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    ' ' +
                        FormatScore.scoreFormat(
                            footballScoreStatusArray(widget.match)[5]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.theme.matchDetailScoreFontSize_10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: isIPad ? 20.w : 4.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageView(
                    'assets/images/detail/red_add.png',
                    width: 14.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    ' ' +
                        FormatScore.scoreFormat(
                            footballScoreStatusArray(widget.match)[4]),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.theme.matchDetailScoreFontSize_10,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          )
      ],
    );
  }

  /// 获得某个阶段某个比分 上半场，全场，加时赛，点球大战
  String getFootballScoreDetail(MatchEntity match) {
    String detail = "";
    String mmp = widget.match.mmp;
    List<String> scoreArray = footballScoreArray(widget.match);
    if (!ObjectUtil.isEmptyString(scoreArray.safe(1)) &&
        collectionA.contains(mmp)) {
      if (widget.isResult) {
        // 赛果显示半
        detail += LocaleKeys.match_info_half.tr;
      } else {
        detail += LocaleKeys.app_h5_detail_half.tr;
      }
    }
    if (!ObjectUtil.isEmptyString(scoreArray.safeFirst) &&
        collectionB.contains(mmp)) {
      detail += "/${LocaleKeys.match_info_full.tr}";
    }
    if (!ObjectUtil.isEmptyString(overtimeScore) && collectionC.contains(mmp)) {
      detail += "/${LocaleKeys.match_info_add.tr}";
    }
    // 赛果显示
    if (!ObjectUtil.isEmptyString(shootScore) &&
        collectionC.contains(mmp) &&
        widget.isResult) {
      detail += "/${LocaleKeys.match_info_shoot_out.tr}";
    }
    if (!ObjectUtil.isEmptyString(scoreArray.safe(1)) &&
        collectionA.contains(mmp)) {
      detail += " : ${FormatScore.scoreFormat(scoreArray.safe(1) ?? "")}";
    }
    if (!ObjectUtil.isEmptyString(scoreArray.safeFirst) &&
        collectionB.contains(mmp)) {
      detail += " / ${FormatScore.scoreFormat(scoreArray.safeFirst ?? "")}";
    }

    if (!ObjectUtil.isEmptyString(overtimeScore) && collectionC.contains(mmp)) {
      detail += " / ${FormatScore.scoreFormat(overtimeScore)}";
    }
    // 赛果显示
    if (!ObjectUtil.isEmptyString(shootScore) &&
        collectionC.contains(mmp) &&
        widget.isResult) {
      detail += " / ${FormatScore.scoreFormat(shootScore)}";
    }

    return detail;
  }

  /// 获得某个阶段某个比分 上半场，全场，加时赛，点球大战
  String getResultFootballScoreDetail(MatchEntity match) {
    String detail = "";
    String mmp = widget.match.mmp;
    List<String> scoreArray = footballScoreArray(widget.match);
    if (!ObjectUtil.isEmptyString(scoreArray.safe(1)) &&
        collectionA.contains(mmp)) {
      if (widget.isResult) {
        // 赛果显示半
        detail += LocaleKeys.match_info_half.tr;
      } else {
        detail += LocaleKeys.app_h5_detail_half.tr;
      }
    }

    ///赛果头部不显示全场比分
    // if (!ObjectUtil.isEmptyString(scoreArray.safeFirst) &&
    //     collectionB.contains(mmp)) {
    //   detail += "/${LocaleKeys.match_info_full.tr}";
    // }
    if (!ObjectUtil.isEmptyString(overtimeScore) && collectionC.contains(mmp)) {
      detail += "/${LocaleKeys.match_info_add.tr}";
    }
    // 赛果显示
    if (!ObjectUtil.isEmptyString(shootScore) &&
        collectionC.contains(mmp) &&
        widget.isResult) {
      detail += "/${LocaleKeys.match_info_shoot_out.tr}";
    }
    if (!ObjectUtil.isEmptyString(scoreArray.safe(1)) &&
        collectionA.contains(mmp)) {
      detail += " : ${FormatScore.scoreFormat(scoreArray.safe(1) ?? "")}";
    }

    ///赛果头部不显示全场比分
    // if (!ObjectUtil.isEmptyString(scoreArray.safeFirst) &&
    //     collectionB.contains(mmp)) {
    //   detail += " / ${FormatScore.scoreFormat(scoreArray.safeFirst ?? "")}";
    // }

    if (!ObjectUtil.isEmptyString(overtimeScore) && collectionC.contains(mmp)) {
      detail += " / ${FormatScore.scoreFormat(overtimeScore)}";
    }
    // 赛果显示
    if (!ObjectUtil.isEmptyString(shootScore) &&
        collectionC.contains(mmp) &&
        widget.isResult) {
      detail += " / ${FormatScore.scoreFormat(shootScore)}";
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
      // 点球
      if (numIndex == 'S170') {
        shootScore = item.split("|")[1];
      }
      if (mscArray.contains(numIndex)) {
        scoreArr.add(item.split("|")[1]);
      }
    });

    return scoreArr;
  }

  String displayLabel() {
    // 有加时赛 才显示常规赛
    String res = '';
    if (!ObjectUtil.isEmptyString(overtimeScore)) {
      res = LocaleKeys.match_map_regular_season.tr;
      // 上半场 不显示
    } else if (widget.match.mmp == "6") {
      res = "";
      // 下半场、中场休息 显示 上半场
    } else if (["7", "31"].contains(widget.match.mmp)) {
      res = LocaleKeys.app_h5_detail_half.tr;
    }

    ///比分板 不显示全场比分
    else {
      if (![Routes.matchResultsDetails].contains(Get.currentRoute)) {
        // 全场
        res = LocaleKeys.match_map_full_court.tr;
      }
    }
    return res;
  }

  ///@description 是否显示 角球 红牌 黄牌
  bool displayCards() {
    // 有加时赛 才显示常规赛
    bool res = true;
    if (widget.match.mbmty == 4 || widget.match.mbmty == 2) {
      res = false;
    } else {
      res = true;
    }
    return res;
  }

  // 显示比分
  String scoreDisplay() {
    List<String> scoreArray = footballScoreArray(widget.match);
    // 下半场、中场休息 显示 上半场比分
    if (["7", "31"].contains(widget.match.mmp)) {
      return FormatScore.scoreFormat(scoreArray.safe(1) ?? "");
      // 上半场不显示比分
    } else if (widget.match.mmp == 6) {
      return "";
      // 其他显示全场比分
    } else {
      return FormatScore.scoreFormat(scoreArray.safeFirst ?? "");
    }
  }

  // 显示比分
  String overtimeScoreDisplay() {
    List<String> scoreArray = footballScoreArray(widget.match);
    return FormatScore.scoreFormat(scoreArray.safe(2) ?? "");
  }
}
