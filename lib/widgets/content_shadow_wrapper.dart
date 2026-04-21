import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_color.dart';
import 'package:filbet/themes/app_newcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 用于标记不需要容器背景的内容，只是一个包装类，没有任何功能
class IgnoreContentContainerBackgroundWidget extends StatelessWidget {
  final Widget child;

  const IgnoreContentContainerBackgroundWidget(
      {super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class ShadowContainerBuilder {
  static BoxDecoration buildShadowDecoration(
    BuildContext context,
    double borderRadius,
    Color? shadowColor,
    Color? bgColor,
    double? shadowAlpha,
  ) {
    return BoxDecoration(
      color: bgColor ?? appnewColors.bg1, // 使用主题的表面颜色作为背景色
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: (shadowColor ?? const Color(0xFFFFFFFF))
              .withValues(alpha: shadowAlpha ?? 0.5),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static Container buildContentContainer(Widget child, double borderRadius) {
    // 检查child是否为Container且有颜色
    bool childHasColor = false;
    if (child is Container) {
      // 检查Container的decoration是否有颜色
      final decoration = child.decoration;
      if (decoration is BoxDecoration && decoration.color != null) {
        childHasColor = true;
      }
      // 检查Container的color属性
      else if (child.color != null) {
        childHasColor = true;
      }
    }

    if (child is IgnoreContentContainerBackgroundWidget) {
      // 如果是IgnoreContentContainerBackgroundWidget，则不使用背景色
      childHasColor = true;
    }

    return Container(
      decoration: BoxDecoration(
        // color:
        //     childHasColor ? null : appColors.bgSecondColor, // 如果child有颜色则不使用背景色
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }

  static Container buildShadowContainer({
    required BuildContext context,
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
    Color? shadowColor,
    Color? bgColor,
    double? shadowAlpha,
  }) {
    final effectiveBorderRadius = borderRadius ?? 12.r;

    return Container(
      margin: margin,
      padding: padding ?? EdgeInsets.all(10.r),
      decoration: buildShadowDecoration(
        context,
        effectiveBorderRadius,
        shadowColor,
        bgColor,
        shadowAlpha,
      ),
      child: child,
    );
  }
}

class _BaseShadowWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? shadowColor;
  final Color? bgColor;
  final double? shadowAlpha;

  const _BaseShadowWrapper({
    required this.child,
    this.padding,
    this.margin,
    this.bgColor,
    this.borderRadius,
    this.shadowColor,
    this.shadowAlpha,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? 8.r;

    return ShadowContainerBuilder.buildShadowContainer(
      context: context,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      bgColor: bgColor,
      shadowAlpha: shadowAlpha,
      child: ShadowContainerBuilder.buildContentContainer(
          child, effectiveBorderRadius),
    );
  }
}

class ContentShadowWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? shadowColor;
  final Color? bgColor;
  final double? shadowAlpha;

  const ContentShadowWrapper({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.bgColor,
    this.borderRadius,
    this.shadowColor,
    this.shadowAlpha,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseShadowWrapper(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      bgColor: bgColor,
      shadowAlpha: shadowAlpha,
      child: child,
    );
  }
}

class MultiContentShadowWrapper extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? shadowColor;
  final Color? bgColor;
  final double? shadowAlpha;
  final double? childrenSpacing;
  final CrossAxisAlignment? crossAxisAlignment;

  const MultiContentShadowWrapper({
    super.key,
    required this.children,
    this.padding,
    this.margin,
    this.borderRadius,
    this.shadowColor,
    this.shadowAlpha,
    this.bgColor,
    this.childrenSpacing,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return _createMultiContentShadowWrapper(
      context: context,
      children: children,
      useContainerBackground: true,
      padding: padding,
      margin: margin,
      bgColor: bgColor,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      shadowAlpha: shadowAlpha,
      childrenSpacing: childrenSpacing,
      crossAxisAlignment: crossAxisAlignment,
    );
  }
}

Widget _buildWrapperWithTitle({
  required String title,
  required Widget wrapperChild,
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  double? positionedLeft,
  TextStyle? titleStyle,
  bool isPermanentUrl = false,
}) {
  final effectiveTitleStyle = titleStyle ??
      TextStyle(
        color: appColors.textMainColor,
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: titlePadding ?? EdgeInsets.only(left: 12.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: effectiveTitleStyle),
            if (isPermanentUrl) ...[
              Transform.translate(
                offset: Offset(-12.r, 0),
                child: Container(
                  height: 18.r,
                  width: 115.r,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 12.r),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Assets.mineIconPermanentUrl),
                    ),
                  ),
                  child: Text(
                    "permanent_website".tr,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: appnewColors.text29,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      SizedBox(height: titleSpacing ?? 10.h),
      wrapperChild,
    ],
  );
}

Widget buildContentShadowWrapperWithTitle({
  required String title,
  required Widget content,
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  double? borderRadius,
  Color? shadowColor,
  Color? bgColor,
  double? shadowAlpha,
  bool isPermanentUrl = false,
  double? positionedLeft,
}) {
  return _buildWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
    isPermanentUrl: isPermanentUrl,
    positionedLeft: positionedLeft,
    wrapperChild: ContentShadowWrapper(
      //ContentShadowWrapper
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      bgColor: bgColor,
      shadowAlpha: shadowAlpha,
      child: content,
    ),
  );
}

Widget buildContentShadowWrapper({
  required Widget content,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? shadowColor,
  double? shadowAlpha,
}) {
  return ContentShadowWrapper(
    padding: padding,
    borderRadius: borderRadius,
    shadowColor: shadowColor,
    shadowAlpha: shadowAlpha,
    child: content,
  );
}

Widget buildContentShadowWrapperWithoutContainerBackground({
  required Widget content,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? shadowColor,
  double? shadowAlpha,
}) {
  return Builder(
    builder: (BuildContext context) {
      return ShadowContainerBuilder.buildShadowContainer(
        context: context,
        padding: padding,
        borderRadius: borderRadius,
        shadowColor: shadowColor,
        shadowAlpha: shadowAlpha,
        child: content, // 直接使用内容，不包装额外容器
      );
    },
  );
}

Widget buildContentShadowWrapperWithoutContainerBackgroundWithTitle({
  required String title,
  required Widget content,
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? shadowColor,
  double? shadowAlpha,
}) {
  return _buildWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
    wrapperChild: buildContentShadowWrapperWithoutContainerBackground(
      content: content,
      padding: padding,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      shadowAlpha: shadowAlpha,
    ),
  );
}

Widget buildMultiContentShadowWrapperWithTitle({
  required String title,
  required List<Widget> children,
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  double? borderRadius,
  Color? shadowColor,
  Color? bgColor,
  double? shadowAlpha,
  double? childrenSpacing,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  return _buildWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
    wrapperChild: MultiContentShadowWrapper(
      padding: padding,
      margin: margin,
      bgColor: bgColor,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      shadowAlpha: shadowAlpha,
      childrenSpacing: childrenSpacing,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    ),
  );
}

Widget buildMultiContentShadowWrapperWithoutContainerBackgroundWithTitle({
  required String title,
  required List<Widget> children,
  EdgeInsetsGeometry? titlePadding,
  double? titleSpacing,
  TextStyle? titleStyle,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? shadowColor,
  double? shadowAlpha,
  double? childrenSpacing,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  return _buildWrapperWithTitle(
    title: title,
    titlePadding: titlePadding,
    titleSpacing: titleSpacing,
    titleStyle: titleStyle,
    wrapperChild: Builder(
      builder: (BuildContext context) {
        return _createMultiContentShadowWrapper(
          context: context,
          children: children,
          useContainerBackground: false,
          padding: padding,
          borderRadius: borderRadius,
          shadowColor: shadowColor,
          shadowAlpha: shadowAlpha,
          childrenSpacing: childrenSpacing,
          crossAxisAlignment: crossAxisAlignment,
        );
      },
    ),
  );
}

/// 创建多内容阴影包装器的辅助方法
Widget _createMultiContentShadowWrapper({
  required BuildContext context,
  required List<Widget> children,
  required bool useContainerBackground,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  double? borderRadius,
  Color? shadowColor,
  Color? bgColor,
  double? shadowAlpha,
  double? childrenSpacing,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  final effectiveBorderRadius = borderRadius ?? 12.r;
  final effectiveSpacing = childrenSpacing ?? 10.h;
  final effectiveCrossAxisAlignment =
      crossAxisAlignment ?? CrossAxisAlignment.start;

  return ShadowContainerBuilder.buildShadowContainer(
    context: context,
    padding: padding,
    margin: margin,
    bgColor: bgColor,
    borderRadius: borderRadius,
    shadowColor: shadowColor,
    shadowAlpha: shadowAlpha,
    child: Column(
      crossAxisAlignment: effectiveCrossAxisAlignment,
      children: useContainerBackground
          ? _buildChildrenWithSpacing(
              children, effectiveSpacing, effectiveBorderRadius)
          : _buildChildrenWithoutContainerBackground(
              children, effectiveSpacing),
    ),
  );
}

/// 构建带容器背景的子组件列表
List<Widget> _buildChildrenWithSpacing(
  List<Widget> children,
  double spacing,
  double borderRadius,
) {
  final List<Widget> result = [];

  for (int i = 0; i < children.length; i++) {
    result.add(
      ShadowContainerBuilder.buildContentContainer(children[i], borderRadius),
    );

    if (i < children.length - 1) {
      result.add(SizedBox(height: spacing));
    }
  }

  return result;
}

/// 构建不带容器背景的子组件列表
List<Widget> _buildChildrenWithoutContainerBackground(
  List<Widget> children,
  double spacing,
) {
  final List<Widget> result = [];

  for (int i = 0; i < children.length; i++) {
    result.add(children[i]);

    if (i < children.length - 1) {
      result.add(SizedBox(height: spacing));
    }
  }

  return result;
}

Widget buildMultiContentShadowWrapper({
  required List<Widget> children,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? shadowColor,
  double? shadowAlpha,
  double? childrenSpacing,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  return Builder(
    builder: (BuildContext context) {
      return _createMultiContentShadowWrapper(
        context: context,
        children: children,
        useContainerBackground: true,
        padding: padding,
        borderRadius: borderRadius,
        shadowColor: shadowColor,
        shadowAlpha: shadowAlpha,
        childrenSpacing: childrenSpacing,
        crossAxisAlignment: crossAxisAlignment,
      );
    },
  );
}

Widget buildMultiContentShadowWrapperWithoutContainerBackground({
  required List<Widget> children,
  EdgeInsetsGeometry? padding,
  double? borderRadius,
  Color? shadowColor,
  double? shadowAlpha,
  double? childrenSpacing,
  CrossAxisAlignment? crossAxisAlignment,
}) {
  return Builder(
    builder: (BuildContext context) {
      return _createMultiContentShadowWrapper(
        context: context,
        children: children,
        useContainerBackground: false,
        padding: padding,
        borderRadius: borderRadius,
        shadowColor: shadowColor,
        shadowAlpha: shadowAlpha,
        childrenSpacing: childrenSpacing,
        crossAxisAlignment: crossAxisAlignment,
      );
    },
  );
}
