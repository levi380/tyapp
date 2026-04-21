import 'package:filbet/themes/app_newcolor.dart';
import 'package:filbet/widgets/badge_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarItem {
  TabBarItem({
    this.title,
    this.number,
    this.showDot,
  });

  String? title;
  String? number;
  bool? showDot;
}

class CommonTabBar extends StatelessWidget {
  const CommonTabBar(
      {super.key,
      this.height,
      required this.tabController,
      required this.menus,
      required this.selectIndex,
      this.fontSize,
      this.bgColor,
      this.labelPadding,
      this.onTap});

  final double? height;
  final TabController tabController;
  final List<TabBarItem> menus;
  final int selectIndex;
  final double? fontSize;
  final Color? bgColor;
  final bool isFill = true;
  final bool isCenter = false;
  final EdgeInsetsGeometry? labelPadding;
  final Function(int)? onTap;
  final double underLineWidth = 26;
  final double underPaddingHorizontal = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 48.r,
      color: bgColor ?? Colors.white,
      child: TabBar(
          onTap: onTap,
          controller: tabController,
          tabAlignment: isFill
              ? TabAlignment.fill
              : isCenter
                  ? TabAlignment.center
                  : TabAlignment.start,
          isScrollable: isFill ? false : true,
          indicatorWeight: 0.1,
          dividerHeight: 0,
          labelPadding: labelPadding,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
              color: appnewColors.textBlue,
              fontSize: fontSize ?? 14.sp,
              fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(
            color: appnewColors.textSecond,
            fontSize: fontSize ?? 14.sp,
            fontWeight: FontWeight.w600,
          ),
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.symmetric(horizontal: underPaddingHorizontal),
            borderSide: BorderSide(
              color: appnewColors.bg,
              width: 3.r,
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(3.r),
            ),
          ),
          tabs: menus.map((e) {
            return BadgeTab(
              text: e.title ?? '',
              showDot: e.showDot ?? false,
              badgeText: e.number,
            );
          }).toList()),
    );
  }
}
