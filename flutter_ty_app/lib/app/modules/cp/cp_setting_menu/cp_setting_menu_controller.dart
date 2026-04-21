import '../../../global/ty_user_controller.dart';
import '../../../services/api/cp_api.dart';
import '../../../services/models/res/get_user_info_cp_entity.dart';
import '../../../utils/systemchrome.dart';
import '../../home/controllers/home_controller.dart';
import '../../login/login_head_import.dart';
import 'cp_setting_menu_logic.dart';
/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-865e55c5-ff96-400e-9c5b-fa97bce48a09-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票设置菜单 控制器 CpSettingMenuController 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票设置菜单 控制器 CpSettingMenuController
    - CpSettingMenuPage
    - 包含-主题风格-音效-中奖提示-主题风格-游戏玩法投注金额区间
    ```
    ///主题风格 1日间 2夜间
    int themeStyle = 1;

    ///音效
    bool countDownBeep = false;

    ///中奖提示
    bool winModal = false;

    ///冷热提示
    bool coldHot = false;

    ///遗留提示
    bool missRemind = false;

    ///立即投注确认弹窗
    bool doubleBetConfirm = false;
    ```
    】】】
 *
 */
class CpSettingMenuController extends GetxController {
  final CpSettingMenulogic logic = CpSettingMenulogic();
  bool isDarkMode = false;



  late List<GetUserInfoCpDataDoubleBetRangeList> doubleBetRangeList = [];
  late List<GetUserInfoCpDataFeatureBetRangeList> featureBetRangeList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    initData();
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

  ///初始化数据
  Future<void> initData() async {
    Get.isDarkMode ? logic.themeStyle = 1 : logic.themeStyle = 0;
    logic.themeStyle = Get.isDarkMode ? 2 : 1;
    isDarkMode = Get.isDarkMode ? true : false;
    update();

    final res = await CpApi.instance().getUserInfoCp(
      TYUserController.to.userName,
    );

    if (res.code == '200') {
      logic.doubleSidedPlayId = res.data.selectConfigId;
      logic.featuredGamesId = res.data.selectFeatureConfigId;
      logic.coldHot = res.data.coldHot;
      logic.countDownBeep = res.data.countDownBeep;
      logic.doubleBetConfirm = res.data.doubleBetConfirm;
      logic.missRemind = res.data.missRemind;
      logic.winModal = res.data.winModal;
      if (res.data.doubleBetRangeList.isNotEmpty) {
        doubleBetRangeList = res.data.doubleBetRangeList;
      }
      if (res.data.doubleBetRangeList.isNotEmpty) {
        featureBetRangeList = res.data.featureBetRangeList;
      }

      update();
    }
  }

  ///主题风格
  onThemeStyle(int theme) {
    logic.themeStyle = theme;
    Get.changeThemeMode(theme == 1 ? ThemeMode.light : ThemeMode.dark);
    BoolKV.theme.save(Get.isDarkMode);
    TyHomeController.to.homeState.isLight = theme == 2 ? false : true;
    TyHomeController.to.update();
    isDarkMode = theme == 2 ? true : false;
    SystemUtils.isDarkMode(theme == 2 ? true : false);
    update();
  }

  ///音效
  onSoundEffects() {
    logic.countDownBeep = !logic.countDownBeep;
    update();
  }

  ///中奖提示
  onWinningTips() {
    logic.winModal = !logic.winModal;
    update();
  }

  ///冷热说明在点击时提示
  onHotAndColdTips() {
    logic.coldHot = !logic.coldHot;
    update();
  }

  ///遗留说明在点击时提示
  onLegacyReminders() {
    logic.missRemind = !logic.missRemind;
    update();
  }

  ///立即投注确认弹窗
  onBetConfirmation() {
    logic.doubleBetConfirm = !logic.doubleBetConfirm;
    update();
  }

  ///双面盘玩法投注金额区间
  onDoubleSidedPlay(int id) {
    logic.doubleSidedPlayId = id;
    saveUserInfoCpNextConfigId();
    update();
  }

  saveUserInfoCpNextConfigId() async {
    final res = await CpApi.instance().saveUserInfoCpNextConfigId(
      logic.doubleSidedPlayId,
    );
    if (kDebugMode) {
      print(res);
    }
  }

  ///特色游戏投注金额区间
  onFeaturedGames(int id) {
    logic.featuredGamesId = id;
    saveUserInfoCpNextFeatureConfigId();
    update();
  }

  saveUserInfoCpNextFeatureConfigId() async {
    final res = await CpApi.instance().saveUserInfoCpNextFeatureConfigId(
      logic.featuredGamesId,
    );
    if (kDebugMode) {
      print(res);
    }
  }

  ///关闭
  toClose() async {
    Get.back();
    final res = await CpApi.instance().saveUserInfoCp(
      logic.coldHot,
      logic.countDownBeep,
      logic.doubleBetConfirm,
      logic.missRemind,
      logic.winModal,
      Get.isDarkMode ? 2 : 1,
    );
    if (kDebugMode) {
      print(res);
    }
  }
}
