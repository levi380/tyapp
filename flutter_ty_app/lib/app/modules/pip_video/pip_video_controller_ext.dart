import 'package:flutter_ty_app/app/modules/pip_video/pip_video_controller.dart';

import '../../extension/map_extension.dart';
import '../../extension/num_extension.dart';
import '../../global/ws/ws_type.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import '../../utils/debounce_throttle.dart';
import '../../utils/sport.dart';
import '../home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import '../home/controllers/home_controller_ext.dart';
import '../match_detail/models/header_type_enum.dart';

extension PipVideoControllerExt on PipVideoController {
  /// 处理ws指令 与返回来的数据
  /// `ms` 赛事状态 0:未开赛 1:赛事进行中  2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
  ///  `mmp` 赛事阶段
  ///  赛事结束标志 mmp=999 || ms = "比赛结束"  mhs=2 关盘 移除赛事
  ///  `mhs` 赛事级别盘口状态（0:active 开盘, 1:suspended 封盘, 2:deactivated 关盘 ,11:锁盘状态）
  ///  c303  拉取所有数据
  ///  "C101","C102","C104","C109","C302","C303"
  ///  "C102"  获取玩法集 获取盘口信息
  ///  "C109"  获取玩法集 获取盘口信息
  ///  "C112"  获取玩法集 获取盘口信息
  ///  "C303"  获取盘口信息 新增玩法/新增盘口/主主盘变更
  initBus() {
    var fetchMatchDetailThrottle = throttle(() {
      fetchMatchDetailData();
    }, const Duration(milliseconds: 1500));

    //C101, C102, C103, C104, C107
    Bus.getInstance().on(EventType.updata_detail_data, (data) {
      Map<String, dynamic> map =
          (data as List).safeFirst as Map<String, dynamic>;
      String cmd = map['cmd'];

      if (!filterDifferentMatch(data)) {
        return;
      }

      switch (cmd) {
        case WsType.C101:
          // >>>>C101 赛事状态
          // {
          //     "cd": {
          //         "mid": "639633",
          //         "ms": 3
          //     },
          //     "cmd": "C101",
          //     "ctsp": "1580714665510"
          // }
          Map<String, dynamic> cd = map['cd'];
          int ms = int.tryParse(cd['ms'].toString()) ?? -1;
          int oldMs = int.tryParse(cd['oldMs'].toString()) ?? -1;
          // 监听赛事状态ms的值，0:未开赛 1:滚球阶段 2:暂停 3:结束 4:关闭 5:取消 6:比赛放弃 7:延迟 8:未知 9:延期 10:比赛中断 110:即将开赛
          List<int> arrMs = [
            SportData.sportMs_0,
            SportData.sportMs_1,
            SportData.sportMs_2,
            SportData.sportMs_7,
            SportData.sportMs_10,
            SportData.sportMs_110
          ];
          // debugPrint("赛事状态变化");
          debugPrint(ms.toString());
          if (!arrMs.contains(ms)) {
            // debugPrint("赛事状态变化ms$ms");
            TyHomeController.to.closePipVideo();
          }
          // 赛事状态为 0:未开赛 1:滚球阶段 2:暂停 7:延迟 10:比赛中断 110:即将开赛 时更新玩法集
          else {
            // ms变更时才调用
            if (ms != oldMs) {
              // 重新调用 赛事详情页面接口(/v1/m/matchDetail/getMatchDetailPB)
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                fetchMatchDetailData();
              });
            }
          }
          break;
        case WsType.C102:
          // RCMD_C102(map['cd']);
          Map<String, dynamic> cd = map['cd'];
          String mmp  = cd.get('mmp').toString();
          debugPrint("赛事状态变化mmp$mmp");
          if (cd.get('mmp').toString() == "999") {
            //切换赛事
            // debugPrint("赛事状态变化mmp999");
            TyHomeController.to.closePipVideo();
          } else {}
          break;
        default:
          break;
      }
    });

    // C11事件 拉取http接口更新
    Bus.getInstance().on(EventType.RCMD_C11, (value) {
      if (value.toString() == state.match?.mid) {
        fetchMatchDetailThrottle();
      }
    });
  }

  /// 过滤赛事
  bool filterDifferentMatch(data) {
    Map<String, dynamic> map = (data as List).safeFirst as Map<String, dynamic>;
    // String cmd = map['cmd'];
    try {
      Map<String, dynamic> cd = map['cd'] as Map<String, dynamic>;
      if (cd.get('mid') == state.match?.mid) {
        return true;
      }
    } catch (e) {
      List<dynamic> cd = map['cd'] as List<dynamic>;
      bool find = false;
      for (var element in cd) {
        String mId = element['mid'];
        if (mId == state.match?.mid) {
          find = true;
        }
      }
      return find;
    }
    return false;
  }

  void handleEvent(EventType eventType) {
    if (eventType == EventType.changeLang) {
      fetchMatchDetailData();

      if (state.headerType == HeaderType.animate) {
        loadAnimation();
      }
      if (state.headerType == HeaderType.live) {
        loadVideo();
      }
      update();
    }
  }
}
