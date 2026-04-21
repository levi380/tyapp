import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/zr/controllers/ZrItemInfo.dart';
import 'package:flutter_ty_app/app/modules/zr/res/zr_assets.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-18253eb3-5a09-49ef-95c2-d1a3f865fd27-zr 】】】
    【【【 AUTO_DOCUMENT_MENU 首页列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人列表】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人列表-State】】】
    【【【 AUTOMATIC_GENERATE_DOCUMENT_PARAGRAPH_CONTENT
    - 真人列表-State
    - 存储临时数据，状态
    】】】
 *
 */
class ZrState {
  ZrState() {
    ///Initialize variables
  }

  ///是否选择全部
  bool isAll = true;

  ///是否加载中
  bool isLoading = false;

  ///当前所选下标，默认第1个，现场
  var pageIndex = 0;

  /// 0-全部 1-历史 默认全部
  var historyType = 0;

  /// 处理的列表
  /// 筛选出开启的台桌
  List<ZrItemInfo> processList = [];

  /// ------------------ 通用常量 ------------------

  /// 真人模块浅色背景色（常用）
  static const Color bgColorLight = Color(0xFFF2F2F6);

  /// 真人模块浅色背景色（另一处用到的灰色）
  static Color get bgColorLightAlt => '#F2F2F2'.hexColor;

  /// 真人模块深色背景色（常用）
  static const Color bgColorDark = Color(0xFF1E2029);

  /// 主要文字颜色（浅色模式）
  static const Color textColorPrimary = Color(0xFF303442);

  /// 二级文字颜色（浅色模式）
  static const Color textColorSecondary = Color(0xFF7981A4);

  /// 卡片背景（深色模式常用透明白）
  static Color get cardBgDarkAlpha04 => Colors.white.withValues(alpha: 0.04);

  /// 深色模式下常用文字透明度（0.9）
  static Color get whiteAlpha09 => Colors.white.withValues(alpha: 0.9);

  /// 深色模式下常用文字透明度（0.5）
  static Color get whiteAlpha05 => Colors.white.withValues(alpha: 0.5);

  /// 深色模式下分割线透明度（0.08）
  static Color get whiteAlpha008 => Colors.white.withValues(alpha: 0.08);

  /// 深色模式下边框透明度（0.12）
  static Color get whiteAlpha012 => Colors.white.withValues(alpha: 0.12);

  /// 浅色模式下标题类深色文字
  static const Color textColorTitle = Color(0xFF333333);

  /// 主要蓝色（高亮/选中）
  static const Color primaryBlue = Color(0xFF179CFF);

  /// 开关关闭背景色
  static const Color switchOffColor = Color(0xFFE4E6ED);

  /// ------------------ 资源路径常量 ------------------

  /// 真人列表 loading 背景图
  static const String zrLoadingBgAsset = ZrAssets.zrLoadingBgAsset;

  /// 真人教程深色背景图
  static const String tutorialBgDarkAsset = ZrAssets.tutorialBgDarkAsset;

  /// 通用切换背景图（短切换按钮使用）
  static const String switchBgImage = ZrAssets.switchBgImage;

  /// 通用切换背景图（长切换按钮使用）
  static const String switchBgImageLong = ZrAssets.switchBgImageLong;

  /// 通用切换选中图标
  static const String switchIconSelected = ZrAssets.switchIconSelected;

  /// 通用切换未选中图标（深色）
  static const String switchIconNormalDark = ZrAssets.switchIconNormalDark;

  /// 通用切换未选中图标（浅色）
  static const String switchIconNormalLight = ZrAssets.switchIconNormalLight;

  /// 真人-现场统计图标
  static const String xianchangTongjiIcon = ZrAssets.xianchangTongjiIcon;

  /// 真人-现场庄图标
  static const String xianchangZhuangIcon = ZrAssets.xianchangZhuangIcon;

  /// 真人-现场闲图标
  static const String xianchangXianIcon = ZrAssets.xianchangXianIcon;

  /// 真人-现场和图标
  static const String xianchangHeIcon = ZrAssets.xianchangHeIcon;

  /// 真人-荷官背景图
  static const String heguanDeskBg = ZrAssets.heguanDeskBg;

  /// 真人-荷官在线人数图标（深色）
  static const String heguanOnlineIconDark = ZrAssets.heguanOnlineIconDark;

  /// 真人-荷官在线人数图标（浅色）
  static const String heguanOnlineIconLight = ZrAssets.heguanOnlineIconLight;

  /// 真人-路纸在线人数图标
  static const String luzhiOnlinePeopleIcon = ZrAssets.luzhiOnlinePeopleIcon;

  /// 真人-引导页关闭图标
  static const String guideCloseIcon = ZrAssets.guideCloseIcon;

  /// 真人-引导页专业版图片
  static const String guideProfessionImage = ZrAssets.guideProfessionImage;

  /// 真人-引导页新手版图片
  static const String guideBeginnerImage = ZrAssets.guideBeginnerImage;

  /// 真人设置-音量图标（小）
  static const String volumeIconDark = ZrAssets.volumeIconDark;
  static const String volumeIconLight = ZrAssets.volumeIconLight;

  /// 真人设置-音量图标（大）
  static const String volumeIconDarkMax = ZrAssets.volumeIconDarkMax;
  static const String volumeIconLightMax = ZrAssets.volumeIconLightMax;

  /// ------------------ 常用尺寸/间距常量 ------------------

  /// 通用间距 2
  static double get space2 => 2.w;

  /// 通用间距 3
  static double get space3 => 3.w;

  /// 通用间距 4
  static double get space4 => 4.w;

  /// 通用间距 5
  static double get space5 => 5.w;

  /// 通用间距 8
  static double get space8 => 8.w;

  /// 通用间距 10
  static double get space10 => 10.w;

  /// 通用间距 14
  static double get space14 => 14.w;

  /// 通用间距 15
  static double get space15 => 15.w;

  /// 通用间距 20
  static double get space20 => 20.w;

  /// 通用间距 32
  static double get space32 => 32.w;

  /// 常用圆角 8
  static const double radius8 = 8.0;

  /// 常用圆角 20
  static const double radius20 = 20.0;

  /// 常用字号 10sp
  static double get font10 => 10.sp;

  /// 路纸格子边框宽度
  static double get roadPaperBorderWidth => 0.5.w;

  /// 路纸格子尺寸
  static double get roadPaperBlockSize => 14.w;

  /// 路纸图标尺寸
  static double get roadPaperIconSize => 10.w;

  /// 真人列表项高度（荷官/路纸列表）
  static double get listItemExtent150 => 150.w;

  /// 短切换按钮高度
  static double get shortSwitchHeight => 24.h;

  /// 短切换按钮内边距
  static const double shortSwitchPadding = 2.0;

  /// 短切换按钮圆角
  static const double shortSwitchRadius = 12.0;

  /// 短切换按钮选中文字颜色（深色）
  static Color get shortSwitchTextSelDark =>
      Colors.white.withValues(alpha: 0.699999988079071);

  /// 短切换按钮未选中文字颜色（深色）
  static Color get shortSwitchTextUnselDark =>
      Colors.white.withValues(alpha: 0.30000001192092896);

  /// 短切换按钮选中文字颜色（浅色）
  static const Color shortSwitchTextSelLight = Color(0xff303442);

  /// 短切换按钮未选中文字颜色（浅色）
  static const Color shortSwitchTextUnselLight = Color(0xff7981A4);

  /// 短切换按钮选中渐变（深色）
  static List<Color> get shortSwitchGradientDark => [
        Colors.white.withValues(alpha: 0.05000000074505806),
        Colors.white.withValues(alpha: 0.10000000149011612),
        Colors.white.withValues(alpha: 0.029999999329447746),
      ];

  /// 短切换按钮选中渐变（浅色）
  static const List<Color> shortSwitchGradientLight = [
    Colors.white,
    Color(0xFFEEF1F8),
    Color(0xFFF8FDFF),
  ];

  /// 短切换按钮选中阴影颜色
  static const Color shortSwitchShadowColor = Color(0x337981A3);

  /// 引导弹窗关闭按钮尺寸
  static double get guideCloseIconSize => 32.w;

  /// 引导弹窗卡片图片尺寸
  static double get guideCardImageSize => 150.w;

  /// 真人设置菜单顶部分组间距
  static double get settingSectionGap => 10.h;

  /// 真人设置菜单底部弹窗高度
  static double get settingBottomSheetHeight => 280.h;

  /// 真人设置菜单底部弹窗头部高度
  static double get settingBottomSheetHeaderHeight => 48.h;

  /// 真人教程/页面通用标题栏高度
  static double get titleBarHeight => 48.h;

  /// 真人设置菜单底部弹窗内容高度
  static double get settingBottomSheetBodyHeight => 232.h;

  /// 真人设置菜单 Picker item 高度
  static const double settingPickerItemExtent = 50;

  /// 真人设置-音量 Slider 宽度
  static double get settingSliderWidth => 210.w;

  /// 真人设置-音量 Slider 轨道高度
  static double get settingSliderTrackHeight => 4.h;

  /// 真人设置-音量 Slider 激活颜色（深色）
  static const Color settingSliderActiveDark = Color(0xFF939498);

  /// 真人设置-音量 Slider 激活颜色（浅色）
  static const Color settingSliderActiveLight = Color(0xFF7881A2);

  /// 真人设置-音量 Slider 非激活颜色（深色）
  static const Color settingSliderInactiveDark = Color(0xFF30323A);

  /// 真人设置-关闭按钮高度
  static double get settingCloseBtnHeight => 52.h;

  /// 真人设置-关闭按钮顶部间距
  static double get settingCloseBtnTopMargin => 10.h;
}
