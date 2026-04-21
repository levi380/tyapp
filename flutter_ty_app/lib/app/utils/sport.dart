class Sport {
  final String csid;
  final String mark;
  final String name;

  Sport({required this.csid, required this.mark, this.name = ''});
}

/**
 * CSID: 1   足球
 * CSID: 2   篮球
 * CSID: 3   棒球
 * CSID: 4   冰球
 * CSID: 5   网球
 * CSID: 6   美式足球
 * CSID: 7   斯诺克
 * CSID: 8   乒乓球
 * CSID: 9   排球
 * CSID: 10  羽毛球
 * CSID: 11  手球
 * CSID: 12  拳击
 * CSID: 13  沙滩排球
 * CSID: 14  联合式橄榄球
 * CSID: 15  曲棍球
 * CSID: 16  水球
 * CSID: 17  田径
 * CSID: 18  政治娱乐
 * CSID: 19  游泳
 * CSID: 20  体操
 * CSID: 21  跳水
 * CSID: 23  举重
 * CSID: 24  射箭
 * CSID: 25  击剑
 * CSID: 26  冰壶
 * CSID: 27  跆拳道
 * CSID: 28  高尔夫
 * CSID: 29  自行车
 * CSID: 30  赛马
 * CSID: 31  帆船
 * CSID: 32  划船
 * CSID: 33  赛车运动
 * CSID: 34  柔道
 * CSID: 35  空手道
 * CSID: 36  摔跤
 * CSID: 37  板球
 * CSID: 38  飞镖
 * CSID: 39  沙滩足球
 * CSID: 40  其他
 * CSID: 100  英雄联盟
 * CSID: 101  Dota2
 * CSID: 102  CS:GO
 * CSID: 103  王者荣耀
 * CSID: 1001 VR 足球
 * CSID: 1002 VR 赛狗
 * CSID: 1007 VR 泥地赛车
 * CSID: 1008 VR 卡丁车
 * CSID: 1009 VR 泥地摩托车
 * CSID: 1010 VR 摩托车
 * CSID: 1011 VR 赛马
 * CSID: 1012 VR 马车赛
 * */
class SportData {
  // 延迟加载运动项目的列表
  static List<Sport>? _sports;

  /// CSID: 1, Mark: 足球
  static final int sportCsid_1 = 1;

  /// CSID: 2, Mark: 篮球
  static final int sportCsid_2 = 2;

  /// CSID: 3, Mark: 棒球
  static final int sportCsid_3 = 3;

  /// CSID: 4, Mark: 冰球
  static final int sportCsid_4 = 4;

  /// CSID: 5, Mark: 网球
  static final int sportCsid_5 = 5;

  /// CSID: 6, Mark: 美式足球
  static final int sportCsid_6 = 6;

  /// CSID: 7, Mark: 斯诺克
  static final int sportCsid_7 = 7;

  /// CSID: 8, Mark: 乒乓球
  static final int sportCsid_8 = 8;

  /// CSID: 9, Mark: 排球
  static final int sportCsid_9 = 9;

  /// CSID: 10, Mark: 羽毛球
  static final int sportCsid_10 = 10;

  /// CSID: 11, Mark: 手球
  static final int sportCsid_11 = 11;

  /// CSID: 12, Mark: 拳击
  static final int sportCsid_12 = 12;

  /// CSID: 13, Mark: 沙滩排球
  static final int sportCsid_13 = 13;

  /// CSID: 14, Mark: 联合式橄榄球
  static final int sportCsid_14 = 14;

  /// CSID: 15, Mark: 曲棍球
  static final int sportCsid_15 = 15;

  /// CSID: 16, Mark: 水球
  static final int sportCsid_16 = 16;

  /// CSID: 17, Mark: 田径
  static final int sportCsid_17 = 17;

  /// CSID: 18, Mark: 政治娱乐
  static final int sportCsid_18 = 18;

  /// CSID: 19, Mark: 游泳
  static final int sportCsid_19 = 19;

  /// CSID: 20, Mark: 体操
  static final int sportCsid_20 = 20;

  /// CSID: 21, Mark: 跳水
  static final int sportCsid_21 = 21;

  /// CSID: 23, Mark: 举重
  static final int sportCsid_23 = 23;

  /// CSID: 24, Mark: 射箭
  static final int sportCsid_24 = 24;

  /// CSID: 25, Mark: 击剑
  static final int sportCsid_25 = 25;

  /// CSID: 26, Mark: 冰壶
  static final int sportCsid_26 = 26;

  /// CSID: 27, Mark: 跆拳道
  static final int sportCsid_27 = 27;

  /// CSID: 28, Mark: 高尔夫
  static final int sportCsid_28 = 28;

  /// CSID: 29, Mark: 自行车
  static final int sportCsid_29 = 29;

  /// CSID: 30, Mark: 赛马
  static final int sportCsid_30 = 30;

  /// CSID: 31, Mark: 帆船
  static final int sportCsid_31 = 31;

  /// CSID: 32, Mark: 划船
  static final int sportCsid_32 = 32;

  /// CSID: 33, Mark: 赛车运动
  static final int sportCsid_33 = 33;

  /// CSID: 34, Mark: 柔道
  static final int sportCsid_34 = 34;

  /// CSID: 35, Mark: 空手道
  static final int sportCsid_35 = 35;

  /// CSID: 36, Mark: 摔跤
  static final int sportCsid_36 = 36;

  /// CSID: 37, Mark: 板球
  static final int sportCsid_37 = 37;

  /// CSID: 38, Mark: 飞镖
  static final int sportCsid_38 = 38;

  /// CSID: 39, Mark: 沙滩足球
  static final int sportCsid_39 = 39;

  /// CSID: 40, Mark: 其他
  static final int sportCsid_40 = 40;

  /// CSID: 90, Mark: 电子足球
  static final int sportCsid_90 = 90;

  /// CSID: 91, Mark: 电子篮球
  static final int sportCsid_91 = 91;

  /// CSID: 100, Mark: 英雄联盟
  static final int sportCsid_100 = 100;

  /// CSID: 101, Mark: Dota2
  static final int sportCsid_101 = 101;

  /// CSID: 102, Mark: CS.GO
  static final int sportCsid_102 = 102;

  /// CSID: 103, Mark: 王者荣耀
  static final int sportCsid_103 = 103;

  /// CSID: 104, Mark:   绝地求生
  static final int sportCsid_104 = 104;

  /// CSID: 105, Mark:   无畏契约
  static final int sportCsid_105 = 105;

  /// CSID: 1001, Mark: VR足球
  static final int sportCsid_1001 = 1001;

  /// CSID: 1002, Mark: VR赛狗
  static final int sportCsid_1002 = 1002;

  /// CSID: 1007, Mark: VR泥地赛车
  static final int sportCsid_1007 = 1007;

  /// CSID: 1008, Mark: VR卡丁车
  static final int sportCsid_1008 = 1008;

  /// CSID: 1009, Mark: VR泥地摩托车
  static final int sportCsid_1009 = 1009;

  /// CSID: 1010, Mark: VR摩托车
  static final int sportCsid_1010 = 1010;

  /// CSID: 1011, Mark: VR赛马
  static final int sportCsid_1011 = 1011;

  /// CSID: 1012, Mark: VR马车赛
  static final int sportCsid_1012 = 1012;

  // 初始化运动项目的列表
  static List<Sport> get sports {
    _sports ??= [
      Sport(csid: "1", mark: "足球"),
      Sport(csid: "2", mark: "篮球"),
      Sport(csid: "3", mark: "棒球"),
      Sport(csid: "4", mark: "冰球"),
      Sport(csid: "5", mark: "网球"),
      Sport(csid: "6", mark: "美式足球"),
      Sport(csid: "7", mark: "斯诺克"),
      Sport(csid: "8", mark: "乒乓球"),
      Sport(csid: "9", mark: "排球"),
      Sport(csid: "10", mark: "羽毛球"),
      Sport(csid: "11", mark: "手球"),
      Sport(csid: "12", mark: "拳击"),
      Sport(csid: "13", mark: "沙滩排球"),
      Sport(csid: "14", mark: "联合式橄榄球"),
      Sport(csid: "15", mark: "曲棍球"),
      Sport(csid: "16", mark: "水球"),
      Sport(csid: "17", mark: "田径"),
      Sport(csid: "18", mark: "政治娱乐"),
      Sport(csid: "19", mark: "游泳"),
      Sport(csid: "20", mark: "体操"),
      Sport(csid: "21", mark: "跳水"),
      Sport(csid: "23", mark: "举重"),
      Sport(csid: "24", mark: "射箭"),
      Sport(csid: "25", mark: "击剑"),
      Sport(csid: "26", mark: "冰壶"),
      Sport(csid: "27", mark: "跆拳道"),
      Sport(csid: "28", mark: "高尔夫"),
      Sport(csid: "29", mark: "自行车"),
      Sport(csid: "30", mark: "赛马"),
      Sport(csid: "31", mark: "帆船"),
      Sport(csid: "32", mark: "划船"),
      Sport(csid: "33", mark: "赛车运动"),
      Sport(csid: "34", mark: "柔道"),
      Sport(csid: "35", mark: "空手道"),
      Sport(csid: "36", mark: "摔跤"),
      Sport(csid: "37", mark: "板球"),
      Sport(csid: "38", mark: "飞镖"),
      Sport(csid: "39", mark: "沙滩足球"),
      Sport(csid: "40", mark: "其他"),
      Sport(csid: "100", mark: "英雄联盟"),
      Sport(csid: "101", mark: "Dota2"),
      Sport(csid: "102", mark: "CS.GO"),
      Sport(csid: "103", mark: "王者荣耀"),
      Sport(csid: "105", mark: "无畏契约"),
      Sport(csid: "1001", mark: "VR足球"),
      Sport(csid: "1002", mark: "VR赛狗"),
      Sport(csid: "1007", mark: "VR泥地赛车"),
      Sport(csid: "1008", mark: "VR卡丁车"),
      Sport(csid: "1009", mark: "VR泥地摩托车"),
      Sport(csid: "1010", mark: "VR摩托车"),
      Sport(csid: "1011", mark: "VR赛马"),
      Sport(csid: "1012", mark: "VR马车赛"),
    ];
    return _sports!;
  }

  // 创建一个 Map 用于快速查找
  static final Map<String, Sport> _sportMap = {
    for (var sport in sports) sport.csid: sport
  };

  // 提供一个方法来获取运动项目
  static Sport? getSportByCsid(String csid) {
    return _sportMap[csid];
  }

  // 返回特定 csid 的运动项目的 csid 列表，或者返回所有运动项目的 csid 列表
  static List<int> getAllSports([List<int>? csids]) {
    if (csids != null && csids.isNotEmpty) {
      final csidSet = Set<String>.from(csids.map((id) => id.toString()));
      return sports
          .where((sport) => csidSet.contains(sport.csid))
          .map((sport) => int.parse(sport.csid))
          .toList();
    }
    return sports.map((sport) => int.parse(sport.csid)).toList(); // 返回所有 csid
  }

  /**
   * CSID: 1   足球
   * CSID: 2   篮球
   * CSID: 3   棒球
   * CSID: 4   冰球
   * CSID: 5   网球
   * CSID: 6   美式足球
   * CSID: 7   斯诺克
   * CSID: 8   乒乓球
   * CSID: 9   排球
   * CSID: 10  羽毛球
   * CSID: 11  手球
   * CSID: 12  拳击
   * CSID: 13  沙滩排球
   * CSID: 14  联合式橄榄球
   * CSID: 15  曲棍球
   * CSID: 16  水球
   * CSID: 17  田径
   * CSID: 18  政治娱乐
   * CSID: 19  游泳
   * CSID: 20  体操
   * CSID: 21  跳水
   * CSID: 23  举重
   * CSID: 24  射箭
   * CSID: 25  击剑
   * CSID: 26  冰壶
   * CSID: 27  跆拳道
   * CSID: 28  高尔夫
   * CSID: 29  自行车
   * CSID: 30  赛马
   * CSID: 31  帆船
   * CSID: 32  划船
   * CSID: 33  赛车运动
   * CSID: 34  柔道
   * CSID: 35  空手道
   * CSID: 36  摔跤
   * CSID: 37  板球
   * CSID: 38  飞镖
   * CSID: 39  沙滩足球
   * CSID: 40  其他
   * CSID: 100  英雄联盟
   * CSID: 101  Dota2
   * CSID: 102  CS:GO
   * CSID: 103  王者荣耀
   * CSID: 1001 VR 足球
   * CSID: 1002 VR 赛狗
   * CSID: 1007 VR 泥地赛车
   * CSID: 1008 VR 卡丁车
   * CSID: 1009 VR 泥地摩托车
   * CSID: 1010 VR 摩托车
   * CSID: 1011 VR 赛马
   * CSID: 1012 VR 马车赛
   * */
  static List<int>? getSportsCsid([List<int>? csids]) {
    return csids; // 返回所有 csid
  }

  /// MS: 0, Mark: 未开赛
  static final int sportMs_0 = 0;

  /// MS: 1, Mark: 进行中
  static final int sportMs_1 = 1;

  /// MS: 2, Mark: 暂停
  static final int sportMs_2 = 2;

  /// MS: 3, Mark: 结束
  static final int sportMs_3 = 3;

  /// MS: 4, Mark: 关闭
  static final int sportMs_4 = 4;

  /// MS: 5, Mark: 取消
  static final int sportMs_5 = 5;

  /// MS: 6, Mark: 比赛放弃
  static final int sportMs_6 = 6;

  /// MS: 7, Mark: 延迟
  static final int sportMs_7 = 7;

  /// MS: 8, Mark: 未知
  static final int sportMs_8 = 8;

  /// MS: 9, Mark: 延期
  static final int sportMs_9 = 9;

  /// MS: 10, Mark: 比赛中断
  static final int sportMs_10 = 10;

  /// MS: 110, Mark: 即将开赛
  static final int sportMs_110 = 110;

  /**
   *
      "0": "未开赛",
      "1": "进行中",
      "2": "暂停",
      "3": "结束",
      "4": "关闭",
      "5": "取消",
      "6": "比赛放弃",
      "7": "延迟",
      "8": "未知",
      "9": "延期",
      "10": "比赛中断",
      "110": "即将开赛"
   * */
  static List<int>? getSportsMS([List<int>? ms]) {
    return ms; // 返回所有 ms
  }

  static int getMatchMS(String csid) {
    return int.parse(csid); // 返回所有 ms
  }
}
