import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';

import '../../../../../../generated/locales.g.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注记录列表信息视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票已结算注单Item
    - 越南菜16样式Widget
    】】】
 *
 */
class Vite16Widget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;
  Vite16Widget(
    this.orderListItem, {
    super.key,
  });

  final List<String> prizeList = [
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_0.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_1.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_2.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_3.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_4.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_5.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_6.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_7.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_ranking_8.tr
  ];
  @override
  Widget build(BuildContext context) {
    List<String> data = (orderListItem.ticketResult ?? "").split(',');
    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? SizedBox()
        : Container(
            child: Column(
              children: [
                SizedBox(
                  height: 8.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: data
                      .map((e) => information(context,
                          prizeList[data.indexOf(e)], e, data.indexOf(e)))
                      .toList(),
                )
              ],
            ),
          );
  }

  Widget information(
      BuildContext context, String leftContent, String rightContent, int index,
      {Color? leftColor}) {
    if (index == 0 || index == 1) {
      leftColor = Colors.blue;
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30.w,
            height: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.2)
                        : const Color(0xFF303442).withValues(alpha: 0.4),
                    width: 0.4)),
            child: Text(
              leftContent,
              style: TextStyle(
                color: leftColor ??
                    (context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF303442)),
                fontSize: 8.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 120.w,
            height: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.2)
                        : const Color(0xFF303442).withValues(alpha: 0.4),
                    width: 0.4)),
            child: Text(
              rightContent,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: (context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.8999999761581421)
                    : const Color(0xFF303442)),
                fontSize: 8.sp,
                fontFamily: 'PingFang SC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
