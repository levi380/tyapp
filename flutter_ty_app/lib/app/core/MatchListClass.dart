import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

import '../../generated/locales.g.dart';
import '../modules/login/login_head_import.dart';
import '../utils/format_money_util.dart';
import '../utils/sport.dart';

/// 为赛事列表(专业版和新手版)提供逻辑方法，拆分组件复杂度
/// 对应vue 路径 core/match-list-h5/match-class/match-list.js
class MatchListClass {
  /// mmp映射赛事阶段名，国际化语言
  static String matchPeriodMap(MatchEntity match, {bool hasReplace = false}) {
    int mmp = int.tryParse(match.mmp) ?? 0;
    int csid = int.tryParse(match.csid) ?? 0;
    int ms = match.ms;


    String mmpMapTitle = '';
    if (ms == 110) {
      // ms == 110: 代表 即将开赛
      return LocaleKeys.ms_110.tr;
    }

    if (mmp == 0 && ms == 1) {
      // 篮球
      if (csid == 2) {
        mmp = 13;
      }
      // 棒球
      else if (csid == 3) {
        mmp = 401;
      }
      // 美式足球6 水球16
      else if ([6, 16].contains(csid)) {
        mmp = 13;
      }
    }

    ///锚点 网球、乒乓球 赛事阶段处理
    if ([5, 8].contains(csid)) {
      return convertTennisPingPongMmp(match);
    }

    // 斯诺克7局显示处理
    if (csid == 7) {
      return covertMct(match);
    }
    // TODO: mmp_${csid}_$mmp

    String r = "";
    String key = "mmp_${csid}_$mmp";
    r = key.tr;

    // 国际化有找到该key 证明转化成功
    if (r != key) {
      mmpMapTitle = r;
      // 如果是篮球的  小节玩法，则转成 上半场
      if ([14, 301].contains(mmp) && hasReplace && csid == 2) {
        mmpMapTitle = "mmp_${csid}_1".tr;
      }
      if ([9, 301].contains(mmp) && csid == 37){
        mmpMapTitle = "mmp_${csid}_9".tr;
      }
    }

    // 篮球3X3滚球时显示"全场"
    if (ms == 1 && csid == 2 && match.mle == 73) {
      mmpMapTitle = LocaleKeys.mmp_2_21.tr;
    }
    // AppLogger.debug("key:${key}   ||  csid:${csid}  ||  mmp:${mmp}");

    return mmpMapTitle;
  }

  /// 网球、乒乓球 mmp 转换 map
  static const Map<String, Map<String, String>> CONST_MMP_30X_SHOW_FIX_MAP = {
    '5': {
      '301': '8',
      '302': '9',
      '303': '10',
      '304': '11',
    },
    '8': {
      '301': '8',
      '302': '9',
      '303': '10',
      '304': '11',
      '305': '12',
      '306': '441',
      '307': '442',
    }
  };

  /// 网球、乒乓球 赛事阶段处理
  static String convertTennisPingPongMmp(MatchEntity match) {
    int mmp = int.tryParse(match.mmp) ?? 0;
    int csid = int.tryParse(match.csid) ?? 0;
    int mft = match.mft;

    /// 1. 完赛逻辑判断
    /// 下发 mmp 为 100 / 999 触发完赛
    if (mmp == 100 || mmp == 999) {
      // 完赛
      return "mmp_${csid}_100".tr;
    }

    /// 计算逻辑: 下发的 303 - 300 == mft 时 触发转化逻辑
    /// 一定要做判断 下发的必须是 300-310 之间的数
    if (mmp >= 300 && mmp <= 310) {
      if (mmp - 300 == mft) {
        // 使用 map 进行转换
        String? mapped =
            CONST_MMP_30X_SHOW_FIX_MAP[match.csid]?[mmp.toString()];
        if (mapped != null) {
          return "mmp_${csid}_$mapped".tr;
        }
      }
    }

    /// 2. 普通状态映射
    String key = "mmp_${csid}_$mmp";
    String r = key.tr;
    if (r != key) {
      return r;
    }

    return "";
  }

  /// 斯诺克mmp转mct值,所需的转换对象
  static Map<String, String> snookerMmpToMctMap = {
    "8": "1", // 第一局开始
    "301": "1", // 第一局结束
    "9": "2", // 第二局开始
    "302": "2", // 第二局结束
    "10": "3", // 第三局开始
    "303": "3", // 第三局结束
    "11": "4", // 第四局开始
    "304": "4", // 第四局结束
    "12": "5", // 第五局开始
    "305": "5", // 第五局结束
    "441": "6", // 第六局开始
    "306": "6", // 第六局结束
    "442": "7", // 第七局开始
    "307": "7", // 第七局结束
    "500": "8", // 第八局开始
    "308": "8", // 第八局结束
    "501": "9", // 第九局开始
    "309": "9", // 第九局结束
    "502": "10", // 第十局开始
    "310": "10", // 第十局结束
    "503": "11", // 第十一局开始
    "311": "11", // 第十一局结束
    "504": "12", // 第十二局开始
    "312": "12", // 第十二局结束
    "505": "13", // 第十三局开始
    "313": "13", // 第十三局结束
    "506": "14", // 第十四局开始
    "314": "14", // 第十四局结束
    "507": "15", // 第十五局开始
    "315": "15", // 第十五局结束
    "508": "16", // 第十六局开始
    "316": "16", // 第十六局结束
    "509": "17", // 第十七局开始
    "317": "17", // 第十七局结束
    "510": "18", // 第十八局开始
    "318": "18", // 第十八局结束
    "511": "19", // 第十九局开始
    "319": "19", // 第十九局结束
    "512": "20", // 第二十局开始
    "320": "20", // 第二十局结束
    "513": "21", // 第二十一局开始
    "321": "21", // 第二十一局结束
    "514": "22", // 第二十二局开始
    "322": "22", // 第二十二局结束
    "515": "23", // 第二十三局开始
    "323": "23", // 第二十三局结束
    "516": "24", // 第二十四局开始
    "324": "24", // 第二十四局结束
    "517": "25", // 第二十五局开始
    "325": "25", // 第二十五局结束
    "518": "26", // 第二十六局开始
    "326": "26", // 第二十六局结束
    "519": "27", // 第二十七局开始
    "327": "27", // 第二十七局结束
    "520": "28", // 第二十八局开始
    "328": "28", // 第二十八局结束
    "521": "29", // 第二十九局开始
    "329": "29", // 第二十九局结束
    "522": "30", // 第三十局开始
    "330": "30", // 第三十局结束
    "523": "31", // 第三十一局开始
    "331": "31", // 第三十一局结束
    "524": "32", // 第三十二局开始
    "332": "32", // 第三十二局结束
    "525": "33", // 第三十三局开始
    "333": "33", // 第三十三局结束
    "526": "34", // 第三十四局开始
    "334": "34", // 第三十四局结束
    "527": "35", // 第三十五局开始
    "335": "35", // 第三十五局结束
  };

  ///斯诺克 局数处理
  /// @description:斯诺克csid:7  局显示处理
  /// @param {Object} {mct局数 mmp赛事阶段 ms赛事状态}
  /// @return {String}
  static String covertMct(MatchEntity match) {
    int ms = match.ms;
    int mmp = int.tryParse(match.mmp) ?? 0;
    int mct = match.mct;

    ///  通过 mmp 映射 mct（斯诺克专用）
    final mappedMct = snookerMmpToMctMap[match.mmp];
    if (mappedMct != null) {
      mct = int.tryParse(mappedMct) ?? mct;
    }

    ///兜底 赛事状态为 比赛中  但 mmp=0
    if (isMatchPlaying(ms) && mmp == 0) {
      mct = 1;
    }

    String result = '';
    String newNum = mct.toString();
    // 中文特殊处理
    if (['zh', 'hk'].contains(Get.locale?.languageCode)) {
      newNum = FormatMoney.numberToChinese(mct);
    }
    String gameCount = LocaleKeys.mmp_7_x.tr;
    Map ext = {
      419: LocaleKeys.mmp_7_419.tr,
      420: LocaleKeys.mmp_7_420.tr,
      439: LocaleKeys.mmp_7_439.tr,
    };
    if (mmp == 445) {
      result = LocaleKeys.mmp_7_445.tr;
    } else {
      String gameCountDes = gameCount.replaceAll('%s', newNum);
      String gameCountDes2 = "";
      if (ext.containsKey(mmp)) {
        gameCountDes2 = ext[mmp];
      }
      result = gameCountDes + gameCountDes2;
    }
    return result;
  }

  /// @description: 赛事进行中
  /// 0未开始 1滚球阶段 2暂停 7延迟 10比赛中断 110即将开赛 3结束 4关闭 5取消 6比赛放弃 8未知 9延期
  static bool isMatchPlaying(int ms) {
    return [1, 2, 7, 10, 110].contains(ms);
  }

  /// @description: 赛事异常不显示进球
  /// 0未开始 1滚球阶段 2暂停 7延迟 10比赛中断 110即将开赛 3结束 4关闭 5取消 6比赛放弃 8未知 9延期
  static bool isMatchPlayingShowGoal(int ms) {
    return [   110,9,31,32,33,34,100,120,999].contains(ms);
  }


  /// @description 虚拟赛事换算走表步长
  /// @param match 赛事信息
  /// @param step 原来的步长
  /// @return 换算后的步长
  static double matchVrStep(MatchEntity? match, double step) {
    double res = step;
    if (match == null) {
      return res;
    }
    ///match.cds == '1500' 这类赛事判断已移除
    // 赛事显示倒计时优化(使用每场比赛90分钟进行换算)
    // if (match.cds == '1500' && match.csid == "1") {
    //   switch (match.mle.toString()) {
    //     case '57': // 2 * 4分钟 加中场休息时间4分钟=>按照720秒换算
    //       res = 7.5;
    //       break;
    //     case '66': // 2 * 5分钟  加中场休息时间4分钟=>按照840秒换算
    //       res = 6.428571;
    //       break;
    //     case '55': // 2 * 6分钟 (10.5s累加1分钟)
    //       res = 5.7142;
    //       break;
    //     default:
    //       break;
    //   }
    // } else

      if (match.ctt == 1 && [SportData.sportCsid_1, SportData.sportCsid_2].contains(match.csid)) {
      // 是机器开出的虚拟赛事时,使用atf时间系数换算时间
      // ctt (0 人 1机器)   atf (时间系数)
      res = double.parse(match.atf) * step;
    }
    return res;
  }


}
