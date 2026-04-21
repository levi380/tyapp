import '../../login/login_head_import.dart';
import 'big_and_small_ball_strategy/big_and_small_ball_strategy_controller.dart';
import 'handicap_strategy/handicap_strategy_controller.dart';
import 'tutorial_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 控制器 TutorialController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程 控制器 TutorialController
    - TutorialController
    ```
    /// 0 让球攻略 1 大小球攻略
    int tutorial = 0;

    /// 让球攻略  大小球攻略 头部
    onTutorial(int index)；
    ```
    】】】
 *
 */
class TutorialController extends GetxController {
  final Tutoriallogic logic = Tutoriallogic();
  final ScrollController scrollController = ScrollController();



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

  /// 让球攻略  大小球攻略 头部
  onTutorial(int index) {
    logic.tutorial = index;
    logic.tutorial == 0
        ? Get.lazyPut(() => HandicapStrategyController())
        : Get.lazyPut(() => BigAndSmallBallStrategyController());
    if (index == 0) {
      scrollController.jumpTo(0);
    } else {
      scrollController.jumpTo(700);
    }
    update();
  }
}
