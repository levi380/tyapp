import 'package:flutter_ty_app/app/utils/utils.dart';
import 'package:get/get.dart';

import 'token_expired_state.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-79f99259-4a57-43da-8cf8-4bf260562931-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 独立模块 】】】
    【【【 AUTO_DOCUMENT_TITLE  APPToken失效页面】】】
    【【【 AUTO_PARAGRAPH_TITLE APPToken失效页面 控制器 TokenExpiredLogic 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - PPToken失效页面 控制器 TokenExpiredLogic
    - TokenExpiredLogic
    】】】
 *
 */
class TokenExpiredLogic extends GetxController {
  final TokenExpiredState state = TokenExpiredState();
  static TokenExpiredLogic get to => Get.find();

  // 图片的key
  // String imgKey = 'images/common/friendly_reminder_zh.jpg';
  var expiredState = TokenExpiredState();


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

  @override
  void onInit() {
    // TODO: implement onInit

    onInitData();
    super.onInit();
  }

  void onInitData() {
    if(!isZh()){
      expiredState.imgKey = 'assets/images/common/friendly_reminder_en.jpg';
    }
    
  }
}
