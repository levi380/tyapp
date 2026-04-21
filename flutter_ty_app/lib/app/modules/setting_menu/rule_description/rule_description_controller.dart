
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/utils.dart';
import '../../../utils/webview_ios_http_auth.dart';
import 'rule_description_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-7442ad20-6841-43b0-910a-13b44c7b8923-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 规则说明】】】
    【【【 AUTO_PARAGRAPH_TITLE 规则说明 控制器 RuleDescriptionController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 规则说明 控制器 RuleDescriptionController
    - RuleDescriptionController
    ```
    ///初始化数据
    initData();
    ```
    】】】
 *
 */
class RuleDescriptionController extends GetxController {
  static RuleDescriptionController get to =>
      Get.put(RuleDescriptionController());
  final RuleDescriptionlogic logic = RuleDescriptionlogic();
  late final WebViewController webViewController;


  late Widget webviewWidget;


  @override
  void onInit() {
    // TODO: implement onInit
    initData();
    super.onInit();
  }

  void initData() {
    if (logic.isInit) return;
    logic.isInit = true;

    String apiUrl = MapKV.topic.get()?['sports_rules'] ??
        '${getStaticDomain()}/sports-rules/23-app/common/';
    String token = StringKV.token.get() ?? '';
    String api = StringKV.best_api.get() ?? '';
    // 加密api
    api = apiEncrypt(api);
    String theme = Get.isDarkMode ? 'theme02' : 'theme01';
    String tag = Get.locale!.toLanguageTag();

    String lang ='zh_cn';
    String url = 'en_GB';

    if(tag.contains('zh-CN')){
      ///中文-简体
      lang ='zh_cn';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('zh-TW')){
      ///中文-繁体
      lang ='zh_tw';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('en-GB')){
      ///英式-英语
      lang ='en_gb';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('vi-VN')){
      ///越南
      lang ='vi_vn';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('th-TH')){
      ///泰国
      lang ='th_th';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('ms-MY')){
      ///马来西亚
      lang ='ms_my';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('id-ID')){
      ///印尼语
      lang ='id_id';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('pt-PT')){
      ///葡萄牙
      lang ='pt_pt';
      url = '$apiUrl#/pt_br?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('ko-KR')){
      ///韩国
      lang ='ko_kr';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('es-ES')){
      ///西班牙语
      lang ='es_es';
      url = '$apiUrl#/en_GB?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('my-MM')){
      ///缅甸语
      lang ='my_mm';
      url = '$apiUrl#/en_GB?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('ar-AE')){
      ///阿拉伯语
      lang ='ar_ar';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('ru-RU')){
      ///俄语
      lang ='ru_ru';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else if(tag.contains('hi-IN')){
      ///印地语
      lang ='hi_in';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }else {
      lang ='zh_cn';
      url = '$apiUrl#/$lang?token=$token&themeColors=$theme&api=$api&sty=y0&isTablet=$isIPad&project=app-h5';
    }

    url = url + '&rdm=' + DateTime.now().millisecondsSinceEpoch.toString();

    if (kDebugMode) {
      AppLogger.debug('规则地址---$url');
    }

    initWeb(url);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  initWeb(String url) {
    final NavigationDelegate nav = NavigationDelegate(
      onProgress: (int progressa) {
        logic.progress = progressa;
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onHttpAuthRequest: tyWebViewRejectHttpAuth,
    );
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    tyWebViewBindNavigationAndLoadUnawaited(
      controller: webViewController,
      navigationDelegate: nav,
      loadRequestUri: Uri.parse(url),
    );

    webviewWidget = WebViewWidget(
      controller: webViewController,
    );
  }
}
