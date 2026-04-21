import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/utils/sport.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../core/constant/project/module/betting/bet-odds-constant.dart';
import '../modules/home/logic/other_player_name_to_playid.dart';
import '../modules/match_detail/models/odds_button_enum.dart';
import '../services/models/res/match_entity.dart';

class OddsUtil {
  // 反波胆玩法增加'非'
  static String fei(MatchHpsHlOl ol, MatchHps? matchHps) {
    return (['367', '368', '369'].contains(matchHps?.hpid) &&
            (ol.ot != 'Other'))
        ? LocaleKeys.detail_non.tr
        : '';
  }

  static String olOtvName(MatchHpsHlOl ol) {
    String name = "";
    //  先注释
    // if ((ol.on.contains('+') || ol.on.contains('-'))) {
    //   return name += ol.ott + "%dbx" + ol.on;
    // }

    if (ObjectUtil.isNotEmpty(ol.otv)) {
      name += ol.otv;
    } else {
      name += ol.ott + ol.on;
    }
    return name;
  }

  static String olName(MatchHpsHlOl ol, MatchHps? matchHps, MatchEntity match) {
    String olName = '';

    int? hpt = matchHps?.hpt;
    // if (props.type == 'fill') {
    // olName = olOtvName
    // }else
    if ([0, 2, 5, 7, 12, 13, 14, 18].contains(hpt)) {
      olName = olOtvName(ol);
    } else {
      if (ObjectUtil.isNotEmpty(ol.on)) {
        olName = ol.on;
      } else {
        olName = ol.ott;
      }
    }

    if (hpt == 4) {
      int otd = ol.otd;
      // olName = ' $olName';
      if (otd == 0) {
        // olName = LocaleKeys.list_dogfall.tr + olName;
        olName = olName;
      } else if (otd == 1) {
        // olName = LocaleKeys.app_h5_handicap_tutorial_home_team.tr + olName;
        olName = olName;
      } else if (otd == 2) {
        // olName = LocaleKeys.app_h5_handicap_tutorial_away_team.tr + olName;
        olName = olName;
      }
    }

    /// 替换数据返回队伍名
    olName = olName
        .replaceAll(r"{$Competitor1}", match.mhn)
        .replaceAll(r"{$Competitor2}", match.man);

    return olName;
  }

  // 判断包含缅甸语
  static bool isBurmese(String input) {
    for (int i = 0; i < input.length; i++) {
      int codeUnit = input.codeUnitAt(i);
      if (codeUnit >= 0x1000 && codeUnit <= 0x109F) {
        return true; // 字符在缅甸语 Unicode 范围内
      }
    }
    return false; // 没有找到缅甸语字符
  }

  /// 详情逻辑 ： mhs: 0开 1封 2关 11锁
  ///           hs: 0开 1封 2关 11锁
  ///           os: 1开 2封 3隐藏不显示不占地方
  static OddsButtonState betState(int mhs, int hs, MatchHpsHlOl ol, String hsw,
      {String csid = ""}) {
    //开盘_mhs=0或者锁盘_mhs=11
    if (mhs == 0 || mhs == 11) {
      if (hs == 0 || hs == 11) {
        // os = 1 开盘
        if (ol.os == 1) {
          if (computeCurOddTypeOlItemStatusCheck(ol, hsw, csid: csid)) {
            return OddsButtonState.lock;
          } else {
            return OddsButtonState.open;
          }
        }
        // os = 2 封盘
        else if (ol.os == 2) {
          return OddsButtonState.lock;
        } else {
          return OddsButtonState.none;
        }
      }
      // hs=1封盘
      else if (hs == 1) {
        if (ol.os == 3) {
          return OddsButtonState.none;
        } else {
          return OddsButtonState.lock;
        }
      } else if (hs == 2) {
        // 盘口级别状态关盘要显示占位
        return OddsButtonState.none;
      } else {
        return OddsButtonState.none;
      }
    }
    //封盘_mhs=1
    else if (mhs == 1) {
      return OddsButtonState.lock;
    }
    // 关盘_mhs=2
    else if (mhs == 2) {
      return OddsButtonState.close;
    } else {
      return OddsButtonState.none;
    }
  }

  ///根据赔率数据对象ov和ov2判断是否封盘
  static bool computeCurOddTypeOlItemStatusCheck(MatchHpsHlOl ol, String hsw,
      {String csid = ""}) {
    bool res = true;

    String curOdd = TYUserController.to.curOdds;
    List<String> arr = hsw.split(',');
    // 虚拟体育只支持欧盘和香港盘
    if (['1001', '1002', '1004', '1007', '1008', '1009', '1010', '1011', '1012']
        .contains(csid)) {
      arr = ["1", "2"];
    }
    // 获取当前的盘口赔率
    BetOddsConstantModel? data =
        oddsConstant.firstWhereOrNull((e) => e.value == curOdd);
    String curOddsNum = data?.id ?? "";
    // 赔率ov
    int ov = ol.ov;
    switch (curOdd) {
      case 'US': // 美式盘: 美式赔率和印尼赔率一样，算法为 ： 印尼赔率*100
      case 'ID': // 印尼盘
      case 'MY': // 马来盘
      case 'GB': // 英式盘: 英国赔率和香港赔率逻辑一样，区别是展示为分数
        if (arr.contains(curOddsNum)) {
          String ov2 = ol.ov2 ?? "";
          res = ov2 == "" ? true : false;
        } else {
          // 不支持取欧赔判断
          res = ov < 101000;
        }
        break;
      case 'HK':
      case 'EU':
        res = ov < 101000;
        break;

      default:
        break;
    }

    return res;
  }

  static String getOddsName(
      MatchHpsHlOl ol, MatchHps? matchHps, MatchEntity match) {
    String name = "";
    String fei = OddsUtil.fei(ol, matchHps);
    if (fei.isNotEmpty) {
      name += "$fei ";
    }

    String olName = OddsUtil.olName(ol, matchHps, match);
    name += olName;
    return name;
  }

  static String oddsName({
    required MatchHpsHlOl ol,
    required MatchEntity match,
    required MatchHps hps,
    required MatchHpsHl hl,
    String? name,
    required String playId,
  }) {
    OddsButtonState state =
        OddsUtil.betState(match.mhs, hl.hs, ol, hps.hsw, csid: match.csid);
    if (ObjectUtil.isEmptyString(name)) {
      ///
      if (int.parse(match.csid) == SportData.sportCsid_1 &&
          (playId == playIdConfig.hps15Minutes) &&
          (ol.ot == "Over" || ol.ot == "Under")) {
        /// 15分钟玩法 1007
        if (!ObjectUtil.isEmptyString(ol.on)) {
          return ol.on;
        }
        return ol.onb;
      } else if ((playId == playIdConfig.hpsCompose) &&
          !ObjectUtil.isEmptyString(ol.onb)) {
        /// 特殊组合 1010
        return ol.onb + ol.on;
      } else if ((playId == playIdConfig.hpsBold) &&
          ol.ot.isNotEmpty &&
          (ObjectUtil.isNotEmpty(ol.ot) && ol.ot == "Other")) {
        /// 波胆显示 “其他” 单独处理
        return LocaleKeys.list_other.tr;
      } else if (!ObjectUtil.isEmptyString(ol.onb)) {
        return ol.onb;
      } else {
        if (!ObjectUtil.isEmptyString(ol.on)) {
          return ol.on;
        } else {
          /// 独赢的没有赔率名称 显示主队客队平局
          if (hps.chpid == '1' || playId == playIdConfig.hpsPunish) {
            if (ol.ot == '1') {
              return playId == playIdConfig.hpsPunish
                  ? LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_1.tr
                  : LocaleKeys.ouzhou_bet_col_bet_col_4_bet_col_1.tr;
            } else if (ol.ot == '2') {
              return playId == playIdConfig.hpsPunish
                  ? LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_2.tr
                  : LocaleKeys.ouzhou_bet_col_bet_col_4_bet_col_2.tr;
            } else {
              return LocaleKeys.ouzhou_bet_col_bet_col_1_bet_col_X.tr;
            }
          } else {
            return '';
          }
        }
      }
    } else {
      if (state == OddsButtonState.lock && playId == playIdConfig.hpsBold) {
        return "";
      } else {
        return name ?? "";
      }
    }
  }

  static List<String> splitOddsName(String str) {
    // 使用正则匹配最后一个 `-` 或 `+`
    RegExp regex = RegExp(r'([+-])(?!.*[+-])'); // 负向零宽断言，确保是最后一个
    Match? match = regex.firstMatch(str);
    if (match != null) {
      int splitIndex = match.start;
      String part1 =
      str.substring(0, splitIndex).trim(); // "VAT-CSGO-HARRISON-000002"
      String part2 = str.substring(splitIndex).trim(); // "-1.5"
      return [part1, part2];
    } else {
      return [str];
    }
  }
}
