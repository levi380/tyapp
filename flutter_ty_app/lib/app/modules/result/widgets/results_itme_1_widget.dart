


import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_itme_team_score_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';


import '../../../core/format/common/module/format-score.dart';
import '../../../services/models/res/get_notice_list_by_id_entity.dart';

import '../../../utils/sport.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';

import 'package:intl/intl.dart';

import '../gaming_results/gaming_results_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 普通赛果列表 组件   ResultsItemWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 普通赛果列表 组件   ResultsItemWidget
    - ResultsItemWidget
    ```
    ResultsItemWidget(
    isDark: context.isDarkMode,
    dataItem: dataItem,
    onExpandItem: () => controller.onExpandItem(dataItem),
    onGoToDetails: (item) => controller.onGoToDetails(item, widget.titleIndex),
    index: index,
    sportId: controller.sportid,
    )
    ```
    】】】
 *
 */
class ResultsItem1Widget extends StatelessWidget {
  const ResultsItem1Widget({
    super.key,
    required this.isDark,
    required this.dataItem,
    this.onExpandItem,
    required this.index,
    required this.onGoToDetails,
    required this.sportId,
    required this.isIcon,
    required this.onIsIcon,
    required this.noticeListByIdData,
    required this.mid,
  });

  final bool isDark;
  final TidDataList dataItem;
  final VoidCallback? onExpandItem;
  final int index;
  final void Function(dynamic) onGoToDetails;
  final String sportId;
  final bool isIcon;
  final void Function(dynamic,dynamic) onIsIcon;
  final List<GetNoticeListByIdData>  noticeListByIdData;
  final String mid;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: dataItem.isExpand,
      maintainAnimation: true,
      maintainState: true,
      child: Container(
        margin: EdgeInsets.only(
          left: 8.w,
          right: 8.w,
        ),
        child: Column(
          children:
          List<Widget>.generate(dataItem.list.length, (index) {
            return InkWell(
              onTap: () => onGoToDetails(dataItem.list[index]),
              child: Container(
                margin: EdgeInsets.only(
                  top: 3.h,
                ),
                decoration: index != dataItem.list.length - 1
                    ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(
                          alpha: 0.07999999821186066)
                          : const Color(0xFFE4E6ED),
                      width: 0.6.w,
                    ),
                  ),
                )
                    : null,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Text(
                                            formatDateTime(int.tryParse(TimeZoneUtils.convertTimeToTimestamp(dataItem.list[index].mgt, isMilliseconds: true, returnMilliseconds: true).toString()) ?? 0) + " (" + TimeZoneUtils.getTimeZoneString() + ")",
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white.withValues(
                                                  alpha:
                                                  0.30000001192092896)
                                                  : const Color(
                                                  0xFFAFB3C8),
                                              fontSize:
                                              isIPad ? 14.sp : 12.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          if(dataItem.list[index].isIcon)
                                            GestureDetector(
                                              onTap: () => onIsIcon(dataItem.list[index].mid,index),
                                              child: ImageView(
                                                'assets/images/icon/title_lb.svg',
                                                width: 18.w,
                                                height: 18.w,
                                              ).marginOnly(left: 5.w),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: sportId.contains('101') || sportId.contains('190') ? 3 : 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                LocaleKeys.msc_S1.tr,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: isDark ? Colors.white.withValues(alpha: 0.30000001192092896) : const Color(0xFFAFB3C8),
                                                  fontSize: isIPad ? 14.sp : 12.sp,
                                                  fontFamily: 'PingFang SC',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),

                                          if (sportId.contains('101') || sportId.contains('190'))
                                            Visibility(
                                              visible: showMsc(int.tryParse(dataItem.list[index].csid) ?? 0),
                                              child: Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    LocaleKeys.msc_S10.tr,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: isDark ? Colors.white.withValues(alpha: 0.30000001192092896)
                                                          : const Color(0xFFAFB3C8),
                                                      fontSize: isIPad ? 14.sp : 12.sp,
                                                      fontFamily: 'PingFang SC',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ///竖线占位
                                          Container(
                                            width: 17.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => onGoToDetails(dataItem.list[index]),
                                    child: SizedBox(
                                      width: Get.locale?.languageCode == 'zh' || Get.locale?.languageCode == 'tw' ? 30.w : 50.w,
                                      child: Text(
                                        LocaleKeys.list_go_to_details.tr,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: const Color(0xFF303442).withValues(alpha: 0.0),
                                          fontSize: isIPad ? 12.sp : 10.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 5.w,
                                  ),
                                  ImageView(
                                    context.isDarkMode ? 'assets/images/icon/results_details_dark.png' : 'assets/images/icon/results_details_light.png',
                                    width: 12.w,
                                    height: 12.w,
                                    color: const Color(0xFF303442).withValues(alpha: 0.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  ResultsItemTeamScoreWidget(
                                      teamName: dataItem.list[index].mhn,
                                      fullScore: TYFormatScore.formatTotalScore(dataItem.list[index]).home,
                                      penaltyScore: TYFormatScore.formatScorePenaltyScore(dataItem.list[index].msc, 0).toString(),
                                      isDark: isDark,
                                      sportId: sportId,
                                      showPenalty: showMsc(int.tryParse(dataItem.list[index].csid) ?? 0)),
                                  ResultsItemTeamScoreWidget(
                                      teamName: dataItem.list[index].man,
                                      fullScore: TYFormatScore.formatTotalScore(dataItem.list[index]).away,
                                      penaltyScore: TYFormatScore.formatScorePenaltyScore(dataItem.list[index].msc, 1).toString(),
                                      isDark: isDark,
                                      sportId: sportId,
                                      showPenalty: showMsc(int.tryParse(dataItem.list[index].csid) ?? 0)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 0.50.w,
                                    height: 50.h,
                                    color: isDark
                                        ? const Color(0x14E4E6ED)
                                        : const Color(0xFFE4E6ED),
                                  ),
                                  Container(
                                    width: 10.w,
                                  ),
                                  dataItem.list[index].ms == 5
                                      ? Row(
                                    children: [
                                      InkWell(
                                        onTap: () => onGoToDetails(dataItem.list[index]),
                                        child: SizedBox(
                                          width: Get.locale?.languageCode == 'zh' || Get.locale?.languageCode == 'tw' ? 30.w : 50.w,
                                          child: Text(
                                            dataItem.list[index].ms == 5 ? LocaleKeys.bet_record_cancel_type_1.tr : LocaleKeys.list_go_to_details.tr,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: dataItem.list[index].ms == 5 ? Colors.red : isDark ? Colors.white : const Color(0xFF303442),
                                              fontSize: 10.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      InkWell(
                                        onTap: () => onGoToDetails(
                                            dataItem.list[index]),
                                        child: SizedBox(
                                          width: Get.locale?.languageCode == 'zh' || Get.locale?.languageCode == 'tw' ? 30.w : 50.w,
                                          child: Text(
                                            LocaleKeys.list_go_to_details.tr,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: isDark ? Colors.white : const Color(0xFF303442),
                                              fontSize: isIPad ? 12.sp : 10.sp,
                                              fontFamily: 'PingFang SC',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 5.w,
                                      ),
                                      ImageView(
                                        context.isDarkMode ? 'assets/images/icon/results_details_dark.png' : 'assets/images/icon/results_details_light.png',
                                        width: 12.w,
                                        height: 12.w,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        if(isIcon&&mid== dataItem.list[index].mid)
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      noticeListByIdData[0].context,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: isIPad ? 14.sp : 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      formatDateTimes(int.tryParse(TimeZoneUtils.convertTimeToTimestamp(noticeListByIdData[0].sendTimeOther, isMilliseconds: true, returnMilliseconds: true).toString()) ?? 0) + " (" + TimeZoneUtils.getTimeZoneString() + ")",
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: isIPad ? 14.sp : 12.sp,
                                        fontFamily: 'PingFang SC',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ).marginOnly(top: 5.h),

                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  ///是否显示点球比分
  bool showMsc(int csid) {
    ///特定球种csid 不显示点球比分
    List hideList = SportData.getSportsCsid([37])!;
    return !hideList.contains(csid);
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }

  formatDateTimes(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp,isUtc: true);
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(date);
  }
}
