import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet/extensions/theme_extension.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/constant/common/module/keyword.dart';
import '../../../core/format/common/module/format-date.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_order_list_zr_entity.dart';
import '../../../utils/format_money_util.dart';
import '../../../utils/toast_util.dart';
import '../../../widgets/image_view.dart';
import '../../settled_bets/zr/widgets/live_util.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人注单，注单类型为真人时显示
    】】】
 *
 */
class BetItemZrSingle extends StatefulWidget {
  const BetItemZrSingle(this.orderItem, {super.key});

  final GetOrderListZrDataList orderItem;

  @override
  State<BetItemZrSingle> createState() => _BetItemZrSingleState();
}

class _BetItemZrSingleState extends State<BetItemZrSingle> {
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
              setState(() {
                widget.orderItem.isExpand = !widget.orderItem.isExpand;
              });
            },
            child: Stack(
              children: [
                _buildLeft(),
                _buildRight(),
              ],
            ),
          ),
          if (widget.orderItem.isExpand) _buildContent()
        ],
      ),
    );
  }

  Widget _buildLeft() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.orderItem.isExpand) _buildStatus().marginOnly(bottom: 4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageView('assets/images/bets/betitem_type_cp2.png', width: 16.w),
            SizedBox(width: 4.w),
            // 赛事名称
            Text(
              LiveUtils.getGameTypeNameLocale(widget.orderItem.gameTypeName) + widget.orderItem.tableCode,
              style: TextStyle(
                color: Theme.of(context).betMainText,
                fontSize: 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        if (!widget.orderItem.isExpand)
          Text(
            '${LiveUtils.getBetPointNameLocale(widget.orderItem.betPointName)} @${widget.orderItem.odds}',
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

  Widget _buildRight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!widget.orderItem.isExpand) _buildStatus(),
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: widget.orderItem.isExpand ? 0 : -0.25,
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
        // if (widget.orderItem.isExpand && widget.settled == 1)
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
  Widget _buildStatus() {
    return Text(
      widget.orderItem.betStatus != "0"
          ? LocaleKeys.zr_cp_Lottery_Bet_Slips_distributed.tr
          : LocaleKeys.zr_cp_Lottery_Bet_Slips_not_paid.tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).betSubText,
        fontSize: 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 展开内容和区域
  Widget _buildContent() {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${LiveUtils.getBetPointNameLocale(widget.orderItem.betPointName)} @${widget.orderItem.odds}',
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
                        fontSize:12.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "${FormatMoney.formatMoney2(double.tryParse(widget.orderItem.betAmount) ?? 0.0)} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
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
                      // 未派彩 可赢额 maxWinAmount 已派彩 派彩 netAmount
                      Text(
                        widget.orderItem.betStatus != "0"
                            ? "派彩"
                            : LocaleKeys.app_h5_cathectic_winnable.tr,
                        style: TextStyle(
                          color: Theme.of(context).betSubText,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "${FormatMoney.formatMoney2(widget.orderItem.betStatus != "0" ? (double.tryParse(widget.orderItem.netAmount) ?? 0.0) : widget.orderItem.maxWinAmount.toDouble())} ${currency_code[TYUserController.to.userInfo.value?.cvo?.series?.code ?? 1] ?? TYUserController.to.currCurrency()}",
                        style: TextStyle(
                          color: widget.orderItem.betStatus != "0"
                              ? const Color(0xFFF76565)
                              : Theme.of(context).betMainText,
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
                        widget.orderItem.createTime.toString(),
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
                  Clipboard.setData(
                      ClipboardData(text: widget.orderItem.roundNo));
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
                      widget.orderItem.roundNo,
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
}
