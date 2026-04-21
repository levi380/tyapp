import 'package:get/get.dart';

import 'quick_bet_controller.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID cc-0ff385d2-90ba-4fd9-bd7f-068a85286ade 】】】
    【【【 AUTO_DOCUMENT_MENU 一键投注弹窗 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注弹窗-业务逻辑 】】】
    【【【 AUTO_PARAGRAPH_TITLE 主控制器 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注binding样式

    】】】
 *
 */
class QuickBetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuickBetController());
  }
}
