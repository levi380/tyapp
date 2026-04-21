import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';

import '../../../login/login_head_import.dart';
import 'handicap_strategy_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 盘口教程 让球攻略 控制器 HandicapStrategyController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 盘口教程 让球攻略 控制器 HandicapStrategyController
    - HandicapStrategyController
    ```
    ///标题
    List<String> tabList = [
    '0',
    '0/0.5',
    '0.5',
    '0.5/1',
    '1',
    '1/1.5',
    '1.5',
    '1.5/2',
    ];
    ```
    】】】
 *
 */
class HandicapStrategyController extends GetxController  with GetSingleTickerProviderStateMixin {
  final HandicapStrategylogic logic = HandicapStrategylogic();

  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController = ListObserverController(controller: autoScrollController);

  late TabController tabController;


  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: logic.tabList.length, vsync: this);
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
    tabController.dispose();
    autoScrollController.dispose();
    super.onClose();
  }


  ///更新选中title
  changeIndex(int index) {
    logic.currentIndex = index;
    ///滚动到指定索引
    listObserverController.animateTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    update();
  }

  ///滑动监听更新 title
  onObserves(index) {
    logic.currentIndex = index;
    update();
    tabController.animateTo(index);
  }
}
