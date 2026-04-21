import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/num_extension.dart';

import 'app_color.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9236b86d-2f93-40b7-a267-6fcfe0acb8fe-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 公共功能模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP 主题  】】】
    【【【 AUTO_PARAGRAPH_TITLE APP 主题 AppTheme 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP 主题 AppTheme
    - AppTheme
    ```
    theme: AppTheme.light,

    ```
    】】】
 *
 */

class AppTheme {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryTextColor,
    required Color labelTextColor,
    required Color primaryColor,
    required Color cardBgColor,
    required Color divider,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      useMaterial3: false,
      fontFamily: "DIN Alternate",
      brightness: brightness,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      primarySwatch: AppColor.createMaterialColor(primaryColor),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(10),

        /// 滚动条的常亮
        thumbVisibility: WidgetStateProperty.all<bool>(true),
        thumbColor: WidgetStateProperty.all(Colors.white.withValues(alpha:0.08)),
        trackColor: WidgetStateProperty.all(Colors.white.withValues(alpha:0.08)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColor.createMaterialColor(primaryColor),
        // primaryColorDark: primaryColor,
        accentColor: primaryColor,
        backgroundColor: background,
        brightness: brightness,
      ),
      splashFactory: NoSplash.splashFactory,
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        backgroundColor: background,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: primaryTextColor,
          fontSize: 14.sp.scale,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF546371),
        size: 24.0,
      ),
      scaffoldBackgroundColor: background,
      drawerTheme: DrawerThemeData(
        elevation: 0,
        backgroundColor: background,
        width: 0.7.sw,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: EdgeInsets.symmetric(vertical: 0.h),
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF96A5AA),
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
        labelStyle: TextStyle(
          color: labelTextColor,
          fontSize: 14.sp.scale,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: labelTextColor,
          fontSize: 14.sp.scale,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBgColor,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
      ),
      textTheme: TextTheme(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          fontSize: 40.sp.scale,
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          fontSize: 25.sp.scale,
          color: primaryTextColor,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          fontSize: 17.sp.scale,
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: baseTextTheme.titleMedium?.copyWith(
          fontSize: 14.sp.scale,
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
        ),
        titleSmall: baseTextTheme.titleSmall?.copyWith(
          fontSize: 13.sp.scale,
          color: primaryTextColor,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 14.sp.scale,
          color: primaryTextColor,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 13.sp.scale,
          color: primaryTextColor,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: 12.sp.scale,
          color: primaryTextColor,
        ),
        labelLarge: baseTextTheme.labelLarge?.copyWith(
          fontSize: 13.sp.scale,
          color: labelTextColor,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          fontSize: 12.sp.scale,
          color: labelTextColor,
        ),
        labelSmall: baseTextTheme.labelSmall?.copyWith(
          fontSize: 11.sp.scale,
          color: labelTextColor,
        ),
      ),
    );
  }

  static ThemeData get light => createTheme(
        brightness: Brightness.light,
        background: AppColor.bgColorLight,
        primaryTextColor: AppColor.colorTextPrimaryLight,
        primaryColor: AppColor.colorPrimary,
        cardBgColor: AppColor.cardBgColorLight,
        divider: AppColor.dividerColorLight,
        labelTextColor: AppColor.colorTextSecondaryLight,
      );

  static ThemeData get dark => createTheme(
        brightness: Brightness.dark,
        background: AppColor.bgColorDark,
        primaryTextColor: AppColor.colorTextPrimaryDark,
        primaryColor: AppColor.colorPrimary,
        cardBgColor: AppColor.cardBgColorDark,
        divider: AppColor.dividerColorDark,
        labelTextColor: AppColor.colorTextPrimaryDark,
      );
}
