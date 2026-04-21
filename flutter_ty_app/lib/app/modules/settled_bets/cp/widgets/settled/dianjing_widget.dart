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
    - 电竞 英雄 男女 样式 Widget
    】】】
 *
 */
class DianJingWidget extends StatelessWidget {
  final GetOrderCpListEntryList orderListItem;

  DianJingWidget(
    this.orderListItem, {
    super.key,
  }) {}

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

  @override
  Widget build(BuildContext context) {
    List<String> data = (orderListItem.ticketResult ?? "").split(',');
    return (data.isEmpty || orderListItem.ticketResult?.isEmpty == true)
        ? const SizedBox()
        : SizedBox(
            height: 40.w,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${orderListItem.ticketResult}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: 0.8999999761581421)
                        : const Color(0xFF303442),
                  ),
                )
              ],
            ));
  }
}
