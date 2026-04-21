import 'package:common_utils/common_utils.dart';
import '../../../generated/locales.g.dart';
import '../../modules/login/login_head_import.dart';
import '../../utils/ty_text_scaler.dart';
import 'date_picker.dart';
import '../../utils/DateTimeUtils.dart';
import '../../utils/text_Utitl.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1f21ccd4-2254-4304-866f-cd6254836532-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  自定义时间工具类】】】
    【【【 AUTO_PARAGRAPH_TITLE 时间选择器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    # `showTimeBottom` 类功能总结

    ## 类概述
    `showTimeBottom` 类用于显示一个底部模态选择器，允许用户选择开始和结束日期。

    ## 属性
    - **`startTime`**: `Rx<String>`，存储开始时间。
    - **`endTime`**: `Rx<String>`，存储结束时间。
    - **`startDateTime`**: `Rx<DateTime>`，存储开始日期，默认值为当前时间前 30 天。
    - **`endDateTime`**: `Rx<DateTime>`，存储结束日期，默认值为当前时间。

    ## 方法

    ### 1. `resetinitTime()`
    - **功能**: 重置时间选择器的状态。
    - **逻辑**:
    - 清空 `startTime` 和 `endTime`。
    - 将 `endDateTime` 设置为当前时间。
    - 将 `startDateTime` 设置为当前时间前 30 天。

    ## 逻辑
    - 使用 `showModalBottomSheet` 显示模态选择器。
    - 使用 `StatefulBuilder` 和 `Obx` 来实现响应式 UI。
    - 显示开始和结束时间的选择区域。
    - 使用 `CupertinoDatePicker` 选择日期。
    - 提供确认和取消按钮：
    - **确认按钮**: 验证日期选择的合法性，调用 `onDateTimeChanged` 回调。
    - **取消按钮**: 调用 `cancel` 回调并关闭选择器。

    ## 主要功能
    - **模态选择器**: 允许用户选择日期。
    - **响应式更新**: UI 根据时间选择的变化自动更新。
    - **日期选择**: 使用 `CupertinoDatePicker` 组件。
    - **操作按钮**: 提供确认和取消操作。

    】】】
 *
 */
class showTimeBottom{
  static Rx<String> startTime =  "".obs;
  static Rx<String>  endTime =  "".obs;
  ///滑动选中的开始日期
  static Rx<DateTime> startDateTime = DateTimeUtils.addDays(DateTime.now(), -30).obs;

  ///滑动选中的结束日期
  static Rx<DateTime> endDateTime = DateTime.now().obs;

  ///重置初始化数据
  static resetinitTime() {
    startTime.value = "";
    endTime.value = "";
    endDateTime.value = DateTime.now(); //默认当前时间
    startDateTime.value = DateTimeUtils.addDays(DateTime.now(), -30); //默认当前时间 00:00
  }

  static  showModalBottom(BuildContext context,

      {String? title,
        bool isLeft=true,
        ValueChanged<List<DateTime>>? onDateTimeChanged,
        ValueChanged<int>? cancel,
        }) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {

        return StatefulBuilder(builder: (context, state) {

          return Obx(() {
            return SafeArea(
              child:  Container(
                padding:  EdgeInsets.only(top: 15.h, left: 12.w, right: 12.w),
                height: 450.h,
                decoration: BoxDecoration(
                  color:
                  context.isDarkMode ? const Color(0xFF1E2029) : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtitls.normalText(
                      title ?? LocaleKeys.app_customFiltering.tr,
                      color: context.isDarkMode
                          ? Colors.white.withValues(alpha:0.8999999761581421)
                          : const Color(0xFF303442),
                      fontSize: TyTextScaler.instance().scale(16.sp),
                      fontWeight: FontWeight.w500,
                    ).marginOnly(
                      bottom: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.w,
                                        color: isLeft == true
                                            ? context.isDarkMode
                                            ? const Color(0xFF127DCC)
                                            : const Color(0xFF179CFF)
                                            : context.isDarkMode
                                            ? Colors.white
                                            .withValues(alpha:0.07999999821186066)
                                            : const Color(0xFFE4E6ED)),
                                  ),
                                ),
                                child: TextUtitls.normalText(
                                  startTime.value.isNotEmpty? startTime.value :DateUtil.formatDateMs(
                                      DateTimeUtils.addDays(DateTime.now(), -30).millisecondsSinceEpoch,
                                      format: DateFormats.y_mo_d,   isUtc: true)
                                      .toString() ,
                                  color: isLeft == true
                                      ? context.isDarkMode
                                      ? const Color(0xFF127DCC)
                                      : const Color(0xFF179CFF)
                                      : context.isDarkMode
                                      ? Colors.white
                                      .withValues(alpha:0.30000001192092896)
                                      : const Color(0xFFAFB3C8),
                                  fontSize: TyTextScaler.instance().scale(18.sp),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                state(() {
                                  isLeft = true;
                                });
                              },
                            )),
                        TextUtitls.normalText(
                          LocaleKeys.app_to.tr,
                          color: context.isDarkMode
                              ? Colors.white.withValues(alpha:0.8999999761581421)
                              : const Color(0xFF303442),
                          fontWeight: FontWeight.w500,
                        ).marginOnly(left: 10.w, right: 10.w),
                        Expanded(
                            child: GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.w,
                                        color: isLeft == false
                                            ? context.isDarkMode
                                            ? const Color(0xFF127DCC)
                                            : const Color(0xFF179CFF)
                                            : context.isDarkMode
                                            ? Colors.white
                                            .withValues(alpha:0.07999999821186066)
                                            : const Color(0xFFE4E6ED)),
                                  ),
                                ),
                                child: TextUtitls.normalText(
                                  endTime.value .isNotEmpty? endTime.value  :DateUtil.formatDateMs(
                                      DateTime.now().millisecondsSinceEpoch,
                                      format: DateFormats.y_mo_d,   isUtc: true)
                                      .toString() ,
                                  color: isLeft == false
                                      ? context.isDarkMode
                                      ? const Color(0xFF127DCC)
                                      : const Color(0xFF179CFF)
                                      : context.isDarkMode
                                      ? Colors.white
                                      .withValues(alpha:0.30000001192092896)
                                      : const Color(0xFFAFB3C8),
                                  fontSize: TyTextScaler.instance().scale(18.sp),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                state(() {
                                  isLeft = false;
                                });
                              },
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: TextUtitls.normalText(
                          LocaleKeys.app_dayBettingRecord.tr,
                          color: const Color(0xFFFEAE2B),
                          fontSize: TyTextScaler.instance().scale(12.sp),
                          fontWeight: FontWeight.w500,
                        ).marginOnly(bottom: 10.h, top: 10.h)),
                      ],
                    ),
                    Container(
                      height: 180.h,
                      width: Get.width,
                      child: CupertinoDatePicker(
                          itemExtent: 36,
                          use24hFormat: true,
                          //dateOrder: DatePickerDateOrder.ymd,
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.now().subtract(const Duration(days: 30,minutes: 0)),
                          minimumDate: DateTime.now().subtract(const Duration(days: 30,minutes: 1)),
                          ///当一月份的时候才能看上一年的数据
                          minimumYear: DateTime.now().year - (DateTime.now().month == 1 ? 1 : 0),
                          maximumYear: DateTime.now().year,
                          maximumDate: DateTime.now(),
                          onDateTimeChanged: (date) {
                            state(() {
                              if (isLeft) {
                                startTime.value  = DateUtil.formatDateMs(
                                    date.millisecondsSinceEpoch,
                                    format: DateFormats.y_mo_d,)
                                    .toString();
                                startDateTime.value  = date;
                              } else {
                                endTime.value  = DateUtil.formatDateMs(
                                    date.millisecondsSinceEpoch,
                                    format: DateFormats.y_mo_d, )
                                    .toString();
                                endDateTime.value  = date;
                              }
                            });
                          }),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: context.isDarkMode ? null : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          .withValues(alpha:0.07999999821186066)
                                          : const Color(0xFFF2F2F6),
                                      width: 1.w),
                                ),
                                child: TextUtitls.normalText(
                                  LocaleKeys.common_cancel.tr,
                                  color: context.isDarkMode
                                      ? Colors.white.withValues(alpha:0.8999999761581421)
                                      : const Color(0xFF303442),
                                  fontSize: TyTextScaler.instance().scale(16.sp),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                if (cancel!=null){
                                  cancel(0);
                                }
                                Navigator.of(context).pop();
                              },
                            )),
                        SizedBox(width: 12.w),
                        Expanded(
                            child: InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    color: context.isDarkMode
                                        ? const Color(0xFF127DCC)
                                        : const Color(0xff179CFF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextUtitls.normalText(
                                    LocaleKeys.common_ok.tr,
                                    color: Colors.white,
                                    fontSize: TyTextScaler.instance().scale(16.sp),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: () {
                                  state(() {
                                    bool isDayApart = endDateTime.value
                                        .difference(startDateTime.value )
                                        .inDays >
                                        30;
                                    bool isOneDayApart = startDateTime.value .difference(endDateTime.value ).inMilliseconds > 0;
                                    if (isDayApart) {
                                      ToastUtils.show(LocaleKeys.app_greaterThan.tr);

                                      return;
                                    }
                                    if (isOneDayApart) {
                                      ToastUtils.show(LocaleKeys.app_endTime.tr);
                                      return;
                                    }
                                    onDateTimeChanged!([startDateTime.value ,endDateTime.value ]);
                                    Navigator.of(context).pop();
                                  });
                                }))
                      ],
                    ).marginOnly(bottom: 20.h),
                  ],
                ),
              ),
            );
          });
        });
      },
    );
  }
}

