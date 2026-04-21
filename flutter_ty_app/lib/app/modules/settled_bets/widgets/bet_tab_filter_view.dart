import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';



/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单时间选择器Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义Widget
    - 视图支持全屏，全屏不可设置.h .w
    - 主要是彩票注单时间选择器
    】】】
 *
 */
class BetTabFilterView extends StatelessWidget {
  const BetTabFilterView({
    required this.selectType,
    required this.onChanged,
    required this.startTime,
    required this.endTime,
    this.openSelectTypeTime = false,
    Key? key,
  }) : super(key: key);

  final int selectType;
  final ValueChanged<int> onChanged;
  final String startTime, endTime;
  final bool openSelectTypeTime;

  bool get _isChinese => ['zh', 'hk'].contains(Get.locale?.languageCode);

  bool get _isEnglish => ['en'].contains(Get.locale?.languageCode);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.w,
      child: Container(
          // height: 40.w,
          margin: EdgeInsets.only(top: 10.w),
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
          ),
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha:0.04)
                : Colors.white,
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Row(
            children: [
              _single(
                context,
                1,
                LocaleKeys.app_bet_date_list_0.tr,
              ),
              _single(
                context,
                2,
                LocaleKeys.app_bet_date_list_1.tr,
              ),
              _single(
                context,
                3,
                LocaleKeys.app_bet_date_list_2.tr,
              ),
              _single(
                context,
                4,
                LocaleKeys.app_bet_date_list_3.tr,
              ),
              _single(
                context,
                5,
                LocaleKeys.app_custom.tr,
              ),
            ],
          )),
    );
  }


  /**
   * 适配中英文
   */
  int fitWidth(int singleType) {
    if (_isEnglish ) {
      if (singleType==2||singleType==5){
        return 7;
      }
    } else if (_isChinese) {
      if (singleType==3||singleType==4){
        return 6;
      }else if (singleType==5){
        return 7;
      }
    }
    return 5;
  }

  Widget _single(BuildContext context, int singleType, String title) {
    return Flexible(
      flex: fitWidth(singleType),

     // _isChinese && [3, 4, 5].contains(singleType)
     //     ? 6
     //     : _isEnglish && singleType == 2
     //         ? 6
     //         : 5,
      child: InkWell(
        onTap: () => {
          onChanged(singleType),
        },
        child: Container(

          margin: EdgeInsets.symmetric(
              horizontal: singleType == 5 && selectType == 5 ? 0.w : 1.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 4.w,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: (singleType == 5 &&
                          selectType == 5 &&
                          !openSelectTypeTime)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              startTime,
                              maxLines: 1,
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? const Color(0xFF127DCC)
                                    : const Color(0xff179CFF),
                                fontSize: 7.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w600,
                              ),
                            ).paddingOnly(bottom: 2.w),
                            Text(
                              endTime,
                              maxLines: 1,
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? const Color(0xFF127DCC)
                                    : const Color(0xff179CFF),
                                fontSize: 7.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? singleType == selectType
                                        ? const Color(0xFF127DCC)
                                        : Colors.white.withValues(alpha:0.5)
                                    : Color(singleType == selectType
                                        ? 0xff179CFF
                                        : 0xFF949AB6),
                                fontSize: _isChinese ? 13.sp : 11.sp,
                                fontFamily: 'PingFang SC',
                                fontWeight: singleType == selectType
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                height: 1.0.h),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
              ),
              Container(
                      width: 28.w,
                      height: 3.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1.5.r),
                            topRight: Radius.circular(1.5.r),
                          ),
                          color: selectType == singleType
                              ? Color(
                                  context.isDarkMode ? 0xFF127DCC : 0xFF179cff)
                              : Colors.transparent))
                  .marginOnly(bottom: 1.h)
            ],
          ),
        ),
      ),
    );
  }
}
