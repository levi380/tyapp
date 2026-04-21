import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';

import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle_pub_method.dart';

import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';


/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-ffec4c85-6e72-4e9e-b232-50e804d0ffa1-sz 】】】
    【【【 AUTO_DOCUMENT_MENU ws推送 】】】
    【【【 AUTO_DOCUMENT_TITLE  WS集中处理执行扩展类 】】】
    【【【 AUTO_PARAGRAPH_TITLE WS集中处理执行扩展类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - cmd中转站 (C01  --------  C3011)
    】】】
 *
 */
extension MatchDataBaseWSEx on MatchDataBaseWS {
  ///更新数据仓库 赛事模型 区分普通赛事  和 优惠盘口赛事
  ///涉及cmd:
  ///C101  C102  C103 C104 C105 C211 C302
  // bool isDiscout (Map<String, dynamic> cdObj){
  //   int dom = cdObj.get('dom') ?? 0;
  //   return dom == 1 ? true : false;
  // }

  ///赛事状态
  ///{"cd":{"mid":"308230039208001538","ms":1},
  ///"cmd":"C101","ctsp":"1710743707617","ld":"RC_PUSH_3fd0a7b47fa04291b05845fa5305b8fb_STAT_1111178"}
  void C101(wsObj) {
    if (wsObj != null) {
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'] ?? '';
      String ms = cdObj['ms'].toString();

      ///Real-time time
      MatchEntity? match = dataStoreController.getMatchById(mid);

      ////获取快速查询对象中的mid赛事对象
      ///final match = getQuickMidObj(mid);
      if (match != null) {
        int oldMs = match.ms;
        wsObj['oldMs'] = oldMs;

        ///滚球开赛推送
        Bus.getInstance().emit(EventType.RCMD_C101, [wsObj]);
        if (ms.isNotEmpty) {
          match.ms = int.tryParse(ms) ?? 0;
        }
        dataStoreController.updateMatch(match);
        Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);

        ////数据同步逻辑
        ///assignWith(match, cdObj);
      }
    }
  }

  ///赛事事件
  ///"cd":{"cmec":"match_status","cmes":0,"csid":"8","mat":"away","mct":"0","mess":"1","mid":"
  ///3263011","mmp":"999"},"cmd":"C102","ctsp":"1709636840763",
  ///"ld":"B02_0af5158e202403051907156855ec1f6a"}
  void C102(wsObj) {
    // AppLogger.debug("===========>赛事事件C102 wsObj    ${wsObj['cd']}");

    if (wsObj != null) {
      Map<String, dynamic> cdObj = wsObj['cd'];
      String mid = cdObj['mid'] ?? "";

      ///int? cmec = int.tryParse(cdObj['cmec'].toString());Ï
      ///int? cmes = int.tryParse(cdObj['cmes'].toString());
      ///String? csid = cdObj['csid'];
      ///String? mat = cdObj['mat'];
      ///String? mgt = cdObj['mgt'];
      ///String? mct = cdObj['mct'];
      ///String? mess = cdObj['mess'];
      ///String? mmp = cdObj['mmp'];
      ///int? mst = int.tryParse(cdObj['mst'].toString());
      //
      ///////棒球
      ///int? mbhn = int.tryParse(cdObj['mbhn'].toString());
      ///int? mbkn = int.tryParse(cdObj['mbkn'].toString());
      ///int? mbcn = int.tryParse(cdObj['mbcn'].toString());
      ///int? mbolp = int.tryParse(cdObj['mbolp'].toString());
      ///int? mbtlp = int.tryParse(cdObj['mbtlp'].toString());
      ///int? mbthlp = int.tryParse(cdObj['mbthlp'].toString());

      ///String ctsp = wsObj['ctsp'];

      ////获取快速查询对象中的mid赛事对象
      ///MatchEntity match = getQuickMidObj(mid);

      MatchEntity? match = dataStoreController.getMatchById(
        mid,
      );

      ///final sktData = wsObj.cd;

      ////var 事件 skt_data.cmec !== 'goal 避免接口返回 goal 事件
      ////设置赛事比分更新时间
      ///wsMatchKeyUpdTimeCacheSet(match, 'msc', ctsp);

      ///cmec":"match_status","cmes":0,"csid":"8","mat":"away","mct":"0","mess":"1"
      if (match != null) {
        ///ws102 103 根据et值过滤
        String et = cdObj.get('et') ?? '';
        String mgt = match.mgt;
        if (mgt.isNotEmpty && et.isNotEmpty) {
          bool enable = mgt.toInt() - et.toInt() <= 0 ? true : false;
          if (!enable) {
            return;
          }
        }
        Bus.getInstance().emit(EventType.RCMD_C102, wsObj);
        Map<String, dynamic> matchMap = match.toJson();
        matchMap.addAll(cdObj);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);
        Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
      }
    }
  }

  ///赛事比分
  ///{"cd":{"csid":1,"mid":"3261173","mpid":"6","msc":
  ///["S1|0:0","S2|0:0","S5|4:3","S6|2:1","S8|56:33","S10|0:0","S11|0:0","S12|0:0",
  ///"S13|0:0","S14|0:0","S15|4:3","S17|1:1","S18|1:0","S104|54:40","S105|0:0","S555|4:3"
  ///,"S1001|0:0","S1002|0:0","S1003|0:0","S1004|0:0","S1005|0:0","S1006|0:0","S1101|2:1",
  ///"S5001|1:0","S5002|2:2","S5003|1:1","S5004|0:0","S5005|0:0","S5006|0:0","S10011|0:0",
  ///"S10012|0:0","S10013|0:0","S10021|0:0","S10022|0:0","S10023|0:0","S10031|0:0","S10032|0:0",
  ///"S10101|0:0","S10102|0:0","S10103|0:0","S11001|0:0","S12001|0:0","S50011|0:0","S50012|0:0","S50013|0:0"]},
  ///"cmd":"C103","ctsp":"1710239917185","ld":"KO_0af50b2320240312183837069761c72d054b"}
  void C103(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);

      ///ws命令数据信息
      Map<String, dynamic> cdObj = wsObj['cd'];

      ///赛事标识
      ///=============获取mid
      String mid = cdObj['mid'].toString();

      ///实时时间歘
      ///=============获取ctsp

      ///获取快速查询对象中的mid赛事对象
      ///final match = getQuickMidObj(mid);

      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        ///ws102 103 根据et值过滤
        String et = cdObj.get('et') ?? '';
        String mgt = match.mgt;
        if (mgt.isNotEmpty && et.isNotEmpty) {
          bool enable = mgt.toInt() - et.toInt() <= 0 ? true : false;
          if (!enable) {
            return;
          }
        }
        ////合并赛事
        Map<String, dynamic> matchMap = match.toJson();
        ////更新msc比分信息
        matchMap.addAll(cdObj);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);

        //////数据同步逻辑
        ///assignWith(match, {...cdObj, 'is_ws': true});
        //////格式化列表赛事(部分数组转对象)
        ///listSerializedMatchObj([match], true);
        //////设置赛事比分更新时间
        ///wsMatchKeyUpdTimeCacheSet(match, 'msc', ctsp);
      }
    }
  }

  ///C104 赛事级别盘口状态
  ///{
  ///"cd": {
  ///"csid": "2",
  ///"mhs": 0, 0开盘 1 封盘  2 关盘 11锁盘
  ///"mid": "634519",
  ///"ms": "110"
  ///},
  ///"cmd": "C104",
  ///"ctsp": "1611287974122",
  ///"ld": "82c7abba44124dbcb24d47824fd231ce_odds_trade"
  ///}
  void C104(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);

      ///ws命令数据信息
      Map<String, dynamic> cd = wsObj["cd"];

      ///赛事标识
      String mid = cd["mid"];

      ////实时时间歘
      ////获取快速查询对象中的mid赛事对象

      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        match.mhs = int.parse(cd["mhs"].toString());

        ///match?.ms = int.parse(cd["ms"].toString());
        match.ms = int.tryParse(cd["ms"].toString()) ?? 0;

        ///Map<String, dynamic> matchMap = match.toJson();
        ///matchMap.addAll(cd);
        ///MatchEntity? newMatch = MatchEntity.fromJson(matchMap);
        ///同步更新快速查询对象中的赛事状态
        dataStoreController.updateMatch(match);
      }
    }
  }

  ///{
  ///"cd": {
  ///"hls": [
  ///{
  ///"hid": "143349024444581022",
  ///"hmt": 0,
  ///"hn": 1,
  ///"hpid": "2",
  ///"hs": 0,
  ///"mid": "619449",
  ///"ol": [
  ///{
  ///"obv": "178000",
  ///"oid": "143634920413042028",
  ///"os": 1,
  ///"ot": "Over",
  ///"ov": "178000"
  ///},
  ///
  ///]
  ///},
  ///{
  ///"hid": "142841435599534052",
  ///"hmt": 0,
  ///"hpid": "1",
  ///"hs": 0,
  ///"mid": "619449",
  ///"ol": [
  ///{
  ///"obv": "88000",
  ///"oid": "143573153910168915",
  ///"os": 2,
  ///"ot": "1",
  ///"ov": "88000"
  ///},
  ///{
  ///"obv": "1799000",
  ///"oid": "140457023563880646",
  ///"os": 1,
  ///"ot": "X",
  ///"ov": "1799000"
  ///},
  ///{
  ///"obv": "5645000",
  ///"oid": "145602149493075410",
  ///"os": 1,
  ///"ot": "2",
  ///"ov": "5645000"
  ///}
  ///]
  ///}
  ///],
  ///"mid": "619449"
  ///},
  ///"cmd": "C105",
  ///"ctsp": "1610590773893",
  ///"ld": "0af51251202101141019331186a5783f"
  ///}
  ///盘口赔率
  void C105(wsObj) {
    ///0615 关闭详情的ws推送  解决线上赔率精准度问题 只轮询调用接口
    //String route = Get.currentRoute;
    //if (route == Routes.matchDetail) return;

    if (wsObj == null) return;

    Map<String, dynamic>? cd = wsObj["cd"];
    if (cd == null) return;

    String mid = cd["mid"] ?? '';
    if (mid.isEmpty) return;

    MatchEntity? match = dataStoreController.getMatchById(mid);
    if (match == null) return;
    /// 解析 hls/hls2
    dynamic hlsGet = cd.get('hls') ?? cd.get('hls2');
    List<Map<String, dynamic>> hls = [];

    if (hlsGet is Map<String, dynamic>) {
      hls = hlsGet.values
          .expand((list) => list)
          .toList()
          .cast<Map<String, dynamic>>();
    } else if (hlsGet is List) {
      hls = hlsGet.cast<Map<String, dynamic>>();
    }

    /// 找出最新 ctsp 对应的 hps
    List<MatchHps> hpsList = match.hps
        .where((e) => e.ctsp.isNotEmpty)
        .toList();

    MatchHps? hps;
    String apiTime = '';

    if (hpsList.isNotEmpty) {
      hpsList.sort((a, b) =>
          ctspForInt(a.ctsp).compareTo(ctspForInt(b.ctsp)));
      hps = hpsList.last;
      apiTime = hps.ctsp;
    }

    /// 时间校验，不通过直接退出
    bool enable = juageTime(wsObj: wsObj, apiTime: apiTime);
    if (!enable) return;

    /// 校准 match.hps 的时间戳
    String wsTime = wsObj['ctsp'] ?? '';
    if (hps != null && wsTime.isNotEmpty && apiTime.isNotEmpty) {
      for (MatchHps element in match.hps) {
        element.ctsp = wsTime;
      }
    }

    /// 更新赔率（核心逻辑）
    if (hls.isNotEmpty) {
      for (Map<String, dynamic> hlMap in hls) {
        List<Map<String, dynamic>>? ols =
        hlMap.get("ol")?.cast<Map<String, dynamic>>();

        ///赔率分组是否达标
        // bool enableTag = enableOddsReload(ols ?? [], hlMap, match!);
        ///放开0.2水差兜底逻辑
        bool enableTag = true;

        if (ols != null && ols.isNotEmpty && enableTag) {
          for (Map<String, dynamic> olMap in ols) {
            final oid = olMap.get("oid");
            MatchHpsHlOl? ol = dataStoreController.getOlById(oid);
            if (ol == null) continue;

            ///旧数据
            Map<String, dynamic> oldOlMap = ol.toJson();

            ///玩法级别 hs
            olMap['hs'] = hlMap.get("hs");

            ///赛事级别 mhs
            olMap['mhs'] = match.mhs;

            ///合并数据
            oldOlMap.addAll(olMap);

            MatchHpsHlOl newOl = MatchHpsHlOl.fromJson(oldOlMap);

            ///更新赔率
            dataStoreController.updateOl(newOl);
          }
        }
      }
    }

    ///  更新赛事数据
    dataStoreController.updateMatch(match);
  }

  ///{"cd":{"hls":[{"hid":"141166327841400404","hmt":0,"hpid":"1",
  ///"hs":0,"mid":"3309107","ol":[{"obv":"440000","oid":"144240021206684277",
  ///"os":1,"ot":"1","ov":"440000"},{"obv":"145000","oid":"148031785175341227","os":1,
  ///"ot":"2","ov":"145000"},{"obv":"425000","oid":"144068151919801125","os":1,"ot":"X"
  ///,"ov":"425000"}]}],"ld":"AO_0af5159720240318143400766992c849_0","mid":"3309107"},"
  ///cmd":"C106","ctsp":"1710743641357","ld":"AO_0af5159720240318143400766992c849_0"}
  void C106(wsObj) {
    C105(wsObj);
  }

  ///赛事视频/动画状态
  ///动画状态 mvs -1: 没有配置动画源  0 已配置 不可用  1/2 已配置 可用
  ///视频状态 mms -1: 没有配置动画源  0 已配置 不可用  1 已配置 暂未播放  2 已配置 播放中
  void C107(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.updata_detail_data, [wsObj]);
      Map<String, dynamic> cd = wsObj["cd"];
      String mid = cd["mid"];
      MatchEntity? match = dataStoreController.getMatchById(mid);

      ///final match = getQuickMidObj(mid);
      if (match != null) {
        if (cd['mvs'] != null) {
          match.mvs = cd['mvs'];
        }
        if (cd['mms'] != null) {
          match.mms = cd['mms'];
        }
        if (cd['pmms'] != null) {
          match.pmms = cd['pmms'];
        }
        dataStoreController.updateMatch(match);

        ///Data synchronization logic
        ///assignWith(match, cdObj);
        ///matchUpdTimeRetChange(match);
        ///updDataVersion();
      }
    }
  }

  ///财务推送 收到这个命令需要刷新整个页面
  ///  {
  ///  cmd: "C108", ///指令
  ///  ctsp: 13136466799,   ///时间戳
  ///  cd:""//数据
  ///}
  void C108(wsObj) {
    if (wsObj != null) {
      Bus.getInstance().emit(EventType.RCMD_C108, [wsObj]);
    }
  }

  ///109 赛事开盘推送 无需订阅  自动推送
  ///***** 同步赛事状态 调用相关的api接口
  ///{"cd":[{"csid":"1","hs":0,"mid":"3288756","ms":"1"},{"csid":"1","hs":0,"mid":"306148956190478338","ms":"0"}],
  ///"cmd":"C109","ctsp":"1710234480448",
  ///"ld":"a4ed698c104d43df9f701f6d38b17211_trade_config,RC_PUSH_81b3e39431144e78867f67ed3ad11b83_1102121_1"}
  void C109(wsObj) {
    if (wsObj != null) {
      ///Bus.getInstance().emit(EventType.RCMD_C109, [wsObj]);
      ///List cdList = wsObj["cd"];
      ///cdList.forEach((element) {
      ///  Map eleMap = element;
      ///  MatchEntity? match = dataStoreController.getMatchById(eleMap['mid']);
      ///  if (match != null) {
      ///    match.csid = eleMap['csid'].toString();
      ///    match.ms = int.parse(eleMap['ms'].toString());
      ///    dataStoreController.updateMatch(match);
      ///  }
      ///});
    }
  }

  ///赛事订阅C8-玩法数量
  ///赛事玩法数量同步到玩法数量显示区域
  ///{"cd":{"mc":133,"mid":"3261173"},"cmd":"C110","ctsp":"1710239917139"
  ///,"ld":"AO_0af5159020240312183835892b6960b8_0"}
  void C110(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C110, [wsObj]);
    Map<String, dynamic> cdObj = wsObj['cd'];
    String mid = cdObj['mid'];
    int mc = int.tryParse(cdObj['mc'].toString()) ?? 0;

    // String ctsp = wsObj['ctsp'];
    MatchEntity? match = dataStoreController.getMatchById(mid);

    ///Map<String, dynamic> match = getQuickMidObj(mid);
    if (match != null) {
      match.mc = mc;
      dataStoreController.updateMatch(match);
    }
  }

  /// {
  /// "cd": {
  /// "csid": 1,
  /// "mid": "1825427606007189506"
  /// },
  /// "cmd": "C11",
  /// "ctsp": "1724051152900",
  /// "ld": "OPEN_RC_1_1825411575243083777_347_1724051144212"
  /// }
  void C11(Map<String, dynamic> wsObj) {
    Map<String, dynamic> cdObj = wsObj['cd'];
    String mid = cdObj['mid'];

    ///可视化区 刷新业务接口
    if (DataStoreController.to.showMatchIdList.contains(mid)) {
      Bus.getInstance().emit(EventType.RCMD_C11, mid);
    }
  }
}