import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/result/widgets/results_item_dj_team_widget.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../core/format/common/module/format-score.dart';
import '../../../services/models/res/get_notice_list_by_id_entity.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../utils/csid_util copy.dart';
import '../../../utils/time_zone/timeZoneUtils.dart';

import 'package:intl/intl.dart';

import '../../../widgets/sport_icon.dart';
import '../gaming_results/gaming_results_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-b2ccb138-282e-4221-bd35-397e2c2dd9d2-sg 】】】
    【【【 AUTO_DOCUMENT_MENU 赛果 】】】
    【【【 AUTO_DOCUMENT_TITLE 赛果】】】
    【【【 AUTO_PARAGRAPH_TITLE 电竞赛果列表 组件   ResultsItemDjWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 电竞赛果列表 组件  ResultsItemDjWidget
    - ResultsItemDjWidget
    ```
    ResultsItemDjWidget(
      isDark: context.isDarkMode,
      dataItem: dataItem,
      onExpandItem: () => controller.onExpandItem(dataItem),
      onGoToDetails: (item) =>
      controller.onGoToDetails(item, widget.titleIndex),
      index: index,
    )
    ```
    】】】
 *
 */
class ResultsItemDjWidget extends StatelessWidget {
  const ResultsItemDjWidget({
    super.key,
    required this.isDark,
    required this.isIcon,
    required this.dataItem,
    required this.noticeListByIdData,
    this.onExpandItem,
    required this.index,
    required this.onGoToDetails,
    required this.onIsIcon,
    required this.mid,
    required this.miid,
  });

  final bool isDark;
  final bool isIcon;
  final TidDataList dataItem;
  final List<GetNoticeListByIdData>  noticeListByIdData;
  final VoidCallback? onExpandItem;
  final int index;
  final void Function(dynamic) onGoToDetails;
  final void Function(dynamic) onIsIcon;
  final String mid;
  final int miid;

  @override
  Widget build(BuildContext context) {
    int position = SpriteImagesPosition.data[(miid)] ?? 0;
    return Container(
      color: isDark ? null : const Color(0xFFF2F2F6),
      child: Container(
        margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
        decoration: isDark
            ? ShapeDecoration(
                color: Colors.white.withValues(alpha:0.03999999910593033),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.w,
                    color: Colors.white.withValues(alpha:0.03999999910593033),
                  ),
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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
        child: StickyHeader(
          header: InkWell(
            onTap: onExpandItem,
            child: Container(
              color: Get.isDarkMode
                  ? ChangeSkinToneColorUtil.instance().getDarkBackgroundColor(colorStyle_1: Color(0xFF2B2D33) ,colorStyle_2: Color(0xFF23292D),colorStyle_3: Color(0xFF26242A))
                  : const Color(0xffF8F9FA),
              margin: EdgeInsets.only(right: 5.w),
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
                      dataItem.lurl.isEmpty ?
                      sportIcon(
                        index: position,
                        width: 24.w,
                        height: 24.w,
                        isSelected: true,
                      ):
                      ImageView(
                       dataItem.lurl,
                        dj: true,
                        width: 20.w,
                        height: 20.w,
                        errorWidget:ImageView(
                          "assets/images/home/list/placeholder_team.png",
                          cdn: true,
                          width: 20.w,
                          height: 20.w,
                        ) ,
                      ),
                      Container(
                        width: 8.w,
                      ),
                      SizedBox(
                        width: 300.w,
                        child: AutoSizeText(
                          dataItem.tn,
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
                  Transform.rotate(
                    angle: dataItem.isExpand ? 0 : -pi / 2,
                    child: ImageView(
                      context.isDarkMode
                          ? 'assets/images/icon/results_folding_dark.png'
                          : 'assets/images/icon/results_folding_light.png',
                      width: 13.w,
                      height: 13.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          content: Column(
            children: [
              dataItem.isExpand
                  ? Container(
                      color: isDark
                          ? Colors.white.withValues(alpha:0.07999999821186066)
                          : const Color(0xFFE4E6ED),
                      height: 0.5.h,
                    )
                  : Container(),
              Visibility(
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
                                          ? Colors.white
                                              .withValues(alpha:0.07999999821186066)
                                          : const Color(0xFFE4E6ED),
                                      width: 0.6.w,
                                    ),
                                  ),
                                )
                              : null,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        formatDateTime(int.tryParse(TimeZoneUtils
                                            .convertTimeToTimestamp(
                                            dataItem.list[index].mgt,
                                            isMilliseconds: true,
                                            returnMilliseconds: true)
                                            .toString()) ??
                                            0) +
                                            " (" +
                                            TimeZoneUtils.getTimeZoneString() +
                                            ")",
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              .withValues(alpha:0.30000001192092896)
                                              : const Color(0xFFAFB3C8),
                                          fontSize: isIPad ? 14.sp : 12.sp,
                                          fontFamily: 'PingFang SC',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    if(dataItem.list[index].isIcon)
                                      GestureDetector(
                                        onTap: () => onIsIcon(dataItem.mid),
                                        child: ImageView(
                                          'assets/images/icon/title_lb.svg',
                                          width: 18.w,
                                          height: 18.w,
                                        ).marginOnly(left: 5.w),
                                      ),
                                  ],
                                ),
                              ),
                              Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            ResultsItemDjTeamWidget(
                                                isDark: isDark,
                                                teamText: dataItem.list[index].mhn,
                                                scoreText: TYFormatScore.formatTotalScore(
                                                    dataItem.list[index])
                                                    .home
                                            ),
                                            ResultsItemDjTeamWidget(
                                                isDark: isDark,
                                                teamText: dataItem.list[index].man,
                                                scoreText: TYFormatScore.formatTotalScore(
                                                    dataItem.list[index])
                                                    .away
                                            ),
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
                                                  onTap: () => onGoToDetails(
                                                      dataItem.list[index]),
                                                  child: SizedBox(
                                                    width: Get.locale
                                                        ?.languageCode ==
                                                        'zh' ||
                                                        Get.locale
                                                            ?.languageCode ==
                                                            'tw'
                                                        ? 30.w
                                                        : 50.w,
                                                    child: Text(
                                                      dataItem.list[index]
                                                          .ms ==
                                                          5
                                                          ? LocaleKeys
                                                          .bet_record_cancel_type_1
                                                          .tr
                                                          : LocaleKeys
                                                          .list_go_to_details
                                                          .tr,
                                                      textAlign:
                                                      TextAlign.end,
                                                      style: TextStyle(
                                                        color: dataItem
                                                            .list[
                                                        index]
                                                            .ms ==
                                                            5
                                                            ? Colors.red
                                                            : isDark
                                                            ? Colors.white
                                                            : const Color(
                                                            0xFF303442),
                                                        fontSize: 10.sp,
                                                        fontFamily:
                                                        'PingFang SC',
                                                        fontWeight:
                                                        FontWeight.w400,
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
                                                    width: Get.locale
                                                        ?.languageCode ==
                                                        'zh' ||
                                                        Get.locale
                                                            ?.languageCode ==
                                                            'tw'
                                                        ? 30.w
                                                        : 50.w,
                                                    child: Text(
                                                      LocaleKeys
                                                          .list_go_to_details
                                                          .tr,
                                                      textAlign:
                                                      TextAlign.end,
                                                      style: TextStyle(
                                                        color: isDark
                                                            ? Colors.white
                                                            : const Color(
                                                            0xFF303442),
                                                        fontSize: isIPad ? 12.sp : 10.sp,
                                                        fontFamily:
                                                        'PingFang SC',
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 5.w,
                                                ),
                                                ImageView(
                                                  context.isDarkMode
                                                      ? 'assets/images/icon/results_details_dark.png'
                                                      : 'assets/images/icon/results_details_light.png',
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
                                  if(isIcon&& mid == dataItem.list[index].mid)
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
                                                formatDateTimes(int.tryParse(TimeZoneUtils
                                                    .convertTimeToTimestamp(
                                                    noticeListByIdData[0].sendTimeOther,
                                                    isMilliseconds: true,
                                                    returnMilliseconds: true)
                                                    .toString()) ??
                                                    0) +
                                                    " (" +
                                                    TimeZoneUtils.getTimeZoneString() +
                                                    ")",
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
              ),
              SizedBox(
                height: 5.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  formatDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp,isUtc: true);
    var formatter = DateFormat('MM/dd HH:mm');
    return formatter.format(date);
  }

  formatDateTimes(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp,isUtc: true);
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(date);
  }
}
