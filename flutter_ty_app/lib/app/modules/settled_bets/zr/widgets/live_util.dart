import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-bd58c8a0-e850-406d-82ea-e9d19c8f5403-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人注单LiveUtils组件 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - getGameTypeName     游戏类型
    - getBetPointName     投注选中类型

    ## 描述
    根据当前语言环境返回游戏类型的名称，支持中文和英文。

    ## 方法

    ### 1. `getGameTypeName`
    - 返回游戏类型名称，如果是中文则返回原名称，否则根据预设的英文名称返回。

    ### 2. `getBetPointName`
    - 根据投注点名称返回对应的英文名称，支持中文和英文。

    ## 其他说明
    - 支持多种投注点名称的转换，确保不同语言环境下的显示一致性。

    】】】
 *
 */

class LiveUtils {
  ///真人注单名称只有中文，没有的英文显示
  ///
  static getGameTypeName(String gameTypeName) {
    String tlg = Get.locale!.toLanguageTag();
    if (tlg.contains('zh-CN') || tlg.contains('zh-TW')) {
      return gameTypeName;
    } else {
      switch (gameTypeName) {
        case '经典百家乐':
          return 'Classic baccarat';
        case '极速百家乐':
          return 'Speed baccarat';
        default:
          return "";
      }
    }
  }

  static getGameTypeNameLocale(String gameTypeName) {
    switch (gameTypeName) {
      case '经典百家乐':
        return LocaleKeys.zr_cp_settings_Menu_zr_cla.tr;
      case '极速百家乐':
        return LocaleKeys.zr_cp_settings_Menu_zr_spd.tr;
      default:
        return gameTypeName;
    }
  }

  static getBetPointName(String betPointName) {
    String tlg = Get.locale!.toLanguageTag();
    if (tlg.contains('zh-CN') || tlg.contains('zh-TW')) {
      return betPointName;
    } else {
      switch (betPointName) {
        case '庄':
          return 'B';
        case '闲':
          return 'P';
        case '和':
          return 'Tie';
        case '局数':
          return 'Game';
        case '庄对':
          return 'B Pair';
        case '闲对':
          return 'P Pair';
        case '大':
          return 'Big';
        case '小':
          return 'Small';
        case '赢':
          return 'Win';
        case '老虎对':
          return 'Tiger Pair';
        case '老虎和':
          return 'Tiger Tie';
        case '龙虎和':
          return 'Dragon Tiger Tie';
        case '龙':
          return 'Dragon';
        case '虎':
          return 'Tiger';
        case '天牌':
          return 'Natural';
        case '庄天牌':
          return 'B Natural';
        case '闲天牌':
          return 'P Natural';
        case '小老虎':
          return 'Small Tiger';
        case '大老虎':
          return 'Big Tiger';
        case '熊猫8':
          return 'Panda 8';
        case '龙7':
          return 'Dragon 7';
        case '超级对':
          return 'Super Pair';
        case '任意对子':
          return 'Either Pair';
        case '完美对子':
          return 'Perfect Pair';
        case '庄龙宝':
          return 'B Dragon Bonus';
        case '闲龙宝':
          return 'P Dragon Bonus';
        case '庄免佣':
          return 'B No-commission';
        case '幸运六':
          return 'Lucky6';
        case '和局':
          return 'Tie';
        case '例牌':
          return 'Natural';
        case '免佣':
          return 'No Commission';
        case '不免佣':
          return 'Commission';
        case '庄平倍':
          return 'B Equal';
        case '闲1庄平倍':
          return 'P1B Equal';
        case '闲2庄平倍':
          return 'P2B Equal';
        case '闲3庄平倍':
          return 'P3B Equal';
        case '闲平倍':
          return 'P Equal';
        case '闲1闲平倍':
          return 'P1P Equal';
        case '闲2闲平倍':
          return 'P2P Equal';
        case '闲3闲平倍':
          return 'P3P Equal';
        case '庄翻倍':
          return 'B Double';
        case '闲1庄翻倍':
          return 'P1B Double';
        case '闲2庄翻倍':
          return 'P2B Double';
        case '闲3庄翻倍':
          return 'P3B Double';
        case '闲翻倍':
          return 'P Double';
        case '闲1闲翻倍':
          return 'P1P Double';
        case '闲2闲翻倍':
          return 'P2P Double';
        case '闲3闲翻倍':
          return 'P3P Double';
        case '我的投注':
          return 'My bet';
        case '本局总投注':
          return 'Total bet';
        case '经典':
          return 'Classic';
        case '龙宝':
          return 'Dra Bon';
        case '对子':
          return 'Pair';
        case '超和':
          return 'Super Tie';
        case '老虎':
          return 'Tiger';
        case '龙虎':
          return 'Dragon Tiger';
        case '大小':
          return 'Big Small';
        default:
          return "";
      }
    }
  }

  static getBetPointNameLocale(String betPointName) {
    String tlg = Get.locale!.toLanguageTag();
    if (tlg.contains('zh-CN') || tlg.contains('zh-TW')) {
      return betPointName;
    } else {
      switch (betPointName) {
        case '庄':
          return LocaleKeys.zr_cp_record_zr_play01.tr;
        case '闲':
          return LocaleKeys.zr_cp_record_zr_play02.tr;
        case '和':
          return LocaleKeys.zr_cp_record_zr_play03.tr;
        case '局数':
          return LocaleKeys.zr_cp_record_zr_play04.tr;
        case '庄对':
          return LocaleKeys.zr_cp_record_zr_play05.tr;
        case '闲对':
          return LocaleKeys.zr_cp_record_zr_play06.tr;
        case '大':
          return LocaleKeys.zr_cp_record_zr_play07.tr;
        case '小':
          return LocaleKeys.zr_cp_record_zr_play08.tr;
        case '赢':
          return LocaleKeys.zr_cp_record_zr_play09.tr;
        // case '赢':
        //   //不执行
        //   return LocaleKeys.zr_cp_record_zr_play10.tr;
        case '老虎对':
          return LocaleKeys.zr_cp_record_zr_play11.tr;
        case '老虎和':
          return LocaleKeys.zr_cp_record_zr_play12.tr;
        case '龙虎和':
          return LocaleKeys.zr_cp_record_zr_play13.tr;
        case '龙':
          return LocaleKeys.zr_cp_record_zr_play14.tr;
        case '虎':
          return LocaleKeys.zr_cp_record_zr_play15.tr;
        case '天牌':
          return LocaleKeys.zr_cp_record_zr_play16.tr;
        case '庄天牌':
          return LocaleKeys.zr_cp_record_zr_play17.tr;
        case '闲天牌':
          return LocaleKeys.zr_cp_record_zr_play18.tr;
        case '小老虎':
          return LocaleKeys.zr_cp_record_zr_play19.tr;
        case '大老虎':
          return LocaleKeys.zr_cp_record_zr_play20.tr;
        case '熊猫8':
          return LocaleKeys.zr_cp_record_zr_play21.tr;
        case '龙7':
          return LocaleKeys.zr_cp_record_zr_play22.tr;
        case '超级对':
          return LocaleKeys.zr_cp_record_zr_play23.tr;
        case '任意对子':
          return LocaleKeys.zr_cp_record_zr_play24.tr;
        case '完美对子':
          return LocaleKeys.zr_cp_record_zr_play25.tr;
        case '庄龙宝':
          return LocaleKeys.zr_cp_record_zr_play26.tr;
        case '闲龙宝':
          return LocaleKeys.zr_cp_record_zr_play27.tr;
        case '庄免佣':
          return LocaleKeys.zr_cp_record_zr_play28.tr;
        case '幸运六':
          return LocaleKeys.zr_cp_record_zr_play29.tr;
        case '和局':
          return LocaleKeys.zr_cp_record_zr_play30.tr;
        case '例牌':
          return LocaleKeys.zr_cp_record_zr_play31.tr;
        case '免佣':
          return LocaleKeys.zr_cp_record_zr_play32.tr;
        // case '免佣':
        //   //不执行
        //   return LocaleKeys.zr_cp_record_zr_play33.tr;
        case '不免佣':
          return LocaleKeys.zr_cp_record_zr_play34.tr;
        // case '不免佣':
        //   //不执行
        //   return LocaleKeys.zr_cp_record_zr_play35.tr;
        case '庄平倍':
          return LocaleKeys.zr_cp_record_zr_play36.tr;
        case '闲1庄平倍':
          return LocaleKeys.zr_cp_record_zr_play37.tr;
        case '闲2庄平倍':
          return LocaleKeys.zr_cp_record_zr_play38.tr;
        case '闲3庄平倍':
          return LocaleKeys.zr_cp_record_zr_play39.tr;
        case '闲平倍':
          return LocaleKeys.zr_cp_record_zr_play40.tr;
        case '闲1闲平倍':
          return LocaleKeys.zr_cp_record_zr_play41.tr;
        case '闲2闲平倍':
          return LocaleKeys.zr_cp_record_zr_play42.tr;
        case '闲3闲平倍':
          return LocaleKeys.zr_cp_record_zr_play43.tr;
        case '庄翻倍':
          return LocaleKeys.zr_cp_record_zr_play44.tr;
        case '闲1庄翻倍':
          return LocaleKeys.zr_cp_record_zr_play45.tr;
        case '闲2庄翻倍':
          return LocaleKeys.zr_cp_record_zr_play46.tr;
        case '闲3庄翻倍':
          return LocaleKeys.zr_cp_record_zr_play47.tr;
        case '闲翻倍':
          return LocaleKeys.zr_cp_record_zr_play48.tr;
        case '闲1闲翻倍':
          return LocaleKeys.zr_cp_record_zr_play49.tr;
        case '闲2闲翻倍':
          return LocaleKeys.zr_cp_record_zr_play50.tr;
        case '闲3闲翻倍':
          return LocaleKeys.zr_cp_record_zr_play51.tr;
        case '我的投注':
          return LocaleKeys.zr_cp_record_zr_play52.tr;
        case '本局总投注':
          return LocaleKeys.zr_cp_record_zr_play53.tr;
        case '经典':
          return LocaleKeys.zr_cp_record_zr_play54.tr;
        case '龙宝':
          return LocaleKeys.zr_cp_record_zr_play56.tr;
        case '对子':
          return LocaleKeys.zr_cp_record_zr_play57.tr;
        case '超和':
          return LocaleKeys.zr_cp_record_zr_play58.tr;
        case '老虎':
          return LocaleKeys.zr_cp_record_zr_play60.tr;
        case '龙虎':
          return LocaleKeys.zr_cp_record_zr_play62.tr;
        case '大小':
          return LocaleKeys.zr_cp_record_zr_play63.tr;
        default:
          return betPointName;
      }
    }
  }
}
