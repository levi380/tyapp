import 'package:badges/badges.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;


class RedDotNumber extends StatelessWidget {
  final int value;
  final Widget child;
  final bool showBadge;
  final BadgePosition? position;

  const RedDotNumber({
    super.key,
    required this.value,
    required this.child,
    this.showBadge = false,
    this.position,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: showBadge,
      badgeAnimation: BadgeAnimation.slide(toAnimate: false),
      position: position ?? BadgePosition.topStart(top: -10, start: 30.r),
      badgeContent: Text(
        '${value > 99 ? '99+' : value}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 8.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'PingFang SC',
          letterSpacing: 0,
        ),
      ),
      badgeStyle: BadgeStyle(
          shape: value.toString().length == 1
              ? BadgeShape.circle
              : BadgeShape.square,
          badgeColor: appnewColors.tip1,
          borderRadius: BorderRadius.circular(12.r),
          // borderSide: BorderSide(
          //   color: Colors.white,
          //   width: 0.5.r,
          // ),
          padding: EdgeInsets.symmetric(horizontal: 5.r)),
      child: child,
    );
  }
}
