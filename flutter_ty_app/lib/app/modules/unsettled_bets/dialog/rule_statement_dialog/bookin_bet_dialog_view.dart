import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';

import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../utils/oss_util.dart';
import '../../../../utils/utils.dart';

class BookinBetDialogView extends StatelessWidget {
  const BookinBetDialogView({
    Key? key,
    required this.statistics,
    required this.isOpenTips,
    required this.onTap,
  }) : super(key: key);
  final List<String> statistics;
  final bool isOpenTips;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _singleNumber(
          LocaleKeys.app_total_bookings.tr,
          statistics[0],
        ).expanded(flex: 8),
        _div(),
        _singleNumber(
          LocaleKeys.app_total_revenue.tr,
          formatNumber(statistics[1]),
        ).expanded(flex: 8),
        _div(),
        _singleSpecial(
          context,
          LocaleKeys.app_estimated_profit.tr,
          formatNumber(statistics[2]),
        ).expanded(flex: 9),
        _div(),
        _isSpecialViewWidget(
          context,
        ).expanded(flex: 9),
      ],
    );
  }

  /**
   * 隔离线
   */
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

  /**
   * 统计标题
   */
  Widget _isSpecialViewWidget(BuildContext context) {
    return Container(
      width: 256.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.r,
            ),
          ),
          image: DecorationImage(
            image: NetworkImage(
              OssUtil.getServerPath(
                context.isDarkMode
                    ? 'assets/images/bets/nighttime_bg.png'
                    : 'assets/images/bets/daytime_bg.png',
              ),
            ),
            fit: BoxFit.cover,
          ),
          color: Colors.white),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 16.h,
      ),
      child: _cathectic(context),
    );
  }

  Widget _cathectic(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.app_h5_cathectic_cash_rules.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.isDarkMode
                ? Colors.white.withValues(alpha: 0.8999999761581421)
                : const Color(0xFF303442),
            fontSize: 14.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w600,
          ),
        ).marginOnly(bottom: 8.h),
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.07999999821186066)
                  : const Color(0xFFE4E6ED)),
        ).marginOnly(bottom: 8.h),

        SizedBox(
          width: double.infinity,
          child: SizedBox(
            child: Text(
              '${LocaleKeys.app_h5_cathectic_explain1.tr}\n${LocaleKeys.app_h5_cathectic_explain2.tr}',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                  height: 1.75.h),
            ),
          ),
        ).marginOnly(bottom: 8.h),
        //统计弹框
        _countClicks(context),
      ],
    );
  }

  /**
   * 预约统计点击弹框
   */
  Widget _countClicks(BuildContext context) {
    return InkWell(
        onTap: () =>
        {
          Navigator.of(context).pop(),
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 5.w,
            ),
            Container(
              width: 46.w,
              height: 22.h,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.w,
                    color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
                  ),
                  borderRadius: BorderRadius.circular(
                    5.r,
                  ),
                ),
              ),
              child: Text(
                '+' + LocaleKeys.bet_bet_book_confirm.tr,
                style: TextStyle(
                  color: Color(
                    context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
                  ),
                  fontSize: 12.sp,
                  fontFamily: 'PingFang SC',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
    );
  }

  /**
   * 特殊统计展示
   */
  Widget _singleSpecial(BuildContext context, String title, String number) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60.w,
        child: Text(
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
        ),
      ).marginZero.marginOnly(
            bottom: 10.h,
          ),
    );
  }

  Widget _statusBox(
      BuildContext context, String title, String number, bool contain) {
    return Container(
      width: contain ? 55.w : 46.w,
      height: 22.h,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.w,
            color: Color(context.isDarkMode ? 0xFF127DCC : 0xff179CFF),
          ),
          borderRadius: BorderRadius.circular(
            5.r,
          ),
        ),
      ),
      child: Text(
        '+' + LocaleKeys.bet_bet_book_confirm.tr,
        style: TextStyle(
          color: Color(
            context.isDarkMode ? 0xFF127DCC : 0xff179CFF,
          ),
          fontSize: contain ? 10.sp : 12.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  /**
   * 普通统计展示
   */
  Widget _singleNumber(String title, String number) {
    return Container(
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
                top: 10.h,
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
          ).marginZero.marginOnly(
                bottom: 10.h,
              ),
        ],
      ),
    );
  }
}
