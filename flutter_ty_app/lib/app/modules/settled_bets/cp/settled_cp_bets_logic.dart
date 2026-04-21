import 'package:flutter_ty_app/app/modules/vr/vr_sport_detail/import_head.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-9a61e93d-0e07-4552-a0f0-3de51265f9a8-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票注单主界面控制器】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票注单主界面
    - 投注记录和追号记录切换
    】】】
 *
 */
class SettledCpBetsLogic extends GetxController {
  ///type彩票0：投注记录
  ///type彩票1：追号记录
  var type = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///切换投注记录和追号记录
  setType(int type) {
    this.type.value = type;
  }
}
