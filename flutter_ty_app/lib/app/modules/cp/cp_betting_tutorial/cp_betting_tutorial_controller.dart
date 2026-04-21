import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollview_observer/scrollview_observer.dart';


import '../../login/login_head_import.dart';
import 'cp_betting_tutorial_logic.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-6413aae8-8a7e-47c0-9a74-e3720f3aa655-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票盘口教程】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票盘口教程 控制器 CpBettingTutorialController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票盘口教程 控制器 CpBettingTutorialController
    - CpBettingTutorialController
    - 包含-双面盘-选择彩种-标准盘-玩法选择及其投注区-双面盘-玩法旋转及其投注区-进行投注双面盘-进行投注-标准盘-查看兑换结果-个性化设置
    - 跳转方法 逻辑
    ```
    ///彩票教程标题
    List<String> tabList = [
      LocaleKeys.zr_cp_footer_menu_cp_double.tr,
      LocaleKeys.zr_cp_footer_menu_cp_select.tr,
      LocaleKeys.zr_cp_footer_menu_cp_double_sided_bets.tr,
      LocaleKeys.zr_cp_footer_menu_cp_standard.tr,
      LocaleKeys.zr_cp_footer_menu_cp_place_double.tr,
      LocaleKeys.zr_cp_footer_menu_cp_place_standard.tr,
      LocaleKeys.zr_cp_footer_menu_cp_results.tr,
      LocaleKeys.zr_cp_footer_menu_cp_personalization.tr,
      LocaleKeys.zr_cp_footer_menu_cp_more_features.tr,
    ];
    ```
    】】】
 *
 */
class CpBettingTutorialController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CpBettingTutoriallogic logic = CpBettingTutoriallogic();

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


  ///不同语言图片，不支持的用英文图片
  getLanguageImg(int index) {
    String tag = Get.locale!.toLanguageTag();
    if(tag.contains('zh-CN')){
      return 'assets/images/icon/cp_${index}_zh_cn.png';
    }else if (tag.contains('zh-TW')){
      return 'assets/images/icon/cp_${index}_zh_tw.png';
    }else if (tag.contains('en-GB')){
      return 'assets/images/icon/cp_${index}_en_gb.png';
    }else if (tag.contains('vi-VN')){
      return 'assets/images/icon/cp_${index}_vi_vn.png';
    }else if (tag.contains('pt-PT')){
      return 'assets/images/icon/cp_${index}_pt_pt.png';
    }else {
      return 'assets/images/icon/cp_${index}_en_gb.png';
    }

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
