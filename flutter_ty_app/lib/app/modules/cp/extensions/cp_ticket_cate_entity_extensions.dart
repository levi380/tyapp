import 'package:flutter_ty_app/app/services/models/res/cp_ticket_cate_entity.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:get/get.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-27800d93-e3ca-4e92-b267-9f07d07c3e73-cp 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票列表页】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票列表页 彩种 CpTicketCateEntityExtension 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票列表页 彩种 CpTicketCateEntityExtension
    - CpTicketCateEntityExtension
    ```
    ///对应彩种国际化
    localeName
    ```
    】】】
 *
 */
extension CpTicketCateEntityExtension on CpTicketCateEntity {
  String get localeName {
    final keyNames = {
      'PK10': LocaleKeys.zr_cp_list_Games_Lottery_pk10.tr,
      '时时彩': LocaleKeys.zr_cp_list_Games_Lottery_colorful.tr,
      '六合彩': LocaleKeys.zr_cp_list_Games_Lottery_mark_six_lottery.tr,
      '11选5': LocaleKeys.zr_cp_list_Games_Lottery_choose_5_from_11.tr,
      '快三': LocaleKeys.zr_cp_list_Games_Lottery_fast_three.tr,
      '3D': LocaleKeys.zr_cp_list_Games_Lottery_3d.tr,
      '快乐8': LocaleKeys.zr_cp_list_Games_Lottery_happy_8.tr,
      '双色球': LocaleKeys.zr_cp_list_Games_Lottery_double_color_ball.tr,
      '幸运28': LocaleKeys.zr_cp_list_Games_Lottery_lucky_28.tr,
      '539': LocaleKeys.zr_cp_list_Games_Lottery_539.tr,
      '台湾539': LocaleKeys.zr_cp_list_Games_Lottery_taiwan_539.tr,
      '万字3D': LocaleKeys.zr_cp_list_Games_Lottery_ten_thousand_3d.tr,
      '万字4D': LocaleKeys.zr_cp_list_Games_Lottery_ten_thousand_4d.tr,
      '泰国彩': LocaleKeys.zr_cp_list_Games_Lottery_thai_lottery.tr,
      '北部越南彩': LocaleKeys.zr_cp_list_Games_Lottery_northern_vietnam_lottery.tr,
      '越南北部彩': LocaleKeys.zr_cp_list_Games_Lottery_northern_vietnam_lottery.tr,
      '中部越南彩': LocaleKeys.zr_cp_list_Games_Lottery_central_vietnam_lottery.tr,
      '越南中部彩': LocaleKeys.zr_cp_list_Games_Lottery_central_vietnam_lottery.tr,
      '南部越南彩': LocaleKeys.zr_cp_list_Games_Lottery_southern_vietnam_lottery.tr,
      '越南南部彩': LocaleKeys.zr_cp_list_Games_Lottery_southern_vietnam_lottery.tr,
      '低频彩': LocaleKeys.zr_cp_list_Games_Lottery_low_frequency_color.tr,
      '骰宝': LocaleKeys.zr_cp_list_Games_Lottery_sic_bo.tr,
      '百家乐': LocaleKeys.zr_cp_list_Games_Lottery_baccarat.tr,
      '特色PK10': LocaleKeys.zr_cp_list_Games_Lottery_featured_pk10.tr,
      '英雄召唤': LocaleKeys.zr_cp_list_Games_Lottery_hero_call.tr,

    };
    final localeName = keyNames[name] ?? '';
    if (localeName.isEmpty) {
      return name;
    }
    return localeName;
  }

  String cpCateIconPath(
    bool isSel,
    bool isDarkMode,
  ) {
    return 'assets/images/cp_cate_icon/${isSel ? 'active' : 'normal'}/${isDarkMode ? 'night' : 'day'}/$id.png';
  }
}
