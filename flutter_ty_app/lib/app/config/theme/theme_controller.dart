import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-901f9269-12c6-45b3-b38c-090743d6a91d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  主题切换工具控制器 】】】
    【【【 AUTO_PARAGRAPH_TITLE 主题切换工具控制器入口 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 调整亮度白天模式和夜间模式
    - isDarkMode 是否为黑暗模式还是 白天模式 否认为false 白天模式
    ```
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    ```
    】】】
 *
 */
class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
  }

  ThemeData get currentTheme =>
      isDarkMode.value ? ThemeData.dark() : ThemeData.light();
}
