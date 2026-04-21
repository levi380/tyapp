import 'package:dio/dio.dart';
import 'package:flutter_ty_app/app/modules/main_tab/main_tab_controller.dart';
import 'package:flutter_ty_app/main.dart';

import '../../config/app_logger/app_logger.dart';
import '../../global/config_controller.dart';
import '../../mixins/domain_init_mixin.dart';
import '../../services/models/domain_model.dart';
import '../../utils/bus/bus.dart';
import '../../utils/bus/event_enum.dart';
import 'login_head_import.dart';
import 'ty_login_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-1946adf1-50a0-44ce-9d72-c792c3516a9f-dl 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP登录界面 控制器】】】
    【【【 AUTO_PARAGRAPH_TITLE APP登录界面 控制器 TyLoginController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP登录界面 控制器 TyLoginController
    - TyLoginController
    ```
    生产  开发 测试 隔离 试玩  mini
    ```
    】】】
 *
 */

class TyLoginController extends GetxController with DomainInitMixin {
  final TyLoginlogic logic = TyLoginlogic();

  ///初始化配置
  bool obscurePassword = false;
  String version = '';
  String env = '生产维护';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final dio = Dio();

  String domain = '';
  String terminal = 'mobile';

  @override
  void onInit() {
    // TODO: implement onInit
    initialization();

    ///获取设备信息 版本信息
    getVersion();
    super.onInit();
  }

  void onObscurePassword() {
    obscurePassword = !obscurePassword;
    update();
  }

  ///获取设备信息 版本信息
  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    env = StringKV.env.get() ?? "";
    mainEnv = StringKV.env.get() ?? "";
    update();
  }

  void initialization() {
    env = StringKV.env.get() ?? "";
    mainEnv = StringKV.env.get() ?? "";

    goToSelect(env);
  }

  void goToSelect(String ev) {
    env = ev;
    mainEnv = ev;
    StringKV.env.save(ev);

    if (env == '生产维护') {
      domain = 'https://neibu.dbsportxxx1zx.com/yewu6';
      usernameController.text = 'app001';
      passwordController.text = 'tySWGRrZes6m';
      codeController.text = 'oubao';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_online';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'prod.json';
    } else if (env == '开发') {
      domain = 'http://dev-api-1.dbsportxxxifbdxm2.com/yewu6';
      usernameController.text = 'tyDFW37dIXzl';
      passwordController.text = 'tyDFW37dIXzl';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_dev';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'dev.json';
    } else if (env == '测试') {
      // http://sit-api-2.dbsportxxxifbdxm2.com/yewu6/user/login
      domain = 'http://sit-api-2.dbsportxxxifbdxm2.com/yewu6';
      // usernameController.text = 'tyD77exnBH47';
      // passwordController.text = 'tyD77exnBH47';
      // codeController.text = 'WX246';
      usernameController.text = 'royalrmb008';
      passwordController.text = 'royalrmb008';
      codeController.text = '111111';
      BUILDIN_CONFIG['CURRENT_ENV'] = 'local_test';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'test.json';
    } else if (env == '隔离') {
      /// http://uat-api-1.dbsportxxxifbdxm2.com/yewu6
      domain = 'http://uat-api-1.dbsportxxxifbdxm2.com/yewu6/';
      usernameController.text = 'ty1Cnvi8RSBf';
      passwordController.text = 'ty1Cnvi8RSBf';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_lspre';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'lspre.json';
    } else if (env == '试玩') {
      domain = 'https://api.dbsporxxxw1box.com/yewu6';
      usernameController.text = 'ty9AWxILKhwp';
      passwordController.text = 'ty9AWxILKhwp';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_sandbox';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'play.json';
    } else if (env == 'MINI') {
      domain = 'http://api.dbsportxxxyp7.com/yewu6';
      usernameController.text = 'tyZzGmOV8hf1';
      passwordController.text = 'tyZzGmOV8hf1';
      codeController.text = '';

      BUILDIN_CONFIG['CURRENT_ENV'] = 'idc_ylcs';
      BUILDIN_CONFIG['OSS_FILE_NAME'] = 'mini.json';
    }
  }

  ///登录
  Future<void> toLogin() async {
    if (usernameController.text.isEmpty) {
      ToastUtils.show('请输入用户名称');
      return;
    } else if (passwordController.text.isEmpty) {
      ToastUtils.show('请输入用户密码');
      return;
    }

    ConfigController.to.fetchConfig();
    var res = await AccountApi(AppDio.getInstance().dio, baseUrl: domain)
        .loginPanda(usernameController.text, codeController.text,
            passwordController.text, terminal);
    var data = res['data'];
    AppLogger.debug("登录=====>${data.toString()}");

    if (data != null && data['loginUrl'] != null) {
      try {
        String loginUrl = data['loginUrl'];
        Uri uri = Uri.parse(loginUrl);
        String? sessionId = uri.queryParameters['sessionId'];
        if (sessionId != null && sessionId.isNotEmpty) {
          StringKV.sessionId.save(sessionId);
        }
      } catch (e) {
        Get.log("解析sessionId失败: $e");
      }
    }

    if (res['status'] == false) {
      ToastUtils.show(res['msg']);
    } else {
      if (Get.isRegistered<MainTabController>()) {
        //跳转到home,再重新打开mainTab
        Bus.getInstance()
            .emit(EventType.tyLogined, {'url': data['loginUrl'], 'env': env});
      } else {
        initDomainData(h5Url: data['loginUrl'] ?? '', env: env);
      }
    }
  }

}
