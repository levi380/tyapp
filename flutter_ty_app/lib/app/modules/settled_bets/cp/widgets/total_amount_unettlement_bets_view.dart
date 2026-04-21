import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../services/models/res/get_order_cp_list_entry_entity.dart';
import '../unsettled_records/unsettled_records_logic.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单记录列表头部统计注单Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票注单记录列表头部统计注单Widget
    】】】
 *
 */
class TotalAmountUnsettlementBetsView extends StatelessWidget {
  final int settled;
  final GetOrderCpListEntryEntity? orderCpListData;

  TotalAmountUnsettlementBetsView(
    this.orderCpListData,
    this.settled, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UnsettledRecordsLogic>(
        id: "totalAmountUnsettlementBetsView",
        builder: (logic) {
          return SizedBox(
            height: 49.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _single(
                    LocaleKeys.zr_cp_Lottery_Bet_Slips_total_number_of_bets.tr,
                    logic.total.toString()),
                _div(),
                _single(
                    LocaleKeys.bet_total.tr, logic.totalBetAmount.toString()),
                _div(),
                if (logic.settled == 0)
                  _single(
                      LocaleKeys.zr_cp_Lottery_Bet_Slips_total_win_amount.tr,
                      logic.totalCanWinAmount.toString()),
                if (logic.settled == 1)
                  _single(
                      LocaleKeys.zr_cp_Lottery_Bet_Slips_total_valid_bets.tr,
                      logic.totalBetAmount.toString()),
                _div(),
                if (logic.settled == 1)
                  if (logic.settled == 1)
                    _single(
                        LocaleKeys
                            .zr_cp_Lottery_Bet_Slips_total_winning_amount.tr,
                        logic.totalWinAmount.toString(),
                        isSpecial: true),
              ],
            ),
          );
        });
  }

  Widget _single(String title, String number, {bool isSpecial = false}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Get.isDarkMode
                  ? Colors.white.withValues(alpha: 0.5)
                  : const Color(0xFF7981A3),
              fontSize: 10.sp,
              height: 1,
              fontFamily: 'PingFang SC',
              fontWeight: FontWeight.w400,
            ),
          ).marginZero.marginOnly(bottom: 2.h),
          Text(
            number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSpecial
                  ? const Color(0xFFF53F3F)
                  : Get.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
              fontSize: 14.sp,
              fontFamily: 'Akrobat',
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget _div() {
    return Container(
      width: 1.w,
      height: 27.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Colors.white.withValues(alpha: 0.07999999821186066)
            : const Color(0xFFE4E6ED),
      ),
    );
  }
}
