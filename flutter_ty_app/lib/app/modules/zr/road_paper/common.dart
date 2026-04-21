/// 真人类型参数
const zrContainerItemType = {
  /**现场 */
  'live': 'live',
  /**荷官 */
  'dealer': 'dealer',
  /**路纸 */
  'roadPaper': 'roadPaper',
  /**极简 */
  'minimalist': 'minimalist',
};

///路纸玩法类型信息 roadPaperTypeInfo
/// 	  1 长闲（连闲） -- lian_xian--pic_haolu_2
///    2 长庄（连庄）-- lian_zhuang--pic_haolu_1
///    3 大路单跳（连跳） -- lian_tiao--pic_haolu_5
///    4 长路转单跳 --chang_lu_zhuan_dan_tiao--pic_haolu_6
///    5 一庄两闲 -- yi_zhuang_liang_xian--pic_haolu_4
///    6 一闲两庄 -- yi_xian_liang_zhuang--pic_haolu_3
///    7 逢庄跳 -- feng_zhuang_tiao--pic_haolu_7
///    8 逢闲跳 -- feng_xian_tiao--pic_haolu_8
///    9 逢庄连 -- feng_zhuang_lian--pic_haolu_9
///    10 逢闲连 -- feng_xian_lian--pic_haolu_10
///    11 拍拍连(排排连) -- pai_pai_lian--pic_haolu_11

const ROAD_PAPER_TYPE_INFO = {
  1: 'pic_haolu_2',
  2: 'pic_haolu_1',
  3: 'pic_haolu_5',
  4: 'pic_haolu_6',
  5: 'pic_haolu_4',
  6: 'pic_haolu_3',
  7: 'pic_haolu_7',
  8: 'pic_haolu_8',
  9: 'pic_haolu_9',
  10: 'pic_haolu_10',
  11: 'pic_haolu_11',
};

/// 游戏类型信息
///   1、旗舰厅---8、新旗舰厅也显示为旗舰厅
///    // 3、亚太厅
///    4、欧洲厅
///    5、国际厅 -- 3、亚太厅 也显示为国际厅
///    6、主播厅---9、新主播厅也显示为主播厅
///    7、美洲厅
///    // 8、新旗舰厅
///    // 9、新主播厅

const GAME_TYPE_IMG_INFO = {
  1: 'road_qijian',
  4: 'road_ouzhou',
  5: 'road_guoji',
  6: 'road_zhubo',
  7: 'road_meizhou',
  10: 'road_hanguo',
  11: 'road_taiwan',
};

/// 庄闲和 的id和名称对应关系
const BOOT_TYPE_MAP = {
  3001: {'name': '庄', 'img': 'zhuang', 'type': 'zhuang'},
  3002: {'name': '闲', 'img': 'xian', 'type': 'xian'},
  3003: {'name': '和', 'img': 'he', 'type': 'he'},
  3004: {'name': '庄对', 'img': '', 'type': 'zhuangdui'},
  3005: {'name': '闲对', 'img': '', 'type': 'xiandui'}
  // 3012 : '超级六',
  // 3013 : '庄免佣',
};

/// 游戏状态 0- 准备中 1-洗牌中 2-下注中 3-开牌中 4-结算中 5-结算完成 6-维护中
const GAME_STATUS = {
  0: '准备中',
  1: '洗牌中',
  2: '下注中',
  3: '开牌中',
  4: '结算中',
  5: '结算完成',
  6: '维护中',
};

/// 百家乐路纸类型枚举
class RoadPaperType {
  static const int NONE = 0;
  static const int MAIN_ROAD = 1; //庄闲珠盘路
  static const int BIG_ROAD = 2; //大路
  static const int BIG_EYE_ROAD = 3; //大眼路
  static const int SMALL_ROAD = 4; //小路
  static const int SMALL_Q_ROAD = 5; //小强路
  static const int DRAG_BOUNS = 6; //龙宝珠盘路
  static const int WIN_POINT = 7; //点数珠盘路
  static const int BIG_PAIR_ROAD = 8; //大路带对路纸
  static const int BIG_PAIR_AND_SUPER_SIX_ROAD = 9; //大路带对带超级6路纸
  static const int BIG_SMALL = 10; //大小珠盘路
  static const int ZHISHA = 11;
}

/// 百家乐结果枚举
class BaccaratResult {
  static const EMPTY = -1; //空白点
  static const BANKER_WIN = 1; //庄赢
  static const PLAYER_WIN = 0; //闲赢
  static const TIE = 2; //和局
  static const BANKER_SIX = 3; //庄赢且为庄6点
  static const DRAGON_WIN = 4; //龙赢
  static const TIGER_WIN = 5; //虎赢
  static const PHENIX_WIN = 6; //鳳赢
}

/// 游戏类型
class GameType {
  static const HALL_VIDEO = -121099;

  /// 主播间返回
  static const Baccarat_GOOD_ROAD = 0;
  static const Baccarat_GOOD_ROAD_F = 4;
  static const HALL_ALL = 1;

  /// 比赛大厅
  static const MATCH_LOBBY = -121090;
  static const LIVE_LOBBY = -121091;

  /// 不是任何游戏类型
  static const NONE = -1;

  /// 经典百家乐
  static const BACCARAT = 2001;

  /// 极速百家乐
  static const BACCARAT_FAST = 2002;

  /// 竞咪百家乐
  static const BACCARAT_BID = 2003;

  /// 包桌百家乐
  static const BACCARAT_VIP = 2004;

  /// 共咪百家乐
  static const BACCARAT_REVEAL = 2005;

  /// 龙虎
  static const DRAGONTIGER = 2006;

  /// 轮盘
  static const ROULETTE = 2007;

  /// 骰宝
  static const SIC_BO = 2008;

  /// 牛牛
  static const BULL_FIGHT = 2009;

  /// 炸金花
  static const WIN_THREE_CARDS = 2010;

  /// 三公
  static const THREE_TRUMPS = 2011;

  /// 21点
  static const BLACKJACK = 2021;

  /// 多台
  static const MULTIPLAY = 2013;

  /// 高额百家乐 是竞咪
  static const BACCARAT_HIGH_STAKES = 2014;

  /// 斗牛
  static const DOU_NIU = 2015;

  /// 保险百家乐
  static const BACCARAT_INSURANCE = 2016;

  /// 区块链经典百家乐
  static const CRYPTO_CLASSIC_BACCARAT = 2017;

  /// 百家乐大赛
  static const BACCARAT_MATCH = 2018;

  /// 德州扑克
  static const TEXASPOKER = 2019;

  /// 番摊
  static const FAN_TAN = 2020;

  /// 色碟
  static const COLORDISC = 2022;

  /// 牌九
  static const PAIGOW = 2023;

  /// 安达巴哈
  static const ANDARBAHAR = 2025;

  /// 印度炸金花
  static const INDIA_THREECARDS = 2026;

  /// 劲舞百家乐
  static const BACCARAT_JINWU = 2027;

  /// 主播百家乐
  static const BACCARAT_ZHUBO = 2030;

  /// 六合彩
  static const MarkSix = 2029;

  /// OB滚球
  static const OBBALL = 2028;

  /// 3D游戏
  static const GAME_3D = 2031;

  /// 5D游戏
  static const GAME_5D = 2032;
  //赛车
  static const CAR = 2035;
}

///国旗的对应参数，通过这个来找图片
const IDictItemCountry = {
  'CN': {
    'label': '中国',
    'languageCode': '@country_00001',
    'value': 'CN',
    'src': 'flag_cn',
    'casinoSrc': "flag_cn1"
  },
  'TW': {
    'label': '中国',
    'languageCode': '@country_00002',
    'value': 'TW',
    'src': 'flag_tw',
    'casinoSrc': "flag_tw1"
  },
  'TC': {
    'label': '中国',
    'languageCode': '@country_00002',
    'value': 'TC',
    'src': 'flag_tw',
    'casinoSrc': "flag_tw1"
  },
  'PH': {
    'label': '菲律宾',
    'languageCode': '@country_00003',
    'value': 'PH',
    'src': 'flag_ph',
    'casinoSrc': "flag_ph1"
  },
  'UA': {
    'label': '乌克兰',
    'languageCode': '@country_00004',
    'value': 'UA',
    'src': 'flag_ua',
    'casinoSrc': "flag_ua1"
  },
  'GB': {
    'label': '英国',
    'languageCode': '@country_00005',
    'value': 'GB',
    'src': 'flag_gb',
    'casinoSrc': "flag_gb1"
  },
  'EN': {
    'label': '美国',
    'languageCode': '@country_00006',
    'value': 'US',
    'src': 'flag_us',
    'casinoSrc': "flag_us1"
  },
  'US': {
    'label': '美国',
    'languageCode': '@country_00006',
    'value': 'US',
    'src': 'flag_us',
    'casinoSrc': "flag_us1"
  },
  'MY': {
    'label': '马来西亚',
    'languageCode': '@country_00007',
    'value': 'MY',
    'src': 'flag_my',
    'casinoSrc': "flag_my1"
  },
  'SG': {
    'label': '新加坡',
    'languageCode': '@country_00008',
    'value': 'SG',
    'src': 'flag_sg',
    'casinoSrc': "flag_sg1"
  },
  'RU': {
    'label': '俄罗斯',
    'languageCode': '@country_00009',
    'value': 'RU',
    'src': 'flag_ru',
    'casinoSrc': "flag_ru1"
  },
  'VN': {
    'label': '越南',
    'languageCode': '@country_00010',
    'value': 'VN',
    'src': 'flag_vn',
    'casinoSrc': "flag_vn1"
  },
  'VI': {
    'label': '越南',
    'languageCode': '@country_00010',
    'value': 'VI',
    'src': 'flag_vn',
    'casinoSrc': "flag_vn1"
  },
  'JP': {
    'label': '日本',
    'languageCode': '@country_00011',
    'value': 'JP',
    'src': 'flag_riben',
    'casinoSrc': "flag_riben1"
  },
  'KR': {
    'label': '韩国',
    'languageCode': '@country_00012',
    'value': 'KR',
    'src': 'flag_korea',
    'casinoSrc': "flag_korea1"
  },
  'KS': {
    'label': '哈萨克斯坦',
    'languageCode': '@country_00013',
    'value': 'KS',
    'src': 'flag_hxkst',
    'casinoSrc': "flag_hxkst1"
  },
  'BY': {
    'label': '白俄罗斯',
    'languageCode': '@country_00014',
    'value': 'BY',
    'src': 'flag_by',
    'casinoSrc': "flag_by1"
  },
  'BRA': {
    'label': '巴西',
    'languageCode': '@country_00015',
    'value': 'BRA',
    'src': 'flag_baxi',
    'casinoSrc': "flag_baxi1"
  },
  'TH': {
    'label': '泰国',
    'languageCode': '@country_00016',
    'value': 'TH',
    'src': 'flag_taiguo',
    'casinoSrc': "flag_taiguo1"
  },
  'DE': {
    'label': '德国',
    'languageCode': '@country_00017',
    'value': 'DE',
    'src': 'flag_deguo',
    'casinoSrc': "flag_deguo1"
  },
  'AU': {
    'label': '澳大利亚',
    'languageCode': '@country_00018',
    'value': 'AU',
    'src': 'flag_aodaliya',
    'casinoSrc': "flag_aodaliya1"
  },
  'CA': {
    'label': '加拿大',
    'languageCode': '@country_00019',
    'value': 'CA',
    'src': 'flag_jianada',
    'casinoSrc': "flag_jianada1"
  },
  'KH': {
    'label': '柬埔寨',
    'languageCode': '@country_00020',
    'value': 'KH',
    'src': 'flag_jianpuzhai',
    'casinoSrc': "flag_jianpuzhai1"
  },
  'ES': {
    'label': '西班牙',
    'languageCode': '@country_00021',
    'value': 'ES',
    'src': 'flag_es',
    'casinoSrc': "flag_es1"
  },
  'PT': {
    'label': '葡萄牙',
    'languageCode': '@country_00022',
    'value': 'PT',
    'src': 'flag_pt',
    'casinoSrc': "flag_pt1"
  },
  'ID': {
    'label': '印度尼西亚',
    'languageCode': '@country_00023',
    'value': 'ID',
    'src': 'flag_id',
    'casinoSrc': "flag_id1"
  },
  'MX': {
    'label': '墨西哥',
    'languageCode': '@country_00024',
    'value': 'MX',
    'src': 'flag_mx',
    'casinoSrc': "flag_mx1"
  },
  'MM': {
    'label': '缅甸',
    'languageCode': '@country_00025',
    'value': 'MM',
    'src': 'flag_mm',
    'casinoSrc': "flag_mm1"
  },
  'LA': {
    'label': '老挝',
    'languageCode': '@country_00026',
    'value': 'LA',
    'src': 'flag_la',
    'casinoSrc': "flag_la2"
  },
  'BN': {
    'label': '文莱',
    'languageCode': '@country_00027',
    'value': 'BN',
    'src': 'flag_bn',
    'casinoSrc': "flag_bn1"
  },
  'IR': {
    'label': '伊朗',
    'languageCode': '@country_00028',
    'value': 'IR',
    'src': 'flag_yilang',
    'casinoSrc': "flag_yilang1"
  },
  'CO': {
    'label': '哥伦比亚',
    'languageCode': '@country_00029',
    'value': 'CO',
    'src': 'flag_co',
    'casinoSrc': "flag_co1"
  },
  'SI': {
    'label': '斯洛文尼亚',
    'value': 'SI',
    'languageCode': '@country_00030',
    'src': 'flag_si',
    'casinoSrc': "flag_si1"
  },
  'JO': {
    'label': '约旦',
    'value': 'JO',
    'languageCode': '@country_00031',
    'src': 'flag_jo',
    'casinoSrc': "flag_jo1"
  },
  'KG': {
    'label': '吉尔吉斯斯坦',
    'value': 'KG',
    'languageCode': '@country_00032',
    'src': 'flag_kg',
    'casinoSrc': "flag_kg1"
  },
  'AM': {
    'label': '亚美尼亚',
    'value': 'AM',
    'languageCode': '@country_00033',
    'src': 'flag_am',
    'casinoSrc': "flag_am1"
  },
  'GE': {
    'label': '格鲁吉亚',
    'value': 'GE',
    'languageCode': '@country_00034',
    'src': 'flag_gg',
    'casinoSrc': "flag_gg1"
  },
};
