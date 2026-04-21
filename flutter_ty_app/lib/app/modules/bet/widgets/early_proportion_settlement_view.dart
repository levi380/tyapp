
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/format_money_util.dart';
import '../../unsettled_bets/utils/betsUtils.dart';
import '../../unsettled_bets/widgets/information_view.dart';
import '../../unsettled_bets/widgets/slider/custom_slider_new.dart';
import '../controllers/bet_record_controller.dart';
import '../controllers/bet_ty_logic.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)部分提前兑Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 处理注单类型切换逻辑
    】】】
 *
 */
class EarlyProportionSettlementView extends StatelessWidget {
  const EarlyProportionSettlementView({
    Key? key,
    required this.index,
    required this.data,
    required this.betTylogic,
  }) : super(key: key);

  final GetH5OrderListDataRecordxData data;
  final BetTyLogic betTylogic;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InformationView(
          top: 6,
          information: '${LocaleKeys.early_info4.tr}：',
          outcome:
          '${FormatMoney.formatMoney2(BetsUtils.cashoutStake(betTylogic.listData[index]))} ${TYUserController.to.currCurrency()}',
          isAmount: true,
        ),
        _slideBar(),
        InformationView(
          top: 6,
          information: '${LocaleKeys.early_info8.tr}：',
          outcome:
          '${FormatMoney.formatMoney2(BetsUtils.betRemainingAmount(betTylogic.listData[index]))} ${TYUserController.to.currCurrency()}',
          isAmount: true,
        ),
        //  InformationView(
        //    information: '${LocaleKeys.early_info9.tr}：',
        //    outcome: BetsUtils.betPreCount(awaitBetsLogic.listData[index]),
        //    isAmount: true,
        //  ),
      ],
    );
  }



  _slideBar() {
    final logic = Get.find<BetRecordController>();
    return CustomSliderNew(
      image: logic.state.sliderBlockImage,
      thumbHeight: 30.h,
      thumbWidth: 45.w,
      trackHeight: 6.h,
      imageThumbOffset: 0,
      inactiveTrackColor: Get.isDarkMode
          ? const Color.fromRGBO(
        255,
        255,
        255,
        0.08,
      )
          : const Color.fromRGBO(
        228,
        230,
        237,
        1,
      ),
      activeTrackColor: const Color.fromRGBO(
        102,
        186,
        253,
        1,
      ),
      value: data.earlyProportionSettleRatio,
      min: 0,
      max: 1,
      minAmount: getMinAmount(),
      maxAmount: getMaxAmount(),
      onChanged: (val) {
        betTylogic.setEarlyProportionSettleRatio(index, val);
      },
    );
  }

  ///最小的兑现金额

  String getMinAmount() {
    double minAmount =  data.preSettleBetAmount;
    ///当最大额度大于1，最小额度才是1
    if (minAmount>1){
      return "1";
    }else{
      return minAmount.toString();
    }

  }
  ///最大的兑现金额
  String getMaxAmount() {
    return data.preSettleBetAmount.toString();

  }
}
