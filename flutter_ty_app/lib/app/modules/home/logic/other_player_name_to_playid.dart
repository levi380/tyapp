class playIdConfig {
  /// 角球
  static const String hpsCorner = '1001';
  /// 加时赛
  static const String hpsOvertime = '1002';
  /// 罚牌
  static const String hpsPunish = '1003';
  /// 点球大战
  static const String hpsPenalty = '1004';
  /// 晋级赛
  static const String hpsPromotion = '1005';
  /// 冠军
  static const String hpsOutright = '1006';
  /// 5分钟玩法
  // hps5Minutes: 1009;
  // 15分钟玩法
  static const String hps15Minutes = '1007';

  /// 波胆
  static const String hpsBold = '1008';
  /// 特色组合
  static const String hpsCompose = '1010';
  ///加时角球
  static const String hpsTCorner = '1011';
  /// 加时罚牌
  static const String hpsTPunish = '1012';
  /// 加时波胆
  static const String hpsTBold = '1013';

  ///加时角球
  static const String hpsCornerOvertime = '1011';
  /// 加时罚牌
  static const String hpsPunishOvertime = '1012';
  /// 加时波胆
  static const String hpsBoldOvertime = '1013';

  static const String hpsSection1 = '2001'; // 第一节
  static const String hpsSection2 = '2002'; // 第2节
  static const String hpsFristHalf = '2005'; // 上半场
  static const String hpsSection3 = '2003'; // 第3节
  static const String hpsSection4 = '2004'; // 第4节
  static const String hpsSecondHalf = '2006'; // 下半场
  static const String hps6Minutes = '1014'; // 6分钟
  static const String hpsKempGuide = '99001'; // 冠军引导盘
  // 2001：第一节  2002：第二节 2003 第三节  2004 第四节  2005 上半场 2006 下半场
  // 创造玩法 后端landen确认，这个id不在操盘后台配置，接口就没有的，此处的id属于自定义id，不会使用。排序在最后
  static const String hpsBetBuilder = '9999914'; // 创造玩法
  /// 自选波胆
  static const List<String> customGallbladder = [
    '1100487',
    '1100488',
    '1100489'
  ];
  /// 冠军引导 临时改成1015
  static const String championGuide = '1015';
  /// 上半场
  static const String hpsFirstHalf = '2005';
}
