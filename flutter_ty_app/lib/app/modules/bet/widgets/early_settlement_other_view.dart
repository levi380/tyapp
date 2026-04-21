
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../controllers/bet_ty_logic.dart';
import 'early_appointment_settlement_view.dart';
import 'early_proportion_settlement_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)预约提前兑Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示预约提前结算和部分提前结算的选项，以及相应的操作视图。
    - `EarlySettlementOtherView`：接收三个参数：
    - `data`：类型为 `GetH5OrderListDataRecordxData`，用于存储提前结算的详细数据。
    - `awaitBetsLogic`：类型为 `AwaitBetsLogic`，用于处理逻辑操作。
    - `index`：整数类型，表示当前视图的索引。
    - 返回一个包含多个子组件的列布局：
    - **提前结算列表视图**：展示预约和部分提前结算的开关。
    - **操作视图**：根据 `earlySettlementType` 的值，展示不同的操作视图。
    - `_showDifferentStyles`：根据 `earlySettlementType` 返回相应的视图组件（`EarlyAppointmentSettlementView` 或 `EarlyProportionSettlementView`）。
    - `earlySettlementSwitch`：创建一个可点击的切换按钮，展示预约和部分提前结算的选项。
    】】】
 *
 */
class EarlySettlementOtherView extends StatelessWidget {
  const EarlySettlementOtherView({
    Key? key,
    required this.data,
    required this.betTylogic,
    required this.index,
  }) : super(key: key);

  final int index;
  final BetTyLogic betTylogic;
  final GetH5OrderListDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///提前结算列表视图
        Row(
          children: [
            if (data.bookedSettleSwitch)
              earlySettlementSwitch(
                  LocaleKeys.app_scheduled_early_settlement.tr, 0, context),
            if (data.partSettleSwitch)
              earlySettlementSwitch(
                  LocaleKeys.app_partial_early_settlement.tr, 1, context),
          ],
        ).marginZero.marginOnly(top: 8.h, bottom: 8.h),

        ///提前结算操作视图
        _showDifferentStyles(data.earlySettlementType),
      ],
    );
  }

  ///操作视图
  Widget _showDifferentStyles(int earlySettlementType) {
    ///预约提前结算
    if (data.earlySettlementType == 0) {
      return EarlyAppointmentSettlementView(
        data: data,
        index: index,
        betTyLogic: betTylogic,
      );

      ///部分提前结算
    } else if (data.earlySettlementType == 1) {
      return EarlyProportionSettlementView(
        data: data,
        betTylogic: betTylogic,
        index: index,
      );
    }
    return Container();
  }

  ///提前结算列表视图
  Widget earlySettlementSwitch(String title, int type, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => {
          if (data.earlySettlementType != type)
            {
              betTylogic.setType(index, type),
            }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 6.h,
            ),
            //
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.isDarkMode
                    ? type == data.earlySettlementType
                        ? Colors.white.withValues(alpha:0.8999999761581421)
                        : Colors.white.withValues(alpha:0.5)
                    : type == data.earlySettlementType
                        ? const Color(0xFF303442)
                        : const Color(0xFF7981A3),
                fontSize: 12.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              height: 6.h,
            ),
            if (type == data.earlySettlementType)
              Container(
                width: 35.w,
                height: 3.h,
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? const Color(0xFF127DCC)
                      : const Color(0xFF179CFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
