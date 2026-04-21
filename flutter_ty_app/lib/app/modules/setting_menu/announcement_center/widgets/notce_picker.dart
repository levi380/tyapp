import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';



/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a3a627ae-2de5-4ce2-862f-eeb8573aa24d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 公告中心】】】
    【【【 AUTO_PARAGRAPH_TITLE 公告中心 时间选择弹框 NoticePickerWidget  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 公告中心 时间选择弹框 NoticePickerWidget
    - NoticePickerWidget
    ```
    DateTime today = DateTime.now();
    ///起始日期 提前15天
    DateTime firstDay = DateTime.now().subtract(const Duration(days: 14));
    ///终止日期  今日
    DateTime lastDay = DateTime.now();

    ///强制设置日期
    DateTime focusedDay = DateTime.now();
    ///强制选择范围
    RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;

    ```
    】】】
 *
 */

typedef SelectDataCallback = void Function( DateTime? rangeStart, DateTime? rangeEnd);

class NoticePickerWidget extends StatefulWidget {
  ///外部日期范围
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final SelectDataCallback onItemClick;
   NoticePickerWidget({super.key,required this.onItemClick,
  required this.rangeStart,required this.rangeEnd});

  @override
  State<NoticePickerWidget> createState() => _NoticePickerWidgetState();
}

class _NoticePickerWidgetState extends State<NoticePickerWidget> {
  DateTime today = DateTime.now();
  ///起始日期 提前15天
  DateTime firstDay = DateTime.now().subtract(const Duration(days: 14));
  ///终止日期  今日
  DateTime lastDay = DateTime.now();

  ///强制设置日期
  DateTime focusedDay = DateTime.now();
  ///强制选择范围
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;

  final mainColor = const Color(0xFF127DCC);
  late int selectedYear;
  late int selectedMonth;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  @override
  void initState() {
    rangeStart = widget.rangeStart;
    rangeEnd = widget.rangeEnd;
    super.initState();
    focusedDay = DateTime.now();
    selectedYear = focusedDay.year;
    selectedMonth = focusedDay.month;
  }

  void updateFocusedDay() {
    final newFocusedDay = DateTime(selectedYear, selectedMonth, 1);
    setState(() {
      focusedDay = newFocusedDay;
    });
  }

  bool isInRange(DateTime day) {
    if (rangeStart == null) return false;
    if (rangeEnd == null) return isSameDay(rangeStart, day);
    return day.isAfter(rangeStart!.subtract(const Duration(days: 1))) &&
        day.isBefore(rangeEnd!.add(const Duration(days: 1)));
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay_) {
    setState(() {
      focusedDay = focusedDay_;
      if (rangeSelectionMode == RangeSelectionMode.toggledOff) {
        rangeStart = selectedDay;
        rangeEnd = null;
        rangeSelectionMode = RangeSelectionMode.toggledOn;
      } else if (rangeSelectionMode == RangeSelectionMode.toggledOn &&
          rangeStart != null &&
          rangeEnd == null) {
        if (selectedDay.isBefore(rangeStart!)) {
          rangeEnd = rangeStart;
          rangeStart = selectedDay;
        } else {
          rangeEnd = selectedDay;
        }
      } else {
        rangeStart = selectedDay;
        rangeEnd = null;
        rangeSelectionMode = RangeSelectionMode.toggledOn;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 350.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                context.isDarkMode
                    ? 'assets/images/date _background_dark.png'
                    : 'assets/images/date _background_light.png',
              ),
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.h),
              child: Text(
                LocaleKeys.app_query_date.tr,
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : const Color(0xFF303442),
                  fontSize: 14.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon:  Icon(Icons.chevron_left,
                          color: context.isDarkMode
                              ? Color(0xFF6E717B)
                              :  Color(0xFFC9CDDB),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedMonth = selectedMonth == 1 ? 12 : selectedMonth - 1;
                            if (selectedMonth == 12) selectedYear--;
                            updateFocusedDay();
                          });
                        },
                      ),

                      Text(
                        '$selectedMonth${LocaleKeys.zr_cp_bet_Window_month.tr}',
                        style: TextStyle(
                          color: context.isDarkMode ? Colors.white :const Color(0xFF303442) /* text-color-text */,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      IconButton(
                        icon:  Icon(Icons.chevron_right,
                          color: context.isDarkMode
                              ? Color(0xFF6E717B)
                              : Color(0xFFC9CDDB),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedMonth = selectedMonth == 12 ? 1 : selectedMonth + 1;
                            if (selectedMonth == 1) selectedYear++;
                            updateFocusedDay();
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon:  Icon(Icons.chevron_left,
                          color: context.isDarkMode
                              ? Color(0xFF6E717B)
                              : Color(0xFFC9CDDB),

                        ),
                        onPressed: () {
                          setState(() {
                            selectedYear--;
                            updateFocusedDay();
                          });
                        },
                      ),
                      Text(
                        '$selectedYear${LocaleKeys.zr_cp_bet_Window_year.tr}',
                        style: TextStyle(
                          color: context.isDarkMode ? Colors.white :const Color(0xFF303442) /* text-color-text */,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon:  Icon(Icons.chevron_right,
                          color: context.isDarkMode
                              ? Color(0xFF6E717B)
                              : Color(0xFFC9CDDB),

                        ),
                        onPressed: () {
                          setState(() {
                            selectedYear++;
                            updateFocusedDay();
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),

            TableCalendar(
              locale: "${Get.locale?.languageCode}-${Get.locale?.countryCode}",
              focusedDay: focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              rowHeight:29,
              rangeStartDay: rangeStart,
              rangeEndDay: rangeEnd,
              rangeSelectionMode: rangeSelectionMode,
              selectedDayPredicate: (day) => isInRange(day),
              onDaySelected: onDaySelected,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: context.isDarkMode ? const Color(0xFFC1C2C6) : const Color(0xFF616783) ,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
                weekendStyle: TextStyle(
                  color: context.isDarkMode ? const Color(0xFFC1C2C6) : const Color(0xFF616783) ,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),

              ),
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                rangeHighlightColor: context.isDarkMode ? Color(0xFF2A435E) : Color(0xFFD1EBFF),
                rangeStartDecoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
                rangeEndDecoration: BoxDecoration(color: mainColor, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: Color(0xFF179CFF), shape: BoxShape.circle),
                todayDecoration: BoxDecoration(color: Color(0xFF179CFF), shape: BoxShape.circle),
                defaultTextStyle: TextStyle(
                  color: context.isDarkMode ?Colors.white: const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
                selectedTextStyle :  TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w500,
                ),
                disabledTextStyle: TextStyle(
                  color: context.isDarkMode ? Color(0xFF595D68) : const Color(0xFFAFB3C8),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),

                weekNumberTextStyle: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    color:  context.isDarkMode ?
                    Colors.white.withAlpha(51):
                    const Color(0xFFAFB3C8)),
                weekendTextStyle: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'PingFang SC',
                    color: context.isDarkMode
                        ? Colors.white
                        : Colors.black
                ),
              ),
              enabledDayPredicate: (day) {
                bool within15Days =
                    day.isAfter(firstDay.subtract(const Duration(days: 1))) && day.isBefore(today.add(const Duration(days: 1)));
                return within15Days;
              },
              headerVisible: false,
            ),
            Expanded(child: Container()),
            Container(
              margin: EdgeInsets.only(bottom: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:   InkWell(

                    onTap: () => {
                      ///取消
                      widget.onItemClick(null,null),
                    },
                    child: Container(
                      height: 35.h,
                      margin: EdgeInsets.only(left: 10.w),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.w,
                            color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.common_cancel.tr,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                          fontSize: 12.sp,
                          height: 1.0,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        ///确认
                       widget.onItemClick(rangeStart,rangeEnd);
                      },
                      child: Container(
                        height: 35.h,
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: ShapeDecoration(
                          color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.app_h5_bet_confirm.tr,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
