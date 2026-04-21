import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../../services/models/res/cp_order_list_entity.dart';
import '../../../../utils/utils.dart';
import '../widgets/additiona_linformation_area_view.dart';
import '../widgets/additional_information_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 追号记录列表条目item视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，用于展示额外的投注记录项，包括投注信息、状态和金额等。
    - index: 当前项的索引（整数）。
    - isTopRounded: 是否为顶部圆角（布尔值）。
    - isBottomRounded: 是否为底部圆角（布尔值）。
    - data: 包含订单信息的对象（`CpOrderListList` 类型）。
    - settled: 结算状态（整数）。
    - build()构建组件的 UI，展示投注的各种信息，包括票据名称、投注时间、投注金额等。
    - 功能: 返回票据名称，如果不存在则返回空字符串。
    - getStartTicketPlanNo(): 返回起始票据计划号及其描述，如果不存在则返回空字符串。
    - getChaseId(): 返回追号 ID，如果不存在则返回空字符串。
    - getBetTime(): 返回投注时间，如果不存在则返回空字符串。
    - getTotalBetAmount(): 返回格式化后的总投注金额字符串。
    - getTotalWinAmount(): 返回格式化后的总中奖金额字符串。
    - getFinishPlanNoCount(): 返回完成计划号的数量，如果不存在则返回空字符串。
    - getCancelPlanNoCount(): 返回取消计划号的数量，如果不存在则返回空字符串。
    - getFinishAmount(): 返回格式化后的完成金额字符串。
    - getCancelWinAmount(): 返回格式化后的取消中奖金额字符串。
    - getChaseOrderStatus(): 根据追号状态返回对应的状态描述字符串。
    - getInformationColorType(): 根据追号状态返回信息颜色类型，状态为 2 时返回 2，否则返回 0。
    - 使用 `Container` 进行布局，设置内边距和外边距。
    - 使用 `ShapeDecoration` 进行背景颜色和圆角样式的设置。
    - 包含多个 `AdditionalInformationView` 组件，用于显示订单的各项信息。
    】】】
 *
 */
class AdditionalRecordsItem extends StatelessWidget {
  AdditionalRecordsItem({
    Key? key,
    required this.index,
    required this.isTopRounded,
    required this.isBottomRounded,
    required this.data,
    required this.settled,
  }) : super(key: key);
  final int index;
  final bool isTopRounded, isBottomRounded;
  final CpOrderListList data;
  final int settled;

  ///货币类型
  final String managerCode = TYUserController.to.currCurrency();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 4.h,
        left: 12.w,
        right: 12.w,
      ),
      margin: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.03999999910593033)
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isTopRounded ? 12.r : 0.r),
            topRight: Radius.circular(isTopRounded ? 12.r : 0.r),
            bottomLeft: Radius.circular(isBottomRounded ? 12.r : 0.r),
            bottomRight: Radius.circular(isBottomRounded ? 12.r : 0.r),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AdditionalInformationView(
            information: getTicketName(),
            outcome: getStartTicketPlanNo(),
            titleFontSize: 14,
            bottom: 12,
            isLeftThickness: true,
          ),
          AdditionalInformationAreaView(
            data: data,
            settled: settled,
          ).marginOnly(
            bottom: 8.h,
          ),
          AdditionalInformationView(
            information:
                LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_slip_number.tr,
            outcome: getChaseId(),
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_time.tr,
            outcome: getBetTime(),
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_amount.tr,
            outcome: getTotalBetAmount(),
            isRightThickness: true,
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_winning_amount.tr,
            outcome: getTotalWinAmount(),
            InformationColorType: 3,
            isRightThickness: true,
          ),
          AdditionalInformationView(
            information: LocaleKeys
                .zr_cp_Lottery_Bet_Slips_number_of_periods_completed.tr,
            outcome: getFinishPlanNoCount(),
            isRightThickness: true,
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_cancel_period.tr,
            outcome: getCancelPlanNoCount(),
            isRightThickness: true,
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_amount_completed.tr,
            outcome: getFinishAmount(),
            isRightThickness: true,
          ),
          AdditionalInformationView(
            information:
                LocaleKeys.zr_cp_Lottery_Bet_Slips_cancellation_amount.tr,
            outcome: getCancelWinAmount(),
            isRightThickness: true,
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_status.tr,
            outcome: getChaseOrderStatus(),
            InformationColorType: getInformationColorType(),
          ),
        ],
      ),
    );
  }

  String getTicketName() {
    String ticketName = '';
    if (data.ticketName.isNotEmpty) {
      ticketName = data.ticketName;
    }
    return ticketName;
  }

  String getStartTicketPlanNo() {
    String startTicketPlanNo = '';
    if (data.startTicketPlanNo.isNotEmpty) {
      startTicketPlanNo =
          '${LocaleKeys.bet_record_issue.tr}${data.startTicketPlanNo}${LocaleKeys.bet_record_period.tr}';
    }
    return startTicketPlanNo;
  }

  String getChaseId() {
    String chaseId = '';
    if (data.chaseId.isNotEmpty) {
      chaseId = data.chaseId;
    }
    return chaseId;
  }

  String getBetTime() {
    String betTime = '';
    if (data.betTime.isNotEmpty) {
      betTime = data.betTime;
    }
    return betTime;
  }

  String getTotalBetAmount() {
    String totalBetAmount = '';
    totalBetAmount = '${data.totalBetAmount} $managerCode';
    return totalBetAmount;
  }

  String getTotalWinAmount() {
    String totalWinAmount = '';
    totalWinAmount =
        '${setAmount(data.totalWinAmount.toString())} $managerCode';
    return totalWinAmount;
  }

  String getFinishPlanNoCount() {
    String finishPlanNoCount = '';
    finishPlanNoCount = data.finishPlanNoCount.toString();
    return finishPlanNoCount;
  }

  String getCancelPlanNoCount() {
    String cancelPlanNoCount = '';
    cancelPlanNoCount = data.cancelPlanNoCount.toString();
    return cancelPlanNoCount;
  }

  String getFinishAmount() {
    String finishAmount = '';
    finishAmount = '${setAmount(data.finishAmount.toString())} $managerCode';
    return finishAmount;
  }

  String getCancelWinAmount() {
    String cancelWinAmount = '';
    cancelWinAmount =
        '${setAmount(data.cancelWinAmount.toString())} $managerCode';
    return cancelWinAmount;
  }

  String getChaseOrderStatus() {
    String chaseOrderStatus = '';
    if (data.chaseOrderStatus == 1) {
      chaseOrderStatus =
          LocaleKeys.zr_cp_Lottery_Bet_Slips_following_numbers.tr;
    } else if (data.chaseOrderStatus == 2) {
      chaseOrderStatus = LocaleKeys.zr_cp_Lottery_Bet_Slips_finish.tr;
    }
    return chaseOrderStatus;
  }

  int getInformationColorType() {
    int informationColorType = 0;
    if (data.chaseOrderStatus == 2) {
      informationColorType = 2;
    }
    return informationColorType;
  }
}
