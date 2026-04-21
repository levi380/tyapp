import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import '../../login/login_head_import.dart';
import 'zr_tutorial_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-488c53f4-9968-4535-b4cf-778c73d801d7-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐真人教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐真人教程 控制器 ZrTutorialController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐真人教程 控制器 ZrTutorialController
    - ZrTutorialController
    - 包含-游戏规则-博牌牌例-点数计算-玩法判定-赔率表-游戏特点-注意事项
    - 等规则玩法
    ```
    ///标题
    List<String> tabList = [
      LocaleKeys.zr_cp_footer_menu_zr_menus_0.tr,
      LocaleKeys.zr_cp_footer_menu_zr_menus_1.tr,
      LocaleKeys.zr_cp_footer_menu_zr_menus_2.tr,
      LocaleKeys.zr_cp_footer_menu_zr_menus_3.tr,
      LocaleKeys.zr_cp_footer_menu_zr_menus_4.tr,
      LocaleKeys.zr_cp_footer_menu_zr_menus_5.tr,
      LocaleKeys.zr_cp_footer_menu_zr_menus_6.tr,
    ];
    ```
    】】】
 *
 */
class ZrTutorialController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ZrTutoriallogic logic = ZrTutoriallogic();

  final AutoScrollController autoScrollController = AutoScrollController();
  late ListObserverController listObserverController =
      ListObserverController(controller: autoScrollController);
  late TabController tabController;


  PageController pageController = PageController();



  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: logic.tabList.length, vsync: this);
    super.onInit();
  }

  ///头部选中更新
  changeIndex(int index) {
    logic.currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    update();
  }

  ///页面滑动更新
  onPageChanged(int page) {
    tabController.animateTo(page);
    logic.currentIndex = page;
    update();
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
}
