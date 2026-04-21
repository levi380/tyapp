import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/vr_results/widgets/vr_sm_item/vr_sm_itme_ranking_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/services/models/res/query_tournament_score_result_entity.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:intl/intl.dart';

// import '../../../../utils/change_skin_tone_color_util.dart';
// import '../../../../utils/time_zone/timeZoneUtils.dart';
// import '../../../../utils/vr_rank_icon_utils.dart';
import '../../../../../utils/change_skin_tone_color_util.dart';
import '../../../../../utils/time_zone/timeZoneUtils.dart';
import '../../../../../utils/vr_rank_icon_utils.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-3d55b048-92b4-4be6-a119-1d7d90b81aef-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE VR赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE  VR赛果 赛马列表件 VrSmItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  VR赛果 赛马列表件 VrSmItemWidget
    - VrSmItemWidget
    】】】
 *
 */
class VrSmItemWidget extends StatelessWidget {
  const VrSmItemWidget({
    super.key,
    required this.isDark,
    required this.recordsList,
    this.onExpandItem,
    required this.isExpand,
    required this.vRMenuMenuId,
  });

  final bool isDark;
  final List<QueryTournamentScoreResultDataRecords> recordsList;
  final VoidCallback? onExpandItem;
  final bool isExpand;
  final String vRMenuMenuId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, left: 8.h, right: 8.h, bottom: 20.h),
      child: Column(
        children: [
          GestureDetector(
            onTap: onExpandItem,
            child: Container(
              decoration: isDark
                  ? ShapeDecoration(
                      color: ChangeSkinToneColorUtil.instance()
                          .getDarkBackgroundColor(
                              colorStyle_1: Color(0xFF2B2D33),
                              colorStyle_2: Color(0xFF23292D),
                              colorStyle_3: Color(0xFF26242A)),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5.h,
                          color: Colors.white
                              .withValues(alpha: 0.03999999910593033),
                        ),
                        borderRadius: isExpand
                            ? BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                            : BorderRadius.circular(8),
                      ),
                      shadows: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ])
                  : ShapeDecoration(
                      color: const Color(0xFFF8F9FA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.5.h, color: Colors.white),
                        borderRadius: isExpand
                            ? BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              )
                            : BorderRadius.circular(8),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
              height: 30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageView(
                        'assets/images/icon/title_tag.png',
                        width: 2.w,
                        height: 15.w,
                      ),
                      Container(
                        width: 8.w,
                      ),
                      SizedBox(
                        width: 300.w,
                        child: AutoSizeText(
                          recordsList[0].tournamentName,
                          style: TextStyle(
                            color:
                                isDark ? Colors.white : const Color(0xFF303442),
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: Transform.rotate(
                      angle: isExpand ? 0 : -pi / 2,
                      child: ImageView(
                        context.isDarkMode
                            ? 'assets/images/icon/results_folding_dark.png'
                            : 'assets/images/icon/results_folding_light.png',
                        width: 13.w,
                        height: 13.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpand)
            Container(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.07999999821186066)
                  : const Color(0xFFE4E6ED),
              height: 0.5.h,
            ),
          Visibility(
            visible: isExpand,
            maintainAnimation: true,
            maintainState: true,
            child: Container(
              decoration: isDark
                  ? ShapeDecoration(
                      color: ChangeSkinToneColorUtil.instance()
                          .getDarkBackgroundColor(
                              colorStyle_1: Color(0xFF2B2D33),
                              colorStyle_2: Color(0xFF23292D),
                              colorStyle_3: Color(0xFF26242A)),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5.h,
                          color: Colors.white
                              .withValues(alpha: 0.03999999910593033),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      shadows: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ])
                  : ShapeDecoration(
                      color: const Color(0xFFF8F9FA),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: Colors.white),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: List<Widget>.generate(recordsList.length, (index) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: 3.h,
                      ),
                      decoration: index != recordsList.length - 1
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: isDark
                                      ? Colors.white.withValues(
                                          alpha: 0.30000001192092896)
                                      : const Color(0xFFE4E6ED),
                                  width: 0.5.h,
                                ),
                              ),
                            )
                          : null,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 60.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: Text(
                                    recordsList[index].batchNo.toString() +
                                        " " +
                                        LocaleKeys
                                            .zr_cp_Lottery_Bet_Slips_period.tr,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF333333),
                                      fontSize: isIPad ? 14.sp : 12.sp,
                                      fontFamily: 'PingFang SC',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      VrSmItemRankingWidget(
                                          isDark: isDark,
                                          rankingIcon: getIconByRankIndex(
                                              recordsList[index].sportId,
                                              int.tryParse(extractNumbers(
                                                      recordsList[index]
                                                          .scoreResult)[0]) ??
                                                  1002),
                                          rankingName: LocaleKeys
                                              .menu_itme_name_champion.tr,
                                          showImg: recordsList[index]
                                              .scoreResult
                                              .isNotEmpty),
                                      // Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Text(
                                      //       LocaleKeys.menu_itme_name_champion.tr,
                                      //       style: TextStyle(
                                      //         color: isDark
                                      //             ? Colors.white
                                      //             : const Color(0xFF333333),
                                      //         fontSize: isIPad?14.sp:12.sp,
                                      //         fontFamily: 'PingFang SC',
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      //     ),
                                      //     Container(height: 5.h,),
                                      //     if(recordsList[index].scoreResult.isNotEmpty)
                                      //     ImageView(
                                      //
                                      //       width: 22.w,
                                      //       height: 22.w,
                                      //     ),
                                      //   ],
                                      // ),
                                      VrSmItemRankingWidget(
                                          isDark: isDark,
                                          rankingIcon: getIconByRankIndex(
                                              recordsList[index].sportId,
                                              int.tryParse(extractNumbers(
                                                      recordsList[index]
                                                          .scoreResult)[1]) ??
                                                  1002),
                                          rankingName: LocaleKeys
                                              .virtual_sports_runner_up.tr,
                                          showImg: recordsList[index]
                                              .scoreResult
                                              .isNotEmpty),
                                      // Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Text(
                                      //       LocaleKeys.virtual_sports_runner_up.tr,
                                      //       style: TextStyle(
                                      //         color: isDark
                                      //             ? Colors.white
                                      //             : const Color(0xFF333333),
                                      //         fontSize: isIPad?14.sp:12.sp,
                                      //         fontFamily: 'PingFang SC',
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      //     ),
                                      //     Container(height: 5.h,),
                                      //     ImageView(
                                      //
                                      //       width: 22.w,
                                      //       height: 22.w,
                                      //     ),
                                      //   ],
                                      // ),
                                      VrSmItemRankingWidget(
                                          isDark: isDark,
                                          rankingIcon: getIconByRankIndex(
                                              recordsList[index].sportId,
                                              int.tryParse(extractNumbers(
                                                      recordsList[index]
                                                          .scoreResult)[2]) ??
                                                  1002),
                                          rankingName: LocaleKeys
                                              .virtual_sports_third_place.tr,
                                          showImg: recordsList[index]
                                              .scoreResult
                                              .isNotEmpty),
                                      // Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Text(
                                      //       LocaleKeys.virtual_sports_third_place.tr,
                                      //       style: TextStyle(
                                      //         color: isDark
                                      //             ? Colors.white
                                      //             : const Color(0xFF333333),
                                      //         fontSize: isIPad?14.sp:12.sp,
                                      //         fontFamily: 'PingFang SC',
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      //     ),
                                      //     Container(height: 5.h,),
                                      //     ImageView(
                                      //
                                      //       width: 22.w,
                                      //       height: 22.w,
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: Container(
                                    width: 100.w,
                                    child: Text(
                                      formatDateTime(int.tryParse(TimeZoneUtils
                                                      .convertTimeToTimestamp(
                                                          recordsList[index]
                                                              .matchTime,
                                                          isMilliseconds: true,
                                                          returnMilliseconds:
                                                              true)
                                                  .toString()) ??
                                              0) +
                                          " (" +
                                          TimeZoneUtils.getTimeZoneString() +
                                          ")",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF333333),
                                        fontSize: isIPad ? 14.sp : 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    var formatter = DateFormat('MM月dd日 HH:mm');
    return formatter.format(date);
  }

  ///公共获取vr赛狗 vr赛马 vr摩托车 vr泥地摩托车 图标 公共方法
  String getIconByRankIndex(String? csid, int index) {
    String icon = VrRankIconUtils.getRankIcon(
        int.tryParse(csid ?? '1002') ?? 1002, index.toString());
    if (icon.isEmpty) {
      icon = 'assets/images/vr/vr_dog_horse_rank$index.png';
    }
    return icon;
  }

  List<String> extractNumbers(String text) {
    /// 使用正则表达式提取数字
    RegExp regExp = RegExp(r'(\d+)\(\d+\)');
    Iterable<Match> matches = regExp.allMatches(text);

    /// 将匹配的内容转换为列表
    return matches.map((match) => match.group(1)!).toList();
  }
}
