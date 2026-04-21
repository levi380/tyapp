import 'package:flutter/material.dart';

import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/db/app_cache.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/global/conif_controller_ext_s.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';



import 'package:flutter_ty_app/app/utils/toast_util.dart';
import 'package:flutter_ty_app/app/utils/ty_text_scaler.dart';
import 'package:get/get.dart';


import '../../../generated/locales.g.dart';
import '../../config/getx_navigation.dart';

import '../../global/config_controller.dart';

import '../../routes/app_pages.dart';

import '../../services/api/language_api.dart';
import '../../services/api/match_api.dart';
import '../../services/api/menu_api.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_bus.dart';
import '../../utils/bus/event_enum.dart';
import '../main_tab/main_tab_controller.dart';

import '../quick_bet/quick_bet_controller.dart';
import 'bet_order_notification/bet_order_notification_controller.dart';
import 'bet_order_notification/bet_order_notification_view.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5a7d82aa-a062-4061-ad30-cc1cd2482bdc-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 设置菜单控制器SettingMenuController】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 设置菜单控制器SettingMenuController
    - SettingMenuController
    - 包含联赛删选-投注模式-排序规则-盘口设置-主题风格-自定义快捷金额一键投注-切换语言-盘口教程-规则说明-公告中心
    - 跳转按钮处理
    ```
    ///投注模式 1新手 2专业

    int bettingMode = 2;

    ///排序规则 1热门 2时间
    int sortingRules = 1;

    ///盘口设置 1欧洲盘 2香港盘口
    int handicapSettings = 1;

    //投注按钮设置 1滑动下注 2点击下注
    int betButtonStyle = 1;

    ///主题风格 1日间 2夜间
    int themeStyle = 1;

    ///每日活动 1开启 2关闭
    int dailyActivities = 1;

    bool isDarkMode = false;

    /// 是否显示活动
    late bool showActivity = false;

    /// 是否显示联赛筛选
    late bool showMatchFilter = true;

    /// 字体大小 1 默认 2 放大
    int fontSize = 1;

    /// 投注手势 1 滑动投注  2 点击投注
    int bettingGestures = 1;

    /// 队名偏好 1 简译 2 繁译
    int teamNamePreference = 1;

    /// 当前值
    int fastBetAmount = 0;

    /// 是否开启和关闭
    bool switchOn = false;

    /// 最小投注额
    int min = 0;

    /// 最大投注额
    int max = 100000000;

    ///简译繁译加载框
    bool updateLanguage = false;

    ///商户开关 0-关，1-开 队名偏好菜单
    String languageSwitch = '0';

    ///系统级别开关 0-关，1-开 队名偏好菜单
    String languageSystemSwitch = '0';
    ```
    】】】
 *
 */

extension SettingMenuControllerExt on SettingMenuController{
  ///每日活动
  onDailyActivities(int i) {
    logic.dailyActivities = i;
    BoolKV.dailyActivities.save(i == 1 ? true : false);

    final mainTabController = Get.find<MainTabController>();
    mainTabController.initData();
    update();
  }

  ///自定义快捷金额
  onCustomBetAmount() {
    Get.toNamed(Routes.quickBetAmount);
  }

  ///一键投注
  onOneClickBetting() {
    Get.toNamed(Routes.oneClickBetting);
  }

  ///关闭
  steShutDown() {
    Get.back();
  }

  ///盘口设置
  toHandicapSettings() {
    if (checkHandicapSettings()) {
      return;
    }
    Get.toNamed(Routes.handicapSetting)?.then(
          (data) {
        if (data == "closeSetting") {
          steShutDown();
        }
      },
    );
  }

  checkHandicapSettings() {
    /// dj、冠军、串关默认欧洲盘
    return ShopCartController.to.isEuOnly();
  }

  ///选择时区
  onSelectTimeZone() {
    Get.toNamed(Routes.selectTimeZone)?.then(
          (data) {
        if (data == "closeSetting") {
          steShutDown();
        }
      },
    );
  }

  ///字体大小
  onFontSize(int size) {
    setFontSizeSet(size);
  }

  ///队名偏好  1 简译 ，2 繁译
  onTeamNamePreference(int team) async {
    ///简译繁译加载框
    // updateLanguage = true;
    int tempTeam = teamNamePreference;
    teamNamePreference = team;
    update();
    StringKV.language.save('CN');

    ///队名偏好 存储
    IntKV.teamNamePreference.save(team);
    bool result = await changeLangEffect();
    if (result) {
      String languageName = team == 1 ? 'zh' : 'hk';
      setUserLanguage(languageName);
      update();
    } else {
      IntKV.teamNamePreference.save(tempTeam);
      ///请求失败 就重置回上一次设置内容
      String languageName = tempTeam == 1 ? 'zh' : 'hk';
      setUserLanguage(languageName);
      update();
    }
  }

  ///队名偏好  1 简译 ，2 繁译 接口
  setUserLanguage(String languageName) async {
    String token = StringKV.token.get() ?? "";
    final res =
    await LanguageApi.instance().setUserLanguage(token, languageName);
    String code = res.code;
    if (code == "0000000") {
      print("切换简译繁译--------" + res.msg);
    }
  }

  ///通知刷新列表数据
  Future<bool> changeLangEffect() async {
    ///请求正常返回
    bool requestNomal = true;
    /// 必须等此接口成功后再切换页面
    try {
      await ConfigController.to.loadNameList(switchLanguages: true);
      Bus.getInstance().emit(EventType.changeLang);
      EventBus().fire(EventType.changeLang);
    } catch (e) {
      requestNomal = false;
    }
    ///简译繁译加载框
    logic.updateLanguage = false;
    update();
    return requestNomal;
  }

  /// 用户字体大小方法
  Future<void> setFontSizeSet(int size) async {
    ///先切换
    logic.fontSize = size;
    if (size == 1) {
      ///测试缩放因子
      TyTextScaler.instance()
          .setTextScaleFactor(TyTextScaler.defaultScaleFactor);
    } else {
      ///测试缩放因子
      TyTextScaler.instance()
          .setTextScaleFactor(TyTextScaler.biggerScaleFactor);
    }
    update();
    Get.forceAppUpdate();
    ///储存字体到本地
    BoolKV.isBiggerSize.save(size == 2 ? true : false);
    ///接口只做记录处理
    try {
      final res = await MatchApi.instance().setUserTimeZonePersonaliseNew(
          TYUserController.to.getUid(),
          {ConfigNotifyType.fontSizeSet.key: (size - 1).toString()});
      if (res.data == null) {
        //   resetSize(size);
        //   return;
      }
      // ///储存字体到本地
      // BoolKV.isBiggerSize.save(size == 2 ? true : false);
    } catch (e) {
      AppLogger.debug(e.toString());
      // resetSize(size);
    }
  }

  ///重置
  resetSize(int size) {
    ///充值设置菜单当前标识
    logic.fontSize = size == 2 ? 1 : 2;
    if (size == 1) {
      TyTextScaler.instance()
          .setTextScaleFactor(TyTextScaler.defaultScaleFactor);
    } else {
      TyTextScaler.instance()
          .setTextScaleFactor(TyTextScaler.biggerScaleFactor);
    }
    update();
    Get.forceAppUpdate();
    ToastUtils.showGrayBackground(LocaleKeys.app_edit_fail.tr);
  }

  ///一键投注
  onOneClickBettingNew() async {
    if (ShopCartController.to.isParlayMode()) {
      ToastUtils.show(LocaleKeys.bet_one_click_bet_only_single.tr);
      return;
    }

    logic.switchOn = !logic.switchOn;
    final res = await MenuApi.instance().saveUserCustomizeInfo(
      TYUserController.to.seriesList,
      TYUserController.to.singleList,
      false,
      logic.switchOn,
      textEditingController.text.isEmpty
          ? logic.fastBetAmount.toString()
          : textEditingController.text,
    );
    if (res.code == '0000000') {
      /// 开启或者关闭都清空订单
      QuickBetController.to.orderRespList.clear();
      if (logic.switchOn == true) {
        ToastUtils.customizedBetAmountSuccessful(
            '${'${LocaleKeys.bet_one_click_bet_open.tr} '}${toAmountSplit(int.parse(textEditingController.text.isEmpty ? logic.fastBetAmount.toString() : textEditingController.text).toStringAsFixed(2))}');
      }

      update();
      await getUserCustomizeInfo();
    } else {
      ToastUtils.show(res.msg);
    }
  }

  ///一键投注金额设置关闭
  onCloseVisibility() {
    print('object');
    if (ShopCartController.to.isParlayMode()) {
      ToastUtils.show(LocaleKeys.bet_one_click_bet_only_single.tr);
      return;
    }
    textEditingController.text.isEmpty
        ? textEditingController.text = logic.fastBetAmount.toString()
        : textEditingController.text;
    logic.betAmount = !logic.betAmount;
    update();
  }

  ///一键投注文本处理
  onInsertText(String myText) {
    if (textEditingController.text.startsWith('0') && myText == '0') {
      return;
    }
    if (textEditingController.text.startsWith('0') && myText == '00') {
      return;
    }
    if (textEditingController.text.contains('.') && myText == '.') {
      return;
    }
    List<String> parts = textEditingController.text.split('.');
    if (parts.length == 2 && parts[1].length == 2 && myText == '00') {
      return;
    }
    String inputText = textEditingController.text + myText;

    if (inputText.startsWith('.')) {
      textEditingController.text = '0.';
    } else {
      if (inputText.toInt() >= logic.max) {
        textEditingController.text = logic.max.toString();
      } else {
        if (!_hasTwoDecimalPlaces(inputText)) {
          textEditingController.text = inputText;
        }
      }
    }

    focusNode.requestFocus();
    update();
  }

  bool _hasTwoDecimalPlaces(String value) {
    final pattern = r'^\d+\.\d{3}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  ///一键投注最大值
  onMaxInputText() {
    textEditingController.text = logic.max.toString();
    focusNode.requestFocus();
    update();
  }

  ///一键投注数字键盘
  replaceText(String myText) {
    textEditingController.text = myText;
    update();
  }
  ///一键投注删除文本
  onBackspace() {
    if (textEditingController.text.isEmpty) {
      return;
    }
    String lastChar = textEditingController.text
        .substring(0, textEditingController.text.length - 1);
    textEditingController.text = lastChar;
    focusNode.requestFocus();
    update();
  }
  ///一键投注金额设置确认
  onOK() async {
    if ((int.tryParse(textEditingController.text) ?? 0) <= logic.min) {
      textEditingController.text = logic.min.toString();
    }
    logic.betAmount = false;
    final res = await MenuApi.instance()
        .saveUserCustomizeInfo(
        TYUserController.to.seriesList,
        TYUserController.to.singleList,
        false,
        logic.switchOn,
        textEditingController.text);

    if (res.code == '0000000') {
      ToastUtils.customizedBetAmountSuccessful(
          '${'${LocaleKeys.bet_one_click_bet_change.tr} '}${toAmountSplit(int.parse(textEditingController.text).toStringAsFixed(2))}');
      update();
      await getUserCustomizeInfo();
    } else {
      ToastUtils.show(res.msg);
    }
  }
  ///用户余额不满足最大金额时设置成最小金额
  onMaxOK() async {
    textEditingController.text = logic.min.toString();

    final res = await MenuApi.instance().saveUserCustomizeInfo(
        TYUserController.to.seriesList,
        TYUserController.to.singleList,
        false,
        true,
        textEditingController.text);

    if (res.code == '0000000') {
      ToastUtils.show(LocaleKeys.app_err_msg14.tr +
          ' ' +
          double.parse(logic.min.toString()).toStringAsFixed(2));
      update();
      await getUserCustomizeInfo();
    } else {
      ToastUtils.show(res.msg);
    }
  }
  ///一键投注金额格式化
  String toAmountSplit(String num) {
    String numStr = (num).toString();

    if (numStr.contains('.')) {
      List<String> parts = numStr.split('.');
      String integerPart = parts[0];
      String decimalPart = parts[1];

      String formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    } else {
      return numStr.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+\b)'),
            (match) => '${match.group(1)},',
      );
    }
  }
  /// 跳转订单通知
  void toOrderNotification() {
    Get.lazyPut(() => BetOrderNotificationController());
    Get_TY.bottomSheet(
      ///点击边缘可关闭
      isDismissible: true,
      const BetOrderNotificationPage(),

      ///可拖动关闭
      isScrollControlled: true,
      barrierColor: Colors.black.withValues(alpha: 0.2),
    );
  }
}
