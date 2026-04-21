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
    - 越南菜19样式 Widget
    】】】
 *
 */
class Vite19Widget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;
  Vite19Widget(
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

  final Map<int, int> colorMagzine = {
    1: 0xFFDFC124,
    2: 0xFF4089F7,
    3: 0xFF4D4D4D,
    4: 0xFFEB7B31,
    5: 0xFF55FBFF,
    6: 0xFF4C1FF4,
    7: 0xFFB8B8B8,
    8: 0xFFE73324,
    9: 0xFF6A1208,
    10: 0xFF62bf38,
  };
  Widget information(
      BuildContext context, String leftContent, String rightContent, int index,
      {Color? leftColor}) {
    var data = [];
    if (index == 0 || index == 1) {
      leftColor = Colors.blue;
    }
    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? SizedBox()
        : Container(
            height: 40.w,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: data
                  .map((e) => Container(
                        width: 20.w,
                        height: 20.w,
                        margin: EdgeInsets.only(left: 1.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.w)),
                          color: Color(
                              colorMagzine[int.tryParse(e) ?? 1] ?? 0xDFC124),
                        ),
                        child: Text(
                          "$e",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: context.isDarkMode
                                ? Colors.white
                                    .withValues(alpha: 0.8999999761581421)
                                : const Color(0xFF303442),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }
}
