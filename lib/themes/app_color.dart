import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final appColors = AppColor();

class AppColor {
  Color navbg = const Color(0xff00A6D6);

  ///导航栏背景色
  Color navBgColor = const Color(0xFFE7F4FD);

  ///导航栏标题色
  Color navTitleColor = const Color(0xFF131416);

  ///主题色
  Color mainColor = const Color(0xFF00A6D6);

  ///主题色禁用色
  Color mainColorDisable = const Color(0xFF8FCEE7);
  Color mainColorDisable2 = const Color(0xFF01698F);

  Color mainColorLinearFrom = const Color(0xFF00A6D6);
  Color mainColorLinearEnd = const Color(0xFF62D0F0);

  Color mainColorDisableLinearFrom = const Color(0xFF8DE7F8);
  Color mainColorDisableLinearEnd = const Color(0xFF8FCEE7);

  ///背景色
  Color bgColor = const Color(0xFFE7F4FD);
  Color bgColor2 = const Color(0xFFF6FAFE);
  Color bgColor3 = const Color(0xFFF8F8FF);
  Color bgErrorColor = const Color(0xFF953720);

  ///次级背景色
  Color bgSecondColor = const Color(0xFFEFF5FE);

  ///列表Item背景色
  Color bgListItemBgColor = const Color(0xFFF2F2F6);

  Color bgListItemBgBlueColor = const Color(0xFF4C96FF).withOpacity(.1);

  /// 输入框背景色
  Color bgTextFiledColor = const Color(0xFFEFF5FE);

  ///筛选背景色
  Color filterBgColor = const Color(0xFFE0EAF2);

  ///文本主颜色
  Color textMainColor = const Color(0xFF1D1D1F);

  ///文本主颜色
  Color textMain2Color = const Color(0xFF4C96FF);

  ///背景色
  Color bgMain2Color = const Color(0xFF4C96FF).withOpacity(.1);
  Color bgMain3Color = const Color(0xFFF7F9FF);

  Color borderMain2Color = const Color(0xFF4C96FF);

  ///次级文本颜色
  Color textSecondColor = const Color(0xFF6C8FA2);

  ///输入框字体颜色
  Color inputTextStyleColor = const Color(0xFF6C6C89);

  ///次2级文本颜色 如:活动tabbar未选中 输入提示文字
  Color textSecond2Color = const Color(0xFF778CA4);

  Color textWhiteColor = const Color(0xFFFFFFFF);

  Color textGreenColor = const Color(0xFF00B41E);
  Color textOrangeColor = const Color(0xFFEC9600);
  Color textRedColor = const Color(0xFFE64119);
  Color textRedColor2 = const Color(0xFFFF423A);
  Color textRedErrorColor = const Color(0xFFDB6372);
  Color textDisableColor = const Color(0xFF8096A5);

  ///边框阴影色
  Color shadowColor = const Color(0xFFB3E5F4).withValues(alpha: 0.5);

  Color white = const Color(0xFFFFFFFF);

  ///气泡背景色
  Color bgBubbleCorrectColor = const Color(0xFFFAFFFB);
  Color bgBubbleErrorColor = const Color(0xFFFFFAFA);
  // 登录注册输入框提示语
  Color textInputHintColor = const Color(0xFF778CA4);
  //登录注册输入框图片
  Color textInputHintPicColor = const Color(0xFFA9B5C2);

  ///气泡边框色
  Color borderBubbleCorrectColor = const Color(0xFF00B41E);
  Color borderBubbleErrorColor = const Color(0xFFFFD1CF);

  ///常规边框色
  Color borderCommonColor = const Color(0xFFEEEEEE);

  ///常规边框色
  Color border2Color = const Color(0xFF86B8FF);
}

///扩展
extension AppColorTextStyleExtension on AppColor {
  ///导航栏标题样式
  TextStyle get navTitleStyle => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: appColors.navTitleColor,
      );

  ///主题色文字样式
  TextStyle get mainStyle_14 => TextStyle(color: mainColor, fontSize: 14.sp);
  TextStyle get mainStyle_14_500 =>
      TextStyle(color: mainColor, fontSize: 14.sp, fontWeight: FontWeight.w500);

  ///主级文字样式
  TextStyle get textMainStyle_12 =>
      TextStyle(color: textMainColor, fontSize: 12.sp);
  TextStyle get textMainStyle_12_500 => TextStyle(
      color: textMainColor, fontSize: 12.sp, fontWeight: FontWeight.w500);
  TextStyle get textMainStyle_12_600 => TextStyle(
      color: textMainColor, fontSize: 12.sp, fontWeight: FontWeight.w600);

  TextStyle get textMainStyle_14 =>
      TextStyle(color: textMainColor, fontSize: 14.sp);
  TextStyle get textMainStyle_14_500 => TextStyle(
      color: textMainColor, fontSize: 14.sp, fontWeight: FontWeight.w500);
  TextStyle get textMainStyle_14_600 => TextStyle(
      color: textMainColor, fontSize: 14.sp, fontWeight: FontWeight.w600);
  TextStyle get textMainStyle_16_500 => TextStyle(
      color: textMainColor, fontSize: 16.sp, fontWeight: FontWeight.w500);
  TextStyle get textMainStyle_16_600 => TextStyle(
      color: textMainColor, fontSize: 16.sp, fontWeight: FontWeight.w600);

  ///次级文字样式

  TextStyle get textSecondStyle_10_500 => TextStyle(
      color: textSecondColor, fontSize: 10.sp, fontWeight: FontWeight.w500);

  TextStyle get textSecondStyle_12 =>
      TextStyle(color: textSecondColor, fontSize: 12.sp);
  TextStyle get textSecondStyle_12_500 => TextStyle(
      color: textSecondColor, fontSize: 12.sp, fontWeight: FontWeight.w500);
  TextStyle get textSecondStyle_12_600 => TextStyle(
      color: textSecondColor, fontSize: 12.sp, fontWeight: FontWeight.w600);

  ///次二级文字样式
  TextStyle get textSecond2Style_12_500 => TextStyle(
      color: textSecond2Color, fontSize: 12.sp, fontWeight: FontWeight.w500);
  TextStyle get textSecond2Style_14 =>
      TextStyle(color: textSecond2Color, fontSize: 14.sp);
  TextStyle get textSecond2Style_14_500 => TextStyle(
      color: textSecond2Color, fontSize: 14.sp, fontWeight: FontWeight.w500);

  ///白色文字样式

  TextStyle get textWhiteStyle_10 =>
      TextStyle(color: textWhiteColor, fontSize: 10.sp);
  TextStyle get textWhiteStyle_10_600 => TextStyle(
      color: textWhiteColor, fontSize: 10.sp, fontWeight: FontWeight.w600);

  TextStyle get textWhiteStyle_12_500 => TextStyle(
      color: textWhiteColor, fontSize: 12.sp, fontWeight: FontWeight.w500);

  TextStyle get textWhiteStyle_16_500 => TextStyle(
      color: textWhiteColor, fontSize: 16.sp, fontWeight: FontWeight.w500);

  ///其它文字样式
  TextStyle get textGreenStyle_12 =>
      TextStyle(color: textGreenColor, fontSize: 12.sp);

  TextStyle get textGreenStyle_12_500 => TextStyle(
      color: textGreenColor, fontSize: 12.sp, fontWeight: FontWeight.w500);
  TextStyle get textGreenStyle_12_600 => TextStyle(
      color: textGreenColor, fontSize: 12.sp, fontWeight: FontWeight.w600);
  TextStyle get textGreenStyle_14_600 => TextStyle(
      color: textGreenColor, fontSize: 14.sp, fontWeight: FontWeight.w600);
  TextStyle get textGreenStyle_16_600 => TextStyle(
      color: textGreenColor, fontSize: 16.sp, fontWeight: FontWeight.w600);

  TextStyle get textOrangeStyle_12 =>
      TextStyle(color: textOrangeColor, fontSize: 12.sp);
  TextStyle get textOrangeStyle_12_500 => TextStyle(
      color: textOrangeColor, fontSize: 12.sp, fontWeight: FontWeight.w500);
  TextStyle get textOrangeStyle_12_600 => TextStyle(
      color: textOrangeColor, fontSize: 12.sp, fontWeight: FontWeight.w600);
  TextStyle get textRedStyle_12_500 => TextStyle(
      color: textRedColor, fontSize: 12.sp, fontWeight: FontWeight.w500);
}
