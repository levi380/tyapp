import 'dart:core';
import 'package:flutter_ty_app/main.dart';
import '../../mixins/domain_init_mixin.dart';
import '../../services/network/domain.dart';
import '../login/login_head_import.dart';
import 'sdk_home_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-16041ec7-d06f-4baf-a76c-bc7753195068-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APP入口页面】】】
    【【【 AUTO_PARAGRAPH_TITLE APP入口页面 控制器 SdkTyHomeController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - APP入口页面 控制器 SdkTyHomeController
    - SdkTyHomeController
    】】】
 *
 */
class SdkTyHomeController extends GetxController with DomainInitMixin {
  final SdkHomelogic logic = SdkHomelogic();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady

    super.onReady();

    europeanCupSetting = false;
    olympicGamesSetting = false;

    //此处没必要clear，退出登录时已经clear
    //await dbClear();

    AllDomain.instance().sdkTyHomeController = this;
    initDomainData(h5Url: h5ulr, env: h5Env);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    //AllDomain.instance().sdkTyHomeController = null;
    super.onClose();
  }

  Future<void> retry() async {
    logic.loading.value = true;

    europeanCupSetting = false;
    olympicGamesSetting = false;
    dbClear();
    ///解析URL参数
    initDomainData(h5Url: h5ulr, env:h5Env);

  }
}
