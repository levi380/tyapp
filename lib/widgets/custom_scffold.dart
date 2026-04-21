import 'package:filbet/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomScffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final String? title; // 标题
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Color? appBarColor;
  final double? elevation;
  final Widget? body;
  final bool needAppbar; //是否需要appbar 默认需要
  final bool hideBack; //是否隐藏返回按钮
  final Function()? onBack;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Color? drawerScrimColor;

  /// [背景纹理，视情况设置backgroundColor、appBarColor]
  final bool showBgTexture;
  final bool resizeToAvoidBottomInset; //底部是否根据键盘上顶
  final String? bgimage; // 标题

  const CustomScffold({
    super.key,
    this.onBack,
    this.needAppbar = true,
    this.hideBack = false,
    this.appBar,
    this.elevation = 0,
    this.body,
    this.backgroundColor,
    this.appBarColor,
    this.title,
    this.titleWidget,
    this.actions,
    this.floatingActionButton,
    this.drawer,
    this.drawerScrimColor,
    this.bgimage,
    this.showBgTexture = true,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: !needAppbar
          ? null
          : (appBar ??
              AppBar(
                  leadingWidth: 38.r,
                  elevation: elevation,
                  centerTitle: true,
                  scrolledUnderElevation: 0,
                  leading: hideBack
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: onBack ??
                              () {
                                Get.back();
                              },
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 28.r,
                                height: 28.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Image.asset(
                                  Assets.homeHomeBack,
                                  width: 16.r,
                                  height: 16.r,
                                ),
                              )),
                        ),
                  title: titleWidget ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // color: AoneAppTheme.appTheme.aoneTextColorAnti,
                            fontSize: 16.sp,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w600),
                      ),
                  actions: actions,
                  backgroundColor: appBarColor)),
      body: showBgTexture
          ? Stack(
              children: [
                Image.asset(
                  bgimage ?? Assets.loginLoginLoginBg,

                  ///static/oversea-public/flutter_static/home_bg_image/bg2.png
                  width: Get.width,
                  height: Get.height,

                  fit: BoxFit.fitWidth,
                  repeat: ImageRepeat.repeatY,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox.shrink();
                  },
                ),
                body ?? SizedBox.shrink(),
              ],
            )
          : body,
      backgroundColor: (backgroundColor) ?? Color(0xffE4EFFD),
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      drawerScrimColor: drawerScrimColor,
    );
  }
}
