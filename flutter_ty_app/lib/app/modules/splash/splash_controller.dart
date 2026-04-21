import 'package:common_utils/common_utils.dart';
import 'package:flutter_ty_app/app/config/app_logger/app_logger.dart';
import 'package:flutter_ty_app/app/global/ty_user_controller_ext.dart';
import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';

import '../../global/config_controller.dart';
import '../../global/ty_user_controller.dart';
import '../../mixins/domain_init_mixin.dart';
import '../../utils/systemchrome.dart';
import 'splash_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-e0a4b6c0-8628-4ef2-8688-3a7e18188421-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP启动页】】】
    【【【 AUTO_PARAGRAPH_TITLE APP启动页 控制器 SplashController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP启动页 控制器 SplashController
    - SplashController
    】】】
 *
 */
class SplashController extends GetxController
    with WidgetsBindingObserver, DomainInitMixin {
  final Splashlogic logic = Splashlogic();

  @override
  void onInit() {
    super.onInit();

    ///ws开启 对app状态进行监听
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initData() async {
    String? token = StringKV.token.get();
    String api = StringKV.baseUrl.get() ?? '';
    AppLogger.debug('api: $api');
    SystemUtils.isDarkMode(Get.isDarkMode);

    if (token == null || ObjectUtil.isEmptyString(token)) {
      ///默认入口 配置环境
      ///**************  本地代码走查 设置为  试玩  否则本地代码运行入口阻塞  **************
      ///**************  内部提测  可选择为测试  方便验收 ***********
       //缺省使用试玩环境
      String env = StringKV.env.get() ?? "试玩";
      // String env = StringKV.env.get() ?? "测试";

      await dbClear();
      initDomainData(h5Url: '', env: env);
      // initDomainData(h5Url: 'https://api.dbsporxxxw1box.com',env:'试玩');

      // initDomainData(h5Url: '',env:env);
      // AppDio.getInstance().setApiDomainForNoToken(
      //   //  "http://sit-api-1.sportxxxifbdxm2.com");
      //  "http://api.sportxxxvo3.com");
      // Get.offNamed(Routes.mainTab);
    } else {
      ConfigController.to.fetchConfig();
      TYUserController.to.getUserInfo();

      Get.offNamed(Routes.mainTab);
    }
  }
}
