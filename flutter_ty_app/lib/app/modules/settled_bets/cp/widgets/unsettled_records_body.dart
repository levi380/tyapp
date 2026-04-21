import 'package:flutter_ty_app/app/modules/settled_bets/cp/widgets/total_amount_unettlement_bets_view.dart';

import '../../../../../main.dart';
import '../../../login/login_head_import.dart';
import '../item/additional_aready_settlement_records_item.dart';
import '../item/additional_recordsi_unsettlement_tem.dart';
import '../unsettled_records/unsettled_records_logic.dart';
import 'cp_bets_loading_view.dart';
import 'cp_no_data_hints_view.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单记录列表视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票注单记录列表视图Widget
    】】】
 *
 */
class UnsettledRecordsBody extends StatelessWidget {
  UnsettledRecordsBody({super.key, required this.settled});

  final int settled;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnsettledRecordsLogic>(
        id: "UnsettledRecordsLogicBody",
        builder: (logic) {
          // AppLogger.debug("======>${logic.orderListItemList.length}");
          return SizedBox(
            height: logic.loading || logic.orderListItemList.isEmpty
                ? 300.h
                : isIPad
                    ? 580.h
                    : 460.h,
            //列表组件
            child: logic.loading
                ? const CpBetsLoadingView()
                : logic.orderListItemList.isEmpty
                    ? CpNoDataHintsView(
                        type: settled,
                      )
                    : ListView.separated(
                        itemCount: logic.orderListItemList.length + 1,
                        padding: EdgeInsets.zero,
                        //  controller:logic.scrollController,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return index != 0
                              ? Divider(
                                  color: Get.isDarkMode
                                      ? Colors.white.withValues(
                                          alpha: 0.07999999821186066)
                                      : null,
                                  height: 1.0,
                                ).marginOnly(left: 12.w, right: 12.w)
                              : Container();
                        },
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return TotalAmountUnsettlementBetsView(
                                logic.orderCpListData, settled);
                          }

                          /// 这里传  index-1
                          return settled == 0
                              ? AdditionalUnsettlementRecordsItem(
                                      logic.orderListItemList[index - 1],
                                      index: index - 1,
                                      isTopRounded: index == 1,
                                      isBottomRounded:
                                          logic.orderListItemList.length ==
                                              (index - 1))
                                  .marginZero
                                  .marginOnly(
                                      bottom: logic.orderListItemList.length ==
                                              index
                                          ? 10.w
                                          : 0.w)
                              : AdditionalAreadySettlementRecordsItem(
                                      logic.orderListItemList[index - 1],
                                      index: index - 1,
                                      isTopRounded: index == 1,
                                      isBottomRounded:
                                          logic.orderListItemList.length ==
                                              (index - 1))
                                  .marginZero
                                  .marginOnly(
                                      bottom: logic.orderListItemList.length ==
                                              index
                                          ? 10.w
                                          : 0.w);
                        },
                      ).marginOnly(bottom: 2.w),
          );
        });
  }
}
