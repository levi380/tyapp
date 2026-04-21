import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../utils/utils.dart';

class UnsettledBetHeadView extends StatelessWidget {
  final List<String> statistics;

  const UnsettledBetHeadView({
    Key? key,
    required this.statistics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 46.h,
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
            LocaleKeys.app_totalWinAmount.tr,
            formatNumber(statistics[2]),
          ),
        ],
      ),
    );
  }

  Widget _single(String title, String number) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Get.isDarkMode
                    ? Colors.white.withValues(
                        alpha: 0.5,
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
                color: Get.isDarkMode
                    ? Colors.white.withValues(alpha: 0.9)
                    : const Color(0xFF303442),
                fontSize: 14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(
                alpha: 0.08,
              )
            : const Color(
                0xFFE4E6ED,
              ),
      ),
    );
  }
}
