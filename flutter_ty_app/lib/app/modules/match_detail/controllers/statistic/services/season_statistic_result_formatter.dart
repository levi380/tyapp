
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/theme_extension.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';


import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/// 本赛季统计结果格式化器
/// 负责处理各种结果字符串的格式化和颜色获取
class SeasonStatisticResultFormatter {
  /// 获取比赛结果字符串（根据比赛类型）
  /// [type] 结果类型：2-平，3-负，4-胜
  /// [tag] 比赛ID，用于判断比赛类型
  /// 返回对应的结果字符串
  static String getWinResultStr(num? type, String tag) {
    MatchEntity? match = DataStoreController.to.getMatchById(tag);
    if (match?.csid == "2") {
      // 篮球
      if (type == 2) {
        return LocaleKeys.analysis_football_matches_flat.tr;
      } else if (type == 3) {
        return LocaleKeys.analysis_football_matches_negative.tr;
      } else if (type == 4) {
        return LocaleKeys.analysis_football_matches_victory.tr;
      }
    } else {
      // 足球
      if (type == 2) {
        return LocaleKeys.analysis_football_matches_flat.tr;
      } else if (type == 3) {
        return LocaleKeys.analysis_football_matches_negative.tr;
      } else if (type == 4) {
        return LocaleKeys.analysis_football_matches_win.tr;
      }
    }
    return "-";
  }

  /// 获取比赛结果字符串（格式1）
  /// [type] 结果类型：2-平，3-负，4-胜
  /// 返回对应的结果字符串
  static String getWinResultStr1(num? type) {
    if (type == 2) {
      return LocaleKeys.analysis_football_matches_level.tr;
    } else if (type == 3) {
      return LocaleKeys.analysis_football_matches_lose.tr;
    } else if (type == 4) {
      return LocaleKeys.analysis_football_matches_win.tr;
    }
    return LocaleKeys.ouzhou_no_data_no_data.tr;
  }

  /// 获取大小球结果字符串
  /// [type] 结果类型：3-小，4-大
  /// 返回对应的结果字符串
  static String getWinResultStr2(num? type) {
    if (type == 3) {
      return LocaleKeys.analysis_football_matches_small.tr;
    } else if (type == 4) {
      return LocaleKeys.analysis_football_matches_big.tr;
    }
    return "-";
  }

  /// 获取比赛结果字符串（格式3）
  /// [type] 结果类型：2-平，3-负，4-胜
  /// 返回对应的结果字符串
  static String getWinResultStr3(num? type) {
    if (type == 4) {
      return LocaleKeys.bet_record_bet_win.tr;
    } else if (type == 3) {
      return LocaleKeys.analysis_football_matches_lose.tr;
    } else if (type == 2) {
      return LocaleKeys.analysis_football_matches_level.tr;
    }
    return LocaleKeys.ouzhou_no_data_no_data.tr;
  }

  /// 获取结果文本颜色
  /// [type] 结果类型字符串
  /// 返回对应的颜色
  static Color getWinResultTextColor(String type) {
    Map<String, Color> map = {
      LocaleKeys.analysis_football_matches_flat.tr: Get.theme.equalResultColor,
      LocaleKeys.analysis_football_matches_negative.tr:
          Get.theme.winResultColor,
      LocaleKeys.analysis_football_matches_victory.tr:
          Get.theme.loseResultColor,
      LocaleKeys.analysis_football_matches_lose.tr: Get.theme.winResultColor,
      LocaleKeys.analysis_football_matches_win.tr: Get.theme.loseResultColor,
      LocaleKeys.analysis_football_matches_big.tr: Get.theme.loseResultColor,
      LocaleKeys.analysis_football_matches_small.tr: Get.theme.winResultColor,
      LocaleKeys.analysis_football_matches_level.tr: Get.theme.equalResultColor,
    };
    return map[type] ?? Colors.grey;
  }

  /// 胜平负、大小走水格式化
  /// [type] 类型：'cls'、'resultLabel'、'resultwinlose'、'overunderLabel'
  /// [value] 值：2-平/走水，3-负/小，4-胜/大
  /// 返回格式化后的字符串
  static String resultFilter(String type, int value) {
    if (type == 'cls') {
      switch (value) {
        case 2:
          return LocaleKeys.analysis_flat.tr;
        case 3:
          return LocaleKeys.analysis_lose.tr;
        case 4:
          return LocaleKeys.analysis_big.tr;
        default:
          return 'default';
      }
    } else if (type == 'resultLabel') {
      switch (value) {
        case 2:
          return LocaleKeys.analysis_level.tr;
        case 3:
          return LocaleKeys.analysis_lose.tr;
        case 4:
          return LocaleKeys.analysis_win.tr;
      }
    } else if (type == 'resultwinlose') {
      switch (value) {
        case 2:
          return LocaleKeys.analysis_football_matches_flat.tr;
        case 3:
          return LocaleKeys.analysis_football_matches_negative.tr;
        case 4:
          return LocaleKeys.analysis_victory.tr;
        default:
          return "-";
      }
    } else if (type == 'overunderLabel') {
      switch (value) {
        case 2:
          return LocaleKeys.analysis_level.tr;
        case 3:
          return LocaleKeys.zr_cp_record_zr_play08.tr;
        case 4:
          return LocaleKeys.zr_cp_record_zr_play07.tr;
        default:
          return "-";
      }
    }
    return "-";
  }
}
