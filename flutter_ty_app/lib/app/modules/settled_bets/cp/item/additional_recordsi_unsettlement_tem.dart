import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../../global/ty_user_controller.dart';
import '../../../../services/models/res/get_order_cp_list_entry_entity.dart';
import '../../../../utils/utils.dart';
import '../widgets/additional_information_view.dart';
import '../widgets/details_information_area_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注未结算记录列表条目item视图层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能，用于展示未结算的投注记录项，包含投注信息、状态和金额等。
    - 属性
    - orderListItem: 包含订单信息的对象（`GetOrderCpListEntryList` 类型）。
    - index: 当前项的索引（整数）。
    - isTopRounded: 是否为顶部圆角（布尔值）。
    - isBottomRounded: 是否为底部圆角（布尔值）。
    - build()构建组件的 UI，展示投注的各种信息，包括票据名称、投注时间、投注金额等。
    - getProfitAmount()根据类型返回利润金额字符串。处理未结注单和已结注单的不同状态。
    - getOrderAmountTotal()返回格式化后的投注金额字符串。
    - getOrderStatus()根据订单状态返回对应的状态描述字符串。
    - 使用 `Container` 进行布局，设置内边距和外边距。
    - 使用 `ShapeDecoration` 进行背景颜色和圆角样式的设置。
    - 包含多个 `AdditionalInformationView` 组件，用于显示订单的各项信息。
    】】】
 *
 */
class AdditionalUnsettlementRecordsItem extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  AdditionalUnsettlementRecordsItem(
    this.orderListItem, {
    Key? key,
    required this.index,
    required this.isTopRounded,
    required this.isBottomRounded,
  }) : super(key: key);
  final int index;
  final bool isTopRounded, isBottomRounded;

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
              information: orderListItem.ticketName.toString(),
              outcome:
                  '${LocaleKeys.bet_record_issue.tr}${orderListItem.ticketPlanNo}${LocaleKeys.bet_record_period.tr}',
              titleFontSize: 14,
              bottom: 12,
              isLeftThickness: true),
          DetailsInformationAreaView(orderListItem).marginOnly(bottom: 8.h),
          AdditionalInformationView(
            information:
                LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_slip_number.tr,
            outcome: orderListItem.orderId ?? "",
          ),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_betting_time.tr,
            outcome: orderListItem.betTime ?? "",
          ),
          AdditionalInformationView(
              information: LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_amount.tr,
              outcome: getOrderAmountTotal(orderListItem.betMoney),
              isRightThickness: true),
          AdditionalInformationView(
              information: LocaleKeys.zr_cp_Lottery_Bet_Slips_winning.tr,
              outcome: getProfitAmount(),
              InformationColorType: 2,
              isRightThickness: true),
          AdditionalInformationView(
            information: LocaleKeys.zr_cp_Lottery_Bet_Slips_bet_status.tr,
            outcome: LocaleKeys.zr_cp_Lottery_Bet_Slips_to_be_drawn.tr,
          ),
        ],
      ),
    );
  }

  // 0 未结算  1 已结算

  String getProfitAmount({int type = 0}) {
    String profitAmount = '';

    if (type == 0) {
      profitAmount =
          "${setAmount(orderListItem.maxWinAmount.toString())} $managerCode";
    } else if (type == 1) {
      //只有已结注单才会展示  输赢状态
      String results = '';
      //已结注单，注单成功的时候
      if (orderListItem.betStatus == '1') {
        int outcome = orderListItem.riskStatus?.toInt() ?? 0;
        if (outcome == 2) {
          results = LocaleKeys.bet_record_bet_no_status02.tr;
        } else if (outcome == 3) {
          results = LocaleKeys.bet_record_bet_no_status03.tr;
        } else if (outcome == 4) {
          results = LocaleKeys.bet_record_bet_no_status04.tr;
        } else if (outcome == 5) {
          results = LocaleKeys.bet_record_bet_no_status05.tr;
        } else if (outcome == 6) {
          results = LocaleKeys.bet_record_bet_no_status06.tr;
        } else if (outcome == 7) {
          results = LocaleKeys.bet_record_bet_no_status07.tr;
        } else if (outcome == 8) {
          results = LocaleKeys.bet_record_bet_no_status08.tr;
        }
      } else {
        results = LocaleKeys.bet_record_bet_no_status17.tr;
      }

      //已结注单，注单失败的时候结算是0元
      if (orderListItem.betStatus == '1') {
        profitAmount = results +
            '  ' +
            setAmount(orderListItem.profitAmount.toString()) +
            " " +
            managerCode;
      } else {
        profitAmount = results + '  ' + '0.00' + " " + managerCode;
      }
    }
    return profitAmount;
  }

  String getOrderAmountTotal(num? betMoney) {
    String orderAmountTotal = "";
    if (betMoney != null) {
      orderAmountTotal = "${setAmount(betMoney.toString())} $managerCode";
    }
    return orderAmountTotal;
  }

  String getOrderStatus(String orderStatus) {
    String orderStatus = "";
    String Status = orderStatus;
    if (Status == "0" || Status == "1") {
      orderStatus = LocaleKeys.bet_record_successful_betting.tr;
    } else if (Status == "2") {
      orderStatus = LocaleKeys.bet_record_invalid_bet.tr;
    } else if (Status == "3") {
      orderStatus = LocaleKeys.bet_record_confirming.tr;
    } else if (Status == "4") {
      orderStatus = LocaleKeys.bet_bet_err.tr;
    }
    return orderStatus;
  }
}
