import 'dart:io';
import 'package:flutter/services.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  主题状态栏颜色设置  】】】
    【【【 AUTO_PARAGRAPH_TITLE 主题状态栏颜色设置  SystemUtils 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 主题状态栏颜色设置  SystemUtils
    - SystemUtils
    ```
    /// 手机顶部状态栏 白色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    /// 手机顶部状态栏 黑色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    ```
    】】】
 *
 */
class SystemUtils {
  static isDarkMode(bool isDark) {
    if (Platform.isAndroid || Platform.isIOS) {
      if (isDark == true) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    }
  }
}
