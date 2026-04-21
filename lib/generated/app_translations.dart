import 'package:filbet/generated/vi_VN.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:filbet/generated/zh_TW.dart';
import 'en_US.dart';
import 'zh_CN.dart';

class AppTranslations extends Translations {
  static const List<Locale> supportedLocales = [
    // Locale("en", "US"),
    Locale("zh", "CN"),
    // Locale("vi", "VN"),
    Locale("zh", "TW"), // 中文 - 繁体 (台湾)

  ];
// 设置多语言
  // static Locale? get locale =>
  //   Get.find<SettingsController>().locale.value;
  static const fallbackLocale = Locale('zh', 'CN');
  @override
  Map<String, Map<String, String>> get keys => {
        // 'en_US': enUS,
        'zh_CN': zhCN,
        // 'vi_VN': viVN,
        'zh_TW': zhTW,
   
      };
  String Function(String key) get enUSItemValue => (String key) {
        return keys['en_US']?['key'] ?? '';
      };
}
