import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/core/format/common/module/format-date.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/bet/extensions/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/utils/toast_util.dart';
import 'package:flutter_ty_app/app/widgets/image_view.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单Mixin】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票注单公共代码
    】】】
 *
 */
mixin BetItemCpNumberTimeMixin {
  /// 投注单号
  Widget buildBetNum(BuildContext context, String orderNo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: orderNo));
          ToastUtils.showGrayBackground(LocaleKeys.bet_record_copy_suc.tr);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: LocaleKeys
                              .zr_cp_Lottery_Bet_Slips_order_number.tr.breakWord,
                          style: TextStyle(
                            color: Theme.of(context).betSubText,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: orderNo.breakWord,
                          style: TextStyle(
                            color: Theme.of(context).betMainText,
                            fontSize: 12.sp,
                            fontFamily: 'PingFang SC',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ]),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            ImageView(
              Get.isDarkMode
                  ? 'assets/images/bets/icon_copy_grey_night.svg'
                  : 'assets/images/bets/icon_copy_grey.svg',
              width: 12.w,
              height: 12.w,
            ),
          ],
        ),
      ),
    );
  }

  /// 投注时间
  Widget buildBetTime(BuildContext context, String betTime) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text(
          TYFormatDate.formatTime(
              betTime.toString(),
              Get.locale?.languageCode == 'vi'
                  ? 'HH:MM:ss DD/mm/YYYY'
                  : 'YYYY-mm-DD HH:MM:ss')
              .breakWord,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).betSubText,
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  /// 注单时间+盘口
  Widget buildTimeAndOdd(String betTime, String odds, ThemeData themeData) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width * 0.45),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              children: [
                TextSpan(
                  text: betTime.breakWord,
                  style: TextStyle(
                    color: themeData.betItemTextColor2,
                    fontSize: 10.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: odds.breakWord,
                  style: TextStyle(
                    color: themeData.betItemTextColor2,
                    fontSize: 10.sp,
                    fontFamily: 'PingFang SC',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}