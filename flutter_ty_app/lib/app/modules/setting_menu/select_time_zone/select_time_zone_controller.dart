import 'package:flutter/scheduler.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/services/api/match_api.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/app/utils/time_zone/timeZoneUtils.dart';
import 'package:flutter_ty_app/generated/locales.g.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../setting_menu_controller.dart';
import 'select_time_zone_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-92b5c1c1-aea9-4179-92a5-95a0e2cbaa93-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 时区】】】
    【【【 AUTO_PARAGRAPH_TITLE 时区 控制器 SelectTimeZoneController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 时区 控制器 SelectTimeZoneController
    - SelectTimeZoneController
    ```
    拉取用户时区信息接口
    getUserPersonaliseNew()
    int zoneIndex = TimeZoneUtils.timeZone.values.toList().indexOf(timeZone);
    设置用户时区 如果app启动 公共接口 getUserPersonaliseNew  未获取到用户时区 默认为上一次存储时区
    if(zoneIndex != -1){
    TimeZoneUtils.zoneIndex = TimeZoneUtils.timeZone.keys.toList()[zoneIndex] ;
    }
    储存一份时区到本地 做持久化存储
    IntKV.timeZone.save(TimeZoneUtils.zoneIndex);

    ```
    - 用户修改时区信息
    ```
    setUserPersonaliseNew
    储存一份时区到本地
    IntKV.timeZone.save(TimeZoneUtils.zoneIndex);
    下次进入页面不用加载loading
    TimeZoneUtils.needReload = false;
    update();
    通过语言改变 进行全局通知
    Bus.getInstance().emit(EventType.changeLang);
    ```
    】】】
 *
 */

class SelectTimeZoneController extends GetxController {
  final SelectTimeZonelogic logic = SelectTimeZonelogic();

  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController = ListObserverController(controller: autoScrollController);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(TimeZoneUtils.needReload){
      getUserPersonaliseNew();
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      listObserverController.animateTo(
        index:  TimeZoneUtils.zoneIndex-1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }



  /// 拉取用户时区信息
  Future<void> getUserPersonaliseNew() async {
    try {
      final res =  await  MatchApi.instance()
          .getUserPersonaliseNew([ConfigNotifyType.timezone.key], TYUserController.to.getUid());
      Map<String,dynamic> map= res.data ?? {};
      if(map.keys.length != 0 &&  map.get("userParams") != null )
      {
        Map<String,dynamic> timeZoneMap = map["userParams"];
        String timeZone = timeZoneMap.get(ConfigNotifyType.timezone.key) ?? "";
        int zoneIndex = TimeZoneUtils.timeZone.values.toList().indexOf(timeZone);
        ///设置用户时区
        if(zoneIndex != -1){
          TimeZoneUtils.zoneIndex = TimeZoneUtils.timeZone.keys.toList()[zoneIndex] ;
        }
        ///储存一份时区到本地
        IntKV.timeZone.save(TimeZoneUtils.zoneIndex);

        TimeZoneUtils.needReload = false;

        update();
      }
      ;
    } catch (e) {
      TimeZoneUtils.needReload = false;
      update();
      AppLogger.debug("请求失败 ${e.toString()}");
    }
  }

  /// 用户修改时区信息
  Future<void> setUserPersonaliseNew(int index) async {
    int oldZoneIndex = TimeZoneUtils.zoneIndex;
    TimeZoneUtils.zoneIndex = TimeZoneUtils.timeZone.keys.toList()[index];
    update();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      TimeZoneUtils.needReload = true;
    });
    try {
      final res =  await  MatchApi.instance()
          .setUserTimeZonePersonaliseNew( TYUserController.to.getUid(),{ConfigNotifyType.timezone.key:TimeZoneUtils.timeZone[TimeZoneUtils.zoneIndex]});
      if(res.data == null){
        resetIndex(oldZoneIndex);
        return;
      }
      ///储存一份时区到本地
      IntKV.timeZone.save(TimeZoneUtils.zoneIndex);
      TimeZoneUtils.needReload = false;
      update();
      Bus.getInstance().emit(EventType.changeLang);
      Get.back(result: "closeSetting");
      // AppLogger.debug('set setUserPersonaliseNew ${res.toString()}');
    } catch (e) {
      resetIndex(oldZoneIndex);
    }
  }


  onSelect(int index) {
    /// 用户修改时区信息
    setUserPersonaliseNew(index);

  }

  resetIndex(int oldZoneIndex){
    TimeZoneUtils.needReload = false;
    TimeZoneUtils.zoneIndex = oldZoneIndex;
    update();
    ToastUtils.showGrayBackground(LocaleKeys.app_edit_fail.tr);
  }


}
