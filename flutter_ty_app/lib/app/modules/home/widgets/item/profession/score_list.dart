import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/home/widgets/item/profession/score_list_ext.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:get/get.dart';
import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/format_score_util.dart';
import '../../../../../utils/sport.dart';
import '../../../../match_detail/widgets/header/score/templates/score_child3.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 常规赛事 】】】
    【【【 AUTO_PARAGRAPH_TITLE 列表比分条 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 监听赛事比分变化
    ```
    getMscConverted();
    getLastListScore();
    ```
    - 比分转换为数组的数据
    - 获取最新比分赋值给last_list_score
    】】】
 *
 */
/// 列表比分条
class ScoreList extends StatefulWidget {
  const ScoreList({super.key, required this.match, this.edition = 1});
  final int edition; // 1专业版 2新手版
  final MatchEntity match;
  @override
  State<ScoreList> createState() => _ScoreListState();
}
class _ScoreListState extends State<ScoreList> with ScoreListState{
  @override
  void didUpdateWidget(covariant ScoreList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    if (!showScoreMatchLine(widget.match)) {
      return Container();
    }
    /// 赛事比分变化
    getMscConverted(widget.match);
    getLastListScore(widget.match);
    int csid = int.tryParse(widget.match.csid) ?? 0;
    /// 篮球3X3
    bool isShow3X3 = (widget.match.ms == 1 && widget.match.csid == 2 && widget.match.mle == 73);
    /// 网球  bug id：63304 和 篮球3X3滚球时不显示详细比分
    ///小节详细比分
    bool ShowQuarterScore = 'mmp_${widget.match.csid}_${widget.match.mmp}' != "mmp_5_8" &&
        !isShow3X3;
    /// 总分、回合数、总局数
    /// 篮球 网球 美式足球 斯诺克 乒乓球 排球 羽毛球 沙滩排球 联合式橄榄球 曲棍球 水球
     bool
     ShowTotalGames  = SportData.getSportsCsid([
      SportData.sportCsid_2, SportData.sportCsid_5, SportData.sportCsid_6, SportData.sportCsid_7, SportData.sportCsid_8, SportData.sportCsid_9,
       SportData.sportCsid_10, SportData.sportCsid_13, SportData.sportCsid_14, SportData.sportCsid_15, SportData.sportCsid_16
    ])!
        .contains(csid);
    ///板球赛制  单独显示
    bool isCricket = SportData.getSportsCsid([SportData.sportCsid_37])!
        .contains(csid);
    ///板球球总比分
    bool ShowCricketTotal = mscConverted.isNotEmpty && isCricket;
    ///棒球 加多显示出局 一垒二垒三垒
    bool isBaseball = SportData.getSportsCsid([SportData.sportCsid_3])!
        .contains(csid);
    /// 是否是冰球 加时赛
   bool isExtraForIce = isIceExtraTime(widget.match);
    return Row(
      ///SportData.sportCsid_3 棒球
      mainAxisAlignment: [SportData.sportCsid_3].contains(csid)
          ? MainAxisAlignment.end
          : widget.edition == 2
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
      children: [
        /// 网球不显示详细比分 bug id：63304
        /// 篮球3X3滚球时不显示详细比分
        if ('mmp_${widget.match.csid}_${widget.match.mmp}' != "mmp_5_8" &&
            !isShow3X3)
        ///小节详细比分
        if(ShowQuarterScore)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (mscConverted.length > 1)
                ...mscConverted.map((e) {
                  int i = mscConverted.indexOf(e);
                  // print('mscConverted: --i: $i -- e: $e');
                  ///不显示角球图标 条件
                  bool HideCorner = widget.match.csid ==
                      SportData.sportCsid_1.toString() &&
                      e[0] == 'S5' &&
                      e.length > 4;
                  /// 超过多少显示... 的基数
                  int showUnit = 4;
                  if (isIPad) {
                    // 获取剩余可显示比分的宽度：右侧：120.w，icon：22.w，距左：22.w
                    double availableShowUnitWidth =
                        Get.width - 120.w - 22.w * 4 - 22.w * 2;
                    // 每个比分所占宽度：25.w
                    double countD = availableShowUnitWidth / 30.w;
                    int count = countD.floor();
                    // 预留一个展示 ...
                    showUnit = count - 1;
                  }
                  if (isShowScore(widget.match, e) &&
                      i < mscConverted.length - 1) {
                    return Row(
                      children: [
                        /// 角球图标
                        if (HideCorner)
                          Container(),
                        /// HT半场或 FT全场 或 OT
                        if (e.length > 4 &&
                            [SportData.sportCsid_1, SportData.sportCsid_11, SportData.sportCsid_14, SportData.sportCsid_15, SportData.sportCsid_16]
                             .contains(csid) &&
                            e[4] != '' &&
                            e[0] != 'S5')
                          Text(e[4]),
                        /// 比分
                        if (e.length > 1 && i < showUnit)
                          Builder(builder: (context) {
                            /// 如果是上半场比分 或者下半场比分的情况下
                            if (isLqSX(widget.match.csid,widget.match.mmp)) {
                              return Row(children: [
                                RotatedBox(
                                  quarterTurns: i == 1 ? 2 : 0,
                                  child: ImageView(
                                    'assets/images/score_tip.svg',
                                    width: 10.w,
                                    height: 10.w,
                                    svgColor: Get.isDarkMode
                                        ? Colors.white.withValues(alpha: 0.5)
                                        : Color(0xFF787E9E),
                                  ),
                                ),
                                Text(
                                  '${e[1]}${!isCricket ? "-" : " - "}${e[2]}',
                                  style: TextStyle(
                                      color: (i == mscConverted.length - 1)
                                          ? const Color.fromRGBO(
                                              23, 156, 255, 1)
                                          : Get.isDarkMode
                                              ? const Color.fromRGBO(
                                                  175, 179, 200, 1)
                                              : const Color.fromRGBO(
                                                  0, 0, 0, 0.8),
                                      fontSize: 10.sp),
                                ).marginOnly(right: 4.w),
                              ]);
                            }
                            /// 篮球
                            if ([SportData.sportCsid_2]
                                    .contains(widget.match.csid.toInt()) &&
                                i == 1) {
                              /// 获取 前 2 4节比分总和
                              int home = 0;
                              int away = 0;
                              for (int j = 0; j <= i; j++) {
                                home += int.tryParse(mscConverted[j][1]) ?? 0;
                                away += int.tryParse(mscConverted[j][2]) ?? 0;
                              }
                              return Row(
                                children: [
                                  Text(
                                    '${e[1]}${!isCricket ? "-" : " - "}${e[2]}',
                                    style: TextStyle(
                                        color: (i == mscConverted.length - 1)
                                            ? const Color.fromRGBO(
                                                23, 156, 255, 1)
                                            : Get.isDarkMode
                                                ? const Color.fromRGBO(
                                                    175, 179, 200, 1)
                                                : const Color.fromRGBO(
                                                    0, 0, 0, 0.8),
                                        fontSize: 10.sp),
                                  ).marginOnly(left: 4.w, right: 4.w),
                                  ImageView(
                                    'assets/images/score_tip.svg',
                                    width: 10.w,
                                    height: 10.w,
                                    svgColor: Get.isDarkMode
                                        ? Colors.white.withValues(alpha: 0.5)
                                        : Color(0xFF787E9E),
                                  ),
                                  Text(
                                    '$home-$away',
                                    style: TextStyle(
                                        color: Get.isDarkMode
                                            ? const Color.fromRGBO(
                                                175, 179, 200, 1)
                                            : const Color.fromRGBO(
                                                0, 0, 0, 0.8),
                                        fontSize: 10.sp),
                                  ),
                                ],
                              );
                            } else {
                              return Text(
                                '${e[1]}${!isCricket ? "-" : " - "}${e[2]}',
                                style: TextStyle(
                                    color: (i == mscConverted.length - 1)
                                        ? const Color.fromRGBO(23, 156, 255, 1)
                                        : Get.isDarkMode
                                            ? const Color.fromRGBO(
                                                175, 179, 200, 1)
                                            : const Color.fromRGBO(
                                                0, 0, 0, 0.8),
                                    fontSize: 10.sp),
                              ).marginOnly(left: 4.w);
                            }
                          }),
                        /// 超过showUnit个 显示 ...
                        if (i == showUnit)
                          Text(
                            "...",
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? const Color.fromRGBO(175, 179, 200, 1)
                                    : const Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 10.sp),
                          ).marginOnly(left: 4.w),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              /// 当前比分
              if (mscConverted.isNotEmpty)
                Row(
                  children: [
                    Builder(builder: (context) {
                      if (isLqSX(widget.match.csid,widget.match.mmp) &&
                          (mscConverted.length >= 1 ||
                              mscConverted.length <= 2)) {
                        return RotatedBox(
                          quarterTurns: mscConverted.length == 1 ? 0 : 2,
                          child: ImageView(
                            'assets/images/score_tip.svg',
                            width: 10.w,
                            height: 10.w,
                            svgColor: Get.isDarkMode
                                ? Colors.white.withValues(alpha: 0.5)
                                : Color(0xFF787E9E),
                          ),
                        );
                      }
                      return SizedBox();
                    }),
                    Text(
                      ///如果是冰球加时赛 需要增加文案 ‘加:’
                      '${isExtraForIce ? (LocaleKeys.match_info_add.tr + ':') : ''}${mscConverted.safeLast?[1]}',
                      style: TextStyle(
                          color: Get.theme.scoreDetailColor,
                          fontSize: 10.sp),
                    ),
                    Text(
                      '${!isCricket ? "-" : " - "}',
                      style: TextStyle(
                          color:  Get.theme.scoreDetailColor,
                          fontSize: 10.sp),
                    ),
                    Text(
                      '${mscConverted.safeLast?[2]}',
                      style: TextStyle(
                          color: Get.theme.scoreDetailColor,
                          fontSize: 10.sp),
                    ),
                    /// 篮球显示总分
                    Builder(builder: (context) {
                      if (isLqSX(widget.match.csid,widget.match.mmp)) return SizedBox();
                      /// 篮球第一节
                      if (widget.match.csid == '2' &&
                          ((mscConverted.length >= 2) ||
                              (mscConverted.length == 1))) {
                        int home = 0;
                        int away = 0;
                        if (mscConverted.length > 2) {
                          for (int i = 2; i < mscConverted.length; i++) {
                            home += int.tryParse(mscConverted[i][1]) ?? 0;
                            away += int.tryParse(mscConverted[i][2]) ?? 0;
                          }
                        } else if (mscConverted.length == 2) {
                          for (int i = 0; i < mscConverted.length; i++) {
                            home += int.tryParse(mscConverted[i][1]) ?? 0;
                            away += int.tryParse(mscConverted[i][2]) ?? 0;
                          }
                        } else if (mscConverted.length == 1) {
                          home = int.tryParse(mscConverted[0][1]) ?? 0;
                          away = int.tryParse(mscConverted[0][2]) ?? 0;
                        }
                        return Row(
                          children: [
                            4.horizontalSpace,
                            RotatedBox(
                              quarterTurns: mscConverted.length > 2 ? 2 : 0,
                              child: ImageView(
                                'assets/images/score_tip.svg',
                                width: 10.w,
                                height: 10.w,
                                svgColor: Get.isDarkMode
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : Color(0xFF787E9E),
                              ),
                            ),
                            Text(
                              '$home-$away',
                              style: TextStyle(
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(175, 179, 200, 1)
                                      : const Color.fromRGBO(0, 0, 0, 0.8),
                                  fontSize: 10.sp),
                            ),
                          ],
                        );
                      } else {
                        return SizedBox();
                      }
                    })
                  ],
                ).marginOnly(left: 4.w),
            ],
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 总分、回合数、总局数
            if (ShowTotalGames)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 总分
                  if ([
                        SportData.sportCsid_6,
                      ].contains(csid) &&
                      getTotalScores(widget.match) != '')
                    Text(
                      "${LocaleKeys.list_total_pp_score_count.tr} ${getTotalScores(widget.match)}",
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(175, 179, 200, 1)
                              : const Color.fromRGBO(0, 0, 0, 0.8),
                          fontSize: 10.sp),
                    ),
                  /// 赛事回合数mfo
                  if (ObjectUtil.isNotEmpty(widget.match.mfo))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.match.mfo,
                          style: TextStyle(
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(175, 179, 200, 1)
                                  : const Color.fromRGBO(0, 0, 0, 0.8),
                              fontSize: 10.sp),
                        )
                            .marginSymmetric(horizontal: 4.w)
                            // .marginOnly(bottom: 3.h),
                      ],
                    ),
                  /// 即将开赛不显示
                  if (![
                        SportData.sportCsid_1, SportData.sportCsid_2, SportData.sportCsid_3, SportData.sportCsid_11
                      ].contains(csid) &&
                      widget.match.ms != SportData.sportMs_110)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// 总局数
                        if (![
                          SportData.sportCsid_4, SportData.sportCsid_6, SportData.sportCsid_7, SportData.sportCsid_8, SportData.sportCsid_9,
                          SportData.sportCsid_10, SportData.sportCsid_13, SportData.sportCsid_14, SportData.sportCsid_15, SportData.sportCsid_16
                        ].contains(csid))
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${LocaleKeys.list_total_play_count.tr} ",
                                style: TextStyle(
                                    color: Get.isDarkMode
                                        ? const Color.fromRGBO(175, 179, 200, 1)
                                        : const Color.fromRGBO(0, 0, 0, 0.8),
                                    fontSize: 10.sp),
                              ),
                              Text(
                                totalGames(),
                                style: TextStyle(
                                    color:
                                        const Color.fromRGBO(23, 156, 255, 1),
                                    fontSize: 10.sp),
                              ),
                            ],
                          ),
                        /// <!-- 总分   5--网球， 5--美式足球， 7--斯诺克， 8--乒乓球， 9--排球， 10--羽毛球，-->
                        if (SportData.getSportsCsid([
                              SportData.sportCsid_7, SportData.sportCsid_8, SportData.sportCsid_9, SportData.sportCsid_10,
                              SportData.sportCsid_13, SportData.sportCsid_15, SportData.sportCsid_16
                            ])!.contains(csid) && getTotalScores(widget.match) != '')
                          Text(
                            "${LocaleKeys.list_total_pp_score_count.tr} ",
                            style: TextStyle(
                                color: Get.isDarkMode ? const Color.fromRGBO(175, 179, 200, 1) : const Color.fromRGBO(0, 0, 0, 0.8),
                                fontSize: 10.sp),
                          ).marginOnly(right: 4.w),
                        if (SportData.getSportsCsid([
                              SportData.sportCsid_7, SportData.sportCsid_8, SportData.sportCsid_9, SportData.sportCsid_10,
                              SportData.sportCsid_13, SportData.sportCsid_14, SportData.sportCsid_15, SportData.sportCsid_16
                            ])!
                                .contains(csid) &&
                            getTotalScores(widget.match) != '')
                          Text(
                            totalGames(),
                            style: TextStyle(
                                color: const Color.fromRGBO(23, 156, 255, 1),
                                fontSize: 10.sp),
                          ),
                      ],
                    ),
                ],
              ),
            ///板球赛制
            if (isCricket)
              Text(
                "${widget.match.mfo} | ${LocaleKeys.list_total_pp_score_count.tr}",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'DIN Alternate',
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(175, 179, 200, 1)
                      : const Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ).marginOnly(left: 10.w),
            ///板球球总比分
            if (ShowCricketTotal)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${FormatScore.formatTotalScore(widget.match, 0, playId: "${SportData.sportCsid_37.toString()}").toString()}-${FormatScore.formatTotalScore(widget.match, 1, playId: "${SportData.sportCsid_37.toString()}").toString()}',
                    style: TextStyle(color: const Color.fromRGBO(23, 156, 255, 1), fontSize: 10.sp),
                  ).marginOnly(left: 4.w),
                  if( ['7', '8', '9', '10', '13', '14', '15', '16', '37'].contains(widget.match.csid))
                  Text(
                    '(${FormatScore.formatTotalScore(widget.match, 0, playId: SportData.sportCsid_37.toString())+FormatScore.formatTotalScore(widget.match, 1, playId: SportData.sportCsid_37.toString())})',
                    style: TextStyle(color: const Color.fromRGBO(23, 156, 255, 1), fontSize: 10.sp),
                  ).marginOnly(left: 4.w),
                ],
              ),
            ///  棒球3 出局 一垒二垒三垒
            if (isBaseball)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        fontSize: 12.sp),
                  ),
                ],
              ).marginOnly(left: 8.w)
          ],
        ),
      ],
    ).marginSymmetric(vertical: 4.h,)
        .marginOnly(bottom: 3.h);
  }
}
