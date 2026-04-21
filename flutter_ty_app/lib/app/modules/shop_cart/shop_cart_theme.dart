import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ThemeDataExtension on ThemeData {
  // 自定义颜色键
  Color get shopcartBackgroundColor =>
      Get.isDarkMode ? const Color(0XFF1E2029) : Colors.white;
      //brightness == Brightness.dark ? const Color(0XFF1E2029) : Colors.white;

  Color get shopcartContentBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFF3FAFF);

  Color get shopcartClosedContentBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFF2F2F6);

  Color get shopcartKeyboardColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFFFFFFF);

  Color get shopcartTextColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF303442);

  Color get shopcartTintColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.2) : const Color(0xFFC9CDDB);

  Color get shopcartLabelColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xFF7981A3);

  Color get shopcartItemNumberBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0XFFD1EBFF);

  Color get shopcartParlayChangeBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0XFFE8F5FF);

  Color get shopcartButtonDisableBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.2) :const Color(0XFFC9CDD8) ;
  Color get shopcartButtonSlideDisableColor =>
      Get.isDarkMode ? Colors.white:Colors.white.withValues(alpha:0.96) ;

  Color get shopcartDeleteButtonBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) :const Color(0xFFE4E6ED) ;

  Color get shopcartTipsBackgroundColor =>
      Get.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF3FAFF);

  Color get shopcartCloseButtonColor =>
      Get.isDarkMode ? Colors.black.withValues(alpha:0.6) : Colors.white.withValues(alpha:0.6);

  Color get shopcartTipCloseButtonColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.77):Color(0xFFAFB3C8);
  Color get shopcartDiscountOddsColor =>
      Get.isDarkMode ? const Color(0xFFAFB3C8):const Color(0xFFAFB3C8);

  Color get shopcartTipBoderColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.1):Color(0xFFE4E6ED);

  Color get shopcartInputBorderFocusColor =>
      Get.isDarkMode ? const Color(0XFF179CFF) : const Color(0XFF179CFF);

  Color get shopcartInputBorderUnfocusColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : const Color(0xFFD1EBFF);

  Color get shopcartDividerColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08): const Color(0xFFF2F2F6);

  Color get shopcartReasonBackgroundColor =>
      Get.isDarkMode ? const Color(0x1AE93D3D): const Color(0x1AE93D3D);

  Color get shopcartReasonColor =>
      Get.isDarkMode ? const Color(0xFFF53F3F): const Color(0xFFF53F3F);

  Color get shopcartToastBorderColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.15): Colors.black.withValues(alpha:0.15);
}