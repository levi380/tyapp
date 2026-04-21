import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/extension/widget_extensions.dart';
import 'package:flutter_ty_app/app/modules/match_detail/extension/match_video/match_video_extension.dart';
import 'package:get/get.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../services/models/res/match_entity.dart';

import '../../../../utils/lodash.dart';
import '../../../../utils/match_util.dart';
import '../../../../utils/oss_util.dart';
import '../../../../utils/widget_utils.dart';
import '../../../../widgets/image_view.dart';
import '../../constants/detail_constant.dart';
import '../../controllers/match_detail_controller.dart';
import '../../models/header_type_enum.dart';
import 'fullscreen/video_cover.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-18c95140-aedc-4e47-9bc6-a24b7ecc9060 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 背景+全屏】】】
    【【【 AUTO_PARAGRAPH_TITLE 组件拆分】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 背景图、动画、视频组件
    - 全屏相关组件
    】】】
 *
 */
class HeaderBackground extends StatefulWidget {
  const HeaderBackground({
    super.key,
    this.match,
    required this.controller,
    required this.tag,
    // this.fullscreen = false
  });

  final MatchEntity? match;
  final MatchDetailController controller;
  final String tag;

  // final bool fullscreen;

  @override
  State<HeaderBackground> createState() => _HeaderBackgroundState();
}

class _HeaderBackgroundState extends State<HeaderBackground> {
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 数据仓库没有match情况
    if (widget.match == null) {
      return Container();
      // return Stack(children: [
      //   _buildNormalHeader(),
      //   Positioned(
      //     top: Get.mediaQuery.padding.top,
      //     left: 0,
      //     child: Container(
      //       height: appbarHeight,
      //       padding:
      //           EdgeInsets.only(left: 6.w, top: 4.h, bottom_nav: 4.h, right: 14.w),
      //       child: InkWell(
      //         onTap: () => widgets.controller.back(),
      //         child: Container(
      //           width: 24.w,
      //           height: appbarHeight,
      //           alignment: Alignment.center,
      //           child: ImageView(
      //             widgets.controller.detailState.isMatchSelectExpand.value &&
      //                     !Get.isDarkMode
      //                 ? "assets/images/detail/icon_arrowleft_nor.svg"
      //                 : "assets/images/detail/icon_arrowleft_nor_night.svg",
      //             boxFit: BoxFit.fill,
      //             width: 8.w,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ]);
    }

    return Listener(
      onPointerUp: (_) {
        // 头部区域点击事件
        if (widget.controller.detailState.headerType.value !=
            HeaderType.normal) {
          widget.controller.detailState.videoTopShow.value =
              !widget.controller.detailState.videoTopShow.value;
          widget.controller.detailState.topShowPermanent = false;
          widget.controller.detailState.lockVideoTopShow = false;
          timer?.cancel();
          timer = Timer.periodic(const Duration(seconds: 10), (t) {
            if (mounted) {
              widget.controller.changeVideoTopShow(false);
              // widgets.controller.detailState.videoTopShow.value = false;
            }
          });
        }
      },
      child: Obx(() {
        // 视频
        if (widget.controller.detailState.headerType.value == HeaderType.live ||
            widget.controller.detailState.headerType.value ==
                HeaderType.animate ||
            widget.controller.detailState.headerType.value ==
                HeaderType.replay) {
          if (widget.controller.detailState.liveLoading.value &&
              widget.controller.detailState.headerType.value !=
                  HeaderType.replay) {
            return Container(
              color: Colors.black,
              height: widget.controller.detailState.fullscreen.value
                  ? 1.sh
                  : widget.controller.detailState.obtyHeaderHeight,
              child: const CupertinoActivityIndicator(
                color: Colors.white,
              ).center,
            );
          } else {
            if ((widget.controller.detailState.headerType.value ==
                        HeaderType.live &&
                    widget.controller.detailState.videoUrl != '') ||
                (widget.controller.detailState.headerType.value ==
                        HeaderType.animate &&
                    widget.controller.detailState.animationUrl != '') ||
                widget.controller.detailState.headerType.value ==
                    HeaderType.replay) {
              // double marginTop =
              //     controller.detailState.headerType.value == HeaderType.live
              //         ? 0
              //         : Get.mediaQuery.padding.top;
              /// 允许屏幕自由旋转
              // SystemChrome.setPreferredOrientations([
              //   DeviceOrientation.portraitUp,
              //   DeviceOrientation.portraitDown,
              //   DeviceOrientation.landscapeLeft,
              //   DeviceOrientation.landscapeRight,
              // ]);

              // if (!widgets.controller.detailState.fullscreen.value) {
              //   double animateHeaderHeight = 1.sw / (animateRatio) + Get.mediaQuery.padding.top;
              //   // 防止多次调用
              //   if(widgets.controller.detailState.animateHeaderHeight.value != animateHeaderHeight){
              //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              //       // 动画竖屏 高度需要调整 宽度全屏 比例按照980 / 556
              //       widgets.controller.detailState.animateHeaderHeight.value =
              //           1.sw / (animateRatio) + Get.mediaQuery.padding.top;
              //       widgets.controller.update();
              //     });
              //   }
              //
              // }
              // InAppWebViewSettings settings = InAppWebViewSettings(
              //     isInspectable: false,
              //     mediaPlaybackRequiresUserGesture: false,
              //     allowsInlineMediaPlayback: true,
              //     iframeAllow: "camera; microphone",
              //     underPageBackgroundColor: Colors.black,
              //     transparentBackground: true,
              //     forceDark: ForceDark.ON,
              //     iframeAllowFullscreen: true);
              bool animateNeedPadding = false;
              if (widget.controller.detailState.fullscreen.value &&
                  widget.controller.detailState.headerType.value ==
                      HeaderType.animate) {
                if ((1.sw / 1.sh) >= obtyAnimateZ01Ratio) {
                  animateNeedPadding = true;
                }
              }

              return Container(
                alignment: Alignment.center,
                // 状态栏设置黑色
                color: Colors.black,
                // 非全屏时 动画 设置高度 防止 显示不全问题
                height: widget.controller.detailState.fullscreen.value
                    ? 1.sh
                    : widget.controller.detailState.headerType.value ==
                            HeaderType.animate
                        ? widget
                            .controller.detailState.animateHeaderHeight.value
                        : widget.controller.detailState.obtyHeaderHeight,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          // 适配动画全屏
                          horizontal: animateNeedPadding
                              ? (1.sw - 1.sh * obtyAnimateZ01Ratio).abs() / 2
                              : 0,
                          vertical: 0),
                      child: WebViewWidget(
                        controller:
                            widget.controller.detailState.webViewController,
                      ).paddingOnly(
                          top: widget.controller.detailState.fullscreen.value
                              ? Get.mediaQuery.padding.top
                              : widget
                                  .controller.detailState.physicalPaddingTop),
                    ),

                    // 全屏时 状态栏、分数、按钮展示
                    if (widget.controller.detailState.fullscreen.value)
                      PopScope(
                        canPop: false,
                        child: Visibility(
                          visible:
                              widget.controller.detailState.videoTopShow.value,
                          child: VideoCover(
                            tag: widget.tag,
                            match: widget.match!,
                            controller: widget.controller,
                          ),
                        ),
                      ),
                    if (widget.controller.detailState.videoProgress.value
                            .round() !=
                        100)
                      Obx(() {
                        return Container(
                          color: Colors.transparent,
                          height: widget.controller.detailState.fullscreen.value
                              ? 1.sh
                              : widget.controller.detailState.headerType
                                          .value ==
                                      HeaderType.animate
                                  ? widget.controller.detailState
                                      .animateHeaderHeight.value
                                  : widget
                                      .controller.detailState.obtyHeaderHeight,
                          child: const CupertinoActivityIndicator(
                            color: Colors.white,
                          ).center,
                        );
                      }),
                  ],
                ),
              );
            } else {
              return InkWell(
                child: Container(
                  height: widget.controller.detailState.fullscreen.value
                      ? 1.sh
                      : widget.controller.detailState.headerType.value ==
                              HeaderType.animate
                          ? widget
                              .controller.detailState.animateHeaderHeight.value
                          : widget.controller.detailState.obtyHeaderHeight,
                  color: Colors.black,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// 返回 增大触摸区域
                      Positioned(
                        top: widget.controller.detailState.physicalPaddingTop,
                        left: 6.w,
                        child: InkWell(
                          onTap: () => widget.controller.back(),
                          child: Container(
                            width: 24.w,
                            height: obtyAppbarHeight,
                            alignment: Alignment.center,
                            child: ImageView(
                              "assets/images/detail/icon_arrowleft_nor_night.svg",
                              boxFit: BoxFit.fill,
                              width: 8.w,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        LocaleKeys.video_sorry.tr,
                        style: const TextStyle(color: Colors.white),
                      ).center,
                    ],
                  ),
                ),
              );
            }
          }
        }
        // 赛事信息
        else {
          return _buildNormalHeader();
        }
      }),
    );
  }

  Widget _buildNormalHeader() {
    /// 禁用手机横屏
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    String csid = widget.match?.csid ?? widget.controller.detailState.csid;
    try {
      String bgUrl =
          lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.detail.B');
      String? base64 =
          lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.base64');
      if (base64 == null) {
        return Container(
          height: widget.controller.detailState.obtyHeaderHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  OssUtil.getServerPath(
                    bgUrl,
                  ),
                ),
                fit: BoxFit.cover),
          ),
        );
      } else {
        return SizedBox(
            width: 1.sw,
            height: widget.controller.detailState.obtyHeaderHeight,
            child: WidgetUtils.base64ImageWidget(baseUrl: base64));
      }
    } catch (e) {
      return const CupertinoActivityIndicator().center;
    }
  }
}
