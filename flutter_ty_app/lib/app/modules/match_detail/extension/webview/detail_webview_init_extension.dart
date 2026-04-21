import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../utils/webview_ios_http_auth.dart';
import '../../controllers/match_detail_controller.dart';
import 'detail_webview_interaction_extension.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-ea24aa25-3baf-4294-aec9-8f107d938c0f 】】】
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE webview】】】
    【【【 AUTO_PARAGRAPH_TITLE webview交互逻辑】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - webview的一些初始化配置
    】】】
 *
 */
extension DetailWebViewInitExtension on MatchDetailController {
  initWebView() {
    TargetPlatform platform = Get.theme.platform;
    if (platform == TargetPlatform.windows) {
      // windows 不进行初始化
      return;
    }
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{}, // ios视频自动播放
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    final NavigationDelegate nav = NavigationDelegate(
      onProgress: (int progress) {
        detailState.videoProgress.value = progress;
        if (progress == 100) {
          djImageCoding();
        }
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    tyWebViewSetNavigationDelegateForIosUnawaited(
      controller: controller,
      navigationDelegate: nav,
    );
    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    detailState.webViewController = controller;
  }
}
