import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/utils.dart';


/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单头部注单统计Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义Widget
    - 视图支持全屏，全屏不可设置.h .w
    - 主要是彩票注单头部注单统计
    】】】
 *
 */
class BetDialogHeadView extends StatelessWidget {
  final List<String> statistics;

  const BetDialogHeadView({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _single(
            LocaleKeys.app_alltotal.tr,
            statistics[0],
          ),
          _div(),
          _single(
            LocaleKeys.app_total.tr,
            formatNumber(statistics[1]),
          ),
          _div(),
          _single(
            LocaleKeys.app_totalWinLosses.tr,
            formatNumber(statistics[2]),
            isSpecial: true,
          ),
        ],
      ),
    );
  }

  Widget _single(String title, String number, {bool isSpecial = false}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha:
                        0.5,
                      )
                    : const Color(
                        0xFF7981A4,
                      ),
                fontSize: 10.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginZero.marginOnly(
                  bottom: 2.h,
                ),
            Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSpecial
                    ? const Color(0xFFF53F3F)
                    : Get.isDarkMode
                        ? Colors.white.withValues(alpha:0.9)
                        : const Color(0xFF303442),
                fontSize:14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }

//间隔
  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(alpha:
                0.08,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
