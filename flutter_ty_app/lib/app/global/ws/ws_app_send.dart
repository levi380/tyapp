import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/global/ws/ws_app.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5641aa10-22fc-44ce-9edf-f96e7285e3b9-sz 】】】
    【【【 AUTO_DOCUMENT_MENU ws推送 】】】
    【【【 AUTO_DOCUMENT_TITLE  ws订阅中心 】】】
    【【【 AUTO_PARAGRAPH_TITLE ws订阅中心入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  C8订阅  WsType.C8          订阅赛事状态
    -  C118订阅  WsType.C118      订阅注单盘口赔率
    -  C2订阅  WsType.C2          订阅注单盘口赔率
    -  C21订阅  WsType.C21        订阅注单盘口赔率
    -  C5订阅  WsType.C5          订阅菜单推送
    -  C3订阅  WsType.C3          订阅注单信息命令
    -  C4订阅  WsType.C4          订阅赔率推送开关命令  新玩法級賠率推送樣式  1：新样式  不传：老样式
    -  C5订阅  WsType.C5          订阅菜单推送

    】】】
 *
 */
extension AppWebSocketSend on AppWebSocket{
  // ws命令发送
//------------------------------------------------------------------方法定义-S-------------------------------------------------------------------------------------
// C1                  -- 发送赛状态订阅息命令C1
// C2             -- 发送注单盘口赔率命令C2
// C3                         -- 发送订单信息命令C3
// C4               -- 发送主动推送开关命令C4
// C5                          -- 菜单推送C5
// skt_cancel_send                        -- 发送取消订阅命令
//------------------------------------------------------------------方法定义-E-------------------------------------------------------------------------------------

  /// @Description:发送赛状态订阅息命令C8
  ///  C8 参数说明
  /// `cufm` 赛事列表、详细在同一页面标识，传入"m"。赛事列表、详细不同页面不需要此字段
  /// `marketLevel` 0:默认行情等级，1:信用网等级
  /// `list` 要订阅的赛事玩法对象
  /// `mid` 赛事Id
  /// `hid` 盘口Id，多个玩法Id用逗号分隔。订阅所有玩法用"*"
  /// `说明:` 订阅后会推送C101,C102,C103,C105,C107,C110,C113,C114,C115,C303,C304,C305,C801
  /// @param: obj 数据体
  /// @return:
  void sktSendMatchStatus() {
    List midList = [];
      DataStoreController.to.showMatchIdList.forEach((String  mid) {
        ///加多次要玩法的订阅
        // SecondaryMatchManager
        Map matchMap = {
          "mid":mid.toString(),
          "level":3,
          "hpid":"*",
        };
        midList.add(matchMap);
      });
      // {"cmd":"C8","cufm":"L","marketLevel": "0","list":[{"mid":"2225129","hpid":"*"},{"mid":"2226413","hpid":"1,2,4","level":2}]}
      Map<String, dynamic> cmd_obj = {};
      cmd_obj['cmd'] = WsType.C8;
      // cmd_obj['key'] = obj['key'];
      // cmd_obj['module'] = obj['module'];
      // cmd_obj['one_send'] = obj['one_send'];
      // cmd_obj['ctr_cmd'] = obj['ctr_cmd'];
      cmd_obj['marketLevel'] = TYUserController.to.userInfo.value?.marketLevel ?? 0;
      cmd_obj['esMarketLevel'] = TYUserController.to.userInfo.value?.esMarketLevel ?? 0;
      ///早盘分组
     cmd_obj['earlyMarketLevel'] = TYUserController.to.userInfo.value?.earlyMarketLevel ?? '';
      ///滚球分组
     cmd_obj['rollingMarketLevel'] = TYUserController.to.userInfo.value?.rollingMarketLevel ?? '';
      cmd_obj['list'] = midList;
      cmd_obj['cufm'] = "L";
      // cmd_obj['marketLevel'] = '0';
      cmd_obj['requestId'] = StringKV.token.get();
      if (cmd_obj['list'] != null) {
        sendMsg(cmd_obj);
        ///全局定时器去转发
        Bus.getInstance().emit(EventType.scmd_c8,[
          {'event': 'WS',
            'cmd':'WS_MSG_SEND',
            'data':cmd_obj}
        ]);
      }
  }


  /// 赛事分析走势订阅及接收数据
  /// 默认是关闭状态
  /// trenOpen false--->开启订阅    true--->关闭订阅
  void analysis_trend_switch(bool trenOpen) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C14;
    cmd_obj['requestId'] = StringKV.token.get();
    cmd_obj['cclose'] = '0';
    cmd_obj['close'] = trenOpen == true ? '0':'1';
    sendMsg(cmd_obj);
  }


  /// @Description: 发送注单盘口赔率命令C118
  /// @param: obj 数据体
  /// @return:
   void skt_send_bat_handicap_odds_c118({bool close = false}) {
    // {
    //   "cmd": "C118",
    //   "cuid": "用户id",
    //   "list":[{
    //    "mid":"赛事id"，
    //    "hid":"盘口id"，
    //    "oid": "投注项id",
    //   "hmt":"盘口类型",
    //   }],
    //   "requestId": "c3e7387abf3205c11a4a974d79ad56d5a0ab4d44"
    // }
    Map<String, dynamic> cmdObj = {};
    cmdObj['cmd'] = WsType.C118;
    // cmdObj['list'] = obj['list'];
    cmdObj['cuid'] = TYUserController.to.getUid();
    cmdObj['requestId'] = StringKV.token.get();
    if(close){
      cmdObj["cclose"]= 1;
    }
    if (cmdObj['cuid'] != null) {
      sendMsg(cmdObj);
    }

  }


  /// @Description:发送注单盘口赔率命令C2
  /// @param: obj 数据体
  /// @return:
  void sktSendBatHandicapOdds(Map<String, dynamic> obj) {
    // {cmd: "C2", hid: ""}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C2;
    cmd_obj['hid'] = obj['hid'];
    cmd_obj['mid'] = obj['mid'];
    cmd_obj['marketLevel'] = TYUserController.to.userInfo.value?.marketLevel ?? 0;
    cmd_obj['esMarketLevel'] = TYUserController.to.userInfo.value?.esMarketLevel ?? 0;
    ///早盘分组
    cmd_obj['earlyMarketLevel'] = TYUserController.to.userInfo.value?.earlyMarketLevel ?? '';
    ///滚球分组
    cmd_obj['rollingMarketLevel'] = TYUserController.to.userInfo.value?.rollingMarketLevel ?? '';
    // cmd_obj['marketLevel'] = obj['marketLevel'];
    // cmd_obj['esMarketLevel'] = obj['esMarketLevel'];
    if (cmd_obj['hid'] != "" && cmd_obj['mid'] != "") {
      sendMsg(cmd_obj);
    }
  }

  /// @Description:发送注单盘口赔率命令C21
  /// @param: obj 数据体
  /// @return:
  void sktSendBatHandicapOdds2(Map<String, dynamic> obj) {
    // {cmd: "C21", list:[{hid:"",oid:""}]}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C21;
    cmd_obj['list'] = obj['list'];
    if (cmd_obj['list'] != null) {
      sendMsg(cmd_obj);
    }
  }

  /// @Description:发送订单信息命令C3
  /// @param: obj 数据体
  /// @return:
  void sktSendOrder(Map<String, dynamic> obj) {
    // {cmd: "C3", cuid: ""}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C3;
    cmd_obj['cuid'] = obj['cuid'];
    cmd_obj['requestId'] = StringKV.token.get();
    sendMsg(cmd_obj);
  }

  /// @Description:发送主动推送开关命令C4
  /// @param: obj 数据体
  /// @return:
  void skt_send_initiative_push(Map<String, dynamic> obj) {
    // {cmd:"C4", copen: ""}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C4;
    cmd_obj['copen'] =  '1';
    ///新玩法級賠率推送樣式  1：新样式  不传：老样式
    cmd_obj['msgType'] = '1';
    cmd_obj['requestId'] = StringKV.token.get() ;
    cmd_obj['uuid'] = '${TYUserController.to.getUid().toString()}_sdk';
    // AppLogger.debug('uuid======>${TYUserController.to.getUid().toString()}');
    sendMsg(cmd_obj);
  }

  /// @Description:菜单推送(C5)
  /// @param: obj 数据体
  /// @return:
  void skt_send_menu() {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C5;
    cmd_obj['requestId'] = StringKV.token.get();
    cmd_obj['cdt'] = '7';
    sendMsg(cmd_obj);
  }

  /// @Description:优惠盘口赔率订阅(C18)
  /// @param: obj 数据体
  /// @return:
  /// 0 = {map entry} "cmd" -> "C18"
  /// 1 = {map entry} "cdt" -> "7"
  /// 2 = {map entry} "mc" -> "EzIJI80SqF8GktXVL1AILA=="
  /// 3 = {map entry} "requestId" -> "8f6abd7599ac9f9ebafe377f34e05facf4b2a2f8"
  void skt_send_discounts() {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C18;
    cmd_obj['cdt'] = '7';
    cmd_obj['mc'] = TYUserController.to.userInfo.value?.mc ?? '';
    cmd_obj['requestId'] = StringKV.token.get();
    sendMsg(cmd_obj);
  }

  /// @Description:全局开关推送(C7)
  /// @param: obj 数据体
  /// @return:
  void skt_send_switch() {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['mc'] = TYUserController.to.userInfo.value?.mc ?? '';
    cmd_obj['cmd'] = WsType.C7;
    cmd_obj['requestId'] = StringKV.token.get();
    sendMsg(cmd_obj);
  }

  /// @Description:新版菜单推送(C51)
  /// @param: obj 数据体
  /// @return:
  void skt_send_menu2(Map<String, dynamic> obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C51;
    cmd_obj['cpid'] = obj['cpid'];
    sendMsg(cmd_obj);
  }

  /// @Description:热门/直播推送(C6)
  /// @param: obj 数据体
  /// @return:
  void skt_send_hot_live(Map<String, dynamic> obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C6;
    cmd_obj['hoid'] = obj['hoid'];
    cmd_obj['device'] = obj['device'];
    if (cmd_obj['hoid'] != "") {
      sendMsg(cmd_obj);
    }
  }



  /// @Description:赛事列表接口订阅指令
  /// @param: obj 数据体
  /// @return:
  void stk_match_list_send(Map<String, dynamic> obj) {
    //{"cmd":"C01","mpVO":{"euid":"30001,30002,30003,30004,30007,30005,30006,30008,30009,30010,30011","sort":1,"orpt":-1,"cpn":1,"cps":5000,"lang":"en"}}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C01;
    // cmd_obj.cmd = obj.cmd;
    if (obj['mpVO'] != null) {
      cmd_obj['mpVO'] = obj['mpVO'];
    } else if (obj['empVO'] != null) { // 电竞赛事订阅
      cmd_obj['empVO'] = obj['empVO'];
    }
    sendMsg(cmd_obj);
  }

  /// @Description:联赛订阅指令
  /// @param: obj 数据体
  /// @return:
  void skt_league_list_send(Map<String, dynamic> obj) {
    //{"cmd":"C9","tid":"821456,588955"}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C9;
    cmd_obj['tid'] = obj['tid'];
    sendMsg(cmd_obj);
  }

  /// @Description:定时烟花编辑发送订阅
  /// @param: obj 数据体
  /// @return:
  void skt_fireworks_edit_send(Map<String, dynamic> obj) {
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['cmd'] = WsType.C15;
    cmd_obj['cuid'] = obj['cuid'];
    cmd_obj['requestId'] = StringKV.token.get();
    if (cmd_obj['cuid'] != null) {
      sendMsg(cmd_obj);
    }
  }


  /// @Description:取消订阅指令
  /// @param: obj 数据体
  /// @return: C8
  void skt_cancel_send(String cmd) {
    // {cmd: "xxx"}
    Map<String, dynamic> cmd_obj = {};
    cmd_obj['key'] = 'clear';
    cmd_obj['cmd'] = cmd;
    sendMsg(cmd_obj);
  }
}