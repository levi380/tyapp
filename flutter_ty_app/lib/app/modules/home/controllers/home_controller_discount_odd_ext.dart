import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/ws/ws_type.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';

import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-2bb81bd0-39de-4ec2-bb5c-ea27b888e48c-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表ws监听 】】】
    【【【 AUTO_DOCUMENT_TITLE 首页列表ws监听-业务逻辑 】】】
    【【【 AUTO_PARAGRAPH_TITLE 扩展类 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
     - 首页ws推送监听
     ```
    addListenerDiscountOdd() {
      ///优惠盘口开关推送 商户级别
    Bus.getInstance().on(EventType.RCMD_C109, (wsObj) {
      // AppLogger.debug("RCMD_C109 == "+wsObj.toString());
      getAddedOddsMatches();
    });

    ///优惠盘口开关推送 系统级别
    Bus.getInstance().on(EventType.RCMD_C152, (wsObj) {
      getAddedOddsMatches();
    });

    ///优惠盘口开关推送 商户级别
    Bus.getInstance().on(EventType.init302, (wsObj) {
            ///ws 涉及赛事list
            List<String> wsList = wsObj;

            bool hasInter = hasIntersection(wsList, homeState.discountMidStringList);
            if (hasInter) {
              getAddedOddsMatches();
            }
          });

          ///优惠盘口开关推送 商户级别
          /// 删除赛事
          Bus.getInstance().on(EventType.removeMatch, (value) {
            int index = homeState.matchtDiscount
                .indexWhere((element) => element.mid == value);
            if (index >= 0) {
              homeState.matchtDiscount.removeAt(index);
              getAddedOddsMatches();
            }
          });

          ///优惠盘口开关推送 商户级别
          Bus.getInstance().on(EventType.updata_detail_data, (data) {
            Map<String, dynamic> map =
                (data as List).safeFirst as Map<String, dynamic>;
            String cmd = map['cmd'];
            switch (cmd) {
              case WsType.C104:
                Map<String, dynamic> cd = map['cd'];
                String mid = cd.get('mid') ?? '';

                if (homeState.discountMidStringList.contains(mid)) {
                  getAddedOddsMatches();
                }
                break;
            }
          });
        }
     ```
     - 移除监听
     ```
     removeListenerDiscountOdd() {
      Bus.getInstance().off(EventType.RCMD_C109);
      Bus.getInstance().off(EventType.init302);
    }
     ```
    】】】
 *
 */

extension TyHomeControllerSportExt on TyHomeController {
  addListenerDiscountOdd() {
    ///优惠盘口开关推送 商户级别
    Bus.getInstance().on(EventType.RCMD_C109, (wsObj) {
      getAddedOddsMatches();
    });

    ///优惠盘口开关推送 系统级别
    Bus.getInstance().on(EventType.RCMD_C152, (wsObj) {
      getAddedOddsMatches();
    });
    Bus.getInstance().on(EventType.RCMD_C153, (wsObj) {
      getAddedOddsMatches();
    });

    ///优惠盘口开关推送 商户级别
    Bus.getInstance().on(EventType.init302, (wsObj) {
      ///ws 涉及赛事list
      List<String> wsList = wsObj;

      bool hasInter = hasIntersection(wsList, homeState.discountMidStringList);
      if (hasInter) {
        getAddedOddsMatches();
      }
    });

    ///优惠盘口开关推送 商户级别
    /// 删除赛事
    Bus.getInstance().on(EventType.removeMatch, (value) {
      int index = homeState.matchtDiscount
          .indexWhere((element) => element.mid == value);
      if (index >= 0) {
        homeState.matchtDiscount.removeAt(index);
        getAddedOddsMatches();
      }
    });

    ///优惠盘口开关推送 商户级别
    Bus.getInstance().on(EventType.updata_detail_data, (data) {
      Map<String, dynamic> map =
          (data as List).safeFirst as Map<String, dynamic>;
      String cmd = map['cmd'];
      switch (cmd) {
        case WsType.C104:
          Map<String, dynamic> cd = map['cd'];
          String mid = cd.get('mid') ?? '';

          if (homeState.discountMidStringList.contains(mid)) {
            getAddedOddsMatches();
          }
          break;
      }
    });
  }

  ///判断交集
  bool hasIntersection(List<String> list1, List<String> list2) {
    return list1.toSet().intersection(list2.toSet()).isNotEmpty;
  }

  /// 优惠盘口开关推送 商户级别
  removeListenerDiscountOdd() {
    Bus.getInstance().off(EventType.RCMD_C109);
    Bus.getInstance().off(EventType.init302);
  }
}
