import 'package:flutter/material.dart';
import 'dart:math' as math;

extension CommonButton on Widget {
  Widget toBtn({
    double? height,
    Color bg = Colors.transparent,
    double? width,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Color? splashColor,
    Color? primaryColor,
    double radius = 5,
    BorderRadius? borderRadius,
    List<Color>? colors,
    GestureTapCallback? onTap,
    bool autoSize = true,
    Border? border,
    List<BoxShadow>? boxShadow,
    bool showSplash = true,
    BoxConstraints? constraints,

    /// 新增：扩展点击区域
    EdgeInsets expandArea = EdgeInsets.zero,
  }) {
    return Padding(
      padding: expandArea, // 👈 在外层增加可点击区域
      child: xTextButton(
        height,
        bg,
        width: width,
        margin: margin,
        padding: padding,
        splashColor: splashColor,
        showSplash: showSplash,
        radius: radius,
        borderRadius: borderRadius,
        colors: colors,
        primaryColor: primaryColor,
        onTap: onTap,
        child: this,
        autoSize: autoSize,
        border: border,
        boxShadow: boxShadow,
        constraints: constraints,
      ),
    );
  }
}
Widget xTagView(
  double? height,
  Color bg, {
  double? width,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? radius,
  BorderRadiusGeometry? borderRadius,
  List<Color>? colors,
  Widget? child,
  bool autoSize = false,
  Border? border,
  List<BoxShadow>? boxShadow,
  BoxConstraints? constraints,
}) {
  borderRadius =
      borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 100));
  BoxDecoration boxDecoration = BoxDecoration(
    color: bg,
    borderRadius: borderRadius,
    border: border,
    boxShadow: boxShadow,
  );
  if (colors != null) {
    boxDecoration = BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          // begin: Alignment.centerRight,
          // end: Alignment.centerLeft,
        ),
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow);
  }

  return Container(
    height: height,
    width: width,
    alignment: autoSize ? null : Alignment.center,
    constraints: autoSize
        ? const BoxConstraints(
            minHeight: 0,
            minWidth: 0,
          )
        : constraints,
    margin: margin ?? EdgeInsets.zero,
    padding: padding ?? EdgeInsets.zero,
    decoration: boxDecoration,
    child: child,
  );
}

Widget xTextButton(double? height, Color bg,
    {double? width,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? splashColor,
    Color? primaryColor,
    bool showSplash = true,
    double? radius = 100,
    BorderRadius? borderRadius,
    List<Color>? colors,
    GestureTapCallback? onTap,
    AlignmentGeometry? alignment,
    Widget? child,
    bool autoSize = false,
    Border? border,
    List<BoxShadow>? boxShadow,
    BoxConstraints? constraints}) {
  var r = radius ?? 100;
  if (primaryColor != null && isSameColor(bg, primaryColor)) {
    splashColor = createMaterialColor(bg);
  }

  child = Container(
    constraints: autoSize
        ? const BoxConstraints(
            minHeight: 0,
            minWidth: 0,
          )
        : constraints,
    alignment: autoSize ? null : Alignment.center,
    height: height,
    padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: child,
  );
  if (onTap != null && showSplash) {
    final borderRadius0 = borderRadius ?? BorderRadius.all(Radius.circular(r));

    child = Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: borderRadius0),
      child: InkWell(
        splashColor: splashColor,
        borderRadius: borderRadius0,
        onTap: onTap,
        child: child,
      ),
    );
  }
  return xTagView(height, bg,
      width: width,
      margin: margin,
      padding: EdgeInsets.zero,
      radius: radius,
      borderRadius: borderRadius,
      colors: colors,
      autoSize: autoSize,
      child: child,
      border: border,
      boxShadow: boxShadow,
      constraints: constraints);
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

bool isSameColor(Color color, Color color2) {
  return color.red == color2.red &&
      color.green == color2.green &&
      color.blue == color2.blue;
}
