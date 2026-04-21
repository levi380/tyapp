import 'package:flutter/foundation.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr_backup.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-8aca03eb-7062-4014-a75e-a47192981fe8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 数据仓库 】】】
    【【【 AUTO_DOCUMENT_TITLE  数据仓库集中处理执行扩展类 】】】
    【【【 AUTO_PARAGRAPH_TITLE 数据仓库集中处理执行扩展类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
     - 数据处理合并、逻辑筛选的代码块
     ```
     extension DataStoreCtr on MatchDataBaseWS
     ```
     】】】
 *
 */

/// 数据仓库扩展方法，用于对赛事数据进行集中处理
extension DataStoreCtr on MatchDataBaseWS {

  /// 获取实例的 name_code 参数
  /// 用于唯一标识数据仓库实例
  getNameCode() {
    String nameCode = dataStoreController.params['name_code'] ?? '';
    if (nameCode.isEmpty) {
      if (kDebugMode) {
        AppLogger.debug('MatchDataBase -赛事数据仓库-必须有实例化名字标识---');
      }
      return;
    }
  }

  /// 将指定 mids 的赛事标记为非活跃状态
  void setInactiveMids(mids) {
    if (mids != null) {
      mids.forEach((mid) {
        final match = dataStoreController.listToObj['mid_obj'][mid];
        if (match != null) {
          match['_action'] = false;
        }
      });
    }
  }

  /// 从 wsMatchKeyUpdTimeCache 中获取某赛事某 key 的更新时间
  int wsMatchKeyUpdTimeCacheGetTime(String? mid, String? key) {
    int res = 0;
    if (mid != null && key != null) {
      res = dataStoreController.wsMatchKeyUpdTimeCache[mid][key] ?? 0;
    }
    return res;
  }

  /// 批量更新赛事属性的时间戳
  ///  - 赛事列表
  void setMatchUpdTimeKeys(List? matches, List? keys, int? time) {
    if (matches != null && keys != null && time != null) {
      for (var match in matches) {
        final mid = match['mid'];
        for (var key in keys) {
          dataStoreController.cacheMatch[mid][key] = time;
        }
      }
    }
  }

  /// 获取某赛事的更新时间 map
  Map getMatchUpdTimeKeys(String? mid) {
    Map res = {};
    if (mid != null) {
      res = dataStoreController.cacheMatch[mid] ?? {};
    }
    return res;
  }

  /// 将赛事列表转换为以 mid 为 key 的 Map
  /// 并更新对应赛事属性的更新时间
  Map getListObj(List? list, int timestamp) {
    Map obj = {};
    if (list != null) {
      for (var item in list) {
        if (item != null && item['mid'] != null) {
          obj[item['mid']] = item;
        }
      }
      setMatchUpdTimeKeys(list, dataStoreController.matchUpdTimeKeys, timestamp);
    }
    return obj;
  }

  /// 比较两个赛事列表，返回新增/删除/修改的对象集合
  Map listComparison(List? oldList, List? newList) {
    Map ret = {'add': {}, 'del': {}, 'upd': {}};
    Map oldObj = getListObj(oldList, DateTime.now().millisecondsSinceEpoch);
    Map newObj = getListObj(newList, DateTime.now().millisecondsSinceEpoch);
    String key = '';
    String id = 'mid';

    // 新列表与旧列表对比，找新增和更新
    if (newList != null) {
      for (var item in newList) {
        if (item != null && item[id] != null) {
          key = item[id];
          if (oldObj[key] != null) {
            ret['upd'][key] = item; // 更新
          } else {
            ret['add'][key] = item; // 新增
          }
        }
      }
    }

    // 旧列表与新列表对比，找删除
    if (oldList != null) {
      for (var item in oldList) {
        if (item != null && item[id] != null) {
          key = item[id];
          if (newObj[key] == null) {
            ret['del'][key] = item; // 删除
          }
        }
      }
    }
    return ret;
  }

  /// 将新赛事数据赋值到旧赛事对象
  void matchAssign(Map? matchOld, Map? matchNew) {
    if (matchOld != null && matchNew != null) {
      matchAssignWithV1(matchOld, matchNew);
    }
  }


  void matchAssignWithV1(Map? matchOld, Map? matchNew) {
    if (matchOld != null && matchNew != null) {
      matchNew.forEach((key, value) {
        matchOld[key] = value;
      });
    }
  }

  /// 快速获取指定 mid 的赛事对象（引用）
  getQuickMidObjRef(String mid) {
    final key = getListToObjKey(mid, mid, 'mid');
    return dataStoreController.listToObj['mid_obj'][key];
  }

  /// 将比分字符串列表序列化为比分对象
  /// - 比分数据，如 ["S11|1:0", "S5|2:2"]
  ///  - 是否初始化默认比分结构
  Map<String, dynamic> serializedScoreObj(List msc, [bool isInit = false]) {
    Map<String, dynamic> scoreObj = {};
    if (isInit) {
      scoreObj = {
        'S11': {'home': '', 'away': ''},
        'S103': {'home': '0', 'away': '0'},
        'S5': {'home': '', 'away': ''},
        'S10102': {'home': '', 'away': ''}
      };
    }
    try {
      for (var scoreStr in msc) {
        if (scoreStr is String) {
          final List<String> scoreArr = scoreStr.split('|');
          final String key = scoreArr[0];
          final String value = scoreArr[1];
          if (value.isNotEmpty) {
            final List<String> score = value.split(':');
            scoreObj[key] = {'home': score[0], 'away': score[1]};
          }
        }
      }
    } catch (error) {
      if (kDebugMode) {
        AppLogger.debug('serializedScoreObj msc: $msc');
        AppLogger.debug('serializedScoreObj: $error');
      }
    }
    return scoreObj;
  }

  /// 设置新的赛事 Tab 数据，如果新数据缺失则回退到旧数据
  void setSavaTabPlayData(Map? matchNew, Map? matchOld) {
    if (matchNew == null || matchOld == null) {
      return;
    }

    /// tab菜单字段与数据字段映射关系
    final Map<String, dynamic> tabKeyData = {
      'cosCorner': {'play_name': '角球', 'field': 'hpsCorner'},
      'hpsPunish': {'play_name': '罚牌', 'field': 'hpsPunish'},
      'cosOutright': {'play_name': '冠军', 'field': 'hpsOutright'},
      'cosPromotion': {'play_name': '晋级赛', 'field': 'hpsPromotion'},
      'cosOvertime': {'play_name': '加时赛', 'field': 'hpsOvertime'},
      'cosPenalty': {'play_name': 'hpsPenalty', 'field': 'hpsPenalty'},
      'cos15Minutes': {'play_name': '15分钟玩法', 'field': 'hps15Minutes'},
      'cosBold': {'play_name': '波胆', 'field': 'hpsBold'},
      'cos5Minutes': {'play_name': '5分钟玩法', 'field': 'hps5Minutes'},
      'cosCompose': {'play_name': '特色组合', 'field': 'hpsCompose'},
    };

    tabKeyData.forEach((key, value) {
      final String arrName = value['field'];
      final bool hasData = matchNew[arrName]?.length != null;
      final String updTime = '_${arrName}_upd_time';

      // 新数据缺失时，从旧数据回填
      if (!hasData && matchNew[key] != null && matchOld[key] != null) {
        final List tabDataOld = matchOld[arrName] ?? [];
        matchNew[arrName] = List.from(tabDataOld);
        matchNew[updTime] = DateTime.now().millisecondsSinceEpoch;
      }
    });
  }

  /// 更新赛事的通用更新时间
  void matchUpdTimeRetChange(Map? match) {
    if (match != null) {
      match['_upd_time'] = DateTime.now().millisecondsSinceEpoch;
    }
  }

  /// 获取其他玩法 Tab 的 key 列表
  String getTabPlayKeys(Map<String, dynamic> match) {
    List<String> tabPlayKeys = [];
    List<String> playKeys = dataStoreController.otherPlayNameToPlayId.keys.toList();

    for (var key in playKeys) {
      String statusKey = 'cos${key.substring(3)}';
      if (key == 'hpsCompose') {
        statusKey = 'compose';
      }
      bool status = match[statusKey];
      bool cos15minStatus = !(statusKey == 'cos15Minutes' && match['hSpecial'] == 6);
      bool cos5minStatus = !(statusKey == 'cos5Minutes' && match['hSpecial5min'] == 6);

      if (status && cos15minStatus && cos5minStatus) {
        tabPlayKeys.add(key);
      }
    }
    return tabPlayKeys.join(',');
  }

  /// 判断某赛事是否有附加盘
  /// 返回 hasAdd1 和 hasAdd2 两个布尔值
  Map<String, bool> getHasAddN(Map<String, dynamic> match,
      {String hpsKey = 'hpsData[0].hpsAdd'}) {
    Map<String, bool> hasAdd = {'hasAdd1': false, 'hasAdd2': false};
    try {
      List<dynamic> hpsAddNData = match[hpsKey];

      /// 获取玩法最大坑位的内部函数
      Map<String, dynamic> mainFun(Map<String, dynamic> item) {
        Map<String, dynamic> hnObj = {'hn': 0, 'hpid': item['hpid'], 'item': item};
        List<dynamic> hlArr = item['hl'];
        for (var item2 in hlArr) {
          int hn = item2['hn'] ?? 0;
          if (hn != 0 && hn > hnObj['hn']) {
            hnObj['hn'] = hn;
          }
        }
        return hnObj;
      }

      int hnMax = 0;
      for (int i = 0; i < hpsAddNData.length; i++) {
        Map<String, dynamic> hnObj = mainFun(hpsAddNData[i]);
        if (hnObj['hn'] > hnMax) {
          hnMax = hnObj['hn'];
        }
      }

      if (hnMax >= 3) {
        hasAdd['hasAdd1'] = true;
        hasAdd['hasAdd2'] = true;
      } else if (hnMax >= 2) {
        hasAdd['hasAdd1'] = true;
        hasAdd['hasAdd2'] = false;
      }
    } catch (error) {
      AppLogger.debug('_get_has_add_n: $error');
    }
    return hasAdd;
  }

  /// 将列表数据同步到快捷查询对象中
  void listToObjFun(List list, Map<String, dynamic> listToObj) {
    Map<String, dynamic> manyObj =
    listToManyObj(list, DateTime.now().millisecondsSinceEpoch);
    assignWithListToObj(listToObj, manyObj);
  }

  /// 将 newObj 中的数据合并到 oldObj 中（地址不变）
  void assignWithListToObj(
      Map<String, dynamic> oldObj, Map<String, dynamic> newObj) {
    void setObjFun(
        String key, Map<String, dynamic> objOld, Map<String, dynamic> objNew) {
      objNew.forEach((key, obj) {
        if (obj != null) {
          objOld[key] = obj;
        }
      });
    }

    oldObj.forEach((key, objV1Old) {
      Map<String, dynamic> objV1New = newObj[key];
      setObjFun(key, objV1Old, objV1New);
    });
  }

  /// 根据赛事 ID、查询 ID、类型生成快捷查询 Key
  String getListToObjKey(String mid, String id, String type) {
    String res = id;
    switch (type) {
      case 'mid':
        res = '${mid}_';
        break;
      case 'ol':
      case 'hl':
      case 'hn':
        res = '${mid}_$id';
        break;
      default:
        res = id;
        break;
    }
    return res;
  }
}
