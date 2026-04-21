import 'dart:math';



import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';


import 'package:intl/intl.dart';

import '../../../utils/calcText_util.dart';
import 'mi_apuesta_item_widget.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 赛果详情 我的注单 组件  MatchReplayWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 赛果详情 我的注单 组件  MatchReplayWidget
    - MatchReplayWidget
    ```
    ```
    】】】
 *
 */

class MiApuestaWidget extends StatelessWidget {
  const MiApuestaWidget({
    super.key,
    required this.isDark,
    required this.miApuestaData,
    required this.onBetIsExpand,
  });

  final bool isDark;
  final List<GetH5OrderListDataRecordxData> miApuestaData;
  final void Function(dynamic, dynamic) onBetIsExpand;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isDark ? null : Colors.white,
      height: double.maxFinite,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: miApuestaData.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              color: isDark ? null : Colors.white,
              child: Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    if (int.parse(miApuestaData[index].seriesType) != 1)
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          miApuestaData[index].seriesValue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                isDark ? Colors.white : const Color(0xFF303442),
                            fontSize: 14.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: miApuestaData[index].orderVOS.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index1) {
                          GetH5OrderListDataRecordxDataOrderVOS orderVOS =
                              miApuestaData[index].orderVOS[index1];
                          return Column(
                            children: [
                              if (miApuestaData[index].matchType != 3 &&
                                  miApuestaData[index].seriesType == '1')
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10.h,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ImageView(
                                            orderVOS.tournamentPic,
                                            cdn: true,
                                            width: 20.w,
                                            height: 20.w,
                                          ).marginOnly(right: 8.w),
                                          Text(
                                            orderVOS.matchName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : const Color(0xFF414655),
                                              fontSize: 14.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      if (miApuestaData[index].preOrder != null)
                                        Text(
                                          LocaleKeys.pre_record_book.tr,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: isDark
                                                ? const Color.fromRGBO(
                                                    23, 156, 255, 1)
                                                : const Color(0xFFffb001),
                                            fontSize: 14.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 20.h,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        miApuestaData[index].seriesType == '1'
                                            ? Container(
                                                width: 3.w,
                                                height: 12.h,
                                                color: Colors.red,
                                              )
                                            : ImageView(
                                                orderVOS.tournamentPic,
                                                cdn: true,
                                                width: 22.w,
                                                height: 22.w,
                                              ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          orderVOS.matchInfo,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: isDark
                                                ? Colors.white
                                                : const Color(0xFF414655),
                                            fontSize: 14.sp,
                                            fontFamily: 'PingFang SC',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      formatDateTime(
                                          int.parse(orderVOS.beginTime)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : const Color(0xFF414655),
                                        fontSize: 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 25.h,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${orderVOS.sportName}   ${'types_competitions_matchtype_${orderVOS.matchType}'.tr}  ${orderVOS.playName}${orderVOS.scoreBenchmark.isEmpty ? '' : '('} ${orderVOS.scoreBenchmark.replaceAll(':', '-')} ${orderVOS.scoreBenchmark.isEmpty ? '' : ')'}  [${'types_competitions_odds_${orderVOS.marketType}'.tr}]',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF707070),
                                                  fontSize: 12.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (orderVOS.settleScore != '' &&
                                              miApuestaData[index]
                                                      .orderStatus !=
                                                  1 &&
                                              miApuestaData[index].seriesType !=
                                                  '1')
                                            Expanded(
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  orderVOS.settleScore,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: isDark
                                                        ? Colors.white
                                                        : const Color(
                                                            0xFF707070),
                                                    fontSize: 12.sp,
                                                    fontFamily: 'PingFang SC',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                orderVOS.marketValue,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: isDark
                                                      ? Colors.white
                                                      : const Color(0xFF414655),
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '@ ${orderVOS.oddFinally}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            calcText(
                                                miApuestaData[index], orderVOS),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white
                                                  : const Color(0xFF707070),
                                              fontSize: 14.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    InkWell(
                      onTap: () => onBetIsExpand(
                          miApuestaData[index].betIsExpand, index),
                      child: Container(
                        height: 20.w,
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: 6.w,
                            right: 4.w,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                miApuestaData[index].betIsExpand
                                    ? LocaleKeys.tips_close.tr
                                    : LocaleKeys.tips_expand.tr,
                                style: TextStyle(
                                  color: context.isDarkMode
                                      ? Colors.white
                                          .withValues(alpha: 0.4000000059604645)
                                      : const Color(0xFF949AB6),
                                  fontSize: 12.sp,
                                  fontFamily: 'PingFang SC',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Transform.rotate(
                                angle: miApuestaData[index].betIsExpand
                                    ? -pi / 1
                                    : 0,
                                child: ImageView(
                                  context.isDarkMode
                                      ? 'assets/images/league/tips_expand_dark.png'
                                      : 'assets/images/league/tips_expand_light.png',
                                  width: 10.w,
                                  height: 10.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MiApuestaItemWidget(
                      index: index,
                      isDark: isDark,
                      miApuestaData: miApuestaData,
                      onBetIsExpand: onBetIsExpand,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }
}

Map betResultValue = {
  //'未结算',
  0: LocaleKeys.bet_record_bet_no_status00.tr,
  //'走水',
  2: LocaleKeys.bet_record_bet_no_status02.tr,
  //'输',
  3: LocaleKeys.bet_record_bet_no_status03.tr,
  //'赢',
  4: LocaleKeys.bet_record_bet_no_status04.tr,
  //'赢半',
  5: LocaleKeys.bet_record_bet_no_status05.tr,
  //'输半',
  6: LocaleKeys.bet_record_bet_no_status06.tr,
  //'比赛取消',
  7: LocaleKeys.bet_record_bet_no_status07.tr,
  //'比赛延期',
  8: LocaleKeys.bet_record_bet_no_status08.tr,
  // '比赛延迟',
  11: LocaleKeys.bet_record_bet_no_status11.tr,
  // '比赛中断',
  12: LocaleKeys.bet_record_bet_no_status12.tr,
  // '比赛放弃'
  15: LocaleKeys.bet_record_bet_no_status15.tr
};

Map betResult1 = {
  // '比赛取消',
  7: LocaleKeys.bet_record_bet_no_status07.tr,
  //'比赛延期',
  8: LocaleKeys.bet_record_bet_no_status08.tr,
  // '比赛延迟',
  11: LocaleKeys.bet_record_bet_no_status11.tr,
  // '比赛中断',
  12: LocaleKeys.bet_record_bet_no_status12.tr,
  // '比赛放弃'
  15: LocaleKeys.bet_record_bet_no_status15.tr,
};

//手动取消订单的原因展示
Map betResult3 = {
  1: LocaleKeys.bet_record_cancel_type_1.tr,
  2: LocaleKeys.bet_record_cancel_type_2.tr,
  3: LocaleKeys.bet_record_cancel_type_3.tr,
  4: LocaleKeys.bet_record_cancel_type_4.tr,
  5: LocaleKeys.bet_record_cancel_type_5.tr,
  6: LocaleKeys.bet_record_cancel_type_6.tr,
  17: LocaleKeys.bet_record_cancel_type_17.tr,
  20: LocaleKeys.bet_record_cancel_type_20.tr
};

// footer

Map footBetResult = {
  //'未结算',
  0: LocaleKeys.bet_record_bet_no_status00.tr,
  //'走水',
  2: LocaleKeys.bet_record_bet_no_status02.tr,
  //  //'输',
  3: LocaleKeys.bet_record_bet_no_status03.tr,
  // //'赢',
  4: LocaleKeys.bet_record_bet_no_status04.tr,
  // //'赢半',
  5: LocaleKeys.bet_record_bet_no_status05.tr,
  // //'输半',
  6: LocaleKeys.bet_record_bet_no_status06.tr,
  // //'比赛取消',
  7: LocaleKeys.bet_record_bet_no_status07.tr,
  // //'比赛延期',
  8: LocaleKeys.bet_record_bet_no_status08.tr,
  // // '比赛延迟',
  11: LocaleKeys.bet_record_bet_no_status11.tr,
  // // '比赛中断',
  12: LocaleKeys.bet_record_bet_no_status12.tr,
  // // '比赛放弃'
  15: LocaleKeys.bet_record_bet_no_status15.tr,
};
Map footOutcome = {
  // //'走水',
  2: LocaleKeys.bet_record_bet_no_status02.tr,
  // //'输',
  3: LocaleKeys.bet_record_bet_no_status03.tr,
  // //'赢',
  4: LocaleKeys.bet_record_bet_no_status04.tr,
  // //'赢半',
  5: LocaleKeys.bet_record_bet_no_status05.tr,
  // //'输半',
  6: LocaleKeys.bet_record_bet_no_status06.tr,
};
