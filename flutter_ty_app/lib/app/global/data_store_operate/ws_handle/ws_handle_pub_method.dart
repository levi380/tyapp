import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-ffec4c85-6e72-4e9e-b232-50e804d0ffa1-sz 】】】
    【【【 AUTO_DOCUMENT_MENU ws推送 】】】
    【【【 AUTO_DOCUMENT_TITLE  WS集中处理执行扩展类 】】】
    【【【 AUTO_PARAGRAPH_TITLE WS集中处理执行扩展类代码拆分第二部分-公共方法入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 数据处理合并 逻辑筛选的代码块
    】】】
 *
 */
extension MatchDataBaseWSPubMethod on MatchDataBaseWS {
  bool enableOddsReload(List<Map<String, dynamic>> ols,
      Map<String, dynamic> hlMap, MatchEntity match) {
    bool enable = true;
    for (Map<String, dynamic> olMap in ols) {
      ///玩法级别hs赋值给盘口
      olMap['hs'] = hlMap.get("hs");

      ///赛事级别mhs赋值给盘口
      olMap['mhs'] = match.mhs;
      ///当前赔率是否可用   true 可用  false 超过0.2水差范围 不可用
      bool iseffect = effectiveRange(olMap);
      ///赔率分组更新标识
      ///要么都更新 要么 都不更新赔率分组
      if (!iseffect) {
        enable = iseffect;
        break;
      }
    }
    return enable;
  }

  ///1. 投注弹窗内+
  /// 0.2的水 超出，直接丢弃数据，啥也不做，基准数据不变
  /// 2.列表详情投注项
  /// 0.2的水超出，直接丢弃数据，啥也不做，基准数据不变
  /// 核对的玩法id

  bool effectiveRange(Map<String, dynamic> olMap) {
    bool effective = true;
    MatchHpsHlOl? ol = dataStoreController.getOlById(olMap.get("oid"));
    // if ((ol?.hpid == '2' || ol?.hpid == '4') &&
    //     ol?.oid == '143452481375833356') {
    //   if (kDebugMode) {
    //     AppLogger.debug('水差------->');
    //   }
    // }
    bool newOlEnble = enableOl(olMap['hs'], olMap['os'], olMap['mhs']);
    bool oldOlEnble = enableOl(ol?.hs ?? 0, ol?.os ?? 0, ol?.mhs ?? 0);
    ///hpidArr范围之外的玩法不过滤
    if (newOlEnble && oldOlEnble && hpidArr.contains(ol?.hpid)) {
      double effOv = double.parse(formatNumber(olMap.get("ov")));
      double min = double.parse(formatNumber(ol!.ov)) - 0.2;
      double max = double.parse(formatNumber(ol.ov)) + 0.2;
      if (effOv < min || effOv > max) {
        return false;
      }
    }

    return effective;
  }

  ///过滤条件一  赛事级别 mhs = 0   玩法级别hs = 0  盘口级别os = 1
  ///判断是否是需要过滤盘口
  enableOl(int hs, int os, int mhs) {
    return hs == 0 && os == 1 && mhs == 0;
  }

  ///返回整型ctsp值
  int ctspForInt(String ctsp) {
    if (ctsp.isEmpty) {
      ctsp = '0';
    }
    return int.parse(ctsp);
  }

  /// 只显示三位有效数字
  String formatNumber(var number) {
    String numStr = number.toString();
    double result = (numStr.toInt()) / 100000;
    String resultStr;
    resultStr = result.toStringAsFixed(3);
    return resultStr;
  }

  ///判断当前推送时间戳 是否早于 接口时间时间戳
  bool juageTime({required wsObj, required String apiTime}) {
    bool enable = true;

    ///ws 根据时间过滤
    String wsTime = wsObj['ctsp'] ?? '';
    if (apiTime.isNotEmpty && wsTime.isNotEmpty) {
      enable = apiTime.toInt() - wsTime.toInt() <= 0 ? true : false;
    }
    return enable;
  }


  ///整合并获取当前C8返回的list
  List<Map<String, dynamic>> getC8List(List<dynamic> matchList) {
    List<Map<String, dynamic>> list = [];
    matchList.forEach((item) {
      if (item != null) {
        String mid = item['mid'];
        String hpid = "*";
        if (item['hpids'] is List &&
            item['hpids'].length > 0 &&
            !item['hpids'].contains("*")) {
          hpid = item['hpids'].join(',');
        }
        ///c8 组装特定格式
        Map<String, dynamic> obj = {'mid': mid, 'hpid': hpid, 'level': 3};
        list.add(obj);
      }
    });
    return list;
  }
}