import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/extension/map_extension.dart';
import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

import '../../../global/ty_user_controller.dart';
import '../../../services/api/match_api.dart';
import '../../login/login_head_import.dart';
import 'bet_order_notification_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单 注单通知 控制器 BetOrderNotificationController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单 注单通知 控制器
    - BetOrderNotificationController
    - 设置菜单 注单通知 控制器
    】】】
 *
 */


///投注成功：sn 0关闭/1打卡
///投注失败：fn 0关闭/1打开
///预约成功：rsn 0关闭/1打开
///预约失败：rfn 0 关闭/1打卡
enum OrderNotifyType {
  success('sn'), // 投注成功
  failed('fn'),  // 投注失败
  reserveSuccess('rsn'), // 预约成功
  reserveFailed('rfn');  // 预约失效
  final String key;
  const OrderNotifyType(this.key);
}
class BetOrderNotificationController extends GetxController {
  final BetOrderNotificationLogic logic = BetOrderNotificationLogic();

  ///允许通知
  bool get allowNotifications => successfulBetting || successfulBetting || theReservationOrderBetIsSuccessful || appointmentExpired;


  ///投注成功
  bool get successfulBetting => sn == '1';
  static String sn = '1';


  ///投注失败
  bool get lostBets => fn == '1';
  static String fn = '1';


  ///预约单下注成功
  bool get theReservationOrderBetIsSuccessful => rsn == '1';
  static String rsn = '1';


  ///预约失效点击次数
  bool get  appointmentExpired => rfn == '1';
  static String rfn = '1';




  @override
  void onInit() {
    // TODO: implement onInit
    getOrderNotification();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///点击按钮处理
  void onButtonPressed(int index) {
    if (logic.clickCounts[index] < logic.limit) {
      logic.clickCounts[index]++;
      /// 执行对应按钮的方法
      executeButtonAction(index);
      if (logic.clickCounts[index] == logic.limit) {
        disableButton(index);
      }
    } else {
      ToastUtils.show(LocaleKeys.app_frequentOperations.tr);
    }
    update();
  }

  ///禁用按钮
  void disableButton(int index) {
    logic.buttonEnabled[index] = false;
    Timer(logic.duration, () {
      logic.clickCounts[index] = 0;
      logic.buttonEnabled[index] = true;
    });
    update();
  }

  void executeButtonAction(int index) {
    switch (index) {
      case 0:
        ///允许通知
        onAllowNotifications();
        break;
      case 1:
        ///投注成功
        onSuccessfulBetting();
        break;
      case 2:
        ///投注失败
        onLostBets();
        break;
      case 3:
        ///预约单下注成功
        onTheReservationOrderBetIsSuccessful();
        break;
      case 4:
        ///预约失效
        onAppointmentExpired();
        break;
    }
  }


  ///允许通知
  void onAllowNotifications() {
    if(allowNotifications){
      sn =  "0";
      fn =  "0";
      rsn =  "0";
      rfn =  "0";
    }else{
      sn =  "1";
      fn =  "1";
      rsn =  "1";
      rfn =  "1";
    }
    setOrderNotification();
    update();
  }

  ///获取开关接口
  ///投注成功：sn 0关闭/1打卡
  ///投注失败：fn 0关闭/1打开
  ///预约成功：rsn 0关闭/1打开
  ///预约失败：rfn 0 关闭/1打卡
  Future<void> getOrderNotification() async {
    final res = await MatchApi.instance()
        .getUserPersonaliseNew(OrderNotifyType.values.map((e) => e.key).toList(), TYUserController.to.getUid());
    Map<String, dynamic> map = res.data ?? {};
    if (map.keys.length != 0 && map.get("userParams") != null) {
      Map<String, dynamic> userParams = map["userParams"];
       sn = userParams.get(OrderNotifyType.success.key) ?? "";
       fn = userParams.get(OrderNotifyType.failed.key) ?? "";
       rsn = userParams.get(OrderNotifyType.reserveSuccess.key) ?? "";
       rfn = userParams.get(OrderNotifyType.reserveFailed.key) ?? "";

      ///sn 0关闭/1打开
      AppLogger.debug('投注成功------' + sn.toString()+'------'+successfulBetting.toString());
      AppLogger.debug('投注失败------' + fn.toString()+'------'+lostBets.toString());
      AppLogger.debug('预约单下注成功------' + rsn.toString()+'------'+theReservationOrderBetIsSuccessful.toString());
      AppLogger.debug('预约失效------' + rfn.toString()+'------'+appointmentExpired.toString());
    };
    update();
  }

  ///投注成功接口更新
  Future<void> setOrderNotification() async {
    final res = await MatchApi.instance().setUserTimeZonePersonaliseNew(TYUserController.to.getUid(),
        {OrderNotifyType.success.key: sn,
          OrderNotifyType.failed.key: fn,
          OrderNotifyType.reserveSuccess.key: rsn,
          OrderNotifyType.reserveFailed.key: rfn});
    AppLogger.debug(res.toString());
    getOrderNotification();
    update();
  }

  void initSwitch() {

    update();
  }

  ///投注成功
  void onSuccessfulBetting() {
    // ToastUtils.show('投注成功------' + successfulBetting.toString());
    sn = successfulBetting == false ? '1' : '0';
    setOrderNotification();
    update();
  }

  ///投注失败
  void onLostBets() {
    // ToastUtils.show('投注失败------' + lostBets.toString());
    fn = lostBets == false ? '1' : '0';
    setOrderNotification();
    update();
  }



  ///预约单下注成功
  void onTheReservationOrderBetIsSuccessful() {
    // ToastUtils.show('预约单下注成功------' + theReservationOrderBetIsSuccessful.toString());
    rsn = theReservationOrderBetIsSuccessful == false ? '1' : '0';
    setOrderNotification();
    update();
  }


  ///预约失效
  void onAppointmentExpired() {
    // ToastUtils.show('预约失效------' + appointmentExpired.toString());
    rfn = appointmentExpired == false ? '1' : '0';
    setOrderNotification();
    update();
  }
}
