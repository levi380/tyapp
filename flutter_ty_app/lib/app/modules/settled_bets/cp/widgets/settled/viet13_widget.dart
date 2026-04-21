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
    -  万宁福字 Widget
    】】】
 *
 */
class Viet13Widget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;
  Viet13Widget(
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
    List<String> first = data.sublist(0, 3);
    List<String> second = data.sublist(3, 13);
    List<String> three = data.sublist(13, data.length);

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
                  children: [
                    buildOneTwoThree(context, first),
                    SizedBox(
                      height: 4.w,
                    ),
                    buildFour(context, second),
                    SizedBox(
                      height: 4.w,
                    ),
                    buildFive(context, three),
                  ],
                )
              ],
            ),
          );
  }

  buildOneTwoThree(BuildContext context, List<String> data) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFF7555C),
                  borderRadius: BorderRadius.all(Radius.circular(2.w))),
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                "首奖${data[0]}",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFFFAA552),
                  borderRadius: BorderRadius.all(Radius.circular(2.w))),
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                "二奖${data[1]}",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF52D0FC),
                  borderRadius: BorderRadius.all(Radius.circular(2.w))),
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                "三奖${data[2]}",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: context.isDarkMode
                      ? Colors.white.withValues(alpha: 0.8999999761581421)
                      : const Color(0xFF303442),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildFour(BuildContext context, List<String> second) {
    return Container(
      child: Column(
        children: [
          Text(
            "特等奖",
            style: TextStyle(
              fontSize: 12.sp,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.8999999761581421)
                  : const Color(0xFF303442),
            ),
          ),
          Container(
            width: 200.w,
            child: Wrap(
              children: second
                  .map((e) => Container(
                        width: 50.w,
                        height: 30.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.w, horizontal: 2.w),
                        child: Text(
                          "${e}",
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
          )
        ],
      ),
    );
  }

  buildFive(BuildContext context, List<String> second) {
    return Container(
      child: Column(
        children: [
          Text(
            "安慰奖",
            style: TextStyle(
              fontSize: 12.sp,
              color: context.isDarkMode
                  ? Colors.white.withValues(alpha: 0.8999999761581421)
                  : const Color(0xFF303442),
            ),
          ),
          Container(
            width: 200.w,
            child: Wrap(
              children: second
                  .map((e) => Container(
                        width: 50.w,
                        height: 30.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.w, horizontal: 2.w),
                        child: Text(
                          "${e}",
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
          )
        ],
      ),
    );
  }
}
