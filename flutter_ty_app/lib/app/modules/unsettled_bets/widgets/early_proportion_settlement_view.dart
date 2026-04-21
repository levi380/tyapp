import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/unsettled_bets/widgets/slider/custom_slider_new.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../utils/format_money_util.dart';
import '../../bet_ty_cp_zr/ty/bets/unsettled/unsettled_bets_logic.dart';
import '../utils/betsUtils.dart';
import 'information_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(未结算)部分提前兑Widget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能展示与早期比例结算相关的信息和滑块。
    - 根据业务逻辑动态显示用户的现金支出、剩余投注金额和预计收益。
    - `EarlyProportionSettlementView`：接收三个参数：
    - `data`：类型为 `GetH5OrderListDataRecordxData`，用于存储结算数据。
    - `awaitBetsLogic`：类型为 `AwaitBetsLogic`，用于处理业务逻辑。
    - `index`：整数类型，表示当前视图的索引。
    - 构建一个列布局，包含多个信息视图和一个滑块。
    - 使用 `InformationView` 组件展示不同的信息。
    - 返回一个自定义滑块 `CustomSlider`，用于调整早期比例结算的比例。
    - 设置滑块的属性，如图像、轨道颜色、最小值和最大值等。
    】】】
 *
 */
class EarlyProportionSettlementView extends StatelessWidget {
  const EarlyProportionSettlementView({
    Key? key,
    required this.unsettledBetsLogic,
    required this.index,
    required this.data,
  }) : super(key: key);
  final GetH5OrderListDataRecordxData data;
  final UnsettledBetsLogic unsettledBetsLogic;
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
              '${FormatMoney.formatMoney2(BetsUtils.cashoutStake(unsettledBetsLogic.state.listData[index]))} ${TYUserController.to.currCurrency()}',
          isAmount: true,
        ),
        _slideBar(),
        InformationView(
          top: 6,
          information: '${LocaleKeys.early_info8.tr}：',
          outcome:
              '${FormatMoney.formatMoney2(BetsUtils.betRemainingAmount(unsettledBetsLogic.state.listData[index]))} ${TYUserController.to.currCurrency()}',
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
    return CustomSliderNew(
      image: unsettledBetsLogic.sliderBlockImage,
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
        unsettledBetsLogic.setEarlyProportionSettleRatio(index, val);
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
