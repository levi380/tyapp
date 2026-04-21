import 'package:extended_image/extended_image.dart';
import 'package:filbet/generated/assets.dart';
import 'package:filbet/themes/app_newcolor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.height,
    this.left,
    this.center,
    this.right,
    this.backgroundColor,
    this.topPadding = 0.0,
    this.showShadow = true,
    this.centermargin,
  });

  final double? height;
  final Widget? left;
  final Widget? center;
  final Widget? right;
  final Color? backgroundColor;
  final double topPadding;
  final bool showShadow;
  final double? centermargin;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: _appbar(
        backgroundColor: backgroundColor ?? appnewColors.bg1,
        left: left,
        center: center,
        right: right,
        height: height ?? 54 + data.padding.top,
        topPadding: data.padding.top,
        showShadow: showShadow,
        centermargin: centermargin,
      ),
    );
    // return _appbar(
    //   backgroundColor: backgroundColor,
    //   left: left,
    //   center: center,
    //   right: right,
    //   height: height! + data.padding.top,
    //   topPadding: data.padding.top,
    //   showShadow: showShadow,
    // );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 50);

  static Widget _appbar({
    Color? backgroundColor,
    double? height,
    Widget? left,
    Widget? center,
    Widget? right,
    double topPadding = 0.0,
    bool showShadow = true,
    double? centermargin,
  }) =>
      Container(
        height: height,
        //这里不知道为啥要加left,right
        padding: EdgeInsets.only(left: 8.r, right: 8.r, top: topPadding),
        decoration: BoxDecoration(
          color: backgroundColor ?? appnewColors.bg1,
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: const Color(0xFF000000).withValues(alpha: 0.15),
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                    blurRadius: 4,
                  )
                ]
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: left,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: centermargin ?? 35, right: 35),
                child: center,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: right,
            )
          ],
        ),
      );

  CustomAppbar.searchmargin({
    super.key,
    this.backgroundColor,
    double? height,
    Widget? left,
    this.center,
    List<Widget> actions = const [],
  })  : //height = 124.h,
        // topPadding = 53.h,
        height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        left = left ?? SizedBox(),
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        centermargin = 10,
        showShadow = false;

  CustomAppbar.search({
    super.key,
    this.backgroundColor,
    double? height,
    Widget? left,
    this.center,
    this.centermargin,
    List<Widget> actions = const [],
  })  : //height = 124.h,
        // topPadding = 53.h,
        height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        left = left ?? SizedBox(),
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        showShadow = false;

  CustomAppbar.chatTitle({
    super.key,
    String? title,
    String? subTitle,
    double? height,
    String? leftButton,
    bool? showBack,
    this.centermargin,
    Function()? onClickCallBtn,
    Function()? onClickMoreBtn,
    Function()? onClose,
    this.backgroundColor,
    bool showOnlineStatus = false,
    bool online = false,
    bool showCallButton = true,
    bool showMoreButton = false,
    int count = 0,
  })  : height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        showShadow = true,
        left = showBack != null && showBack
            ? Image.asset(
                Assets.homeHomeBack,
                width: 16.r,
                height: 16.r,
              )
            : Row(
                children: [
                  GestureDetector(
                    onTap: onClose,
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 44,
                      child: Center(
                          child: null != leftButton
                              ? Text(
                                  leftButton,
                                )
                              : const SizedBox()),
                    ),
                  ),
                  const Spacer()
                ],
              ),
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMoreButton)
              TitleImageButton(
                imageStr: "",
                imageWidth: 20,
                imageHeight: 24,
                onTap: onClickMoreBtn,
                // height: 44.h,
              )
          ],
        ),
        center = Container(
          constraints: const BoxConstraints(maxWidth: 180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (null != title)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: appnewColors.text1,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (null != subTitle && subTitle.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showOnlineStatus)
                      Container(
                        margin: const EdgeInsets.only(right: 4, top: 2),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                    if (showOnlineStatus)
                      Text(
                        subTitle,
                      )
                  ],
                ),
            ],
          ),
        );

  CustomAppbar.leftTitle({
    super.key,
    String? title,
    TextStyle? textStyle,
    double? height,
    List<Widget> actions = const [],
    this.centermargin,
    this.backgroundColor,
  })  : //height = height ?? 84.h,
        //topPadding = 40.h,
        height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        showShadow = false,
        center = null,
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        left = Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title ?? '',
          ),
        );

  CustomAppbar.icontitle({
    super.key,
    Widget? leftw,
    double? height,
    Widget? center,
    List<Widget> actions = const [],
    this.backgroundColor,
    this.centermargin,
  })  : //height = height ?? 84.h,
        //topPadding = 40.h,
        height = (height ?? kToolbarHeight) + Get.mediaQuery.padding.top,
        topPadding = 0,
        showShadow = false,
        center = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [if (null != center) center],
        ),
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        left = Container(child: leftw);

  CustomAppbar.leftWidget({
    super.key,
    Widget? left,
    double? height,
    List<Widget> actions = const [],
    this.backgroundColor,
    this.centermargin,
  })  : //height = height ?? 84.h,
        //topPadding = 40.h,
        height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        showShadow = false,
        center = null,
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        left = Container(
            padding: const EdgeInsets.symmetric(horizontal: 10), child: left);

  CustomAppbar.backcenterView({
    super.key,
    Widget? center,
    TextStyle? style,
    String? subTitle,
    TextStyle? subStyle,
    Widget? left,
    double? height,
    dynamic result,
    this.backgroundColor,
    Color? backArrowColor,
    List<Widget> actions = const [],
    Function()? onTap,
    this.centermargin,
    bool showBackArrow = true,
    bool showShadow = true,
  })  : height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        showShadow = false,
        left = left ??
            Row(
              children: [
                GestureDetector(
                  onTap: onTap ?? () => Get.back(result: result),
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 44,
                    child: Center(
                      child: Image.asset(
                        Assets.homeHomeBack,
                        width: 16.r,
                        height: 16.r,
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        center = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [if (null != center) center],
        );

  CustomAppbar.back({
    super.key,
    String? title,
    TextStyle? style,
    String? subTitle,
    TextStyle? subStyle,
    String? leftTile,
    double? height,
    dynamic result,
    this.backgroundColor,
    Color? backArrowColor,
    List<Widget> actions = const [],
    Function()? onTap,
    this.centermargin,
    bool showBackArrow = true,
    bool showShadow = true,
  })  : height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        showShadow = false,
        left = showBackArrow
            ? Row(
                children: [
                  GestureDetector(
                    onTap: onTap ?? () => Get.back(result: result),
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 44,
                      child: Center(
                        child: null != leftTile
                            ? Text(
                                leftTile,
                              )
                            : Image.asset(
                                Assets.homeHomeBack,
                                width: 16.r,
                                height: 16.r,
                              ),
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              )
            : null,
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        center = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (null != title)
              Text(
                title,
                style: style ??
                    TextStyle(
                      fontSize: 16.sp,
                      color: appnewColors.text1,
                      fontWeight: FontWeight.w600,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            if (null != subTitle)
              Text(subTitle, overflow: TextOverflow.ellipsis),
          ],
        );

  CustomAppbar.normalTitle({
    super.key,
    String? title,
    dynamic result,
    int? maxLines,
    List<Widget> actions = const [],
    this.centermargin,
    Color? bgColor,
    Color? leftBackColor,
    EdgeInsetsGeometry? padding,
    Function()? onTap,
  })  : backgroundColor = bgColor ?? appnewColors.bg1,
        height = (kToolbarHeight + Get.mediaQuery.padding.top),
        topPadding = 0,
        showShadow = false,
        center = Text(
          maxLines: maxLines,
          title ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: appnewColors.text1,
          ),
        ),
        right = Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ),
        left = Row(
          children: [
            GestureDetector(
              onTap: onTap ?? () => Get.back(result: result),
              behavior: HitTestBehavior.translucent,
              child: Container(
                padding: padding ?? EdgeInsets.only(left: 10.w, right: 10.w),
                height: kToolbarHeight,
                child: Center(
                  child: Image.asset(
                    Assets.homeHomeBack,
                    width: 16.r,
                    height: 16.r,
                    color: leftBackColor,
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        );
}

class TitleImageButton extends StatelessWidget {
  const TitleImageButton(
      {super.key,
      required this.imageStr,
      required this.imageWidth,
      required this.imageHeight,
      this.width,
      this.height,
      this.onTap,
      this.padding,
      this.color,
      this.fit = BoxFit.contain});

  final String imageStr;
  final double imageWidth;
  final double imageHeight;
  final double? width;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 44,
        padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: isHttpUrl(imageStr)
              ? Image.network(
                  imageStr,
                  height: imageWidth,
                  width: imageWidth,
                  fit: fit,
                )
              : Image.asset(
                  imageStr,
                  width: imageWidth,
                  height: imageHeight,
                  color: color,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}

class TopImageButton extends StatelessWidget {
  const TopImageButton(
      {super.key,
      required this.imageStr,
      required this.dimageStr,
      required this.imageWidth,
      required this.imageHeight,
      this.width,
      this.height,
      this.onTap,
      this.padding,
      this.color,
      this.fit = BoxFit.contain});

  final String imageStr;
  final String dimageStr;
  final double imageWidth;
  final double imageHeight;
  final double? width;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 44,
        padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
        child: Center(
          child: ExtendedImage.network(imageStr,
              fit: fit,
              width: imageWidth,
              height: imageHeight,
              cache: true, loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return Image.asset(
                  dimageStr,
                  fit: BoxFit.fill,
                );
              case LoadState.completed:
                return state.completedWidget;

              case LoadState.failed:
                return Image.asset(
                  width: imageWidth,
                  height: imageHeight,
                  dimageStr,
                  fit: BoxFit.fill,
                );
            }
          }),
        ),
      ),
    );
  }
}

bool isHttpUrl(String url) {
  // 创建一个正则表达式，匹配以 "http://" 或 "https://" 开头的 URL
  RegExp regExp = RegExp(r'^https?://');

  // 使用正则表达式测试 URL
  return regExp.hasMatch(url);
}
