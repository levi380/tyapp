import 'dart:core';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/config_controller.dart';

import 'package:flutter_ty_app/app/global/conif_controller_ext_s.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/language/widgets/language_item.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/setting_menu_controller_ext.dart';
import 'package:flutter_ty_app/app/utils/bus/bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_bus.dart';
import 'package:flutter_ty_app/app/utils/bus/event_enum.dart';
import 'package:flutter_ty_app/main.dart';
import '../../../global/ty_user_controller.dart';

import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../european_cup/european_cup_controller.dart';
import '../../olympic_games/olympic_games_controller.dart';
import 'language_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-c9236939-488f-4411-b9f4-78a79e1f9e8e-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 切换语言】】】
    【【【 AUTO_PARAGRAPH_TITLE 切换语言 控制器 LanguageLogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 切换语言 控制器 LanguageLogic
    - LanguageLogic
    ```
    Locale('zh', 'CN'),  ///中文-简体
    Locale('zh', 'TW'),  ///中文-繁体
    Locale('en', 'GB'),  ///英式-英语
    Locale('vi', 'VN'),  ///越南
    Locale('th', 'TH'),  ///泰国
    Locale('ms', 'MY'),  ///马来西亚
    Locale('id', 'ID'),  ///印尼语
    Locale('pt', 'PT'),  ///葡萄牙
    Locale('ko', 'KR'),  ///韩国
    Locale('es', 'ES'),  ///西班牙语
    Locale('my', 'MM'),  ///缅甸语
    Locale('ar', 'AE'),  ///阿拉伯语
    Locale('ru', 'RU'),  ///俄语
    Locale('hi', 'IN'),  ///印地语
    ```
    】】】
 *
 */
class LanguageLogic extends GetxController {
  final LanguageState state = LanguageState();

  getLanguage() {
    String languageList = TYUserController.to.getlanguageList();
    if (languageList.isNotEmpty) {
      ///当用户有返回语言列表，就是用用户的语言设置列表（默认必须有简体个英文）
      state.itemName.clear();
      state.itemIcon.clear();
      state.itemLanguage.clear();
      //  zh,tw,en,ms,ad,mya,pt,ja,vi,ko,es,hin,th,ara,ru
      ///中文简体(默认有)
      state.itemName.add('中文简体');
      state.itemIcon.add('assets/images/language/zh_cn_new.png');
      state.itemLanguage.add('CN');

      ///中文繁体
      if (languageList.contains('tw')) {
        state.itemName.add('繁體中文');
        state.itemIcon.add('assets/images/language/zh_tw_new.png');
        state.itemLanguage.add('TW');
      }

      ///英国(默认有)
      state.itemName.add('English');
      state.itemIcon.add('assets/images/language/en_gb_new.png');
      state.itemLanguage.add('GB');

      ///越南
      if (languageList.contains('vi')) {
        state.itemName.add('Tiếng Việt');
        state.itemIcon.add('assets/images/language/vi_vn_new.png');
        state.itemLanguage.add('VN');
      }

      ///泰国
      if (languageList.contains('th')) {
        state.itemName.add('ไทย');
        state.itemIcon.add('assets/images/language/th_th_new.png');
        state.itemLanguage.add('TH');
      }

      ///马来西亚
      if (languageList.contains('ms')) {
        state.itemName.add('Melayu');
        state.itemIcon.add('assets/images/language/ms_my_new.png');
        state.itemLanguage.add('MY');
      }

      ///印尼
      if (languageList.contains('ad')) {
        state.itemName.add('Indonesia');
        state.itemIcon.add('assets/images/language/id_id_new.png');
        state.itemLanguage.add('ID');
      }

      ///葡萄牙
      if (languageList.contains('pt')) {
        state.itemName.add('Português');
        state.itemIcon.add('assets/images/language/pt_pt_new.png');
        state.itemLanguage.add('PT');
      }

      ///韩国
      if (languageList.contains('ko')) {
        state.itemName.add('한국어');
        state.itemIcon.add('assets/images/language/ko_ko_new.png');
        state.itemLanguage.add('KR');
      }

      ///西班牙
      if (languageList.contains('es')) {
        state.itemName.add('Español');
        state.itemIcon.add('assets/images/language/es_es_new.png');
        state.itemLanguage.add('ES');
      }

      ///缅甸
      if (languageList.contains('mya')) {
        state.itemName.add('မြန်မာ');
        state.itemIcon.add('assets/images/language/my_mm_new.png');
        state.itemLanguage.add('MM');
      }

      ///阿拉伯国家
      if (languageList.contains('ara')) {
        state.itemName.add('العربية');
        state.itemIcon.add('assets/images/language/ae_ae_new.png');
        state.itemLanguage.add('AE');
      }

      ///俄罗斯
      if (languageList.contains('ru')) {
        state.itemName.add('русский');
        state.itemIcon.add('assets/images/language/ru_ru_new.png');
        state.itemLanguage.add('RU');
      }

      ///印地语
      if (languageList.contains('hin')) {
        state.itemName.add('हिन्दी');
        state.itemIcon.add('assets/images/language/rn_rn_new.png');
        state.itemLanguage.add('IN');
      }

      ///日本(这个没做，等后面补上了再加)
      ///if (tt.contains('ja')) {}
    }
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

  /**
   * 语言样式展示
   */
  List<Widget> loadListLanguagesEuropeanCup() {
    List<Widget> children = [];
    //获取当前语言
    String language = StringKV.language.get() ?? "";
    int current = 0;
    if (language.isNotEmpty) {
      for (int i = 0; i < state.itemLanguageEuropeanCup.length; i++) {
        if (state.itemLanguageEuropeanCup[i].contains(language)) {
          current = i;
          break;
        }
      }
    }
    //设置国际化条目
    for (int i = 0; i < state.itemNameEuropeanCup.length; i++) {
      children.add(LanguageItem(
        title: state.itemNameEuropeanCup[i],
        imageUrl: state.itemIconEuropeanCup[i],
        isSelected: i == current,
        onTap: () {
          //切换语言的事件处理
          setLanguage(state.itemLanguageEuropeanCup[i]);

          if (europeanCup == true && europeanCupSetting == true) {
            final europeanCupController = Get.find<EuropeanCupController>();
            InAppWebViewController.clearAllCache();
            europeanCupController.initData();
            europeanCupController.webViewController.loadUrl(
                urlRequest: URLRequest(url: WebUri(europeanCupController.u)));
            europeanCupController.update();
          } else {
            final olympicGamesController = Get.find<OlympicGamesController>();
            InAppWebViewController.clearAllCache();
            olympicGamesController.initData();
            olympicGamesController.webViewController.loadUrl(
                urlRequest: URLRequest(url: WebUri(olympicGamesController.u)));
            olympicGamesController.update();
          }
        },
      ));
    }
    return children;
  }

  /**
   * 语言设置界面更改逻辑
   */
  changeLangEffect() async {
    // 必须等此接口成功后再切换页面
    await ConfigController.to.loadNameList(switchLanguages: true);
    Bus.getInstance().emit(EventType.changeLang);
    EventBus().fire(EventType.changeLang);
    // 重新拉取name list
  }

  /**
   * 设置语言
   */
  setLanguage(String language) async {
    state.changelan = true;
    StringKV.language.save(language);
    AppLogger.debug("language = $language");
    Locale locale = const Locale('zh', 'CN');
    String languageName = 'zh';
    switch (language) {
      case "CN":

        ///中文-简体
        languageName = 'zh';
        locale = const Locale('zh', 'CN');
        break;
      case "TW":

        ///中文-繁体
        languageName = 'tw';
        locale = const Locale('zh', 'TW');
        break;
      case "GB":

        ///英式-英语
        languageName = 'en';
        locale = const Locale('en', 'GB');
        break;
      case "VN":

        ///越南
        languageName = 'vi';
        locale = const Locale('vi', 'VN');
        break;
      case "KR":

        ///韩国
        languageName = 'ko';
        locale = const Locale('ko', 'KR');
        break;
      case "PT":

        ///葡萄牙
        languageName = 'pt';
        locale = const Locale('pt', 'PT');
        break;
      case "TH":

        ///泰国
        languageName = 'th';
        locale = const Locale('th', 'TH');
        break;
      case "MY":

        ///马来西亚
        languageName = 'ms';
        locale = const Locale('ms', 'MY');
        break;
      case "ID":

        ///印尼语
        languageName = 'ad';
        locale = const Locale('id', 'ID');
        break;
      case "ES":

        ///西班牙语
        languageName = 'es';
        locale = const Locale('es', 'ES');
        break;
      case "MM":

        ///缅甸语
        languageName = 'mya';
        locale = const Locale('my', 'MM');
        break;
      case "AE":

        ///阿拉伯语
        languageName = 'ara';
        locale = const Locale('ar', 'AE');
        break;
      case "RU":

        ///俄语
        languageName = 'ru';
        locale = const Locale('ru', 'RU');
        break;
      case "IN":

        ///印地语
        languageName = 'hin';
        locale = const Locale('hi', 'IN');
        break;
    }

    Future.wait<void>([
      state.setUserLanguage(languageName),
      Get.updateLocale(locale).then((value) async {
        // ToastUtils.showGrayBackground(LocaleKeys.setting_menu_chan_lan.tr);
        //切换语言相关处理
        await changeLangEffect();
        //关闭设置菜单界面
        SettingMenuController.to.update();

        ///烟花活动
        FireworksController.to.getFireworksActivity();
        state.changelan = false;
        // ToastUtils.dismissLoading();
        //关闭当前界面
        Get.back();
      })
    ]).catchError((e) {
      ///切换语言失败 关闭所有弹窗
      //关闭设置菜单界面
      SettingMenuController.to.steShutDown();
      state.changelan = false;
      // ToastUtils.dismissLoading();
      //关闭当前界面
      Get.back();
      return [];
    });
  }
}
