import 'package:common_utils/common_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/bet/extensions/theme_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import 'package:flutter_ty_app/app/utils/format_money_util.dart';

import '../../../core/constant/common/module/keyword.dart';
import '../../../services/models/res/all_order_list_entity.dart';
import '../../../utils/utils.dart';
import '../../../widgets/image_view.dart';
import '../controllers/bet_record_controller.dart';
import 'betitem_cp_number_time_mixin.dart';

part 'betitem_cp_mix.part.dart';
/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 全部注单彩票注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票注单，注单类型为全部时显示
    】】】
 *
 */
class BetItemCpMix extends StatelessWidget with BetItemCpNumberTimeMixin {
  BetItemCpMix(
    this.orderItem,
    this.isExpanded,
    this.isMixExpanded, {
    super.key,
  });

  final AllOrderListList orderItem;
  final bool isExpanded;
  final bool isMixExpanded;
  final logic = Get.find<BetRecordController>();

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
            ImageView('assets/images/bets/betitem_type_cp.png', width: 16.w),
            SizedBox(width: 4.w),
            // 赛事名称
            Text(
              orderItem.orderMixExtendVOList.safeFirst?.ticketName ?? "",
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
          // list 收起内容
          Container(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              '${(orderItem.orderMixExtendVOList.safeFirst?.playOptions != ''
                  ? orderItem.orderMixExtendVOList.safeFirst?.playOptions
                  : orderItem
                  .orderMixExtendVOList.safeFirst?.playLevel) ??
                  ''}${orderItem.orderType == 'CP2'
                      ? ' ${orderItem.orderMixExtendVOList.safeFirst?.totalWinAmount}${LocaleKeys.bet_betd1.tr}'
                      : '${orderItem.orderMixExtendVOList.safeFirst?.betContent}'}@${filterMatchOdds(orderItem.orderMixExtendVOList.safeFirst?.odds)}',
              style: TextStyle(
                color: Theme.of(context).betSubText,
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ).marginOnly(top: 4.h),
          )
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
        if (isExpanded)
          Text(
            LocaleKeys.zr_cp_bet_Window_issue_1.tr.replaceAll(
                "{x}",
                (!ObjectUtil.isEmptyString(
                orderItem.orderMixExtendVOList.safeFirst?.ticketPlanNo)
                ? (orderItem.orderMixExtendVOList.safeFirst?.ticketPlanNo ??
                "")
                : (orderItem.orderMixExtendVOList.safeFirst
                ?.startTicketPlanNo ??
                ""))
            ),
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

  Widget _buildStatus(BuildContext context) {
    String str = "";
    if (orderItem.orderType == "CP") {
      str = getStatusCp(orderItem.orderStatus);
    } else {
      str = getStatusCp2(orderItem.orderStatus);
    }

    return Text(
      str,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: (orderItem.orderStatus == 3
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ((orderItem.orderMixExtendVOList.safeFirst?.playOptions !=
                                      ''
                                  ? orderItem.orderMixExtendVOList.safeFirst
                                      ?.playOptions
                                  : orderItem.orderMixExtendVOList.safeFirst
                                      ?.playLevel) ??
                              '') +
                          ' ' +
                          (orderItem.orderType == 'CP2'
                              ? ' ${orderItem.orderMixExtendVOList.safeFirst?.totalWinAmount}${LocaleKeys.bet_betd1.tr}'
                              : '${orderItem.orderMixExtendVOList.safeFirst?.marketValue} ${orderItem.orderMixExtendVOList.safeFirst?.betContent}') +
                          ' @${filterMatchOdds(orderItem.orderMixExtendVOList.safeFirst?.odds)}',
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
                if (orderItem.orderType == "CP2")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.bet_betd3.tr,
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
                        orderItem.orderMixExtendVOList.safeFirst
                                ?.winAmountPlanNoCount
                                .toString() ??
                            "",
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
                if (orderItem.orderType == "CP")
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
          Column(
            children: [
              // 投注额、中奖金额等信息
              ..._buildInfoList(context),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: buildBetNum(context, orderItem.orderNo),
              ),
              buildBetTime(context, orderItem.betTime.toString()),
            ],
          )
        ],
      ),
    );
  }

  getStatusCp(int v) {
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

  getStatusCp2(int v) {
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
