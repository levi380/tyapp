import 'package:flutter/services.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet/extensions/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/constant/common/module/keyword.dart';
import '../../../core/format/common/module/format-date.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/all_order_list_entity.dart';
import '../../../utils/format_money_util.dart';
import '../../../utils/utils.dart';
import '../controllers/bet_record_controller.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全部注单真人注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人注单，注单类型为全部时显示
    】】】
 *
 */
class BetItemZrMix extends StatelessWidget {
  BetItemZrMix(
    this.orderItem,
    this.isExpanded,
    this.isMixExpanded, {
    super.key,
  });

  final bool isExpanded;
  final bool isMixExpanded;
  final logic = Get.find<BetRecordController>();
  final AllOrderListList orderItem;

  Widget _buildLeft(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isExpanded) _buildStatus(context).marginOnly(bottom: 4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageView('assets/images/bets/betitem_type_cp2.png', width: 16.w),
            SizedBox(width: 4.w),
            // 赛事名称
            Text(
              !isExpanded
                  ? (orderItem.orderMixExtendVOList.safeFirst?.matchInfo != ""
                          ? orderItem.orderMixExtendVOList.safeFirst?.matchInfo
                          : orderItem
                              .orderMixExtendVOList.safeFirst?.tableName) ??
                      ""
                  : (orderItem.orderMixExtendVOList.safeFirst?.matchInfo != ""
                          ? orderItem.orderMixExtendVOList.safeFirst?.matchInfo
                          : orderItem
                              .orderMixExtendVOList.safeFirst?.gameName) ??
                      "",
              style: TextStyle(
                color: Theme.of(context).betMainText,
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        if (!isExpanded)
          Text(
            '${orderItem.orderMixExtendVOList.safeFirst?.marketValue} @${filterMatchOdds(orderItem.orderMixExtendVOList.safeFirst?.odds)}',
            style: TextStyle(
              color: Theme.of(context).betSubText,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ).marginOnly(top: 4.h)
      ],
    );
  }

  Widget _buildRight(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!isExpanded) _buildStatus(context),
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: isExpanded ? 0 : -0.25,
              child: ImageView(
                Get.isDarkMode
                    ? 'assets/images/detail/ico_arrowdown_nor_night.svg'
                    : 'assets/images/detail/ico_arrowdown_nor.svg',
                width: 14.w,
                height: 14.w,
              ),
            ).marginOnly(right: 0, left: 6.w),
          ],
        ),
        // 已结算才有视频播放 这里注单列表不需要
        // if (isExpanded && widget.settled == 1)
        //   Container(
        //     width: 20.w,
        //     height: 20.w,
        //     alignment: Alignment.center,
        //     decoration: ShapeDecoration(
        //       color: Theme.of(context).betZrVideoBgColor,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(4.r)),
        //     ),
        //     child: ImageView(
        //       Get.isDarkMode
        //           ? 'assets/images/bets/zr_video_night.svg'
        //           : 'assets/images/bets/zr_video.svg',
        //       width: 12.w,
        //       height: 12.w,
        //     ),
        //   ).marginOnly(top: 6.h)
      ],
    );
  }

  // 投注结果
  Widget _buildStatus(BuildContext context) {
    return Text(
      orderItem.orderStatus == 0
          ? LocaleKeys.bet_bet_suc.tr
          : LocaleKeys.bet_bet_err.tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: (orderItem.orderStatus == 0
            ? Theme.of(context).betSubSuccessText
            : Theme.of(context).betSubText),
        fontSize: 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 展开内容和区域
  Widget _buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: ShapeDecoration(
              color: Theme.of(context).betPanelSubBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${orderItem.orderMixExtendVOList.safeFirst?.marketValue} ${orderItem.orderMixExtendVOList.safeFirst?.betContent} @${filterMatchOdds(orderItem.orderMixExtendVOList.safeFirst?.odds)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).betMainText,
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if(orderItem.orderMixExtendVOList.safeFirst?.playOptions != "")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        orderItem.orderMixExtendVOList.safeFirst?.playOptions ??
                            "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).betSubText,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ).marginOnly(top: 8.h),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //投注额
                    Text(
                      LocaleKeys.bet_record_bet_val.tr,
                      style: TextStyle(
                        color: Theme.of(context).betSubText,
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${FormatMoney.formatMoney2(double.tryParse(orderItem.betAmount) ?? 0.0)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                      style: TextStyle(
                        color: Theme.of(context).betMainText,
                        fontSize: 16.sp,
                        fontFamily: 'Akrobat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16.w),
                  padding: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                        color: Theme.of(context).betPanelLineColor,
                        width: 0.5.w),
                  )),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 可赢额 maxWinAmount
                      Text(
                        LocaleKeys.app_h5_cathectic_winnable.tr,
                        style: TextStyle(
                          color: Theme.of(context).betSubText,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "${filterMatchOdds(orderItem.maxWinAmount)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                        style: TextStyle(
                          color: Theme.of(context).betMainText,
                          fontSize: 16.sp,
                          fontFamily: 'Akrobat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  height: 0.5.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).betPanelLineColor,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //投注时间
                  Text(
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_time.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).betSubText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    TYFormatDate.formatTime(
                        orderItem.betTime,
                        Get.locale?.languageCode == 'vi'
                            ? 'HH:MM:ss DD/mm/YYYY'
                            : 'YYYY-mm-DD HH:MM:ss'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).betMainText,
                      fontSize: 12.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: orderItem.orderNo));
                  ToastUtils.showGrayBackground(
                      LocaleKeys.bet_record_copy_suc.tr);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_slip_number.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).betSubText,
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      orderItem.orderNo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).betMainText,
                        fontSize: 12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
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
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).betPanelBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x147981A4),
            blurRadius: 12,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              logic.changeExpanded(
                  exapnd: !isExpanded, orderId: orderItem.orderNo);
            },
            child: Stack(
              children: [
                _buildLeft(context),
                _buildRight(context),
              ],
            ),
          ),
          if (isExpanded) _buildContent(context)
        ],
      ),
    );
  }
}
