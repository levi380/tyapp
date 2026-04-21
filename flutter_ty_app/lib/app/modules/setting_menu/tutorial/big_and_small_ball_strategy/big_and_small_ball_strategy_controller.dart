
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';


import '../../../login/login_head_import.dart';
import 'big_and_small_ball_strategy_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6f211a90-890a-42d7-8ab1-05544d7875d0-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 大小球攻略 控制器 BigAndSmallBallStrategyController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 大小球攻略 控制器  BigAndSmallBallStrategyController
    - BigAndSmallBallStrategyController
    ```
    ///标题
    List<String> tabList = [
    '2.5',
    '2.5/3',
    '3',
    '3/3.5',
    ];

    /// 标题选中更新
    changeIndex(int index)

    ///滑动滚动索引更新
    onObserves(index)

    ///跳转模拟训练
    onSimulationTraining()
    ```
    】】】
 *
 */
class BigAndSmallBallStrategyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final BigAndSmallBallStrategylogic logic = BigAndSmallBallStrategylogic();
  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController =
      ListObserverController(controller: autoScrollController);

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

  /// 标题选中更新
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

  ///滑动滚动索引更新
  onObserves(index) {
    logic.currentIndex = index;
    tabController.animateTo(index);
    update();
  }

  ///跳转模拟训练
  onSimulationTraining() {
    Get.offAndToNamed(Routes.simulationTraining);
  }
}
