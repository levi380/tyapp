import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';

import '../../../../generated/locales.g.dart';
import '../../../global/ty_user_controller.dart';
import '../../../services/models/res/get_pre_settle_order_detail_entity.dart';
import '../../../utils/utils.dart';
import '../../login/login_head_import.dart';

import 'information_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单(已结算)提前兑现item视图 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能是展示提前结算的相关信息，包括本金、输赢状态和返还金额。
    - 根据传入的数据动态显示结算信息。
    - `EarlyRedemptionDetailsChildView`：接收两个参数：
    - `data`：类型为 `GetPreSettleOrderDetailData`，用于存储结算详情数据。
    - `index`：整数类型，表示当前视图的索引。
    - 构建一个列布局，包含多个信息视图。
    - 使用 `InformationView` 组件展示标题、结算本金、输赢状态和返还金额。
    - `getPreBetAmount()`：获取并格式化结算本金。
    - `getProfit()`：获取并格式化输赢状态。
    - `getSettleAmount()`：获取并格式化返还金额。
    】】】
 *
 */
class EarlyRedemptionDetailsChildView extends StatelessWidget {
  EarlyRedemptionDetailsChildView({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final int index;
  final GetPreSettleOrderDetailData data;
  final managerCode = TYUserController.to.currCurrency();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///提前结算详情标题
        InformationView(
          information: LocaleKeys.app_h5_cathectic_all_cash_sess.tr,
        ),

        ///结算本金
        InformationView(
          information: index == 0
              ? LocaleKeys.early_list2.tr
              : LocaleKeys.early_list7.tr,
          outcome: getPreBetAmount(),
          titleColorType: 1,
          isAmount: true,
        ),

        ///输赢状态
        InformationView(
          information: LocaleKeys.bet_record_l_w.tr,
          outcome: getProfit(),
          titleColorType: 1,
          isAmount: true,
        ),

        ///返还金额
        InformationView(
          information: LocaleKeys.early_list4.tr,
          outcome: getSettleAmount(),
          InformationColorType: 2,
          titleColorType: 1,
          isAmount: true,
        ),
      ],
    );
  }

  String getPreBetAmount() {
    String preBetAmount = "";

    preBetAmount = '${setAmount(data.preBetAmount.toString())} $managerCode';
    return preBetAmount;
  }

  String getProfit() {
    String profitAmount = "";
    profitAmount = '${setAmount(data.profit.toString())} $managerCode';
    return profitAmount;
  }

  String getSettleAmount() {
    String backAmount = "";
    backAmount = '${setAmount(data.settleAmount.toString())} $managerCode';
    return backAmount;
  }
}
