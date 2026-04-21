
///路纸图的映射值，通过这个来找对应的图片
class RoadPaperCharacterMapping {

  static const baccaratAskRoad = ["装", "闲"];

  static const baccaratDWAskRoad = ["庄", "闲"];

  static const dragonTigerAskRoad = ["龙", "虎"];

  static const winThreeCardsAskRoad = ["风", "弄"];


  static const mainRoadBankerWin = ["装", "妆", "撞", "庄"];
  static const mainRoadPlayerWin = ["闲", "现", "县", "线"];
  static const mainRoadBankerSix = ["壮", "狀", "戆", "僮"];
  static const mainRoadTie = ["合", "河", "荷", "和"];
  static const mainRoadOtherList = ["龙", "虎", "弄", "虎", "风"];


  static const dragonRoadBankerWinList = ["龙", "隆", "拢", "珑", "庄", "装", "撞", "状"];
  static const dragonRoadBankerSixList = ["流", "六", "留", "扭"];
  static const dragonRoadPlayerWinList = ["聋", "农", "浓", "侬", "闲", "先", "嫌", "线"];
  static const dragonRoadPlayerTieList = ["合", "喝", "荷", "何"];


  static const winPointRoadBankerWinList = ["鳞亿而闪式物流器把酒食益铒馓", "磷以尔山师吴六气爸久", "邻意儿删试午留起吧就", "凛翼饵伞四屋扭琪捌纠"];

  static const winPointRoadPlayerWinList = ["麟一贰善思舞溜期罢救湿易洱霰", "霖亦耳扇寺五柳骑巴旧", "淋伊二擅诗吾刘其八九", "令咦鲕三斯武硫妻霸玖"];

  static const winPointRoadTieList = ["琳依鸸杉室误妞弃芭鸠尸艺尓毵", "林宜洏散是乌牛棋扒韭", "临义佴潵石无瘤启拔揪", "零衣迩衫使伍纽鳍疤究"];

  static const bigSmallRoadBigList = ["大", "打", "搭", "答"];
  static const bigSmallRoadSmallList = ["小", "笑", "萧", "肖"];

  /// 百家乐直杀 0没直杀 1直杀
  static const zhisha = ["百", "杀"];

  /// 百家乐大路庄赢
  static const bigRoadBankerWin = [
  ["骝", "锈", "绣", "秀"],
  ["留", "裤", "窟", "齁"],
  ["刘", "库", "鎏", "琉"],
  ["流", "旒", "继", "疁"],
  ["柳", "果", "裹", "过"],
  ["溜", "节", "界", "接"],
  ["瘤", "母", "体", "木"],
  ["硫", "围", "喂", "未"],
  ["陆", "茨", "慈", "次"],
  ["遛", "紫", "兹", "自"],
  ["馏", "哒", "嗒", "大"],
  ["瑠", "血", "邪", "写"],
  ["绺", "客", "渴", "刻"],
  ["锍", "葛", "格", "革"],
  ["镏", "即", "级", "基"],
  ["旈", "活", "奤", "祸"]
  ];

  /// 百家乐大路庄6点赢
  static const bigRoadBankerSixWin = [
  ["鲅", "蔻", "硁", "徎"],
  ["蕖", "刳", "鸲", "秸"],
  ["钚", "湫", "莒", "圪"],
  ["桀", "莙", "洸", "窖"],
  ["钯", "猓", "硌", "趏"],
  ["俐", "嗟", "墂", "桦"],
  ["揆", "焜", "赦", "钰"],
  ["炯", "泂", "迦", "桧"],
  ["鳍", "只", "姬", "指"],
  ["焗", "蛰", "瑰", "噷"],
  ["狃", "舵", "陀", "怼"],
  ["伽", "沫", "溴", "敷"],
  ["绯", "窠", "鲲", "远"],
  ["稗", "峻", "氪", "迁"],
  ["钧", "剀", "噱", "倩"],
  ["铂", "骅", "劼", "苑"]
  ];



  static const bigRoadPlayerWin = [
  ["或", "羞", "休", "修"],
  ["先", "县", "线", "仙"],
  ["含", "酷", "哭", "焊"],
  ["寒", "翰", "撼", "涵"],
  ["韩", "国", "郭", "锅"],
  ["汉", "借", "阶", "截"],
  ["真", "姆", "提", "目"],
  ["帧", "位", "维", "为"],
  ["还", "词", "刺", "此"],
  ["海", "子", "仔", "字"],
  ["害", "答", "搭", "达"],
  ["嗨", "谢", "鞋", "些"],
  ["咳", "珂", "课", "壳"],
  ["耗", "阁", "戈", "镉"],
  ["亥", "机", "集", "鸡"],
  ["伤", "货", "蝦", "霍"]
  ];

  static const bigRoadTie = [
  ["一", "亦", "已", "以"],
  ["二", "而", "儿", "尔"],
  ["三", "潵", "帴", "糁"],
  ["四", "蝈", "帼", "椁"],
  ["五", "皆", "介", "杰"],
  ["六", "替", "题", "踢"],
  ["七", "威", "韦", "魏"],
  ["八", "玼", "赐", "辞"],
  ["九", "姿", "梓", "资"],
  ["十", "笪", "怛", "妲"],
  ["幺", "蟹", "协", "斜"],
  ["哈", "可", "克", "科"],
  ["黑", "个", "哥", "歌"],
  ["红", "及", "急", "己"],
  ["打", "蛤", "铪", "虾"]
  ];

  static const emptyList = ["摆", "百"];

  static const emptyListBlack = ["赫", "鹤"];

  static  getBacaratRoadPaperEmpty(index) {
    return RoadPaperCharacterMapping.emptyList[index];
  }


  static const bigEyeRoadList = ["喝", "话"];

  static const smallRoadList = ["活", "厚"];

  static const smallQRoadList = ["酒", "回"];


  static const fullFightProRedList = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "牛", "公"];
  static const fullFightProBlueList = ["宁", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "扒", "玖", "妞", "工"];
  static const fullFightProGrayList = ["领", "以", "而", "山", "事", "吴", "流", "器", "把", "酒", "扭", "宫"];

  static const fullFightEtrRedList = ["您", "意", "洏", "潵", "斯", "武", "硫", "期", "巴", "鸠", "纽", "功"];
  static const fullFightEtrBlueList = ["凝", "亦", "鸸", "闪", "时", "舞", "拗", "起", "爸", "究", "留", "供"];
  static const fullFightEtrGrayList = ["令", "翼", "佴", "杉", "试", "午", "钮", "骑", "罢", "韭", "斿", "攻"];

  /// 获取牛牛结果
  static getBullFightResult(isBanker, result, isWin) {
    if (isWin) {
      if (isBanker) {
        return fullFightProRedList[result];
      } else {
        return fullFightProBlueList[result];
      }
    } else {
      return fullFightProGrayList[result];
    }
  }

  static const paiGowRedList = ["服", "副", "付", "负", "福", "府", "富", "赴", "扶", "傅", "牛", "公", "您", "意", "洏", "潵", "斯", "武", "硫", "期", "巴", "鸠", "纽", "功", "先", "县", "线", "仙", "喝", "话", "汉", "借"];
  static const paiGowBlueList = ["凝", "异", "鸸", "陕", "使", "物", "斿", "弃", "疤", "舅", "妞", "工", "宁", "亦", "阄", "闪", "时", "舞", "拗", "起", "爸", "究", "留", "供", "含", "酷", "哭", "焊", "韩", "国", "阶", "截"];
  static const paiGowGrayList = ["佞", "伊", "儿", "擅", "似", "乌", "瘤", "妻", "叭", "柩", "扭", "宫", "令", "翼", "佴", "杉", "试", "午", "钮", "骑", "罢", "韭", "旒", "攻", "寒", "翰", "撼", "涵", "郭", "锅", "真", "姆"];


  /// 获取牌九结果
  static  getPaiGowResult(isBanker, result, isWin) {
    if (isWin) {
      if (isBanker) {
        return paiGowRedList[result];
      } else {
        return paiGowBlueList[result];
      }
    } else {
      return paiGowGrayList[result];
    }
  }


  static const zeroTrumpList = [["凝", "异", "鸸", "陕", "使", "物", "斿", "弃", "疤", "舅"], ["佞", "伊", "儿", "擅", "似", "乌", "瘤", "妻", "叭", "柩"], ["柠", "乙", "洱", "扇", "氏", "雾", "遛", "齐", "坝", "臼"],
  ["服", "副", "付", "负", "福", "府", "富", "赴", "扶", "傅"]];

  static const oneTrumpList = [["领", "亦", "二", "三", "四", "无", "硫", "起", "把", "就"], ["零", "意", "而", "潵", "死", "五", "留", "期", "吧", "鸠"], ["令", "一", "佴", "伞", "斯", "午", "流", "气", "爸", "酒"],
  ["红", "宏", "哄", "洪", "鸿", "虹", "弘", "轰", "泓", "烘"]];

  static const twoTrumpList = [["林", "亿", "洏", "闪", "是", "屋", "牛", "琪", "八", "韭"], ["凛", "衣", "鲕", "山", "试", "伍", "妞", "其", "捌", "究"], ["淋", "宜", "饵", "杉", "时", "吾", "纽", "启", "芭", "揪"],
  ["双", "爽", "霜", "孀", "泷", "雙", "滝", "孇", "艭", "礵"]];

  static const threeTrumpList = ["公", "共", "攻", "几"];

  static const threeTrumpsBPList = ["庄", "闲"];


  /*===========================骰宝 start================================*/
  /// 骰宝骰子点数1-6
  static const sicboDicedPointList = ["", "一", "二", "三", "四", "五", "六"];

  /// 骰宝数字0-6
  static const sicboNumberList = ["0", "1", "2", "3", "4", "5", "6"];
  /// 骰宝总点数3-18
  static const sicboTotalNumberList = ["", "", "", "山", "是", "无", "妞", "期", "爸", "究", "斯", "要", "而", "闪", "使", "屋", "牛", "器", "仈"];

  /// 大小围
  static const sicboBigSmallList = ["小", "大", "围"];

  /// 单双围
  static const sicboOddEvenList = ["单", "双", "围"];

  static const sicboBalck = "黑";

  static const sicboEmpty = "000";


  /*=========================== 3D/5D start================================*/
  /// 3d数字0-9
  static const game3DNumberList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  /// 大小
  static const game3DBigSmallList = ["大", "小"];
  /// 单双
  static const game3DOddEvenList = ["单", "双"];

  /// 色碟
  static const discZhupan = ["0", "1", "2", "3", "4"];
  static const discBig = ["小", "大", "和", "消", "哒"];
  static const discSingle = ["单", "双"];
  static const discNumber = ["零", "一", "二", "三", "四"];

  static discIsBigSmallTie(str) {
    return discBig[4] == str || discBig[3] == str;
  }



  /*===========================番摊 start================================*/
  /// 骰宝数字0-6
  static const fantanNumberList = ["四", "一", "二", "三"];
  /// 单双围
  static const fantanOddEvenList = ["单", "双"];
  static const fantanEmpty = "五";
  /*===========================轮盘 start================================*/

  /// 赢点珠盘路字符集
  static const rouletteWinNumberCharList = ["0",
  "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
  "要", "而", "闪", "诗", "无", "牛", "器", "把", "就", "是",
  "药", "儿", "山", "时", "吴", "妞", "起", "爸", "救", "市",
  "咬", "耳", "散", "使", "唔", "钮"
  ];

  /// 大小路字符集
  static const rouletteBigSmallCharList = ["小", "大", "零"];

  /// 红黑路字符集
  static const rouletteRedBlackCharList = ["黑", "红", "零"];

  /// 单双路字符集
  static const rouletteOddEvenCharList = ["双", "单", "零"];

  /// 打列路字符集
  static const rouletteDozenColumnRoadCharList = ["洪", "兰", "绿"];
  /*===========================轮盘 end================================*/
  /// 六合彩数字0-9
  static const markSixNumberList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  /// 赢点珠盘路字符集
  static const MarkSixWinNumberCharList = ["0",
  "一", "二", "三", "四", "五", "六", "七", "八", "九", "十",
  "要", "而", "闪", "诗", "无", "牛", "器", "把", "就", "是",
  "药", "儿", "山", "时", "吴", "妞", "起", "爸", "救", "市",
  "咬", "耳", "散", "使", "唔", "钮"
  ];
  /// 大小路字符集
  static const MarkSixBigSmallCharList = ["小", "大", "零"];
  /// 单双路字符集
  static const MarkSixOddEvenCharList = ["单", "双", "零"];

  /*===========================轮盘 start================================*/
  ///斗牛
  static const DouNiuBeadPlateList = ["闲", "庄", "和"];

  /// 安达巴哈
  static const andabahaBigRoad = ['安', '巴'];


  /// 印度扎金花
  static const indiaZhupan = ["A", "诶", "欸", "誒", "B", "必", "比", "币", "和", "合", "喝", "盒"];
  static const indiaBig = [];

  /// 滚球 3-15 0-2 通用枚举占位用的
  static const obBallBigRoad = ["零", "一", "二", "叁", "肆", "伍", "陆", "柒", "捌", "九", "十", "要", "而", "闪", "诗", "无",/**后面为赛车添加 */ "妞", "期", "爸", "究"];
  static const obBallBig = ["大", "小"];
  static const obBallSingle = ["单", "双"];
  static const obBallNumber = ["零", "一", "二", "三", "四", "五", "六", "七", "八", /**后面为赛车添加 */"玖", "食"];

  /// 获取珠盘结果字符
  ///
  ///*结果 0A 1B 2和, 对子 0无1A2B3AB, 红利0无1有
  static getIndiaResultChar(result, pair, red) {
    return { 'result': indiaZhupan[result * 4 + pair], 'redResult': red ? "心" : "行" };
  }
}