import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_windows/webview_windows.dart';

import '../../routes/app_pages.dart';

import '../../utils/lodash.dart';
import '../../utils/match_util.dart';
import '../../utils/oss_util.dart';
import '../../widgets/hit_test_blocker.dart';
import '../match_detail/models/header_type_enum.dart';
import 'pip_video_controller.dart';
import 'widgets/pip_bottom.dart';
import 'widgets/pip_header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PipVideoView extends StatefulWidget {
  final VoidCallback? onClose;

  const PipVideoView({
    Key? key,
    this.onClose,
  }) : super(key: key);

  @override
  _PipVideoViewState createState() => _PipVideoViewState();
}

class _PipVideoViewState extends State<PipVideoView> with RouteAware {
  double _left = 14.w;
  double _top = 100;
  bool _isDragging = false;
  RouteObserver<Route<dynamic>>? routeObserver;

  double initialWidth = 362.w;
  double initialHeight = 254;

  @override
  void initState() {
    super.initState();
    // 在初始化时计算居中位置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _left = (size.width - initialWidth) / 2;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver = Routes.observer;
    routeObserver?.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPushNext() {
    // 路由跳转其他页面
    final topRoute = Routes.observer.topRoute;

    // 只有当显式检测到是页面路由(PageRoute)时才停止播放
    if (topRoute is PageRoute) {
      Get.log("PipVideo: pausing for PageRoute: ${topRoute.settings.name}");
      PipVideoController.to?.pauseVideoForNavigation();
    } else {
      Get.log(
          "PipVideo: didPushNext ignored. TopRoute: ${topRoute?.runtimeType}");
    }
  }

  @override
  void didPopNext() {
    // 路由返回
    PipVideoController.to?.resumeVideoFromNavigation();
  }

  @override
  dispose() {
    routeObserver?.unsubscribe(this);
    super.dispose();
    Get.delete<PipVideoController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PipVideoController>(
      init: PipVideoController(),
      builder: (controller) {
        // 画中画模式
        return _buildPipView(controller);
      },
    );
  }

  // 构建画中画视图
  Widget _buildPipView(PipVideoController controller) {
    // 计算水平居中位置
    // final screenWidth = MediaQuery.of(context).size.width;
    // final left = (screenWidth - initialWidth) / 2;
    String csid = controller.state.match?.csid ?? "1";
    String bgUrl =
        lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.detail.B');
    // String? base64 = lodash.get(DetailCsidConfig.detailCsidConfig, 'CSID_$csid.base64');
    return Positioned(
      left: _left,
      // left: left, // 始终居中
      top: _top,
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            _isDragging = true;
          });
        },
        onPanUpdate: (details) {
          setState(() {
            _left += details.delta.dx;
            _top += details.delta.dy;
            _ensureInScreenBounds();
          });
        },
        onPanEnd: (details) {
          setState(() {
            _isDragging = false;
          });
        },
        child: Container(
          width: initialWidth,
          height:
              // controller.state.headerType == HeaderType.animate
              //     ? initialWidth / (controller.state.animateRatio) :
              initialWidth * (9 / 16),
          decoration: BoxDecoration(
            image: controller.state.match != null &&
                    [HeaderType.normal].contains(controller.state.headerType)
                ? DecorationImage(
                    image: NetworkImage(
                      OssUtil.getServerPath(
                        bgUrl,
                      ),
                    ),
                    fit: BoxFit.cover)
                : null,
            color: Get.isDarkMode ? Color(0xff27292f) : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
            border: Border.all(
              width: 0.5,
              // strokeAlign: BorderSide.strokeAlignOutside,
              color: Colors.white.withValues(alpha: 0.20),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Stack(
              children: [
                // WebView
                if ([HeaderType.animate, HeaderType.live]
                    .contains(controller.state.headerType))
                  HitTestBlocker(
                    child: Listener(
                        onPointerUp: (_) {
                          controller.changeTopShow();
                        },
                        child: _buildWebView(controller)),
                  ),
                // if (controller.state.match != null &&
                //     [HeaderType.normal].contains(controller.state.headerType))
                //   PipBackground(match: controller.state.match!),
                // 头部
                HitTestBlocker(
                  child: PipHeader(
                    controller: controller,
                    onClose: widget.onClose,
                  ),
                ),
                // 视频、动画切换按钮
                PipBottom(
                  controller: controller,
                ),

                // if (controller.state.requestStatus == RequestStatus.loading)
                //   Loading(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebView(PipVideoController controller) {
    // windows
    if (Platform.isWindows) {
      if (controller.state.webviewWindowsController == null) {
        return Container();
      }

      return Webview(controller.state.webviewWindowsController!);
    }
    if (controller.state.webViewController == null) {
      return Container();
    }
    return WebViewWidget(
      controller: controller.state.webViewController!,
    );
  }

  void _ensureInScreenBounds() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    _left = _left.clamp(0.0, screenWidth - initialWidth);
    _top = _top.clamp(0.0, screenHeight - initialHeight);
  }
}
