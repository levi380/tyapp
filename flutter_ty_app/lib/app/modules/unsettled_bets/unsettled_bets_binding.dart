import 'package:flutter_ty_app/app/modules/unsettled_bets/unsettled_bets_logic.dart';
import 'package:get/get.dart';

/**
 *
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6037f549-f1a7-47b7-94d0-2f3171c23c3d-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 注单列表 】】】
    【【【 AUTO_DOCUMENT_TITLE 体育注单列表 】】】
    【【【 AUTO_PARAGRAPH_TITLE 未结注单Binding层】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    】】】
 *
 */

class UnsettledBetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnsettledBetsLogic());
  }
}
