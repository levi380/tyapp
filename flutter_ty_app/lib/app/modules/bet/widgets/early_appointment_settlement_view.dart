import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/utils/betsUtils.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/format_money_util.dart';
import '../controllers/bet_ty_logic.dart';
import 'early_appointment_settlement_keyboard_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-注单预约提前兑现Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能展示早期预约结算的状态和操作按钮。
    - **动态显示**：根据预约结算类型（未提交、已提交）动态更新 UI。
    - **输入金额**：允许用户输入结算金额，并显示最小和最大值提示。
    - `EarlyAppointmentSettlementView`：接收三个参数：
    - `data`：类型为 `GetH5OrderListDataRecordxData`，用于存储结算数据。
    - `awaitBetsLogic`：类型为 `AwaitBetsLogic`，用于处理业务逻辑。
    - `index`：整数类型，表示当前视图的索引。
    - 使用 `Obx` 观察数据变化，构建包含文本、结算状态和操作按钮的列布局。
    - 显示已结算金额的文本。
    - 根据当前状态渲染不同的操作按钮（申请、移除、确认移除）。
    - 显示输入金额的区域，包含输入提示和数字键盘。
    - 显示最小和最大金额的提示信息。
    】】】
 *
 */
class EarlyAppointmentSettlementView extends StatelessWidget {
  EarlyAppointmentSettlementView({
    Key? key,
    required this.data,
    required this.betTyLogic,
    required this.index,
  }) : super(key: key);

  final GetH5OrderListDataRecordxData data;
  final BetTyLogic betTyLogic;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.earlyAppointmentSettlementType.value == 0
                ? LocaleKeys.bet_set_cash_out.tr
                : LocaleKeys.bet_set_to_cash_out.tr.replaceAll('{num}', ''),
            style: TextStyle(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.30000001192092896)
                  : const Color(0xFFAFB3C8),
              fontSize: 12.sp,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ).marginZero.marginOnly(bottom: 8.h),

          ///预约提前兑现开启没有提交状态
          _submissionStatus(
              context, data.earlyAppointmentSettlementType.value == 0),

          _earlySettlementButton(context),
        ],
      ),
    );
  }

  Widget _submissionStatus(BuildContext context, bool enabled) {
    if (enabled) {
      return _settlementRibbon(context).marginZero.marginOnly(bottom: 12.h);
    } else {
      return _settledRibbon(context).marginZero.marginOnly(bottom: 8.h);
    }
  }

  ///确认预约提前兑现结果 + 货币单位
  Widget _settledRibbon(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        data.reserveCashOutAmount.toString() +
            TYUserController.to.currCurrency(),
        style: TextStyle(
          color: context.isDarkMode
              ? Colors.white.withValues(alpha:0.8999999761581421)
              : const Color(0xFF303442),
          fontSize: 14.sp,
          fontFamily: 'PingFang SC',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _earlySettlementButton(BuildContext context) {
    var prompt = '';
    var state = data.earlyAppointmentSettlementType.value;
    if (state == 0) {
      prompt = LocaleKeys.bet_apply_cash_out.tr;
    } else if (state == 1) {
      prompt = LocaleKeys.bet_remove_cash_out.tr;
    } else {
      prompt = LocaleKeys.bet_confirm_remove.tr;
    }

    return InkWell(
      onTap: () => {
        betTyLogic.setEarlyAppointmentSettlement(
          index,
        ),
      },
      child: Container(
        width: double.maxFinite,
        height: 36.sp,
        alignment: Alignment.center,
        decoration: data.earlyAppointmentSettlementType.value == 0
            ? ShapeDecoration(
                color: Color(
                  context.isDarkMode ? 0xFF127DCC : 0xFF179CFF,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
              )
            : ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Color(
                      context.isDarkMode ? 0xFF127DCC : 0xFF179CFF,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
        child: Text(
          prompt,
          style: TextStyle(
            color: data.earlyAppointmentSettlementType.value == 0
                ? Colors.white
                : Color(
                    context.isDarkMode ? 0xFF127DCC : 0xFF179CFF,
                  ),
            fontSize: 12.sp,
            fontFamily: 'PingFang SC',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _settlementRibbon(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Container(
            width: double.maxFinite,
            height: 32.sp,
            padding: EdgeInsets.only(
                left: data.earlyAppointmentSettlementAmount.value.isEmpty
                    ? 8.w
                    : 14.w),
            decoration: ShapeDecoration(
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha:0.03999999910593033)
                  : const Color(0xFFF3FAFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              data.earlyAppointmentSettlementAmount.value.isEmpty
                  ? LocaleKeys.bet_input_v2.tr
                  : data.earlyAppointmentSettlementAmount.value,
              style: TextStyle(
                color: context.isDarkMode
                    ? data.earlyAppointmentSettlementAmount.value.isEmpty
                        ? Colors.white.withValues(alpha:0.20000000298023224)
                        : Colors.white.withValues(alpha:0.8999999761581421)
                    : data.earlyAppointmentSettlementAmount.value.isEmpty
                        ? const Color(0xFFAFB3C8)
                        : const Color(0xFF303442),
                fontSize:
                  data.earlyAppointmentSettlementAmount.value.isEmpty
                      ? 12.sp
                      : 14.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w500,
              ),
            ),
          ).marginOnly(bottom: 7.h),
        ),
        EarlyAppointmentSettlementKeyboardView(data: data)
            .marginOnly(bottom: 5.h),
        _amountHints(context),
      ],
    );
  }

  Widget _amountHints(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.bet_min_value.tr,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.30000001192092896)
                    : const Color(0xFFAFB3C8),
                fontSize: 13.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              FormatMoney.formatMoney2(
                  BetsUtils.betReserveAmountMin(betTyLogic.listData[index])),
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.699999988079071)
                    : const Color(0xFF616783),
                fontSize: 14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.bet_max_value.tr,
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.30000001192092896)
                    : const Color(0xFFAFB3C8),
                fontSize: 13.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              FormatMoney.formatMoney2(
                  BetsUtils.betReserveAmountMax(betTyLogic.listData[index])),
              style: TextStyle(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha:0.699999988079071)
                    : const Color(0xFF616783),
                fontSize: 14.sp,
                fontFamily: 'Akrobat',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ],
    );
  }
}
