import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/home/models/main_menu.dart';

import '../core/constant/common/module/csid.dart';

/**
 * 球种id枚举
 * H5/PC  对应配置文件 新增 csid_map_name 对应以下国际化
 * 例： name: i18n_t('csid_map_name.xxx')
 */
class CSIDConfig {
  static const Map<String, dynamic> data = {
    "CSID_1": {"csid": "1", "mark": "足球", "name": ""},
    "CSID_2": {"csid": "2", "mark": "篮球"},
    "CSID_3": {"csid": "3", "mark": "棒球"},
    "CSID_4": {"csid": "4", "mark": "冰球"},
    "CSID_5": {"csid": "5", "mark": "网球"},
    "CSID_6": {"csid": "6", "mark": "美式足球"},
    "CSID_7": {"csid": "7", "mark": "斯诺克"},
    "CSID_8": {"csid": "8", "mark": "乒乓球"},
    "CSID_9": {"csid": "9", "mark": "排球"},
    "CSID_10": {"csid": "10", "mark": "羽毛球"},
    "CSID_11": {"csid": "11", "mark": "手球"},
    "CSID_12": {"csid": "12", "mark": "拳击"},
    "CSID_13": {"csid": "13", "mark": "沙滩排球"},
    "CSID_14": {"csid": "14", "mark": "联合式橄榄球"},
    "CSID_15": {"csid": "15", "mark": "曲棍球"},
    "CSID_16": {"csid": "16", "mark": "水球"},
    "CSID_17": {"csid": "17", "mark": "田径"},
    "CSID_18": {"csid": "18", "mark": "政治娱乐"},
    "CSID_19": {"csid": "19", "mark": "游泳"},
    "CSID_20": {"csid": "20", "mark": "体操"},
    "CSID_21": {"csid": "21", "mark": "跳水"},
    "CSID_23": {"csid": "23", "mark": "举重"},
    "CSID_24": {"csid": "24", "mark": "射箭"},
    "CSID_25": {"csid": "25", "mark": "击剑"},
    "CSID_26": {"csid": "26", "mark": "冰壶"},
    "CSID_27": {"csid": "27", "mark": "跆拳道"},
    "CSID_28": {"csid": "28", "mark": "高尔夫"},
    "CSID_29": {"csid": "29", "mark": "自行车"},
    "CSID_30": {"csid": "30", "mark": "赛马"},
    "CSID_31": {"csid": "31", "mark": "帆船"},
    "CSID_32": {"csid": "32", "mark": "划船"},
    "CSID_33": {"csid": "33", "mark": "赛车运动"},
    "CSID_34": {"csid": "34", "mark": "柔道"},
    "CSID_35": {"csid": "35", "mark": "空手道"},
    "CSID_36": {"csid": "36", "mark": "摔跤"},
    "CSID_37": {"csid": "37", "mark": "板球"},
    "CSID_38": {"csid": "38", "mark": "飞镖"},
    "CSID_39": {"csid": "39", "mark": "沙滩足球"},
    "CSID_40": {"csid": "40", "mark": "其他"},
    "CSID_90": {"csid": "90", "mark": "电子足球"},
    "CSID_91": {"csid": "91", "mark": "电子篮球"},
    "CSID_100": {"csid": "100", "mark": "英雄联盟"},
    "CSID_101": {"csid": "101", "mark": "Dota2"},
    "CSID_102": {"csid": "102", "mark": "CS.GO"},
    "CSID_103": {"csid": "103", "mark": "王者荣耀"},
    "CSID_105": {"csid": "105", "mark": "无畏契约"},
    "CSID_1001": {"csid": "1001", "mark": "VR足球"},
    "CSID_1002": {"csid": "1002", "mark": "VR赛狗"},
    "CSID_1007": {"csid": "1007", "mark": "VR泥地赛车"},
    "CSID_1008": {"csid": "1008", "mark": "VR卡丁车"},
    "CSID_1009": {"csid": "1009", "mark": "VR泥地摩托车"},
    "CSID_1010": {"csid": "1010", "mark": "VR摩托车"},
    "CSID_1011": {"csid": "1011", "mark": "VR赛马"},
    "CSID_1012": {"csid": "1012", "mark": "VR马车赛"}
  };
}

/// 球种id 和 play_name_mapping 对应关系
///
class PlayNameMappingCSID {
  static const Map<int, String> data = {
    1: "足球",
    2: "篮球",
    3: "棒球",
    4: "冰球",
    5: "网球",
    6: "美式足球",
    7: "斯诺克",
    8: "乒乓球",
    9: "排球",
    10: "羽毛球",
    11: "手球",
    12: "拳击",
    13: "沙滩排球",
    14: "橄榄球",
    15: "曲棍球",
    16: "水球",
    37: "板球",
    90: "电子足球",
    91: "电子篮球",
    100: "英雄联盟",
    101: "dota2",
    102: "csgo",
    103: "王者荣耀",
    105: "无畏契约",
    1001: "VR足球",
    1002: "VR赛狗",
    1007: "VR泥地赛车",
    1008: "VR卡丁车",
    1009: "VR泥地摩托车",
    1010: "VR摩托车",
    1011: "VR赛马",
    1012: "VR马车赛"
  };
}

List<Map<String, dynamic>> dianjingSublist() {
  return Csid.esports_csid.asMap().entries.map((entry) {
    int index = entry.key;
    int item = entry.value;
    return {"ct": 0, "mi": "2$item", "st": index + 1, "csid": item};
  }).toList();
}

/**
 * H5 赛事 csid 映射二级菜单 menu_type
 */
class CSIDMapSubMenuType {
  static const Map<int, int> data = {
    1: 5,
    2: 7,
    3: 19,
    4: 18,
    5: 13,
    6: 20,
    7: 14,
    8: 16,
    9: 17,
    10: 15,
    11: 43,
    12: 44,
    13: 45,
    14: 22,
    15: 23,
    16: 24,
  };
}

/**
 * H5 赛事 csid 映射让球玩法ID
 */
class CSIDMapConcedePointsID {
  static const Map<int, int> data = {
    1: 4,
    2: 39,
    3: 243,
    4: 4,
    5: 154,
    6: 39,
    7: 181,
    8: 172,
    9: 172,
    10: 172,
    11: 43,
    12: 44,
    13: 45,
    14: 22,
    15: 23,
    16: 24,
  };
}

///球种图标 对应精灵图位置
// 精灵图对应的位置
class SpriteImagesPosition {
  static const Map<num, int> data = {
    0: 2,
    1: 3,
    2: 4,
    3: 14,
    4: 22,
    5: 6,
    6: 11,
    7: 10,
    8: 9,
    9: 5,
    10: 8,
    11: 28,
    12: 16,
    13: 13,
    14: 12,
    15: 23,
    16: 24,
    17: 44,
    18: 18,
    19: 46,
    20: 48,
    21: 47,
    22: 52,
    23: 49,
    24: 50,
    25: 51,
    26: 54,
    27: 56,
    28: 24,
    29: 45,
    30: 66,
    31: 53,
    32: 55,
    33: 41,
    34: 58,
    35: 57,
    36: 59,
    37: 21,
    38: 20,
    39: 60,
    40: 65,
    50: 64,
    90: 61,
    91: 62,
    100: 67,
    300: 33,
    2000: 15,
    2100: 29,
    2101: 30,
    2103: 31,
    2102: 32,
    2105: 72,
    31001: 34,
    31004: 35,
    31011: 25,
    31002: 26,
    31009: 41,
    31010: 42,
    50000: 1,
    4000:69,
    3000:70,
    6000:71,
  };

  /// 球类对应图标的位置
  static int getPosition(String sportMi, MainMenu menu) {
    num target = 0;
    if (menu.isChampion) {
      if (sportMi.toNum() < 500) {
        target = sportMi.toNum() - 400;
      } else {
        target = sportMi.toNum();
      }
      //常规球类 id csid  常规id为 100+csid
    } else if (sportMi.toNum() < 200) {
      target = sportMi.toNum() - 100;
    } else {
      target = sportMi.toNum();
    }
    return data[target] ?? 0;
  }
}

// 复刻版联赛对应的位置
class LeagueSpriteImagesPosition {
  static const Map<int, int> data = {
    1:22, //世界杯 下标从0开始
    2: 6, //欧冠
    3:2,//英超
    4:9,//意甲
    5:3,//西甲
    6:4,//德甲
    7:5,//法甲
    8:39,//中超
    9:22, //欧洲杯
    10:48, //美洲杯
    11:49 //世界杯
  };
}


