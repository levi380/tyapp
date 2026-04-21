import 'dart:convert';
import 'dart:async';

import 'package:filbet/src/login/captcha/captcha_result.dart';
import 'package:filbet/widgets/loadinng_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/utils/webview_ios_http_auth.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CaptchaDialog extends StatefulWidget {
  const CaptchaDialog({
    this.onCaptchaSubmit,
  });

  /// 用户提交验证码后调用；返回 true 表示校验通过并关闭弹窗，false 表示校验失败仅刷新页面
  final Future<bool> Function(CaptchaResult result)? onCaptchaSubmit;

  @override
  State<CaptchaDialog> createState() => _CaptchaDialogState();
}

// 静态变量跟踪 WebView 状态
class _CaptchaWebViewTracker {
  static bool _isWebViewActive = false;
  static Completer<void>? _releaseCompleter;

  static bool get isWebViewActive => _isWebViewActive;

  static Future<void> waitForRelease() async {
    if (!_isWebViewActive) return;
    _releaseCompleter = Completer<void>();
    return _releaseCompleter!.future;
  }

  static void markWebViewActive() {
    _isWebViewActive = true;
  }

  static void markWebViewInactive() {
    _isWebViewActive = false;
    _releaseCompleter?.complete();
    _releaseCompleter = null;
  }
}

class _CaptchaDialogState extends State<CaptchaDialog> {
  WebViewController? _controller;
  final UniqueKey _webViewKey = UniqueKey();
  bool _isDisposed = false;
  bool _showWebView = true;
  bool _webViewReady = false;

  @override
  void initState() {
    super.initState();
    if (_CaptchaWebViewTracker.isWebViewActive) {
      _CaptchaWebViewTracker.waitForRelease().then((_) {
        if (mounted && !_isDisposed) _initializeWebView();
      });
    } else {
      _initializeWebView();
    }
  }

  void _initializeWebView() {
    if (_isDisposed) return;

    _CaptchaWebViewTracker.markWebViewActive();
    final NavigationDelegate nav = NavigationDelegate(
      onPageFinished: (_) {
        if (mounted && !_isDisposed) {
          setState(() => _webViewReady = true);
        }
      },
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    final WebViewController c = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..addJavaScriptChannel(
        'Captcha',
        onMessageReceived: (message) async {
          if (!mounted) return;
          try {
            final data = jsonDecode(message.message) as Map<String, dynamic>;
            if (data['cancel'] == true) {
              Get.back(result: null);
              return;
            }
            final ticket = data['ticket']?.toString() ?? '';
            final randstr = data['randstr']?.toString() ?? '';
            if (ticket.isEmpty || randstr.isEmpty) {
              Get.back(result: null);
              return;
            }
            final result = CaptchaResult(ticket, randstr);
            final callback = widget.onCaptchaSubmit;
            if (callback != null) {
              final success = await callback(result);
              if (!mounted) return;
              if (success) {
                Get.back(result: result);
              } else {
                // 校验失败，只刷新 HTML 不关弹窗
                _controller?.reload();
              }
            } else {
              Get.back(result: result);
            }
          } catch (e) {
            Get.back(result: null);
          }
        },
      );
    _controller = c;
    unawaited(() async {
      await c.setNavigationDelegate(nav);
      await tyWebViewInstallIosSslDelegateIfNeeded(nav);
      await c.loadFlutterAsset('assets/html/app.html');
    }());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // 手动关闭时立即从 widget tree 中移除 WebView
        if (didPop) {
          setState(() {
            _showWebView = false;
          });
          _cleanupWebView();
        }
      },
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            if (_showWebView && _controller != null)
              WebViewWidget(
                key: _webViewKey,
                controller: _controller!,
              ),
            if (!_webViewReady) loadinngView(),
          ],
        ),
      ),
    );
  }

  void _cleanupWebView() {
    if (_controller != null) {
      try {
        _controller!.clearCache();
        _controller!.clearLocalStorage();
      } catch (e) {
        // 忽略清理错误
      }
      _controller = null;
    }
    // 延迟标记为非活动状态，确保 WebView 完全释放
    Future.delayed(const Duration(milliseconds: 100), () {
      _CaptchaWebViewTracker.markWebViewInactive();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _showWebView = false; // 确保不再显示 WebView
    _cleanupWebView();
    super.dispose();
  }
}
