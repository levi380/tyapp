import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/settled/settled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/ty_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/unsettled/unsettled_bets_logic.dart';
import 'package:flutter_ty_app/app/modules/bet_ty_cp_zr/ty/bets/widgets/title_special_view.dart';

import '../../../../../../../generated/locales.g.dart';
import '../../../../../../services/models/res/get_h5_order_list_entity.dart';
import '../../../../../login/login_head_import.dart';
import '../../../../../unsettled_bets/utils/betsUtils.dart';
import '../../../../../unsettled_bets/widgets/early_redemption_details_view.dart';
import '../../../../../unsettled_bets/widgets/early_settlement_feature_view.dart';
import '../../../../../unsettled_bets/widgets/information_copy_view.dart';
import '../../../../../unsettled_bets/widgets/information_important_view.dart';
import '../../../../../unsettled_bets/widgets/information_line_view.dart';

import '../../../../../unsettled_bets/widgets/information_special_view.dart';
import '../../../../../unsettled_bets/widgets/information_time_view.dart';
import '../../../../../unsettled_bets/widgets/information_view.dart';
import '../../../../../unsettled_bets/widgets/information_vr_view.dart';
import '../../../../../unsettled_bets/widgets/record_match_info.dart';
import '../../../../../unsettled_bets/widgets/rule_statement_view.dart';

import '../../widgets/title_view.dart';
import 'order_individually_item_utils.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 体育注单-单关(已结算/未结算)item视图层 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主要功能用于展示单独订单的详细信息，包括赛事信息、投注信息、状态等，适用于不同的订单状态（未注单-未结算、已结算）。
    - `getHomeName()`：获取主队名称。
    - `getAwayName()`：获取客队名称。
    - `getPlayName()`：获取玩法名称。
    - `getPlayOptions()`：获取玩法选项及赔率。
    - `getOrderNo()`：获取订单号。
    - `getModifyTime()`：获取修改时间。
    - `getMarketType()`：获取市场类型。
    - `getMatchInfo()`：获取赛事信息。
    - `getSettleScore()`：获取结算比分。
    - `gettleScore()`：获取当前比分。
    - `getOrderAmountTotal()`：获取订单总金额。
    - `getProfitAmount()`：获取可赢金额。
    - `getProfitAmountColor()`：获取可赢金额的颜色类型。
    - `getOrderStatus()`：获取订单状态。
    - `getScoreBenchmark()`：获取比分基准。
    - `getExhibitEarlySettlement()`：判断是否展示提前结算信息。
    - `getEarlySettlementFeature()`：判断是否有提前结算功能。
    】】】
 *
 */

///单关
class OrderIndividuallyItem extends StatelessWidget {
  const OrderIndividuallyItem({
    super.key,
    required this.index,
    required this.data,
    required this.type,
  });

  ///type  0: 未注单-未结算 ，1:已结算
  final int index, type;
  final GetH5OrderListDataRecordxData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: context.isDarkMode
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.white,
      ),
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w, bottom: 16.h),
      child: Column(
        children: [
          ///球队标题
          _titleview(),

          ///电子赛事id
          // if (["RC", "C01", "OD"].contains(data.detailList[0].dataSourceCode) &&
          //     data.detailList[0].thirdMatchId.isNotEmpty)
          //   InformationLineView(
          //     information: "赛事ID: "+data.detailList[0].thirdMatchId,
          //     multiLine: false,
          //   ),

          ///赛事赔率
          _handicapInformation(),

          ///赛事信息
          _information(),

          ///赛事提前结算
          _earlyRedemptionView(),
        ],
      ),
    );
  }

  ///球队标题
  Widget _titleview() {
    int sportId = 0;
    if (data.detailList.isNotEmpty) {
      sportId = data.detailList[0].sportId;
    }

    ///单关，这4种vr体育，vr赛狗，vr赛马，vr摩托车，vr泥地摩托车，标题头部不一样
    if ([1009, 1010, 1011, 1002].contains(sportId)) {
      return TitleSpecialView(
        information: data.detailList[0].batchNo,
      );
    } else {
      return TitleView(
        information: OrderIndividuallyItemUtils.getHomeName(data),
        outcome: OrderIndividuallyItemUtils.getAwayName(data),
        appointmentMarking: OrderIndividuallyItemUtils.getPreOrder(data),
      );
    }
  }

  ///赛事信息
  Widget _information() {
    return Column(
      children: [
        ///注单说明
        InformationLineView(
          iconUrl: BetsUtils.getBetResultIcon(data.detailList[0].betResult),
          information: OrderIndividuallyItemUtils.getMatchInfo(data),
          batchNo: OrderIndividuallyItemUtils.getBatchNo(data),
          multiLine: false,
        ),

        ///投注单号
        InformationCopyView(
          information: LocaleKeys.app_h5_cathectic_bet_number.tr,
          outcome: OrderIndividuallyItemUtils.getOrderNo(data),
        ),

        ///投注时间
        InformationTimeView(
          information: LocaleKeys.bet_record_sort1.tr,
          dateTime: OrderIndividuallyItemUtils.getModifyTime(data),
          timeZone: OrderIndividuallyItemUtils.getTimeZone(data, type),
          dish: OrderIndividuallyItemUtils.getMarketType(data),
        ),

        ///赛事比分
        if (type == 0)
          Obx(() {
            if (UnsettledBetsLogic.to.state.matchInfoList.isNotEmpty) {
              return RecordMatchInfo(
                data: data,
                matchInfoList: UnsettledBetsLogic.to.state.matchInfoList,
              );
            } else {
              return Container();
            }
          }),

        ///只有已结算，才有结果比分
        if (type == 1 &&
            OrderIndividuallyItemUtils.gettleScore(data).isNotEmpty)
          InformationLineView(
            information: OrderIndividuallyItemUtils.getSettleScore(data),
          ),

        ///投注额度，或者未算本金
        InformationView(
          information: OrderIndividuallyItemUtils.isPreBetAmount(data, type),
          outcome: OrderIndividuallyItemUtils.getOrderAmountTotal(data, type),
          isAmount: true,
        ),

        ///可赢额
        InformationView(
          titleColorType: 2,
          InformationColorType:
              OrderIndividuallyItemUtils.getProfitAmountColor(data, type),
          information: type == 0
              ? LocaleKeys.app_h5_cathectic_winnable.tr
              : LocaleKeys.app_h5_cathectic_settle.tr,
          outcome: OrderIndividuallyItemUtils.getProfitAmount(data, type),
          isAmount: true,
        ),

        ///注单状态
        InformationView(
          information: LocaleKeys.app_h5_cathectic_bet_status.tr,
          outcome: OrderIndividuallyItemUtils.getOrderStatus(data),
          InformationColorType:
              OrderIndividuallyItemUtils.getInformationColorType(data, type),
        ),
      ],
    );
  }

  ///提前结算
  _earlyRedemptionView() {
    return Column(
      children: [
        ///提前兑现说明
        if (OrderIndividuallyItemUtils.getEarlySettlementFeature(data, index) ||
            OrderIndividuallyItemUtils.getExhibitEarlySettlement(data))
          const RuleStatementView(),

        ///只有未注单才有，
        ///判断是否开启提前结算功能,提前结算功能的view（已结和未结都有）
        if (OrderIndividuallyItemUtils.getEarlySettlementFeature(data, index))
          EarlySettlementFeatureView(
            index: index,
            data: data,
          ),

        ///产品要求，4260需求回退，暂时不上线，等待通知......（添加 type == 1）
        ///提前结算,结算信息的view（已结和未结都有）
        if (OrderIndividuallyItemUtils.getExhibitEarlySettlement(data) &&
            type == 1)
          EarlyRedemptionDetailsView(
            data: data,
            index: index,
            onTap: () {
              if (type == 0) {
                /// 已结算提前兑现折叠
                Get.find<UnsettledBetsLogic>().onPreSettleExpand(index);
              } else if (type == 1) {
                /// 已结算提前兑现折叠
                Get.find<SettledBetsLogic>().onPreSettleExpand(index);
              }
            },
          ),
      ],
    );
  }

  /*
   *注单说明
   */
  Widget getInformationWidget() {
    String batchNo = OrderIndividuallyItemUtils.getBatchNo(data);

    ///vr赛事
    if (batchNo.isNotEmpty) {
      return InformationVrView(
        information: OrderIndividuallyItemUtils.getMatchInfo(data),
        batchNo: batchNo,
      );
    }
    //常规赛事
    return InformationLineView(
      information: OrderIndividuallyItemUtils.getMatchInfo(data),
      multiLine: false,
    );
  }

  /*
   *展示优惠盘口还是常规盘口信息
   */
  Widget _handicapInformation() {
    Widget widget = Container();

    String eov = data.detailList[0].eov;
    if (eov.isEmpty) {
      ///常规盘口
      widget = InformationImportantView(
        information: OrderIndividuallyItemUtils.getPlayName(data),
        outcome: OrderIndividuallyItemUtils.getPlayOptions(data),
        scoreBenchmark: OrderIndividuallyItemUtils.getScoreBenchmark(data),
        vrIcons: OrderIndividuallyItemUtils.getVrIcon(data),
      );
    } else {
      ///优惠盘口
      widget = InformationSpecialView(
        information: OrderIndividuallyItemUtils.getPlayName(data),
        outcome: OrderIndividuallyItemUtils.getSpecial(data),
        scoreBenchmark: OrderIndividuallyItemUtils.getScoreBenchmark(data),
        oddFinally: OrderIndividuallyItemUtils.getOddFinally(data),
        eov: OrderIndividuallyItemUtils.getEov(data),
      );
    }
    return InkWell(
      onTap: () => {
        ///（4325需求开发），发版本可以先屏蔽需求上线了，在打开
        Get.find<TyBetsLogic>().getExistMatchResult(
            data.detailList[0].matchId,
            data.detailList[0].playOptionsId,
            data.detailList[0].sportId,
            data.detailList[0].beginTime,
            dataSourceCode: data.detailList[0].dataSourceCode),
      },
      child: widget,
    );
  }
}
