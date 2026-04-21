import 'dart:async';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// Cancels pending HTTP basic/digest auth from the WebView.
void tyWebViewRejectHttpAuth(HttpAuthRequest request) {
  request.onCancel();
}

/// WebKit SSL handler: must call [PlatformSslAuthError.proceed] or [cancel] or
/// iOS can leave the auth challenge channel with a null payload (NSNull cast).
Future<void> tyWebViewInstallIosSslDelegateIfNeeded(
  NavigationDelegate navigationDelegate,
) async {
  if (!Platform.isIOS && !Platform.isMacOS) {
    return;
  }
  if (WebViewPlatform.instance is! WebKitWebViewPlatform) {
    return;
  }
  final Object platform = navigationDelegate.platform;
  if (platform is! WebKitNavigationDelegate) {
    return;
  }
  await platform.setOnSSlAuthError((PlatformSslAuthError error) {
    error.proceed();
  });
}

Future<void> tyWebViewSetNavigationDelegateForIos({
  required WebViewController controller,
  required NavigationDelegate navigationDelegate,
}) async {
  await controller.setNavigationDelegate(navigationDelegate);
  await tyWebViewInstallIosSslDelegateIfNeeded(navigationDelegate);
}

void tyWebViewSetNavigationDelegateForIosUnawaited({
  required WebViewController controller,
  required NavigationDelegate navigationDelegate,
}) {
  unawaited(
    tyWebViewSetNavigationDelegateForIos(
      controller: controller,
      navigationDelegate: navigationDelegate,
    ),
  );
}

/// Await navigation delegate + iOS SSL hook, then load. Use from async code or
/// wrap with [unawaited] when the surrounding API must stay synchronous.
Future<void> tyWebViewBindNavigationAndLoad({
  required WebViewController controller,
  required NavigationDelegate navigationDelegate,
  Uri? loadRequestUri,
  String? loadHtmlString,
}) async {
  await tyWebViewSetNavigationDelegateForIos(
    controller: controller,
    navigationDelegate: navigationDelegate,
  );
  if (loadRequestUri != null) {
    await controller.loadRequest(loadRequestUri);
  } else if (loadHtmlString != null) {
    await controller.loadHtmlString(loadHtmlString);
  }
}

/// Fire-and-forget variant for sync `initState` / builders.
void tyWebViewBindNavigationAndLoadUnawaited({
  required WebViewController controller,
  required NavigationDelegate navigationDelegate,
  Uri? loadRequestUri,
  String? loadHtmlString,
}) {
  unawaited(
    tyWebViewBindNavigationAndLoad(
      controller: controller,
      navigationDelegate: navigationDelegate,
      loadRequestUri: loadRequestUri,
      loadHtmlString: loadHtmlString,
    ),
  );
}
