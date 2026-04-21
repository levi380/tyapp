
import 'package:get/get.dart';

import '../controllers/vr_sport_detail_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-528b398c-8958-44e0-9713-fb7030115573-sz 】】】
    【【【 AUTO_DOCUMENT_MENU vr体育 】】】
    【【【 AUTO_DOCUMENT_TITLE vr详情】】】
    【【【 AUTO_PARAGRAPH_TITLE vr详情-Binding】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - vr详情-Binding
    】】】
 *
 */
class VrSportDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VrSportDetailLogic());

    /// 赛事详情
    // Get.lazyPut(() => MatchDetailController());
  }
}
