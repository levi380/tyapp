import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:lunar/calendar/Lunar.dart';

import '../../../../../../generated/locales.g.dart';

import '../../utils/LunarCalendar.dart';
import 'package:flutter_ty_app/app/services/models/res/get_order_cp_list_entry_entity.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票投注MarkSixSerialTes视图Widget】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    】】】
 *
 */
class MarkSixSerialTes extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  MarkSixSerialTes(
    this.orderListItem, {
    super.key,
  }) {
    initData();
  }

  final List<List<String>> sxNumArray = [
    ['01', '13', '25', '37', '49'],
    ['12', '24', '36', '48'],
    ['11', '23', '35', '47'],
    ['10', '22', '34', '46'],
    ['09', '21', '33', '45'],
    ['08', '20', '32', '44'],
    ['07', '19', '31', '43'],
    ['06', '18', '30', '42'],
    ['05', '17', '29', '41'],
    ['04', '16', '28', '40'],
    ['03', '15', '27', '39'],
    ['02', '14', '26', '38'],
  ];
  final List<String> defaultArr = [
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_0,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_1,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_2,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_3,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_4,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_5,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_6,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_7,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_8,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_9,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_10,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_11
  ];
  final int year = Lunar.fromDate(DateTime.now()).getYear();
  final int index = 0;
  final List<List<String>> newArray = [];

  final List<String> red = [
    '01',
    '02',
    '07',
    '08',
    '12',
    '13',
    '18',
    '19',
    '23',
    '24',
    '29',
    '30',
    '34',
    '35',
    '40',
    '45',
    '46'
  ];
  final List<String> blue = [
    '03',
    '04',
    '09',
    '10',
    '14',
    '15',
    '20',
    '25',
    '26',
    '31',
    '36',
    '37',
    '41',
    '42',
    '47',
    '48'
  ];
  final List<String> green = [
    '05',
    '06',
    '11',
    '16',
    '17',
    '21',
    '22',
    '27',
    '28',
    '32',
    '33',
    '38',
    '39',
    '43',
    '44',
    '49'
  ];

  final List<String> animals = [
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_0,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_1,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_2,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_3,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_4,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_5,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_6,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_7,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_8,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_9,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_10,
    LocaleKeys.zr_cp_Lottery_Bet_Slips_zodiac_signs_11
  ];

  final List<int> years = [2024, 2025, 2026, 2027];

  final int newOdered = 0;
  final List<String> newAnimals = [];
  initData() {
    LunarCalendar lunarCalendar = LunarCalendar(DateTime.now());
    String currentAnimal = lunarCalendar.animalsYear();

    int index = animals.indexOf(currentAnimal);
    newAnimals.addAll(animals.sublist(index));
    newAnimals.addAll(animals.sublist(0, index));
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
    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? SizedBox()
        : Container(
            height: 40.w,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: data.map((e) {
                  String result = "";

                  for (int i = 0; i < sxNumArray.length; i++) {
                    List<String> child = sxNumArray[i];
                    if (child.contains(e)) {
                      result = newAnimals[i];

                      break;
                    }
                  }
                  return Container(
                      width: 32.w,
                      height: 32.w,
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
                                      border:
                                          (data.indexOf(e) == data.length - 1)
                                              ? Border.all(
                                                  color: Color(0xFF008001),
                                                  width: 1.w)
                                              : Border.all(
                                                  color: getColor("$e"),
                                                  width: 1.w),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.w)),
                                      color:
                                          (data.indexOf(e) == data.length - 1)
                                              ? Color(0xFF008001)
                                              : (context.isDarkMode
                                                  ? Colors.white
                                                      .withValues(alpha: 0.04)
                                                  : Colors.white),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "$e",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: (data.indexOf(e) ==
                                                    data.length - 1)
                                                ? Colors.white
                                                : (context.isDarkMode
                                                    ? Colors.white.withValues(
                                                        alpha:
                                                            0.8999999761581421)
                                                    : const Color(0xFF303442)),
                                          ),
                                        ),
                                        Icon(Icons.add,
                                            size: 20,
                                            color: Color(
                                              0xFF303442,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 4.w,
                                  bottom: 0.w,
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
                                      "$result",
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
