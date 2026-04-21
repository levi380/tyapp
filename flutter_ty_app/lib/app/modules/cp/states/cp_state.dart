import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/string_extension.dart';
import 'package:flutter_ty_app/app/modules/cp/res/cp_assets.dart';

class CpState {
  /// ------------------ CpView 常量 ------------------

  /// 背景颜色
  static Color get cpViewBgColor => '#F2F2F2'.hexColor;

  /// 无数据时顶部间距
  static double get cpViewNoDataTopMargin => 70.w;

  /// 其他彩种列表顶部间距
  static double get cpViewOtherTicketTopMargin => 8.w;

  /// ------------------ LotteryBettingView 相关常量 ------------------

  /// 顶部菜单左侧返回按钮左边距
  static double get lotteryBettingBackMarginLeft => 16.w;

  /// 顶部菜单左侧返回按钮图标大小
  static double get lotteryBettingBackIconSize => 20.w;

  /// 顶部菜单左侧返回按钮图标颜色 (亮色模式)
  static Color get lotteryBettingBackIconColorLight => const Color(0xFF303442);

  /// 顶部菜单左侧返回按钮图标颜色 (暗色模式)
  static Color get lotteryBettingBackIconColorDark => Colors.white;

  /// 顶部菜单中间间隔
  static double get lotteryBettingTopBarSpacing => 16.w;

  /// 游戏分类列表背景颜色
  static Color get gameCateListBgColor => Colors.white;

  /// 游戏分类列表宽度
  static double get gameCateListWidth => 116.w;

  /// 游戏分类列表底部内边距
  static double get gameCateListPaddingBottom => 30.0;

  /// 游戏分类列表项高度
  static double get gameCateListItemHeight => 44.w;

  /// 游戏分类列表项水平内边距
  static double get gameCateListItemHPadding => 12.0;

  /// 游戏分类列表全部项文字颜色
  static Color get gameCateListAllTextColor => '#7981A4'.hexColor;

  /// 游戏分类列表全部项文字大小
  static double get gameCateListAllTextSize => 14.sp;

  /// 热门游戏图标路径
  static const String hotGameIconPath = CpAssets.hotGameIconPath;

  /// 热门游戏图标大小
  static double get hotGameIconSize => 20.w;

  /// 热门游戏选中颜色
  static Color get hotGameSelectedColor => '#179CFF'.hexColor;

  /// 热门游戏未选中文字颜色
  static Color get hotGameUnselectedTextColor => '#303442'.hexColor;

  /// 游戏网格水平内边距
  static double get gameGridHPadding => 8.w;

  /// 游戏网格底部内边距
  static double get gameGridBPadding => 30.w;

  /// 游戏网格主轴间距
  static double get gameGridMainAxisSpacing => 8.w;

  /// 游戏网格交叉轴间距
  static double get gameGridCrossAxisSpacing => 8.w;

  /// 游戏网格项背景颜色
  static Color get gameGridItemBgColor => Colors.white;

  /// 游戏演示图片路径
  static const String gameDemoImgPath = CpAssets.gameDemoImgPath;

  /// 游戏演示图片宽度
  static double get gameDemoImgWidth => 71.w;

  /// 游戏演示图片高度
  static double get gameDemoImgHeight => 52.w;

  /// 游戏名称文字大小
  static double get gameNameTextSize => 13.sp;

  /// 游戏名称文字颜色
  static Color get gameNameTextColor => '#303442'.hexColor;

  /// 游戏描述文字大小
  static double get gameDescTextSize => 11.sp;

  /// 游戏描述文字颜色
  static Color get gameDescTextColor => '#7981A4'.hexColor;

  /// 游戏收藏图标路径 (亮色已收藏)
  static const String favSelLightPath = CpAssets.favSelLightPath;

  /// 游戏收藏图标大小
  static double get favIconSize => 20.w;

  /// ------------------ CommonCombinedRolling 相关常量 ------------------

  /// 右侧Grid Item主轴间距
  static const double rollingMainAxisSpacing = 8.0;

  /// 右侧Grid Item交叉轴间距
  static const double rollingCrossAxisSpacing = 8.0;

  /// 右侧Grid Item宽高比
  static const double rollingChildAspectRatio = 1.5;

  /// 右侧Grid View垂直内边距
  static const double rollingGridViewVPadding = 10.0;

  /// 左侧列表 Flex (默认)
  static const int rollingLeftFlexDefault = 60;

  /// 滚动动画时长
  static const Duration rollingScrollDuration = Duration(milliseconds: 500);

  /// ------------------ CpOtherTicketView 相关常量 ------------------

  /// 列表间距
  static double get otherTicketSpace => 8.w;

  /// 左侧 Flex (iPad)
  static const int otherTicketLeftFlexIPad = 100;

  /// 左侧 Flex (手机)
  static const int otherTicketLeftFlexMobile = 116;

  /// 左侧背景颜色 (暗色)
  static Color get otherTicketLeftBgColorDark =>
      Colors.white.withValues(alpha: 0.04);

  /// 左侧头部高度
  static double get otherTicketLeftHeaderHeight => 44.w;

  /// 左侧头部底部边框宽度
  static const double otherTicketLeftHeaderBorderWidth = 0.5;

  /// 左侧头部底部边框颜色 (暗色)
  static Color get otherTicketLeftHeaderBorderColorDark =>
      Colors.white.withValues(alpha: 0.08);

  /// 左侧头部底部边框颜色 (亮色)
  static Color get otherTicketLeftHeaderBorderColorLight => '#F2F2F6'.hexColor;

  /// 左侧头部文字颜色 (暗色)
  static Color get otherTicketLeftHeaderTextColorDark =>
      Colors.white.withValues(alpha: 0.5);

  /// 左侧头部文字颜色 (亮色)
  static Color get otherTicketLeftHeaderTextColorLight => '#7981A4'.hexColor;

  /// 右侧垂直内边距
  static double get otherTicketRightVPadding => 16.w;

  /// 分割线颜色 (暗色)
  static Color get otherTicketDividerColorDark =>
      Colors.white.withValues(alpha: 0.08);

  /// 分割线颜色 (亮色)
  static Color get otherTicketDividerColorLight => '#E4E6ED'.hexColor;

  /// 分割线高度
  static const double otherTicketDividerHeight = 0.5;

  /// 左侧选中边框颜色 (暗色)
  static Color get otherTicketLeftSelBorderColorDark => '#127DCC'.hexColor;

  /// 左侧选中边框颜色 (亮色)
  static Color get otherTicketLeftSelBorderColorLight => '#179CFF'.hexColor;

  /// 左侧选中边框宽度
  static double get otherTicketLeftSelBorderWidth => 2.w;

  /// 左侧项图标大小
  static double get otherTicketLeftIconSize => 20.w;

  /// 左侧项文字选中颜色 (暗色)
  static Color get otherTicketLeftSelTextColorDark => const Color(0xFF127DCC);

  /// 左侧项文字未选中颜色 (暗色)
  static Color get otherTicketLeftUnselTextColorDark =>
      Colors.white.withValues(alpha: 0.8999999761581421);

  /// 左侧项文字选中颜色 (亮色)
  static Color get otherTicketLeftSelTextColorLight => const Color(0xFF179CFF);

  /// 左侧项文字未选中颜色 (亮色)
  static Color get otherTicketLeftUnselTextColorLight =>
      const Color(0xFF303442);

  /// ------------------ CpTicketCardWidget 相关常量 ------------------

  /// 卡片阴影颜色
  static Color get ticketCardShadowColor =>
      Colors.black.withValues(alpha: 0.04);

  /// 卡片阴影模糊半径
  static double get ticketCardBlurRadius => 8.w;

  /// 卡片阴影偏移
  static const Offset ticketCardShadowOffset = Offset(0, 4);

  /// 卡片背景颜色 (暗色)
  static Color get ticketCardBgColorDark =>
      Colors.white.withValues(alpha: 0.04);

  /// 卡片内边距
  static double get ticketCardPadding => 8.w;

  /// 卡片名称文字大小
  static double get ticketNameSize => 13.sp;

  /// 卡片名称文字颜色 (暗色)
  static Color get ticketNameColorDark =>
      Colors.white.withValues(alpha: 0.8999999761581421);

  /// 卡片名称文字颜色 (亮色)
  static Color get ticketNameColorLight => const Color(0xFF303442);

  /// 卡片描述文字容器宽度 (iPad)
  static double get ticketDescWidthIPad => 200.w;

  /// 卡片描述文字容器宽度 (手机)
  static double get ticketDescWidthMobile => 80.w;

  /// 卡片描述文字大小
  static double get ticketDescSize => 11.sp;

  /// 卡片描述文字行高
  static double get ticketDescHeight => 1.2.h;

  /// 卡片描述文字颜色 (暗色)
  static Color get ticketDescColorDark => Colors.white.withValues(alpha: 0.5);

  /// 卡片描述文字颜色 (亮色)
  static Color get ticketDescColorLight => const Color(0xFF7981A3);

  /// 收藏图标底部边距 (iPad)
  static const double ticketCollectBottomIPad = 6;

  /// 收藏图标底部边距 (手机)
  static double get ticketCollectBottomMobile => -2.w;

  /// 收藏图标点击区域内边距
  static double get ticketCollectPadding => 8.0.w;

  /// 收藏图标点击区域底部内边距
  static double get ticketCollectPaddingBottom => 6.w;

  /// 收藏图标资源路径 (暗色选中)
  static const String ticketFavSelNight = CpAssets.ticketFavSelNight;

  /// 收藏图标资源路径 (暗色未选)
  static const String ticketFavNorNight = CpAssets.ticketFavNorNight;

  /// 收藏图标资源路径 (亮色选中)
  static const String ticketFavSelDay = CpAssets.ticketFavSelDay;

  /// 收藏图标资源路径 (亮色未选)
  static const String ticketFavNorDay = CpAssets.ticketFavNorDay;

  /// ------------------ LotteryBettingSwitchButton 相关常量 ------------------

  /// 容器内边距
  static double get switchBtnPadding => 2.w;

  /// 容器最小高度
  static double get switchBtnMinHeight => 24.w;

  /// 容器背景颜色 (暗色)
  static Color get switchBtnBgColorDark =>
      Colors.white.withValues(alpha: 0.03999999910593033);

  /// 背景图片路径
  static const String switchBtnBgImage = CpAssets.switchBtnBgImage;

  /// 选中文字颜色 (暗色)
  static Color get switchBtnSelTextColorDark =>
      Colors.white.withValues(alpha: 0.699999988079071);

  /// 选中文字颜色 (亮色)
  static Color get switchBtnSelTextColorLight => const Color(0xff303442);

  /// 未选中文字颜色 (暗色)
  static Color get switchBtnUnselTextColorDark =>
      Colors.white.withValues(alpha: 0.30000001192092896);

  /// 未选中文字颜色 (亮色)
  static Color get switchBtnUnselTextColorLight => const Color(0xff7981A4);

  /// 选中项背景渐变 (暗色)
  static List<Color> get switchBtnSelGradientDark => [
        Colors.white.withValues(alpha: 0.05000000074505806),
        Colors.white.withValues(alpha: 0.10000000149011612),
        Colors.white.withValues(alpha: 0.029999999329447746)
      ];

  /// 选中项背景渐变 (亮色)
  static const List<Color> switchBtnSelGradientLight = [
    Colors.white,
    Color(0xFFEEF1F8),
    Color(0xFFF8FDFF)
  ];

  /// 选中项阴影颜色
  static const Color switchBtnShadowColor = Color(0x337981A3);

  /// LotteryBettingSwitchContainerWidget 水平内边距
  static double get switchContainerPadding => 8.w;

  /// ------------------ CpBettingTutorial 相关常量 ------------------

  /// 暗色背景图
  static const String tutorialBgDark = CpAssets.tutorialBgDark;

  /// 亮色背景颜色
  static const Color tutorialBgColorLight = Color(0xFFF2F2F6);

  /// 顶部内容间距
  static double get tutorialBodyTopMargin => 20.h;

  /// Tab 标题高度
  static double get tutorialTabHeight => 30.h;

  /// Tab 标题底部间距
  static double get tutorialTabBottomMargin => 10.h;

  /// 教程卡片左边距
  static double get tutorialCardMarginLeft => 20.w;

  /// 教程卡片右边距
  static double get tutorialCardMarginRight => 20.w;

  /// 教程卡片上边距
  static double get tutorialCardMarginTop => 16.h;

  /// 教程卡片下边距
  static double get tutorialCardMarginBottom => 30.h;

  /// 教程卡片内上边距
  static double get tutorialCardInnerMarginTop => 12.h;

  /// 教程卡片内下边距
  static double get tutorialCardInnerMarginBottom => 24.h;

  /// 教程标题文字颜色 (暗色)
  static Color get tutorialTitleColorDark =>
      Colors.white.withValues(alpha: 0.8999999761581421);

  /// 教程标题文字颜色 (亮色)
  static const Color tutorialTitleColorLight = Color(0xFF333333);

  /// 教程标题文字大小
  static double get tutorialTitleSize => 18.sp;

  /// 分割线颜色 (暗色)
  static const Color tutorialDividerColorDark = Color(0xFF4A4346);

  /// 分割线颜色 (亮色)
  static const Color tutorialDividerColorLight = Color(0xFFF2F2F6);

  /// ------------------ CpSettingMenu 相关常量 ------------------

  /// 背景颜色 (暗色)
  static const Color settingMenuBgColorDark = Color(0xFF1E2029);

  /// 背景颜色 (亮色)
  static const Color settingMenuBgColorLight = Color(0xFFF2F2F6);

  /// 确认弹窗下方间距
  static double get settingMenuBetConfirmBottomMargin => 10.h;

  /// AmountRangeWidget 背景颜色 (暗色)
  static Color get amountRangeBgColorDark =>
      Colors.white.withValues(alpha: 0.03999999910593033);

  /// AmountRangeWidget 标题颜色 (暗色)
  static Color get amountRangeTitleColorDark =>
      Colors.white.withValues(alpha: 0.8999999761581421);

  /// AmountRangeWidget 标题颜色 (亮色)
  static const Color amountRangeTitleColorLight = Color(0xFF303442);

  /// AmountRangeWidget 选中项边框颜色 (选中)
  static const Color amountRangeBorderColorSel = Color(0xFF179CFF);

  /// AmountRangeWidget 选中项边框颜色 (暗色未选)
  static Color get amountRangeBorderColorUnselDark =>
      Colors.white.withValues(alpha: 0.07999999821186066);

  /// AmountRangeWidget 选中项边框颜色 (亮色未选)
  static const Color amountRangeBorderColorUnselLight = Color(0xFFF2F2F6);

  /// AmountRangeWidget 文字颜色 (选中)
  static const Color amountRangeTextColorSel = Color(0xFF179CFF);

  /// AmountRangeWidget 文字颜色 (暗色未选)
  static Color get amountRangeTextColorUnselDark =>
      Colors.white.withValues(alpha: 0.5);

  /// AmountRangeWidget 文字颜色 (亮色未选)
  static const Color amountRangeTextColorUnselLight = Color(0xFF7981A3);

  /// AmountRangeWidget 选中图标路径
  static const String amountRangeSelIcon = CpAssets.amountRangeSelIcon;

  /// PowerSwitch 高度
  static double get powerSwitchHeight => 48.h;

  /// PowerSwitch 边框颜色 (暗色)
  static Color get powerSwitchBorderColorDark =>
      Colors.white.withValues(alpha: 0.07999999821186066);

  /// PowerSwitch 边框颜色 (亮色)
  static const Color powerSwitchBorderColorLight = Color(0xFFF2F2F6);

  /// PowerSwitch 开关打开背景色
  static const Color powerSwitchOnColor = Color(0xFF179CFF);

  /// PowerSwitch 开关关闭背景色
  static const Color powerSwitchOffColor = Color(0xFFE4E6ED);

  /// SwitchWidget 禁用蒙层颜色 (暗色)
  static Color get switchWidgetDisableColorDark =>
      Colors.white12.withValues(alpha: 0.10000000298023224);

  /// SwitchWidget 禁用蒙层颜色 (亮色)
  static Color get switchWidgetDisableColorLight =>
      Colors.white.withValues(alpha: .5);

  /// SwitchWidget 选中背景颜色 (暗色)
  static Color get switchWidgetSelBgColorDark =>
      Colors.white.withValues(alpha: 0.20000000298023224);

  /// SwitchWidget 内部背景颜色 (亮色)
  static const Color switchWidgetInnerBgColorLight = Color(0xFF7981A3);

  /// SwitchWidget 文字未选中颜色 (暗色)
  static Color get switchWidgetTextUnselColorDark =>
      Colors.white.withValues(alpha: 0.5);

  /// SwitchWidget 文字未选中颜色 (亮色)
  static const Color switchWidgetTextUnselColorLight = Colors.white;

  /// SwitchWidget 文字选中颜色 (亮色)
  static const Color switchWidgetTextSelColorLight = Color(0xff7981A4);
}
