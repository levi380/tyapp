import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/bet/controllers/bet_record_controller.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/date_picker/show_time_bottom.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 日期选择Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 日期选择。自定义日期会显示起始日期和截至日期
    】】】
 *
 */
class BetDateWidget extends StatelessWidget {
  BetDateWidget({super.key});

  final state = BetRecordController.to.state;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    //是不是选中自定义时间
    bool isCheckCustom = state.timeType == 5;
    return Container(
      height: 44.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 8.h, left: 8.w, right: 16.w, bottom: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: BetRecordController.to.state.scrollController,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      BetRecordController.to.changeTimeType(0);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: state.timeType == 0
                            ? themeData.betItemTabSelectedColor
                            : themeData.orderDateTabBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
                        child: Text(
                          LocaleKeys.app_h5_match_all.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: state.timeType == 0
                                ? Colors.white
                                : themeData.orderDateTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: state.timeType == 0
                                ? FontWeight.w600
                                : FontWeight.w500,
                            height: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      BetRecordController.to.changeTimeType(1);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: state.timeType == 1
                            ? themeData.betItemTabSelectedColor
                            : themeData.orderDateTabBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
                        child: Text(
                          LocaleKeys.app_bet_date_list_0.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: state.timeType == 1
                                ? Colors.white
                                : themeData.orderDateTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: state.timeType == 0
                                ? FontWeight.w600
                                : FontWeight.w500,
                            height: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      BetRecordController.to.changeTimeType(2);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: state.timeType == 2
                            ? themeData.betItemTabSelectedColor
                            : themeData.orderDateTabBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
                        child: Text(
                          LocaleKeys.app_bet_date_list_1.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: state.timeType == 2
                                ? Colors.white
                                : themeData.orderDateTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: state.timeType == 0
                                ? FontWeight.w600
                                : FontWeight.w500,
                            height: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      BetRecordController.to.changeTimeType(3);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: state.timeType == 3
                            ? themeData.betItemTabSelectedColor
                            : themeData.orderDateTabBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
                        child: Text(
                          LocaleKeys.app_bet_date_list_2.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: state.timeType == 3
                                ? Colors.white
                                : themeData.orderDateTextColor,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: state.timeType == 0
                                ? FontWeight.w600
                                : FontWeight.w500,
                            height: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      showTimeBottom.resetinitTime();
                      BetRecordController.to.changeTimeType(5);
                      BetRecordController.to.showTime(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: isCheckCustom
                            ? themeData.betItemTabSelectedColor
                            : themeData.orderDateTabBgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                      child: _showStatus(isCheckCustom, themeData),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              padding: EdgeInsets.only(left: 10.w),
              child: ImageView(
                state.isExapndedAll
                    ? 'assets/images/bets/betitem_expanded.png'
                    : 'assets/images/bets/betitem_collapse.png',
                width: 20.w,
                color: themeData.orderDateTextColor,
                onTap: () {
                  BetRecordController.to.changeExpanded(exapnd: !state.isExapndedAll);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showStatus(bool isCheckCustom, ThemeData themeData) {
    if (isCheckCustom &&
        state.endTimeUi.isNotEmpty &&
        state.startTimeUi.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only( left: 15.w, right: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.startTimeUi,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 7.5.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ).paddingOnly(bottom: 2.w),
            Text(
              state.endTimeUi,
              maxLines: 1,
              style: TextStyle(
                color: Colors.white,
                fontSize: 7.5.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 15.w, right: 15.w),
        child: Text(
          LocaleKeys.zr_cp_settings_Menu_zr_customize.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isCheckCustom?Colors.white: themeData.orderDateTextColor,
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: state.timeType == 0 ? FontWeight.w600 : FontWeight.w500,
            height: 0.8,
          ),
        ),
      );
    }
  }
}
