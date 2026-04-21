import 'package:flutter/material.dart';

class IPadAdaptation {
  static double _designWidth = 768; // iPad 设计稿宽度
  static double _designHeight = 1024; // iPad 设计稿高度

  static double adaptWidth(double width, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return width * screenWidth / _designWidth;
  }

  static double adaptHeight(double height, BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return height * screenHeight / _designHeight;
  }

  static double adaptFontSize(double fontSize, BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return fontSize * pixelRatio;
  }

  static EdgeInsets adaptPadding(EdgeInsets padding, BuildContext context) {
    return EdgeInsets.only(
      left: adaptWidth(padding.left, context),
      top: adaptHeight(padding.top, context),
      right: adaptWidth(padding.right, context),
      bottom: adaptHeight(padding.bottom, context),
    );
  }

  static BoxConstraints adaptBoxConstraints(
    BoxConstraints constraints,
    BuildContext context,
  ) {
    return BoxConstraints(
      minWidth: adaptWidth(constraints.minWidth, context),
      maxWidth: adaptWidth(constraints.maxWidth, context),
      minHeight: adaptHeight(constraints.minHeight, context),
      maxHeight: adaptHeight(constraints.maxHeight, context),
    );
  }
}
