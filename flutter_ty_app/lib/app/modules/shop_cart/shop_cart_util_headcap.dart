import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import 'package:flutter_ty_app/app/modules/shop_cart/model/shop_cart_item.dart';

import '../../../generated/locales.g.dart';
import '../../services/models/res/match_entity.dart';
import '../match_detail/models/odds_button_enum.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-a52f3c6a-30f4-45ab-9564-b71d050885e0-sz 】】】
      【【【 AUTO_DOCUMENT_MENU 投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 投注Controller 】】】
    【【【 AUTO_PARAGRAPH_TITLE 购物车工具类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 购物车辅助工具
    】】】
 *
 */
class ShopCartUtilHandicap{


  // 胜平负玩法
  static Map winDrawLose = {
  "1": ["3",'69','71','1100448','1100449','1100450','1100456','1100460'],
  '2': ["1",'17','44','50','56','62','273','275','277'],
  '4': ['3','261'],
  '6': ['44','50','56','62'],
  '7': ['1'],
  '14': ['3']
  };


  static String calcBifen(List<String> msc, int csid, int ms, int hpid) {
    // 只有足球滚球展示基准分
    if (msc.isEmpty || csid != 1 || ms == 0) return "";
    String? s;
    RegExp regExp;
    String mscString = msc.join(',');

    if (hpid == 128) {
      regExp = RegExp(r'S7\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 130) {
      regExp = RegExp(r'S701\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 143) {
      regExp = RegExp(r'S3\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if ([4, 27, 29, 269, 336].contains(hpid)) {
      regExp = RegExp(r'S1\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 19) {
      regExp = RegExp(r'S2\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 113) {
      regExp = RegExp(r'S5\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    } else if (hpid == 121) {
      regExp = RegExp(r'S15\|[0-9]+\:[0-9]+');
      s = regExp.stringMatch(mscString);
    }

    if (s != null) {
      String str = s.split("|")[1];
      return "(${str.replaceAll(":", "-")})";
    }

    return "";
  }

  static String teamsShow(ShopCartItem item){
    const cornerBall = ["111","114","115","116","117","118","119","122","123","124","226","227","228","229"];
    const penaltyHpid = ["307","309","310","311","312","313","314","315","316","317","318","319","320","321","322","323","125","230"];
    if (cornerBall.contains(item.playId) || penaltyHpid.contains(item.playId)) {
      return '${item.home} vs ${item.away}';
    }
    return '';
  }


  // 获取盘口值 附加值
  static List<String> getHandicap(MatchEntity match, MatchHps place,
      MatchHpsHl? market, MatchHpsHlOl odds, bool isDetail, OddsBetType betType,
      {bool secondaryPaly = false, bool repeat = false}) {
    // ## 详情页的取值，直接取 ol 层级的 `ott` + `on`,当遇到下面几种玩法时，直接取 `otv`,
    // 3-全场让球赛果  69-上半场让球赛果  71-下半场让球赛果
    // 220-球员得分 221-球员三分球 271-球员助攻 272-球员篮板
    // 171-独赢&总局数 13-独赢&进球大小 101-独赢&两队都进球  106-下半场独赢&下半场两队都进球 105-上半场独赢&上半场两队都进球 216-独赢&总分 102-进球大小&两队都进球
    // 107-双重机会&两队都进球
    // 339-拳击的独赢&准确回合数

    // ## 列表页的取值，分2个值相加，即 a+b 的形式，规则如下
    // 1. b取 最里层ol 的 `on`
    // 2. 当b的值里含有 `主胜` 或者 `客胜` 字样时，b 为空字符串
    // 3. 当 `ots` 值是 `T1` 时，a 取 `mhn`,当 `ots` 值是 `T2` 时，a 取 `man`,
    // 4. 当 玩法id 字段 `hpid` ,为 2 或者 173 或者 38 或者 114 时，a 为空字符串
    String text = '';
    String hv = '';
    // 展示用的 + 投注项
    const detailMark = [
      3,
      13,
      69,
      71,
      102,
      107,
      101,
      106,
      105,
      171,
      216,
      220,
      221,
      271,
      272,
      339
    ];
    const lsitMark = [2, 173, 38, 114];
    // 特殊玩法
    const listHead = [
      359,
      31,
      340,
      383,
      13,
      102,
      351,
      101,
      107,
      347,
      105,
      106,
      345,
      346,
      348,
      349,
      353,
      360,
      384
    ];
    // vr 前后2 玩法
    const vrHpid = [20034, 20035, 20036, 20037, 20038];

    List<String> teams = match.teams;
    if (secondaryPaly) {
      //TODO
      if (["Under", 'Over'].contains(odds.ot)) {
        final onArray = odds.on.split(' ');
        text = onArray.safeFirst ?? '';
        hv = onArray.length > 1 ? onArray[1] : '';
      } else if (odds.ot == "Other") {
        // 波胆 玩法 其他
        text = LocaleKeys.list_other.tr;
        hv = '';
      } else if ([111, 119, 126, 129, 135, 136, 310, 311, 333]
          .contains(int.tryParse(place.hpid))) {
        // 独赢 罚牌玩法 / 加时赛 / 冠军
        if (odds.ots == 'T1') {
          text = match.mhn;
        }
        if (odds.ots == 'T2') {
          text = match.man;
        }
        if (odds.ots == '') {
          text = odds.onb;
        }
      } else if ([33, 113, 121, 128, 130, 306, 308, 334]
          .contains(int.tryParse(place.hpid))) {
        // 让球
        if (odds.ots == 'T1') {
          text = match.mhn;
        }
        if (odds.ots == 'T2') {
          text = match.man;
        }
        hv = odds.on;
      } else if (odds.ot.contains("And")) {
        // 特色玩法 拼接
        if (odds.ots == 'T1') {
          text = match.mhn;
        }
        if (odds.ots == 'T2') {
          text = match.man;
        }
        // 平局
        if (odds.ots == '') {
          text = odds.onb;
          hv = odds.on;
        } else {
          List textOnb = odds.onb.split('&');
          text = text + (textOnb.length > 1 ? " & " + textOnb[1] : '');
          hv = odds.on;
        }
      } else {
        text = odds.on;
        hv = '';
      }

      if (text.isEmpty && !repeat) {
        //因为详情页面更新了数据仓库，导致取不倒数据，重新再取一遍详情逻辑
        if(secondaryPaly){
          //次要玩法
          return getHandicap(match, place, market, odds, isDetail, betType,
              secondaryPaly: false, repeat: true);
        }else {
          return getHandicap(
              match, place, market, odds, true,
              betType,
              secondaryPaly: false, repeat: true);
        }
      }
    } else {
      // vr 体育的 赛狗 赛马 泥地摩托  摩托
      if (betType == OddsBetType.vr &&
          ['1002', '1011', '1009', '1010'].contains(match.csid)) {
        if (vrHpid.contains(int.tryParse(place.hpid))) {
          List hvArray = odds.ot.split('/');
          List<Map<String, dynamic>> textArray = hvArray.map((item) {
            int index = (int.tryParse(item) ?? 0) - 1;
            return {
              'text': 0 <= index && index < teams.length ? teams[index] : '',
              'hv': item,
            };
          }).toList();
          //Vue里是数组，暂时以,代替
          text = textArray.map((e) => e['text']).join(',');
          hv = textArray.map((e) => e['hv']).join(',');
        } else if (20033 == int.tryParse(place.hpid)) {
          int index = (int.tryParse(odds.ot) ?? 0) - 1;
          List<Map<String, dynamic>> textArray = [
            {
              'text': 0 <= index && index < teams.length ? teams[index] : '',
              'hv': odds.ot,
            }
          ];
          //Vue里是数组，暂时以,代替
          text = textArray.map((e) => e['text']).join(',');
          hv = textArray.map((e) => e['hv']).join(',');
        } else {
          text = odds.otv;
        }
      } else {
        // 详情
        if (isDetail) {
          // 有球头 球头需要变色
          if (market?.hv != null && market!.hv!.isNotEmpty) {
            text = odds.ott;
            hv = odds.on;
            if(387 == int.tryParse(place.hpid)){
              //角球大小盘三项
              hv = market.hv!;
            }
          } else {
            text = odds.ott + odds.on;
            hv = '';
          }
          if (detailMark.contains(int.tryParse(place.hpid)) && odds.ot == 'X') {
            text = odds.otv;
            hv = '';
          }
          // 特殊玩法
          if (listHead.contains(int.tryParse(place.hpid))) {
            text = odds.otv;
            hv = '';
          }

          // 组合玩法
          if (odds.ot.contains('And')) {
            text = odds.otv;
            hv = '';
          }

          if(winDrawLose[match.csid]?.contains(place.hpid)==true){
            text = odds.otv.replaceAll(odds.on, '');
          }

          if (text.isEmpty && !repeat) {
            //因为列表页面更新了数据仓库，导致取不倒数据，重新再取一遍列表逻辑
            return getHandicap(match, place, market, odds, false, betType,
                secondaryPaly: secondaryPaly, repeat: true);
          }
        } else {
          String a = '';
          String b = odds.on;
          if (betType == OddsBetType.vr) {
            if (odds.ots == 'T1') {
              a = teams.length > 0 ? teams[0] : '';
            }
            if (odds.ots == 'T2') {
              a = teams.length > 1 ? teams[1] : '';
            }
          } else {
            if (odds.ots == 'T1') {
              a = match.mhn;
            }
            if (odds.ots == 'T2') {
              a = match.man;
            }
          }

          // 加入是否有球头判断
          if (['T1', 'T2'].contains(odds.ots) &&
              (market?.hv?.isEmpty ?? true)) {
            b = '';
          }

          if (lsitMark.contains(int.tryParse(place.hpid))) {
            a = '';
          }

          // 首页大小类玩法
          if (['Over', "Under"].contains(odds.ot)) {
            // h5数据格式和pc不一样
            List onArray = odds.on.split(' ');
            a = onArray.length > 1 ? onArray[0] : '';
            b = onArray.safeLast ?? '';
          }

          // 平 不变色
          if (odds.ot == 'X') {
            text = b;
          } else {
            text = a;
            hv = b;
          }

          if (text.isEmpty && !repeat) {
            //因为详情页面更新了数据仓库，导致取不倒数据，重新再取一遍详情逻辑
            return getHandicap(match, place, market, odds, true, betType,
                secondaryPaly: secondaryPaly, repeat: true);
          }
        }
      }
    }

    return [text, hv];
  }

  static bool isVrRankHandicap(String sportId,String playId){
    return ['1002', '1011', '1009', '1010'].contains(sportId)
        && [20033,20034, 20035, 20036, 20037, 20038].contains(int.tryParse(playId));
  }
}