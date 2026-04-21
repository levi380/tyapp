import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet/extensions/theme_extension.dart';
import 'package:flutter_ty_app/app/utils/format_money_util.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../core/constant/common/module/keyword.dart';
import '../../../services/models/res/cp_order_list_entity.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_view.dart';
import 'betitem_cp_number_time_mixin.dart';

part 'betitem_cp_single.part.dart';
/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票注单，注单类型为彩票时显示
    】】】
 *
 */
class BetItemCpSingle extends StatefulWidget {
  const BetItemCpSingle(this.orderItem, {super.key});

  final CpOrderListList orderItem;

  @override
  State<BetItemCpSingle> createState() => BetItemCpSingleState();
}

class BetItemCpSingleState extends State<BetItemCpSingle> with BetItemCpNumberTimeMixin {
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
            ImageView('assets/images/bets/betitem_type_cp.png', width: 16.w),
            SizedBox(width: 4.w),
            // 赛事名称
            Text(
              widget.orderItem.ticketName,
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
          // list 收起内容
          Text(
            widget.orderItem.type == "1"
                ? widget.orderItem.playName
                : '${widget.orderItem.playLevel} ${widget.orderItem.betContent} @${filterMatchOdds(widget.orderItem.odd)}',
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
        if (widget.orderItem.isExpand)
          Text(
            LocaleKeys.zr_cp_bet_Window_issue_1.tr.replaceAll(
                "{x}",
                (widget.orderItem.type == "1"
                    ? widget.orderItem.ticketPlanNo
                    : widget.orderItem.startTicketPlanNo
                )
            ),
    //         LocaleKeys.bet_betd.tr +
    //             (widget.orderItem.type == "1"
    //                 ? widget.orderItem.ticketPlanNo
    //                 : widget.orderItem.startTicketPlanNo) +
    //             LocaleKeys.bet_betd1.tr,
            style: TextStyle(
              color: Theme.of(context).betSubText,
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ).marginOnly(top: 10.h)
      ],
    );
  }

  Widget _buildStatus() {
    String str = "";
    if (widget.orderItem.type == "1") {
      str = get_status_cp(widget.orderItem.betStatus);
    } else {
      str = get_status_cp2(widget.orderItem.chaseOrderStatus);
    }

    return Text(
      str,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: widget.orderItem.type == "1"
            ? (widget.orderItem.betStatus == 3
                ? Theme.of(context).betSubSuccessText
                : Theme.of(context).betSubText)
            : (widget.orderItem.chaseOrderStatus == 3
                ? Theme.of(context).betSubSuccessText
                : Theme.of(context).betSubText),
        fontSize: 12.sp,
        fontFamily: 'PingFang SC',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// 展开内容和区域
  Widget _buildContent() {
    String orderNo = widget.orderItem.chaseId == "0" ||
          widget.orderItem.chaseId == ""
      ? widget.orderItem.orderId
      : widget.orderItem.chaseId;
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.orderItem.type == "1"
                          ? widget.orderItem.playName
                          : widget.orderItem.playLevel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).betMainText,
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      widget.orderItem.betContent,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).betMainText,
                        fontSize: 14.sp,
                        fontFamily: 'PingFang SC',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      widget.orderItem.type == "2"
                          ? (widget.orderItem.totalPlanNoCount.toString() +
                              LocaleKeys.bet_betd1.tr)
                          : "@${filterMatchOdds(widget.orderItem.odd)}",
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
                if (widget.orderItem.type == "2")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.bet_betd3.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).betSubText,
                          fontSize:12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.orderItem.winAmountPlanNoCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).betSubText,
                          fontSize: 12.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        LocaleKeys.bet_betd1.tr,
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
          Column(
            children: [
              // 投注额、中奖金额等信息
              ..._buildInfoList(),
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
          // 投注时间、单号
          // TODO: 这里需要修改
          // fixme:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: buildBetNum(context, orderNo),
              ),
              buildBetTime(context, widget.orderItem.createTime.toString()),
            ],
          )
        ],
      ),
    );
  }

  get_status_cp(int v) {
    String msg = '';
    switch (v) {
      case 1:
        msg = LocaleKeys.zr_cp_Lottery_Bet_Slips_to_be_drawn.tr;
        break;
      case 2:
        msg = LocaleKeys.bet_record_not_winning.tr;
        break;
      case 3:
        msg = LocaleKeys.bet_record_won.tr;
        break;
      case 4:
        msg = LocaleKeys.bet_record_suspended.tr;
        break;
      case 5:
        msg = LocaleKeys.bet_record_settled.tr;
        break;

      default:
        break;
    }
    return msg;
  }

  get_status_cp2(int v) {
    String msg = '';
    switch (v) {
      case 1:
        msg = LocaleKeys.bet_betd4.tr;
        break;
      case 2:
        msg = LocaleKeys.zr_cp_Lottery_Bet_Slips_finish.tr;
        break;
      default:
        break;
    }
    return msg;
  }
}
