import 'package:flutter/foundation.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_ctr.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/backup/backup_deep_clear.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/backup/backup_quick_query_index_builder.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/backup/backup_quick_query_ops.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

extension DataStoreCtrBackup on MatchDataBaseWS {

  /// @description: 赛事详情模块设置赛事信息数据
  /// @param {Map<String, dynamic>} match_details 赛事对象
  /// @param {List<dynamic>} odds_info 赔率信息
  /// @param {Map<String, dynamic>} param 是否数据合并
  /// @return {void} void
  void setMatchDetails(
      Map<String, dynamic> matchDetails, List<dynamic> oddsInfo,
      {Map<String, dynamic> param = const {}}) {
    dataStoreController.type = param['type'] ?? 'match';
    // 格式化列表赛事(部分数组转对象)
    // listSerializedMatchObj([matchDetails]);
    // 设置赔率
    matchDetails['odds_info'] = oddsInfo;

    // 列表数据同步到快捷操作对象中
    listToObjFun([matchDetails], dataStoreController.listToObj);
    // 设置激活的赛事mids数组
    dataStoreController.midsAtion = [matchDetails['mid']];
  }

  /// @description: 将list格式化成多个obj对象
  /// @param {List<dynamic>} list 赛事列表
  /// @param {int} timestap 时间戳
  /// @return {Map<String, dynamic>} 将赛事列表转成成对象,提高检索速度
  Map<String, dynamic> listToManyObj(List<dynamic> list, int timestap) {
    return BackupQuickQueryIndexBuilder(
      keyBuilder: getListToObjKey,
    ).buildManyObj(list, timestap);
  }

  /// @description: 获取赛事列表中的赛事mid索引位置
  /// @param {String} mid 赛事标识
  /// @param {List<dynamic>} list 赛事列表数据
  /// @return {int} 指定赛事列表中的位置
  int getMidIndexFormList(String mid, List<dynamic> list) {
    int res = -1;
    for (int i = 0; i < list.length; i++) {
      if (list[i]['mid'] == mid) {
        res = i;
        break;
      }
    }
    return res;
  }

  /// @description: 删除赛事(释放赛事的所有数据,并从关联的列表)
  /// @param {String} mid 赛事标识
  /// @param {List<dynamic>} list 赛事列表数据
  /// @return {int} 指定赛事列表中的位置
  void removeMatch(String mid) {
    final midObjKey = getListToObjKey(mid, mid, 'mid');
    // 快速赛事对象查找赛事
    if (dataStoreController.listToObj['mid_obj'][midObjKey] != null) {
      // 清除赛事的所有数据
      clearObj(dataStoreController.listToObj['mid_obj'][midObjKey]);
    }
    // 删除快速查询对象中指定赛事的所有赛事关联的挂载点
    deleteMatchFromQuickQueryObj(mid, mid, 'mid', [dataStoreController.listToObj]);
  }

  /// @description: 删除快速查询中指定赛事和编号的挂载点(不清空赛事数据)
  /// @param {String} mid 赛事标识
  /// @param {String} id 精准查询使用到的id
  /// @param {String} type 精准查询id类型(mid/ol/hl/hn)
  /// @param {List<dynamic>} arr 需求清除的对象数组,默认为快速检索对象数组
  void deleteMatchFromQuickQueryObj(
      String mid, String id, String type, List arr) {
    final quickQueryStr = getListToObjKey(mid, id, type);
    if (arr.isEmpty) {
      BackupQuickQueryOps.removeMountPointsFromListToObj(
        dataStoreController.listToObj,
        quickQueryStr,
      );
      return;
    }

    for (final objTemp in arr) {
      if (objTemp is Map<String, dynamic>) {
        BackupQuickQueryOps.removeMountPointsFromListToObj(objTemp, quickQueryStr);
      } else if (objTemp is Map) {
        BackupQuickQueryOps.removeMountPointsFromListToObj(
          objTemp.cast<String, dynamic>(),
          quickQueryStr,
        );
      }
    }
  }

  /// @description: 获取list_to_obj中的赛事
  /// @param {List<String>} mids 赛事mid集合
  /// @param {String} type 返回的类型(Object/Array)
  /// @return {Map<String, dynamic>/List<dynamic>} 赛事信息集合
  dynamic getMatchObjectFormListToObj(List<String> mids,
      [String type = 'Object']) {
    dynamic res;
    if (type == 'Array') {
      res = [];
    } else {
      res = {};
    }
    try {
      for (var mid in mids) {
        final temp = dataStoreController.listToObj['mid_obj'][getListToObjKey(mid, mid, 'mid')];
        if (type == 'Array') {
          res.add(temp);
        } else {
          res[mid] = temp;
        }
      }
    } catch (error) {
      if (kDebugMode) {
        AppLogger.debug('_get_match_arr_form_list_to_obj: $error');
      }
    }
    return res;
  }

  /// @description: 快速检索数据对象合并逻辑
  /// @param {Map<String, dynamic>} many_obj_old 老数据对象
  /// @param {Map<String, dynamic>} many_obj_new 新数据对象
  /// @param {List<String>} mids 赛事mid数组(为空时表示取obj所有key值)
  /// @param {bool} gc 是否回收垃圾
  /// @return {void} void
  void quickQueryObjAssign(Map<String, dynamic> manyObjOld,
      Map<String, dynamic> manyObjNew, List<String> mids,
      [bool gc = true]) {
    // 获取老数据对象keys
    final oldOlObjKeys = getQuickQueryObjObjKeys(manyObjOld['ol_obj'], mids);
    final oldHnObjKeys = getQuickQueryObjObjKeys(manyObjOld['hn_obj'], mids);
    final oldHlObjKeys = getQuickQueryObjObjKeys(manyObjOld['hl_obj'], mids);

    // 获取新数据对象keys
    final newOlObjKeys = getQuickQueryObjObjKeys(manyObjNew['ol_obj'], mids);
    final newHnObjKeys = getQuickQueryObjObjKeys(manyObjNew['hn_obj'], mids);
    final newHlObjKeys = getQuickQueryObjObjKeys(manyObjNew['hl_obj'], mids);

    // 快速检索对象数据合并
    matchAssign(manyObjOld['mid_obj'], manyObjNew['mid_obj']);

    ///============ 问下humal 下面三个方法没有
    // ol_obj_assign(manyObjOld['ol_obj'], manyObjNew['ol_obj']);
    //
    // hn_obj_assign(manyObjOld['hn_obj'], manyObjNew['hn_obj']);
    //
    // hl_obj_assign(manyObjOld['hl_obj'], manyObjNew['hl_obj']);
    if (gc) {
      // 获取无用数据
      final olObjKeys =
          oldOlObjKeys.toSet().difference(newOlObjKeys.toSet()).toList();
      final hnObjKeys =
          oldHnObjKeys.toSet().difference(newHnObjKeys.toSet()).toList();
      final hlObjKeys =
          oldHlObjKeys.toSet().difference(newHlObjKeys.toSet()).toList();
      // 删除无用数据
      for (var keys in olObjKeys) {
        manyObjOld['ol_obj'].remove(keys);
      }
      for (var keys in hnObjKeys) {
        manyObjOld['hn_obj'].remove(keys);
      }
      for (var keys in hlObjKeys) {
        manyObjOld['hl_obj'].remove(keys);
      }
    }
  }

  List<String> getQuickQueryObjObjKeys(
      Map<String, dynamic> obj, List<String> mids) {
    List<String> res = [];
    for (var item in mids) {
      String mid = '${item}_';
      obj.forEach((key, value) {
        if (key.startsWith(mid)) {
          res.add(key);
        }
      });
    }
    return res;
  }

  void clearListOther(List<dynamic> list) {
    List<String> listKeys =
        dataStoreController.listToObj['mid_obj'].keys.toList();
    List<Map<String, dynamic>> listMidObj = [];
    for (var item in listKeys) {
      String mid = item.replaceAll('_', '');
      listMidObj.add({'mid': mid});
    }

    Map obj = listComparison(listMidObj, list);
    obj['del'].forEach((key, value) {
      if (key != null) {
        String mid = key.replaceAll('_', '');
        removeMatch(mid);
      }
    });
  }

  void clearMidObj(dynamic mid) {
    deleteMatchFromQuickQueryObj(mid, mid, 'mid', [dataStoreController.listToObj]);
  }

  void clearHlObj(dynamic mid, dynamic hid) {
    deleteMatchFromQuickQueryObj(mid, hid, 'hl', [dataStoreController.listToObj]);
  }

  void clearOlObj(dynamic mid, dynamic oid) {
    deleteMatchFromQuickQueryObj(mid, oid, 'ol', [dataStoreController.listToObj]);
  }

  void clearHnObj(dynamic mid, dynamic hn) {
    deleteMatchFromQuickQueryObj(mid, hn, 'hn', [dataStoreController.listToObj]);
  }

  void clearObj(dynamic any) {
    BackupDeepClear.clear(any);
  }

  // void assignWith(dynamic oldObj, dynamic newObj) {
  //   dynamic customizer(oldValue, newValue) {
  //     dynamic res = oldValue;
  //     String type = oldValue.runtimeType.toString();
  //     if (type == 'Map') {
  //       if (newValue == null) {
  //         res = newValue;
  //       } else {
  //         oldValue.forEach((key, value) {
  //           if (value != null) {
  //             if (newValue[key] == null && newValue.containsKey(key)) {
  //               oldValue.remove(key);
  //             }
  //           }
  //         });
  //       }
  //     } else if (type == 'List' && newValue is List) {
  //       newValue != null &&
  //           oldValue != null &&
  //           (oldValue.length == newValue.length);
  //       for (int i = 0; i < newValue.length; i++) {
  //         dynamic item = newValue[i];
  //         String type2 = item.runtimeType.toString();
  //         if (type2 == 'Map') {
  //           assignWith(oldValue[i], item);
  //         } else if (type2 == 'List') {
  //           assignWithList(oldValue[i], item);
  //         } else {
  //           oldValue[i] = newValue[i];
  //         }
  //       }
  //       return oldValue;
  //     }
  //     return res;
  //   }
  //   assignWith(oldObj, newObj);
  // }

  void assignWithList(List<dynamic> oldList, List<dynamic> newList) {
    oldList.length = newList.length;
    for (int i = 0; i < oldList.length; i++) {
      final dynamic newItem = newList[i];
      if (newItem is Map && oldList[i] is Map) {
        (oldList[i] as Map).addAll(newItem);
      } else if (newItem is List && oldList[i] is List) {
        assignWithList(oldList[i] as List<dynamic>, newItem);
      } else {
        oldList[i] = newItem;
      }
    }
  }

  void updMatchAllStatus(Map<String, dynamic> obj) {
    if (obj.containsKey('mid')) {
      String mid = obj['mid'];
      if (obj.containsKey('mhs')) {
        quickQueryObjUpdStatusMhs(
            dataStoreController.listToObj, mid, obj['mhs']);
      }
      if (obj.containsKey('hid') && obj.containsKey('hs')) {
        quickQueryObjUpdStatusHs(
            dataStoreController.listToObj, mid, obj['hid'], obj['hs']);
      }
      if (obj.containsKey('oid') && obj.containsKey('os')) {
        quickQueryObjUpdStatusOs(
            dataStoreController.listToObj, mid, obj['oid'], obj['os']);
      }
    }
  }

  void quickQueryObjUpdStatusMhs(
      Map<String, dynamic> quickQueryObj, String mid, int mhs) {
    String midStr = getListToObjKey(mid, mid, 'mid');
    Map<String, dynamic> match = quickQueryObj['mid_obj'][midStr];
    match['mhs'] = mhs;
    Map<String, dynamic> object = quickQueryObj['ol_obj'];
    object.forEach((key, value) {
      if (key.startsWith(midStr) && value != null) {
        value['_mhs'] = mhs;
      }
    });
    object = quickQueryObj['hn_obj'];
    object.forEach((key, value) {
      if (key.startsWith(midStr) && value != null) {
        value['_mhs'] = mhs;
      }
    });
  }

  void quickQueryObjUpdStatusHs(
      Map<String, dynamic> quickQueryObj, String mid, String hid, int hs) {
    String idStr = getListToObjKey(mid, hid, 'hl');
    final obj = quickQueryObj['hl_obj'][idStr];
    if (obj is! Map) return;
    final hlMap = obj.cast<String, dynamic>();
    hlMap['hs'] = hs;
    final objOl = hlMap['ol'];
    if (objOl is List) {
      for (final item in objOl) {
        if (item is Map) {
          item['_hs'] = hs;
        }
      }
    }
  }

  void quickQueryObjUpdStatusOs(
      Map<String, dynamic> quickQueryObj, String mid, String oid, int os) {
    String idStr = getListToObjKey(mid, oid, 'ol');
    Map<String, dynamic> obj = quickQueryObj['ol_obj'][idStr];
    obj['os'] = os;
  }

  void clearQuickQueryObj(Map<String, dynamic> quickQueryObj) {
    BackupDeepClear.clear(quickQueryObj['ol_obj']);
    BackupDeepClear.clear(quickQueryObj['hl_obj']);
    BackupDeepClear.clear(quickQueryObj['hn_obj']);
    BackupDeepClear.clear(quickQueryObj['mid_obj']);
  }

  void clear() {
    clearQuickQueryObj(dataStoreController.listToObj);
    dataStoreController.midsAtion = [];
    clearObj(dataStoreController.cacheMatch);
    dataStoreController.cacheMatch = {};
    clearObj(dataStoreController.wsMatchKeyUpdTimeCache);
    dataStoreController.wsMatchKeyUpdTimeCache = {};
  }

  void destroy() {
    // scmdC8();
    clearQuickQueryObj(dataStoreController.listToObj);
    clearObj(dataStoreController.listToObj);
    clearObj(dataStoreController.matchUpdTimeKeys);
    clearObj(dataStoreController.cache);
    clearObj(dataStoreController.cacheMatch);
    clearObj(dataStoreController.wsMatchKeyUpdTimeCache);
    clearObj(dataStoreController.cacheOid);
    dataStoreController.midsAtion = [];
  }

  List<dynamic> listSortNew(String mid) {
    MatchEntity? match = dataStoreController.getMatchById(mid);
    final hpsList = match?.hps ?? const <MatchHps>[];
    final top = hpsList.where((e) => e.hton != '0').toList(growable: false);
    top.sort((a, b) => (int.tryParse(b.hton) ?? 0).compareTo(int.tryParse(a.hton) ?? 0));
    return top;
  }

  List<dynamic> listSortNormal(String mid) {
    MatchEntity? match = dataStoreController.getMatchById(mid);
    final hpsList = match?.hps ?? const <MatchHps>[];
    final normal = hpsList.where((e) => e.hton == '0').toList(growable: false);
    normal.sort((a, b) => a.hpon.compareTo(b.hpon));
    return normal;
  }

  void scmdC8WsReconnect() {
    // scmdC8();
  }
}
