import 'dart:math';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handle_cmd.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/ws_handle/ws_handlle_cmd_ext.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';

///********************* 频发调接口的 *********************///
//// "C109","C302","C303" C112
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-0ec8f16e-40c1-4a07-b095-479208cdd3f0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU ws推送 】】】
    【【【 AUTO_DOCUMENT_TITLE  WS集中处理执行类 】】】
    【【【 AUTO_PARAGRAPH_TITLE WS集中处理执行类入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - cmd中转站 推送过来的指令处理
    ```
    cmd消息中转站
    initBus()
    ```
    - 需要在ws阶段操作数据仓库的方法体
    功能页面处理ws数据的推送中转站
    ```
    cmd集中处理类
    MatchDataBaseWSEx
    ```
    】】】
 *
 */
class MatchDataBaseWS {
  EventBus? eventBus;

  ///记录赛事id
  Map<String, dynamic> midsMap = {};
  String nameCode = '';
  String type = '';
  bool isDestroyed = false;
  DataStoreController? _dataStoreController;

  DataStoreController get dataStoreController {
    _dataStoreController ??= DataStoreController.to;
    return _dataStoreController!;
  }

  ///延时器
  Timer? microTimer;
  var currentType;
  var wsObj;
  ///hpidArr范围之外的玩法不过滤
  ///指定过滤的hpid
  List hpidArr = [
    '2',
    '4',
    '5',
    '10',
    '11',
    '12',
    '15',
    '18',
    '19',
    '24',
    '26',
    '33',
    '34',
    '42',
    '43',
    '75',
    '76',
    '77',
    '78',
    '79',
    '80',
    '81',
    '82',
    '83',
    '84',
    '86',
    '87',
    '88',
    '89',
    '90',
    '91',
    '92',
    '93',
    '94',
    '96',
    '97',
    '98',
    '99',
    '100',
    '109',
    '110',
    '135',
    '136',
    '142',
    '143',
    '336',
    '352',
    '373',
    '374',
    '375',
    '376',
    '377',
    '378',
    '381',
    '382',
    '393',
    '113',
    '114',
    '115',
    '116',
    '118',
    '121',
    '122',
    '123',
    '124',
    '229',
    '232',
    '233',
    '306',
    '307',
    '308',
    '309',
    '312',
    '313',
    '314',
    '315',
    '316',
    '317',
    '371',
    '372',
    '240',
    '334',
    '335',
    '127',
    '128',
    '130',
    '234',
    '330',
    '332',
    '144',
    '331'
  ];

  ///101 102 103 104 106  201 203 901
  initBus() {
    ///if (wsTimer != null) {
    ///  wsTimer?.cancel();
    ///  wsTimer = null;
    ///}
    ///wsTimer = Timer.periodic(const Duration(milliseconds: 1500), (t) {
    ///  scmdC8();
    ///});
    ///C8订阅后 下面cmd 是可接收
    ////C101,C102,C103,C105,C107,C110,C113,C114,C115,C303,C304,C305,C801
    Bus.getInstance().wsReceive<WsType>().listen((event) {
      ///dataStoreController = dataStoreController.dataState;
      ///"cd":{"cmec":"match_status","cmes":0,"csid":"8","mat":"away","mct":"0","mess":"1","mid":"
      ///3263011","mmp":"999"},"cmd":"C102","ctsp":"1709636840763",
      ///"ld":"B02_0af5158e202403051907156855ec1f6a"}
      ///
      /// 添加紧急开关推送测试

      microtaskCmd(event.type, event.data);

      ///关盘通知 统一处理
      removeMatch(event.type, event.data);
      // AppLogger.debug("=========================>收到event通知  ${event.data}");
      switch (event.type) {
        case WsType.C101:
          C101(event.data);
          break;

        ///赛事事件
        case WsType.C102:
          C102(event.data);
          break;
        case WsType.C103:
          C103(event.data);
          break;

        ///赛事级别盘口状态
        case WsType.C104:
          C104(event.data);
          break;

        ///105盘口状态、赔率  106注单订阅盘口状态、赔率
        case WsType.C105:
          C105(event.data);
          break;
        case WsType.C106:
          C106(event.data);
          break;

        case WsType.C107:
          C107(event.data);
          break;
        case WsType.C108:
          C108(event.data);
          break;

        ///自行处理
        case WsType.C109:
          C109(event.data);
          break;

        ///赛事订阅C1-玩法数量（C110）
        case WsType.C110:
          C110(event.data);
          break;

        ///赔率相关刷新通知
        case WsType.C11:
          C11(event.data);
          break;

        ///接收定时烟花（订阅cmd:C15 接收：C151）
        case WsType.C151:
          C151(event.data);
          break;

        ///玩法集变更
        case WsType.C112:
          C112(event.data);
          break;
        ///赛事进球事件
        case WsType.C115:
          C115(event.data);
          break;
        ///优惠盘口ws开关推送
        case WsType.C152:
          C152(event.data);
          break;
        ///玩法集变更
        case WsType.C120:
          C120(event.data);
          break;

        ////订单状态 注单结算
        case WsType.C201:

          ///注单处理逻辑
          C201(event.data);
          break;
        case WsType.C202:

          ///注单处理逻辑
          C202(event.data);
          break;
        case WsType.C203:

          ///用户账变
          C203(event.data);
          break;
        case WsType.C209:
          C209(event.data);
          break;
        case WsType.C210:
          ////赛事提前结算状态变化
          C210(event.data);
          break;
        case WsType.C211:
          ////赛事提前结算状态变化
          C211(event.data);
          break;

        ////赛事状态发现变更  ms
        case WsType.C301:
          C301(event.data);
          break;

        ////赛事状态发现变更  ms
        case WsType.C302:
          C302(event.data);
          break;
        case WsType.C303:
          C303(event.data);
          break;
        case WsType.C304:

          ///废除
          // C304(event.data);
          break;
        case WsType.C501:
          C501(event.data);
          break;
        case WsType.C701:
          C701(event.data);
          break;

        case WsType.C801:
          C801(event.data);
          break;
        case WsType.C901:
          C901(event.data);
          break;
        case WsType.C1021:
          C1021(event.data);
          break;
      ///赛事分析  走势图ws 订阅C14
        case WsType.C1041:
          C1041(event.data);
          break;
        case WsType.C3011:
          C3011(event.data);
          break;
        default:
          break;
      }
    });
    initTimer();
  }

  ///添加任务执行--- 添加合并延迟推送
  initTimer() {
    microTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      ///添加任务执行--- 添加合并延迟推送
      microtaskSend();

      ///if (timer.tick >= 1500) {
      ///  timer.cancel();
      ///}
    });
  }

  ///微任务队列
  /// "C109","C302","C303" C112
  /// 301
  microtaskCmd(String cmd, wsObj) {
    ///{"cd":{"csid":"1","hpid":"10","mid":"3286676"},
    ///"cmd":"C303","ctsp":"1710240227003","ld":"AO_0af5159020240312184345880657e15e_1"}
    ///{
    ///  'C109':[
    ///    {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    ///    {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    ///    {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    ///    {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    ///    {"csid":"1","hs":0,"mid":"3288756","ms":"1"},
    ///  ]
    ///};

    final cdObj = wsObj['cd'];
    if ([WsType.C302, WsType.C303, WsType.C112].contains(cmd)) {
      String mid = cdObj['mid'] ?? '';
      if (mid.isNotEmpty) {
        if (midsMap.keys.contains(cmd)) {
          List midsList = midsMap[cmd];
          midsList.add(mid);
        } else {
          ///C303 302  合并成1个  C302
          if (cmd == WsType.C303) {
            if (midsMap.keys.contains(WsType.C302)) {
              List midsList = midsMap[WsType.C302];
              midsList.add(mid);
            } else {
              midsMap[WsType.C302] = [mid];
            }
          } else {
            midsMap[cmd] = [mid];
          }
        }
      }
    } else if ([WsType.C109, WsType.C301].contains(cmd)) {
      List cd = cdObj ?? [];
      if (cd.isNotEmpty) {
        if (midsMap.keys.contains(cmd)) {
          List cdObjList = midsMap[cmd];
          cdObjList.addAll(cd);
        } else {
          midsMap[cmd] = cd;
        }
      }
    }

    else if ([WsType.C152].contains(cmd)) {

      midsMap[cmd] = [];
    }
  }

  ///异步发送
  microtaskSend() {
    if (midsMap.keys.isNotEmpty) {
      ///if (kDebugMode) {
      ///  AppLogger.debug('推送时间间隔------》${DateTime.now()}');
      ///}

      Future(() {
        if (Get.currentRoute == Routes.matchDetail) {
          if (midsMap.keys.contains(WsType.C109) &&
              midsMap.keys.contains(WsType.C302)) {
            midsMap.remove(WsType.C302);
          }
        }
        midsMap.keys.forEach((element) {
          if (element == WsType.C109) {
            List cdObjList = midsMap[WsType.C109];

            ///列表相关 刷新接口
            Bus.getInstance()
                .emit(EventType.RCMD_C109, cdObjList.toSet().toList());
          } else if (element == WsType.C112) {
            List midsList = midsMap[WsType.C112];
            Bus.getInstance()
                .emit(EventType.socketOddinfo, midsList.toSet().toList());
          } else if (element == WsType.C302) {
            List midsList = midsMap[WsType.C302];
            Bus.getInstance()
                .emit(EventType.init302, midsList.toSet().toList());
          } else if (element == WsType.C301) {
            List cdObjList = midsMap[WsType.C301];
            Bus.getInstance()
                .emit(EventType.RCMD_C301, cdObjList.toSet().toList());
          }else if (element == WsType.C152) {
            // List cdObjList = midsMap[WsType.C152];
          /// 优惠盘口ws 系统级别推送
            Bus.getInstance()
                .emit(EventType.RCMD_C152, []);
          }else if (element == WsType.C153) {
            // List cdObjList = midsMap[WsType.C152];
            /// 优惠盘口ws 系统级别推送
            Bus.getInstance()
                .emit(EventType.RCMD_C153, []);
          }
        });
      }).then((value) => midsMap.clear());
    }
  }

  ///判断赛事结束1
  removeMatch(String cmd, wsObj) {
    if ([WsType.C101, WsType.C102, WsType.C104, WsType.C901].contains(cmd)) {
      var mid = wsObj['cd']['mid'].toString();
      var mhs = wsObj['cd']['mhs'];
      var mmp = wsObj['cd']['mmp'];
      var ms = wsObj['cd']['ms'];
      if (ms != null) {
        ms = int.tryParse(ms.toString());
      }
      bool isClose = closeMatch(mhs: mhs, mmp: mmp, ms: ms);
      if (isClose) {
        ///赛事删除
        Bus.getInstance().emit(EventType.removeMatch, mid);
      }
    }
  }

  ///判断赛事结束2
  static bool closeMatch({dynamic mhs, dynamic mmp, dynamic ms}) {
    ///mhs 关盘状态
    List closeMhsState = [2, 11];
    bool closeForMhs = (mhs != null && closeMhsState.contains(mhs));

    //////ms 关盘状态
    ///List closeMsState = [3, 4, 5, 6, 7, 8, 9];
    ///bool closeForMs = (ms != null && closeMsState.contains(ms));
    return closeForMhs || mmp == '999';
  }

  List<T> getRandomItems<T>(List<T> list, int count) {
    Random random = Random();
    List<T> resultList = [];

    ///如果要取出的数据数量大于列表长度，则返回整个列表
    if (count >= list.length) {
      return List.from(list);
    }

    while (resultList.length < count) {
      int randomIndex = random.nextInt(list.length);

      ///生成随机索引
      T randomItem = list[randomIndex];

      ///获取随机索引对应的元素

      ///如果 resultList 中不包含当前随机元素，则添加到 resultList 中
      if (!resultList.contains(randomItem)) {
        resultList.add(randomItem);
      }
    }

    return resultList;
  }

  void destroy() {
    microTimer?.cancel();
    microTimer = null;
  }
}
