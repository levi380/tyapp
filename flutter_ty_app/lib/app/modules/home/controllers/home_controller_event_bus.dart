import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';
import 'package:flutter_ty_app/app/global/data_store_controller.dart';
import 'package:flutter_ty_app/app/global/data_store_operate/data_store_handle/data_store_handle.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/home/controllers/home_controller_ext_s.dart';

import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/utils/easy_debounce_throttle/easy_throttle.dart';


import '../../../utils/bus/bus.dart';
import '../../../utils/bus/event_enum.dart';
import '../../login/login_head_import.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-2bb81bd0-39de-4ec2-bb5c-ea27b888e48c-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 体育首页赛事功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  体育首页赛事EventBus管理扩展 】】】
    【【【 AUTO_PARAGRAPH_TITLE 首页EventBus管理 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 首页赛事EventBus管理，包含赛事更新、赛事删除、赔率更新等。
    ```
    handleEventBus() {
    /// 切换联赛
    Bus.getInstance().on(EventType.changeLang, (value) {
      changeLanguage();
    });

    // C11赛事列表 可视化范围内的赛事更新
    Bus.getInstance().on(EventType.RCMD_C11, (value) {
      _updateByMidList([value]);
    });

    /// 删除赛事
    Bus.getInstance().on(EventType.removeMatch, (value) {
      int index =
          homeState.matchtSet.indexWhere((element) => element.mid == value);
      if (index >= 0) {
        homeState.matchtSet.removeAt(index);
        if (visiable && !homeState.isSearch) {
          EasyThrottle.throttle('remove_match', Duration(milliseconds: 1000),
              () {
            handleData(true);
          });
        }
      }
    });

    /// 单枪水差 更新可视化范围的赛事赔率
    Bus.getInstance().on(EventType.send_bat_handicap_odds, (value) {
      EasyThrottle.throttle(
          'send_bat_handicap_odds', Duration(milliseconds: 1000), () {
        refreshData();
      });
    });

    /// C109增加赛事
    Bus.getInstance().on(EventType.RCMD_C109, (value) {
      ///进入详情 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true) return;
      List maps =
          JsonUtil.getObjectList(value, (v) => v as Map<String, dynamic>) ?? [];
      List<String> csids = [];
      for (var map in maps) {
        String csid = map['csid'];
        csids.add(csid);
      }
      bool contain = homeState.matchtSet
              .indexWhere((element) => csids.contains(element.csid)) >=
          0;
      if (contain && visiable && !homeState.isSearch) {
        EasyThrottle.throttle('add_match', Duration(milliseconds: 1000), () {
          fetchData(isWsFetch: true);
        });
      }
    });

    /// 赛事玩法级变更
    Bus.getInstance().on(EventType.socketOddinfo, (value) async {
      // List<String> mid = value DataStoreController.to.showMatchIdList.
      if (visiable && !homeState.isSearch && !homeState.endScroll) {
        _updateByMidList(value);
      }
    });

    /// 赛事开赛状态/新增玩法盘口通知
    Bus.getInstance().on(EventType.init302, (value) {
      ///进入详情 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true) return;
      bool contain = DataStoreController.to.showMatchIdList
              .indexWhere((element) => value.contains(element)) >=
          0;
      contain = true;
      if (visiable && !homeState.isSearch && contain && !homeState.endScroll) {
        _updateByMidList(value);

        /// 列表更新排序
        handleData(true);
      }
    });

    /// 未开赛到开赛
    Bus.getInstance().on(EventType.RCMD_C101, (value) async {
      ///进入详情 列表接口需要屏蔽
      if (DataStoreController.to.isEnterDatail == true) return;
      Map<String, dynamic> map = (value as List).safeFirst;
      String? mid = map['cd']['mid'];
      int? ms = map['cd']['ms'];
      int? oldMs = map['oldMs'];

      if (mid == null || ms == null) return;

      /// ms 从0到1要拉数据
      if (oldMs == 0 && ms == 1 && visiable && !homeState.isSearch) {
        final res = await MatchApi.instance().getMatchBaseInfo(
            mid,
            TYUserController.to.getUid(),
            homeState.matchListReq.sort,
            homeState.matchListReq.euid,
            homeState.matchListReq.device ?? 'v2_h5_st',
            null,
            null,
            null,
            []);
        if (res.success && ObjectUtil.isNotEmpty(res.data)) {
          for (var element in res.data!) {
            DataStoreController.to
                .updateMatch(element, keepSecondary: true, ishomebyMyId: true);
          }

          /// 列表更新排序
          handleData(true);
        }
      }
    });

    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      if (Get.isRegistered<TYUserController>()) {
        // 增加赔率类型
        String curOdd = TYUserController.to.curOdds;
        if (!['EU', 'HK'].contains(curOdd)) {
          fetchData(isWsFetch: true);
        }
      }
      update();
    });
  }

  ///去掉推送监听
  removeBus() {
    Bus.getInstance().off(EventType.changeLang);
    Bus.getInstance().off(EventType.changeOddType);
    Bus.getInstance().off(EventType.removeMatch);
    Bus.getInstance().off(EventType.RCMD_C109);
    Bus.getInstance().off(EventType.socketOddinfo);
    Bus.getInstance().off(EventType.init302);
    Bus.getInstance().off(EventType.RCMD_C101);
  }

  cancelTimerUpdate() {
    homeState.timerForMatchById?.cancel();
    homeState.timerForMatchById = null;
  }

  /// 轮训更新赛事
  timerUpdateMathcOdds() {
    homeState.timerForMatchById?.cancel();
    homeState.timerForMatchById = null;
    if (!homeState.endScroll || !visiable) {
      return;
    }

    homeState.timerForMatchById =
        Timer.periodic(const Duration(seconds: 120), (timer) {
      refreshData();
    });
  }

  Future<void> _updateByMidList(List<String> mids) async {
    List<String> targetMids = mids
        .where((element) =>
            DataStoreController.to.showMatchIdList.contains(element))
        .toList();
    if (targetMids.isNotEmpty) {
      try {
        final res = await MatchApi.instance().getMatchBaseInfo(
            mids.join(','),
            TYUserController.to.getUid(),
            homeState.matchListReq.sort,
            homeState.matchListReq.euid,
            homeState.matchListReq.device ?? 'v2_h5_st',
            null,
            null,
            null,

            []);
        if (res.success && ObjectUtil.isNotEmpty(res.data)) {
          for (var element in res.data!) {
            DataStoreController.to
                .updateMatch(element, keepSecondary: true, ishomebyMyId: true);
          }
        }
      } catch (e) {}
    }
  }
    ```
    】】】
 *
 */

extension TyHomeControllerEventBus on TyHomeController {

  /// 统一处理进入详情页的判断，避免重复代码
  bool get _isEnteringDetail => DataStoreController.to.isEnterDatail == true;
  /// 统一处理数据列表是否为空的判断
  bool _isMatchListEmpty() => homeState.matchtSet.isEmpty;


  handleEventBus() {
    Bus.getInstance().on(EventType.scrollToTop, (value) {
      try {
        if (commonScrollController.hasClients) {
          commonScrollController.animateTo(0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut);
        }
      } catch (e) {}
    });

    /// 切换联赛
    Bus.getInstance().on(EventType.changeLang, (value) {
      changeLanguage();
    });

    // C11赛事列表 可视化范围内的赛事更新
    Bus.getInstance().on(EventType.RCMD_C11, (value) {
      _updateByMidList([value]);
    });

    /// 删除赛事
    Bus.getInstance().on(EventType.removeMatch, (value) {
      if (value is String) { // 确保 value 是 String 类型
        int index = homeState.matchtSet.indexWhere((element) => element.mid == value);
        if (index >= 0) {
          homeState.matchtSet.removeAt(index);
          // 只有在非搜索状态且可见时才重新处理数据，且列表非空
          if (!_isMatchListEmpty() && visiable && !homeState.isSearch) {
            EasyThrottle.throttle('remove_match', const Duration(milliseconds: 1000), () {
              handleData(true);
            });
          }
        }
      } else {
        AppLogger.debug("EventType.removeMatch 错误 value: $value");
      }
    });

    /// 单枪水差 更新可视化范围的赛事赔率
    Bus.getInstance().on(EventType.send_bat_handicap_odds, (value) {
      EasyThrottle.throttle(
          'send_bat_handicap_odds', Duration(milliseconds: 1000), () {
        refreshData();
      });
    });

    /// C109增加赛事
    Bus.getInstance().on(EventType.RCMD_C109, (value) {
      ///进入详情 列表接口需要屏蔽
      if (_isEnteringDetail) return;
      List maps =
          JsonUtil.getObjectList(value, (v) => v as Map<String, dynamic>) ?? [];
      List<String> csids = [];
      for (var map in maps) {
        String csid = map['csid'];
        csids.add(csid);
      }
      bool contain = homeState.matchtSet
              .indexWhere((element) => csids.contains(element.csid)) >=
          0;
      if (contain && visiable && !homeState.isSearch) {
        EasyThrottle.throttle('add_match', Duration(milliseconds: 1000), () {
          fetchData(isWsFetch: true);
        });
      }
    });

    /// 赛事玩法级变更
    Bus.getInstance().on(EventType.socketOddinfo, (value) async {
      // List<String> mid = value DataStoreController.to.showMatchIdList.
      if (value is List<String>) {
        if (visiable && !homeState.isSearch && !homeState.endScroll) {
          _updateByMidList(value);
        }
      } else {
        AppLogger.debug("EventType.socketOddinfo 错误 value: $value");
      }
    });

    /// 赛事开赛状态/新增玩法盘口通知
    Bus.getInstance().on(EventType.init302, (value) {
      /// 如果在详情页，直接返回
      if (_isEnteringDetail) return;
      // 确保 value 是 List<String> 类型
      if (value is List<String>) {
        // 判断当前可见的比赛列表中是否包含任何一个 value 中的 mid
        final bool containsVisibleMatch = DataStoreController.to.showMatchIdList.any((element) => value.contains(element));

        if (visiable && !homeState.isSearch && containsVisibleMatch && !homeState.endScroll) {
          _updateByMidList(value);
          // 列表更新排序，如果 _updateByMidList 已经包含了 update，这里可以考虑合并
          handleData(true);
        }
      } else {
        AppLogger.debug("Home EventType.init302 错误 value: $value");
      }
    });

    /// 未开赛到开赛
    Bus.getInstance().on(EventType.RCMD_C101, (value) async {
      ///进入详情 列表接口需要屏蔽
      if (_isEnteringDetail) return;
      Map<String, dynamic> map = (value as List).safeFirst;
      String? mid = map['cd']['mid'];
      int? ms = map['cd']['ms'];
      int? oldMs = map['oldMs'];

      if (mid == null || ms == null) return;

      /// ms 从0到1要拉数据
      if (oldMs == 0 && ms == 1 && visiable && !homeState.isSearch) {
        final res = await MatchApi.instance().getMatchBaseInfo(
            mid,
            TYUserController.to.getUid(),
            homeState.matchListReq.sort,
            homeState.matchListReq.euid,
            homeState.matchListReq.device ?? 'v2_h5_st',
            null,
            null,
            null,
            /*       "0",
          null,
          0,*/
            null,
            []);
        if (res.success && ObjectUtil.isNotEmpty(res.data)) {
          AppLogger.debug(res.data!.first.kySwitch.toString());
          for (var element in res.data!) {
            DataStoreController.to
                .updateMatch(element, keepSecondary: true, ishomebyMyId: true);
            // MatchEntity match = element;
            // if(isMap(match.kySwitch)){
            //   Map<String, dynamic> kyswitch = Map<String, dynamic>.from(match.kySwitch);
            //   match.kySwitch = KySwitch.fromJson(kyswitch);
            // }else{
            //   match.kySwitch = null;
            // }
            // DataStoreController.to
            //     .updateMatch(match, keepSecondary: true, ishomebyMyId: true);
          }

          /// 列表更新排序
          handleData(true);
        }
      }
    });

    // 盘口设置
    Bus.getInstance().on(EventType.changeOddType, (_) {
      if (Get.isRegistered<TYUserController>()) {
        // 增加赔率类型
        String curOdd = TYUserController.to.curOdds;
        if (!['EU', 'HK'].contains(curOdd)) {
          fetchData(isWsFetch: true);
        }
      }
      update();
    });
  }

  ///去掉推送监听
  removeBus() {
    Bus.getInstance().off(EventType.leagueSearchContent);
    Bus.getInstance().off(EventType.changeLang);
    Bus.getInstance().off(EventType.changeOddType);
    Bus.getInstance().off(EventType.removeMatch);
    Bus.getInstance().off(EventType.RCMD_C109);
    Bus.getInstance().off(EventType.socketOddinfo);
    Bus.getInstance().off(EventType.init302);
    Bus.getInstance().off(EventType.RCMD_C101);
  }

  cancelTimerUpdate() {
    homeState.timerForMatchById?.cancel();
    homeState.timerForMatchById = null;
  }

  /// 轮训更新赛事
  timerUpdateMathcOdds() {
    homeState.timerForMatchById?.cancel();
    homeState.timerForMatchById = null;
    if (!homeState.endScroll || !visiable) {
      return;
    }

    homeState.timerForMatchById =
        Timer.periodic(const Duration(seconds: 20), (timer) {
      refreshData();
    });
  }

  Future<void> _updateByMidList(List<String> mids) async {
    // if(homeState.isSearch)return;
    List<String> targetMids = mids
        .where((element) =>
            DataStoreController.to.showMatchIdList.contains(element))
        .toList();
    if (targetMids.isNotEmpty) {
      try {
        final res = await MatchApi.instance().getMatchBaseInfo(
            mids.join(','),
            TYUserController.to.getUid(),
            homeState.matchListReq.sort,
            homeState.matchListReq.euid,
            homeState.matchListReq.device ?? 'v2_h5_st',
            null,
            null,
            null,
            /*       "0",
            null,
            0,*/
            null,
            []);
        if (res.success && ObjectUtil.isNotEmpty(res.data)) {
          AppLogger.debug(res.data!.first.kySwitch.toString());
          ///次要玩法的插入
          for (var element in res.data!) {
            DataStoreController.to
                .updateMatch(element, keepSecondary: true, ishomebyMyId: true);
            // MatchEntity match = element;
            // if(isMap(match.kySwitch)){
            //   Map<String, dynamic> kyswitch = Map<String, dynamic>.from(match.kySwitch);
            //   match.kySwitch = KySwitch.fromJson(kyswitch);
            // }else{
            //   match.kySwitch = null;
            // }
            // DataStoreController.to
            //     .updateMatch(match, keepSecondary: true, ishomebyMyId: true);
          }
        }
      } catch (e) {}
    }
  }
}
