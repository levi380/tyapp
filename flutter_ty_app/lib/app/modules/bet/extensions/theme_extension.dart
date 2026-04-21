import 'package:flutter/material.dart';
import 'package:get/get.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-d3718b48-f3a5-4265-b0e2-a81a7ca83913-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单中心 】】】
    【【【 AUTO_DOCUMENT_TITLE 全部类型注单 】】】
    【【【 AUTO_PARAGRAPH_TITLE 注单主题适配类】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 处理注单类型切换逻辑
    】】】
 *
 */

/// 注单主题适配
extension ThemeExtension on ThemeData {
  // 背景
  Color get betBackgroundColor =>
      Get.isDarkMode ? Colors.transparent : const Color(0xFFF2F2F6);

  // 切换tab
  Color get betTabBackgroundColor =>
      Get.isDarkMode ? const Color(0xE5181A21) : Colors.white;

  // 面板
  Color get betPanelBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : Colors.white;

  Color get betSubText =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xFF7981A3);

  Color get betSubSuccessText =>
      Get.isDarkMode ? const Color(0xFF127DCC) : const Color(0xFF179CFF);

  Color get betMainText =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF303442);

  // 正码大小
  Color get betPanelSubBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFF2F2F6);

  // 分割线
  Color get betPanelLineColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : const Color(0xFFF2F2F6);

  // 真人video按钮背景
  Color get betZrVideoBgColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFE8F5FF);

  Color get betRecordViewBackgroundColor =>
      Get.isDarkMode ? Colors.transparent : const Color(0xFFF2F2F6);
}
