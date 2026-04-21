import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../main.dart';
import '../../modules/login/login_head_import.dart';
import '../../utils/utils.dart';
import '../../utils/webview_ios_http_auth.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7442ad20-6841-43b0-910a-13b44c7b8923-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 规则说明】】】
    【【【 AUTO_PARAGRAPH_TITLE 规则说明 预加载缓存文件 WebviewCacheController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 规则说明 预加载缓存文件 WebviewCacheController
    - WebviewCacheController
    ```
    ///初始化数据
    initData();
    ```
    】】】
 *
 */
class WebviewCacheController extends GetxController {
  static WebviewCacheController get to =>
      Get.put(WebviewCacheController(), permanent: true);

   Map<String, Widget> cache = {};

  String getKey(String key) => '$key-${_getLang()}-${_getTheme()}';

  void setCache(String key, Widget value) {
    cache[getKey(key)] = value;
  }

  Widget? getCache(String key) => cache[getKey(key)];

  /// 对外使用入口
  ///获取规则
  Widget getRule() => getCache('rule') ?? initRule();
  ///获取默认语言
  String _getLang() => Get.locale?.toLanguageTag() ?? 'zh-CN';
  ///获取默认皮肤
  String _getTheme() => Get.isDarkMode ? 'theme02' : 'theme01';

  /// 规则说明页面初始化
  Widget initRule() {
    if (Platform.isWindows) return const SizedBox();

     String apiUrl = MapKV.topic.get()?['sports_rules'] ??
        '${getStaticDomain()}/sports-rules/23-app/common/';

     String token = StringKV.token.get() ?? '';
     String api = apiEncrypt(StringKV.best_api.get() ?? '');
     String theme = _getTheme();
     String langTag = _getLang();

    /// 语言映射表（避免冗长 if else）
     Map<String, String> langMap = {
      'zh-CN': 'zh_cn',
      'zh-TW': 'zh_tw',
      'en-GB': 'en_gb',
      'vi-VN': 'vi_vn',
      'th-TH': 'th_th',
      'ms-MY': 'ms_my',
      'id-ID': 'id_id',
      'pt-PT': 'pt_pt',
      'ko-KR': 'ko_kr',
      'es-ES': 'es_es',
      'my-MM': 'my_mm',
      'ar-AE': 'ar_ar',
      'ru-RU': 'ru_ru',
      'hi-IN': 'hi_in',
    };

    /// 默认简体中文
     String lang = langMap[langTag] ?? 'zh_cn';

     String url = _buildUrl(
      apiUrl: apiUrl,
      lang: lang,
      token: token,
      theme: theme,
      api: api,
    );

    Widget webviewWidget = _buildWebView(url);
    setCache('rule', webviewWidget);
    return webviewWidget;
  }

  /// 构建 WebViewWidget
  Widget _buildWebView(String url) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    final NavigationDelegate nav = NavigationDelegate(
      onPageStarted: (_) {},
      onPageFinished: (_) {},
      onWebResourceError: (_) {},
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    tyWebViewBindNavigationAndLoadUnawaited(
      controller: controller,
      navigationDelegate: nav,
      loadRequestUri: Uri.parse(url),
    );

    return WebViewWidget(
      controller: controller,
      gestureRecognizers: {
        Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer(),
        ),
      },
    );
  }

  /// 统一 URL 拼接
  String _buildUrl({
    required String apiUrl,
    required String lang,
    required String token,
    required String theme,
    required String api,
  }) {
    String base =
        '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';

    /// 添加随机时间戳避免webview缓存
    return '$base&rdm=${DateTime.now().millisecondsSinceEpoch}';
  }
}

