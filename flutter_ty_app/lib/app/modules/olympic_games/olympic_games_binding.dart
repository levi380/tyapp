import 'package:get/get.dart';

import 'olympic_games_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_MENU 赛事详情 】】】
    【【【 AUTO_DOCUMENT_TITLE 下拉联赛选择】】】
    【【【 AUTO_PARAGRAPH_TITLE 下拉联赛选择组件】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    -  绑定游戏类
    】】】
 *
 */
class OlympicGamesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OlympicGamesController());
  }
}
