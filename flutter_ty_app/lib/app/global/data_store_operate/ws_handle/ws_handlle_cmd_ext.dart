import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle_pub_method.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app_send.dart';
import 'package:flutter_ty_app/app/services/models/res/zr_switch_config_entity.dart';
import 'package:flutter_ty_app/app/services/models/res/match_entity.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import '../../../utils/widget_utils.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';

extension MatchDataBaseWSPubMethodExt on MatchDataBaseWS {

  // {"cd": {
  // "uid": "1343434343",
  // "device": "pc",
  // "groupLevel": "0",
  // "earlyLevel": "0",
  // "marketLevel": "0",
  // "esMarketLevel": "0"
  // },
  // "cmd": "C209",
  // "ctsp": "1771161051458",
  // "ld": "N01_f4a84845dc354ec3ab2218084b3ed42b,N01_0f90347a199b4d89a9a62741c76be079,"}
  void C209(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.changeLang);
  }

  ///C151订阅
  /// {cd: {"id":"767955053119016960","relationId":null,"activityTitle":null,"activityType":null,
  /// "deviceType":null,"deviceTypeList":null,"beginTime":null,"endTime":null,"playType":null,
  /// "fireworksType":null,"activityStatus":1,"logo":null,"merchantCode":null,"languageReqList"
  /// :null,"codeList":null,"createTime":null,"createBy":null,"updateTime":1732093144367,
  /// "updateBy":"shtest"}, cmd: C151, ctsp: 1732093144447,
  /// ld: 45115995c5734d188a255b35732f089b}
  void C151(Map<String, dynamic> wsObj) {
    // final cdObj = wsObj['cd'];
    //String mid = cdObj['mid'];
    //Map<String, dynamic> jsonData = jsonDecode(cdObj);
    //FireworksActivityEntity activityEntity =FireworksActivityEntity.fromJson(jsonData);
    FireworksController.to.getFireworksActivity();
  }

  ///c8订阅
  /// 玩法集变更(C112)
  /// 触发http请求  赛事详情模块收到消息 重新调用玩法集菜单api接口  同步最新的数据、
  ///{
  ///"cd": {
  ///"mcid": [
  ///"48",
  ///"76"
  ///],
  ///"mcms": "3",
  ///"mid": "611980"
  ///},
  ///"cmd": "C112",
  ///"ctsp": "1610592753695",
  ///"ld": "0af5125120210114105233410817f0a6"
  ///}
  void C112(Map<String, dynamic> wsObj) {
    ///Bus.getInstance().emit(EventType.socketOddinfo, [wsObj]);
  }

  ///赛事进球事件
  /// {"cd":{"eventTime":"1714970261324","homeAway":"home","mid":"3417940","secondsFromStart":2078,
  /// "t1":1,"t2":0},"cmd":"C115","ctsp":"1714970261356","ld":"RB_0af515b320240506123741324bface1bb2f9"}
  void C115(Map<String, dynamic> wsObj) {
    // AppLogger.debug("=========================>收到C115通知  $wsObj");
    ////ws命令数据信息
    final cdObj = wsObj['cd'];

    ////赛事标识
    ///=============获取mid
    String mid = cdObj['mid'].toString();
    MatchEntity? match = dataStoreController.getMatchById(mid);
    if (match != null) {
      ////合并赛事
      Map<String, dynamic> matchMap = match.toJson();

      ////更新msc比分信息
      matchMap.addAll(cdObj);
      MatchEntity newMatch = MatchEntity.fromJson(matchMap);
      //   AppLogger.debug("=========================>收到C115通知_时间戳:${newMatch.eventTime.toString()}");

      //进球通知
      WidgetUtils.instance().streamShowGoalController.sink.add(cdObj);

      dataStoreController.updateMatch(newMatch);
    }
  }

  ///优惠盘口ws开关推送  走节流全局推送 刷新接口  RCMD_C152
  void C152(Map<String, dynamic> wsObj) {
    // AppLogger.debug("=========================>收到C152通知  $wsObj");
    ////ws命令数据信息
    // final cdObj = wsObj['cd'];
    ///=============获取mid
    // String mid = cdObj['mid'].toString();
    // MatchEntity? match = dataStoreController.getMatchById(mid);
    // if (match != null) {
    ///合并赛事
    // Map<String, dynamic> matchMap = match.toJson();
    // matchMap.addAll(cdObj);
    // MatchEntity newMatch = MatchEntity.fromJson(matchMap);
    // dataStoreController.updateMatch(newMatch);
    // }
  }

  ///冠军 右边显示的事件
  ///盘口结束时间(针对冠军赛事) C8
  ///{
  ///"cd": {
  ///"mid": "77821687983308802",
  ///"hid": "144025105247958058",
  ///"hmgt": "1628879400000", 冠军盘口开始时间
  ///"hmed": "1652535000000" 冠军盘口结束时间
  ///},
  ///"cmd": "C120",
  ///"ctsp": "1614050093866",
  ///"ld": "c0e02d578dcb4a079e2dcb9652ae9640-1629029377566"
  ///}
  void C120(Map<String, dynamic> wsObj) {
    ///Bus.getInstance().emit(EventType.RCMD_C120, [wsObj]);
    Map<String, dynamic> cdObj = wsObj['cd'];
    String mid = cdObj['mid'].toString();
    MatchEntity? match = dataStoreController.getMatchById(mid);
    if (match != null) {
      Map<String, dynamic> matchMap = match.toJson();
      matchMap.addAll(cdObj);
      MatchEntity newMatch = MatchEntity.fromJson(matchMap);
      dataStoreController.updateMatch(newMatch);
    }
  }

  ///{"cd":{"cuid":"509825984426120034","isOddsChange":false,"newProcessOrder":0,"orderNo":"5132230936416288","preStatus":0,"status":1,
  ///"tryNewProcessBet":0},"cmd":"C201","ctsp":"1710743654741","ld":"fe2c007ba8b14ba787b553657fb269fd"}
  ///注单订阅  订单状态改变使用 C3订阅
  void C201(Map<String, dynamic> wsObj) {
    ///注单处理逻辑
    Map<String, dynamic> cd = wsObj["cd"];
    Bus.getInstance().emit(EventType.orderPreSettle, cd);

    ///判断是否有水差
    if (cd.get("oddsChange") != null &&
        cd.get("oddsChange").toString() != '0') {
      ///发送C118订阅
      AppWebSocket.instance().skt_send_bat_handicap_odds_c118();
      Bus.getInstance().emit(
        EventType.send_bat_handicap_odds,
      );
    }
  }

  ///未结算订单数 未结算订单数量变化 C3订阅
  ///{"cd":{"count":85,"cuid":"509825984426120034"},"cmd":"C202","ctsp":"1710743654741",
  ///"ld":"fe2c007ba8b14ba787b553657fb269fd"}
  void C202(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C202, [wsObj]);
  }

  ///用户账变 重新请求用户余额接口
  ///{
  ///"cd": {
  ///"cuid": "204783950864248832"
  ///},
  ///"cmd": "C203",
  ///"ctsp": "1611300018516",
  ///"ld": "b84fb3f36e524ca282b1172877dfdd60"
  ///}
  void C203(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C203, [wsObj]);
  }

  ///赛事提前结算投注项  C21订阅   提前结算投注项数据变化通知
  ///{
  ///"cmd": "C210",
  ///"ctsp": "1635915042008",
  ///"cd": [
  ///{
  ///"hid": "142725909041383",
  ///"oid": "142725909041383930",
  ///"probabilities": 0.0165,
  ///"cashOutStatus": 1,
  ///"ov": "1.98"
  ///}
  ///],
  ///"ld": "SR_ac12b2f620211103141208728b148f60"
  ///}
  void C210(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C210, [wsObj]);
  }

  ///赛事提前结算状态变化 C8订阅
  ///"cd": {
  ///        "mearlys": 0,
  ///        "mid": "2935854"
  ///    },
  ///    "cmd": "C211",
  ///    "ctsp": "1638513379595",
  ///    "ld": "4eb7da4a209c4128ac9697e84de6360f_merge_trade"
  void C211(Map<String, dynamic> wsObj) {
    Map<String, dynamic> cdObj = wsObj['cd'];
    String mid = cdObj['mid'].toString();
    String mearlys = cdObj['mearlys'].toString();

    MatchEntity? match = dataStoreController.getMatchById(mid);
    if (match != null) {
      match.mearlys = int.parse(mearlys);
      dataStoreController.updateMatch(match);
    }
  }

  ///菜单栏目统计
  ///菜单栏目数量变化时触发
  ///{
  ///"cd": [
  ///{
  ///"containLive": false,
  ///"count": 1488,
  ///"menuId": "302",
  ///"sys": 4
  ///},
  ///],
  ///"cmd": "C301",
  ///"ctsp": "1610590730014"
  ///}
  void C301(Map<String, dynamic> wsObj) {
    ///Bus.getInstance().emit(EventType.RCMD_C301, [wsObj]);
  }

  ///赛事开赛状态
  ///***触发http请求  C4订阅
  ///{"cd":{"csid":"8","mid":"3288468","ms":1},"cmd":"C302","ctsp":"1710241062185",
  ///"ld":"BG_0af513aa20240312185735034a2ef68c0377status,
  ///B02_0af515942024031218574214189cdf50,BG_0af513aa20240312185735034a2ef68c0377status,
  ///B02_0af515942024031218574214189cdf50"}

  ///peilvctsp
  ///matchstatectsp
  void C302(Map<String, dynamic> wsObj) {
    Map<String, dynamic> cdObj = wsObj['cd'];
    String mid = cdObj['mid'];
    String ms = cdObj['ms'].toString();
    MatchEntity? match = dataStoreController.getMatchById(mid);

    if (match != null) {
      String apiTime = '';
      List hpsList = List.from(match.hps
          .where((MatchHps element) => element.ctsp.isNotEmpty)
          .toList());
      MatchHps? hps;
      if (hpsList.isNotEmpty) {
        ///根据ctsp 排序
        hpsList.sort((a, b) => ctspForInt(a.ctsp.toString())
            .compareTo(ctspForInt(b.ctsp.toString())));
        hps = hpsList.last;
        apiTime = hps!.ctsp;
      }
      bool enable = juageTime(wsObj: wsObj, apiTime: apiTime);
      if (!enable) return;
      String wsTime = wsObj['ctsp'] ?? '';
      if (hps != null && wsTime.isNotEmpty && apiTime.isNotEmpty) {
        match.hps.forEach((MatchHps element) {
          element.ctsp = wsTime;
        });
      }

      match.ms = int.parse(ms);
      dataStoreController.updateMatch(match);

      ///assignWith(match, cdObj);
    }
  }

  ///{"cd":{"csid":"1","hpid":"10","mid":"3286676"},
  ///"cmd":"C303","ctsp":"1710240227003","ld":"AO_0af5159020240312184345880657e15e_1"}
  ///新增玩法/盘口通知
  void C303(Map<String, dynamic> wsObj) {
    ///1s 2s 给你发一个mid [‘2222’,‘2222’,‘2222’,‘2222’,]
    ///玩法id mid   多个玩法是用逗号隔开

    ///Map<String, dynamic> cdObj = wsObj['cd'];
    ///String mid = cdObj['mid'];
    ///List matchList = mid.split(',');
    ///matchList.forEach((element) {
    ///  String matchId = element.toString();
    ///  MatchEntity? match = dataStoreController.getMatchById(matchId);
    ///  ///Map<String, dynamic> match = getQuickMidObj(mid);
    ///  if (match != null) {
    ///    dataStoreController.updateMatch(match);
    ///    ///updMatchAllStatus({'mid': mid, 'hid': cdObj['hid'], 'hs': cdObj['hs']});
    ///  }
    ///});
  }

  ///新版UI菜单 C51订阅
  ///{
  ///"cd": [
  ///{
  ///"containLive": false,
  ///"count": 1,
  ///"menuId": "302010108"
  ///},
  ///{
  ///"containLive": false,
  ///"count": 20,
  ///"menuId": "302010109"
  ///}
  ///],
  ///"cmd": "C501",
  ///"ctsp": "1610590812789"
  ///}
  void C501(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C501, [wsObj]);

    ///Map<String, dynamic> cdObj = wsObj['cd'];
    ///String mid = cdObj['mid'];
    ///String ctsp = wsObj['ctsp'];
  }

  ///热门赛事变化时触发
  ///** 触犯http请求
  ///{
  ///"cmd": "C601",
  ///"cd": {
  ///"hoid": 1 ///hoid子栏目列表：“1”：热门9场赛事 “2”：直播/动画列表 (2目前没用到)
  ///},
  ///"ctsp": "1612240060001",
  ///"Id": "task_1612240060001"
  ///}
  void C601(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C601, [wsObj]);

    ///Map<String, dynamic> cdObj = wsObj['cd'];
    ///String mid = cdObj['mid'];
    ///String ctsp = wsObj['ctsp'];
  }

  ///紧急开关推送 订阅走的C7
  void C701(Map<String, dynamic> wsObj) {
    Map<String, dynamic> cdObj = wsObj['cd'];
    if (cdObj.keys.isNotEmpty) {
      ///更新紧急开关
      // Map<String, dynamic> ZrSwitchConfigMap = cdObj.toJson();
      if (cdObj['zrSwitchConfig'] != null) {
        ConfigController.to.accessConfig.value.zrSwitchConfig =
            ZrSwitchConfigEntity.fromJson(cdObj['zrSwitchConfig']);
        ConfigController.to.accessConfig.refresh();
      }
    }
  }

  ///倒计时补充
  ///C8订阅  主要是同步倒计时事件
  ///{
  ///"cd": [
  ///{
  ///"mct": "0",
  ///"mess": "1",
  ///"mhs": 0,
  ///"mid": "594472",
  ///"mmp": "0",
  ///"ms": "0",
  ///"mst": 0
  ///},
  ///{
  ///"mct": "0",
  ///"mess": "1",
  ///"mhs": 1,
  ///"mid": "615509",
  ///"mmp": "31",
  ///"ms": "1",
  ///"msc": [
  ///"S1|2:0",
  ///"S2|2:0",
  ///"S3|0:0",
  ///"S5|2:2",
  ///"S8|32:20",
  ///"S10|1:0",
  ///"S11|0:0",
  ///"S12|2:0",
  ///"S15|2:2",
  ///"S16|0:0",
  ///"S17|3:1",
  ///"S18|0:2",
  ///"S104|59:44",
  ///"S105|49:51",
  ///"S555|2:2"
  ///],
  ///"mst": 2700
  ///},
  ///
  ///],
  ///"cmd": "C801",
  ///"ctsp": "1610593030384"
  ///}

  /// 同步到中央数据库
  void C801(Map<String, dynamic> wsObj) {
    ///Bus.getInstance().emit(EventType.RCMD_C801, [wsObj]);
    List cdObj = wsObj['cd'];
    cdObj.forEach((element) {
      String mid = element['mid'];
      MatchEntity? match = dataStoreController.getMatchById(mid);
      if (match != null) {
        Map<String, dynamic> matchMap = match.toJson();
        matchMap.addAll(element);
        MatchEntity newMatch = MatchEntity.fromJson(matchMap);
        dataStoreController.updateMatch(newMatch);
      }
    });
  }

  ///关盘补充
  ///收到消息后 根据联赛和赛事信息删除联赛下的赛事
  ///{
  ///"cd": {
  ///"csid": "1",
  ///"mhs": 2,    0:开盘 1 封盘  2 关盘  11 锁盘
  ///"mid": "2289274",
  ///"ms": "0",
  ///"tid": "821456"
  ///},
  ///"cmd": "C901",
  ///"ctsp": "1620291316135",
  ///"ld": "cca874a2026540119554ee9f61a27aac_trade_status"
  ///}
  void C901(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C901, [wsObj]);

    ///Map<String, dynamic> cdObj = wsObj['cd'];
    ///String mid = cdObj['mid'];
    ///String ctsp = wsObj['ctsp'];
  }

  ///赛事事件 通知赛事变化 更新指定模块显示逻辑
  ///C14订阅
  /**
      {
      "cd": {
      "cmec": "match_status",
      "cmes": 0,
      "csid": "2",
      "mess": "1",
      "mid": "1865958274411528194",
      "mmp": "999",
      "mst": 0
      },
      "cmd": "C1021",
      "ctsp": "1733715689284",
      "ld": "RC_PUSH_02171a6ac7ad491ba2ed317a69ee808e_1112741_EVENT"
      }
   **/
  void C1021(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C1021, wsObj);
    Map<String, dynamic> cdObj = wsObj['cd'];
    String mid = cdObj['mid'];
    MatchEntity? match = dataStoreController.getMatchById(mid);
    if (match != null) {
      Map<String, dynamic> matchMap = match.toJson();
      matchMap.addAll(cdObj);
      MatchEntity newMatch = MatchEntity.fromJson(matchMap);
      dataStoreController.updateMatch(newMatch);
    }

    ///Map<String, dynamic> cdObj = wsObj['cd'];
    ///String mid = cdObj['mid'];
    ///String ctsp = wsObj['ctsp'];
  }

  ///订阅C14
  ///赛事分析  走势图ws
  /// {
  /// "cd":{"averageList":{"average":"10.20","formatTime":"2632","oddsValue":"10.20","time":"2632","timeMillis":"1744456533462"},"fieldOddsValueList":{"1XBet":{"formatTime":"2632","oddsValue":"10.2","time":"2632","timeMillis":"1744456533462"}},"hid":"143483935687923425","hn":"1","hpid":"1","mid":"39779409","mmp":6},
  /// "cmd":"C1401",
  /// "ctsp":"1744465505921",
  /// "ld":"0c31baffaf7f49b0a23e46ebbad67ced_report_ws_ws_39779409"
  /// }
  void C1041(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C1041, wsObj);
  }

  ///菜单栏顺序变更
  ///{
  ///"cd": {
  ///"refreshAll": true
  ///},
  ///"cmd": "C3011",
  ///"ctsp": "1612240060001",
  ///"ld": "task_1612240060001"
  ///}
  void C3011(Map<String, dynamic> wsObj) {
    Bus.getInstance().emit(EventType.RCMD_C3011, [wsObj]);

    ///Map<String, dynamic> cdObj = wsObj['cd'];
    ///String mid = cdObj['mid'];
    ///String ctsp = wsObj['ctsp'];
  }
}