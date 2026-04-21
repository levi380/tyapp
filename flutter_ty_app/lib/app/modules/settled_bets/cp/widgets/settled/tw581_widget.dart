import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:lunar/calendar/Lunar.dart';
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
    -  台湾581样式 Widget
    】】】
 *
 */
class Tw581Widget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  Tw581Widget(
    this.orderListItem, {
    super.key,
  }) {
    initData();
  }

  final List<List<String>> sxNumArray539 = [
    ['04', '16', '28'],
    ['03', '15', '27', '39'],
    ['02', '14', '26', '38'],
    ['01', '13', '25', '37'],
    ['12', '24', '36'],
    ['11', '23', '35'],
    ['10', '22', '34'],
    ['09', '21', '33'],
    ['08', '20', '32'],
    ['07', '19', '31'],
    ['06', '18', '30'],
    ['05', '17', '29'],
  ];
  final List<String> defaultArr = [
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_0.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_1.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_2.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_3.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_4.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_5.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_6.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_7.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_8.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_9.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_10.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_11.tr
  ];
  int year = Lunar.fromDate(DateTime.now()).getYear();
  int index = 0;
  final List<List<String>> newArray = [];

  final List<String> red = [
    '01',
    '04',
    '07',
    '10',
    '13',
    '16',
    '19',
    '22',
    '25',
    '28',
    '31',
    '34',
    '37'
  ];
  final List<String> blue = [
    '02',
    '05',
    '08',
    '11',
    '14',
    '17',
    '20',
    '23',
    '26',
    '29',
    '32',
    '35',
    '38'
  ];
  final List<String> green = [
    '03',
    '06',
    '09',
    '12',
    '15',
    '18',
    '21',
    '24',
    '27',
    '30',
    '33',
    '36',
    '39'
  ];

  final List<String> animals = [
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_0.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_1.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_2.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_3.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_4.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_5.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_6.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_7.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_8.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_9.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_10.tr,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_11.tr
  ];

  final List<int> years = [2024, 2025, 2026, 2027];

  final int newOdered = 0;

  initData() {
    year = Lunar.fromDate(DateTime.now()).getYear();
    index = [2024, 2025, 2026, 2027].indexOf(year);
    newArray.clear();
    newArray.addAll(sxNumArray539.sublist(3 - index));
    newArray.addAll(sxNumArray539.sublist(0, 3 - index));
    // newArray = [sxNumArray539.sublist(3-index),sxNumArray539.sublist(0, 3-index)]
  }

  Color getColor(String num) {
    if (red.contains(num)) {
      return Colors.red;
    } else if (blue.contains(num)) {
      return Colors.blue;
    } else if (green.contains(num)) {
      return Colors.green;
    }
    return Colors.green;
  }

  String getZodiac(String num) {
    for (int i = 0; i < newArray.length; i++) {
      List<String> dataList = newArray[i];
      if (dataList.contains(num)) {
        return defaultArr[i];
      }
    }
    return defaultArr[0];
  }

  @override
  Widget build(BuildContext context) {
    List<String> data = (orderListItem.ticketResult ?? "").split(',');
    initData();

    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? SizedBox()
        : Container(
            height: 40.w,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: data.map((e) {
                  return Container(
                      width: 36.w,
                      height: 36.w,
                      margin: EdgeInsets.only(right: 3.w),
                      child: index == -1
                          ? SizedBox()
                          : Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 20.w,
                                    height: 20.w,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 4.w),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: getColor(e), width: 1.w),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.w)),
                                      color: context.isDarkMode
                                          ? Colors.white.withValues(alpha: 0.04)
                                          : Colors.white,
                                    ),
                                    child: Text(
                                      "$e",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: context.isDarkMode
                                            ? Colors.white.withValues(
                                                alpha: 0.8999999761581421)
                                            : const Color(0xFF303442),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 4.w,
                                  bottom: 4.w,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.w)),
                                      color: context.isDarkMode
                                          ? Colors.white.withValues(alpha: 0.04)
                                          : Colors.white,
                                    ),
                                    child: Text(
                                      "${getZodiac(e)}",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: context.isDarkMode
                                            ? Colors.white.withValues(
                                                alpha: 0.8999999761581421)
                                            : const Color(0xFF303442),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ));
                }).toList(),
              ),
            ),
          );
  }
}
