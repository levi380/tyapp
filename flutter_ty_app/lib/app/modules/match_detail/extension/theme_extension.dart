import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../main.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-416f2725-5439-4a04-9298-bb6da7f9e5f0 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 主题配置】】】
    【【【 AUTO_PARAGRAPH_TITLE 详情主题相关配置】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 夜间白天不同颜色以及ipad不同字体进行声明
    】】】
 *
 */
extension ThemeExtension on ThemeData {
  // 背景
  Color get detailBackgroundColor => Get.isDarkMode
      ? Colors.transparent
      : const Color.fromRGBO(248, 249, 250, 1);

  // 面板
  Color get tabPanelBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : Colors.white;
  Color get selectTabPanelBgColor =>
      Get.isDarkMode ? Color(0xFF2A2C31) : Colors.white;
  // 面板阴影
  Color get tabPanelBoxShadowColor =>
      Get.isDarkMode ? Colors.black : Colors.black54;

  // 主tab选中
  Color get tabPanelSelectedColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF303442);

  Color get tabPanelHeadColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFF3FAFF);


  Color get tabAnaysisBgColor =>
      Get.isDarkMode ? Color(0xFF181A21) :Color(0xFFE4E6ED);


  // 主tab未选中
  Color get tabPanelUnSelectedColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF303442);

  // 指示器
  Color get tabIndicatorColor => Get.isDarkMode
      ? const Color.fromRGBO(18, 125, 204, 1)
      : const Color.fromRGBO(23, 156, 255, 1);

  // 次级面板
  Color get secondTabPanelBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : Colors.white;

  // 次tab选中
  Color get secondTabPanelSelectedColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFE8F5FF);

// 次tab选中字体
  Color get secondTabPanelSelectedFontColor => Get.isDarkMode
      ? const Color.fromRGBO(18, 125, 204, 1)
      : const Color(0xFF179CFF);

// 次tab选中字体
  Color get analyzeSecondTabPanelSelectedFontColor =>
      Get.isDarkMode ? const Color(0xFF179CFF) : const Color(0xFF303442);

// 次tab选中字体
  Color get analyzeSecondTabPanelUnSelectedFontColor => Get.isDarkMode
      ? const Color(0xFFFFFFFF).withValues(alpha:0.3)
      : const Color(0xFF7981A4);

  // 次tab未选中字体
  Color get secondTabPanelUnSelectedFontColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.3) : const Color(0xFFAFB3C8);

  // 一键折叠按钮
  Color get foldColor => Get.isDarkMode
      ? Colors.white.withValues(alpha:0.03999999910593033)
      : const Color(0xFFF2F2F6);

  // 投注面板面板
  Color get betPanelBackGroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : Colors.white;

  // 投注面板黑色字体
  Color get betPanelFontColor => Get.isDarkMode
      ? Colors.white.withValues(alpha:0.9)
      : const Color.fromRGBO(48, 52, 66, 1);

  // 黑色字体
  Color get titleBlack => Get.isDarkMode
      ? Colors.white.withValues(alpha:0.9)
      :  Colors.black;

  // 一条横线
  Color get betPanelUnderlineColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : const Color(0xFFF2F2F6);

  /// 投注按钮
  // 背景
  Color get oddsButtonBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : const Color(0xffFFFFFF);

  // 联赛分组切换
  Color get leaguePointsBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : const Color(0xFFF4F7FF);




  // 优惠赔率背景
  Color get addOddsButtonBackgroundColor =>
      Get.isDarkMode ? Color(0xFFFDBF54) : Color(0xFFFDBF54);

  //选中背景
  Color get oddsButtonSelectedBackgroundColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.2) : const Color(0xFFD1EBFF);

  // 选中字体颜色
  Color get oddsButtonSelectFontColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF127DCC);

  // 阴影
  Color get oddsButtonShadowColor =>
      Get.isDarkMode ? Colors.transparent : const Color.fromRGBO(0, 0, 0, 0.08);

  // 名称
  Color get oddsButtonNameFontColor => Get.isDarkMode
      ? Colors.white.withValues(alpha:0.5)
      : const Color.fromRGBO(121, 129, 164, 1);

  // 优惠赔率投注项名
  Color get addedOddsButtonNameFontColor => Get.isDarkMode
      ? const Color(0X9A303422)
      : const Color(0X9A303422);

  Color get oddsTeamNameFontColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xFF7981a4);

  // 赔率
  Color get oddsButtonValueFontColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF303442);

  // 优惠赔率
  Color get addedOddsButtonValueFontColor =>
      Get.isDarkMode ? Color(0XFF303422) : Color(0XFF303422);

  // vr赛果投注项颜色
  Color get oddsButtonVrResultValueFontColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.898)
      : const Color.fromRGBO(48, 52, 66, 1);

  // 文章二级标题
  Color get secondFontColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xFF7981A4);

  /// 详细比分条
  // 比分
  Color get scoreDetailColor => Get.isDarkMode
      ? const Color.fromRGBO(23, 156, 255, 1)
      :const Color.fromRGBO(23, 156, 255, 1);
      // : const Color(0xFFFEBE55);

  /// 下拉联赛
  Color get matchSelectBackgroundColor =>
      Get.isDarkMode ? const Color(0xFF1E2029) : Colors.white;

  // title
  Color get matchSelectTitleColor =>
      Get.isDarkMode ? Colors.white : const Color(0xFF303442);

  Color get subSelectTitleColor =>
      Get.isDarkMode ? Colors.white : const Color(0xFF7981A4);

  // 选中
  Color get matchSelectedBgColor => Get.isDarkMode
      ? Colors.white.withValues(alpha:0.04)
      : const Color.fromRGBO(243, 250, 255, 1);

  /// 底部导航
  Color get bottomBgColor =>
      Get.isDarkMode ? const Color(0xFF171A22) : Colors.white;

  // 导航圆圈背景
  Color get bottomNavCircleColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.2) : const Color(0xFFE8F5FF);

  // 聊天输入框背景
  Color get chatInputBgColor => Get.isDarkMode
      ? Colors.white.withValues(alpha:0.04)
      : const Color.fromRGBO(242, 242, 246, 1);

  // 选中
  Color get resultTextColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.7) : const Color(0xFF616783);

  // 选中
  Color get resultSecondTextColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.4) : const Color(0xFF303442);

  // 选中
  Color get resultContainerBgColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0x33AFAFAF);

  Color get dataContainerTextColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.4) : const Color(0xFF949AB6);

  // 负
  Color get winResultColor => Get.isDarkMode
      ? const Color.fromRGBO(113, 200, 102, 1)
      : const Color.fromRGBO(113, 200, 102, 1);

  // 胜
  Color get loseResultColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 115, 115, 1)
      : const Color.fromRGBO(255, 115, 115, 1);

  // 平
  Color get equalResultColor => Get.isDarkMode
      ? const Color.fromRGBO(90, 182, 247, 1)
      : const Color.fromRGBO(90, 182, 247, 1);

  // 展开
  Color get analsColorExpand => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.9)
      : const Color.fromRGBO(48, 52, 66, 1);

  // 阵容tabBar文字选中颜色
  Color get analsTextTabSelectColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 1)
      : const Color.fromRGBO(48, 52, 66, 1);

  // 阵容tabBar文字颜色
  Color get analsTextTabUnSelectColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.5)
      : const Color.fromRGBO(121, 129, 164, 1);

  // 阵容tabBar背景色
  Color get analsTextTabBgColor => Get.isDarkMode
      ? const Color.fromRGBO(255, 255, 255, 0.08)
      : const Color(0xFFF2F2F6);

  // 注单日期tab背景色
  Color get orderDateTabBgColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : Colors.white;

  // 注单日期tab文字颜色
  Color get orderDateTextColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.7) : const Color(0xff7981A4);

  // 注单view底色
  Color get betViewBackgroundColor =>
      Get.isDarkMode ? Colors.transparent : const Color(0xFFF2F2F6);

  // 注单单条底色
  Color get betItemBgColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : Colors.white;

  Color get betItemTitleColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.9) : const Color(0xFF303442);

  Color get betItemTextColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xFF616783);

  Color get betItemTextColor2 =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.7) : const Color(0xFF616783);

  Color get betItemTabSelectedColor =>
      Get.isDarkMode ? const Color(0xFF127DCC) : const Color(0xFF179CFF);

  Color get betItemTyStatusErrorColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.3) : const Color(0xFFAFB3C8);

  Color get betItemExpandColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.3) : const Color(0xFFC9CDDB);

  Color get betItemContentBgColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.04) : const Color(0xFFF2F2F6);

  Color get betItemCopyColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.5) : const Color(0xFF7981A4);

  Color get betItemDividerColor =>
      Get.isDarkMode ? Colors.white.withValues(alpha:0.08) : const Color(0xFFF2F2F6);


  //选中背景
  Color get matchHeadContainerBackgroundColor =>
      Get.isDarkMode ? Color(0xFF30323A) : const Color(0xFFF7F9FF);

  // Ipad 适配字体
  double get fontSize_12 => isIPad ? 16.sp : 12.sp;

  double get fontSize_14 => isIPad ? 18.sp : 14.sp;

  double get matchDetailScoreFontSize_10 => isIPad ? 16.sp : 10.sp;
}
