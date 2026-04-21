import 'package:flutter_ty_app/app/modules/login/login_head_import.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/widgets/custom_Amount_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/widgets/single_level_combo_Item_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/widgets/single_level_combo_title_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/widgets/no_amount_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/quick_bet_amount/widgets/quick_bet_title_widget.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../main_tab/main_tab_controller.dart';
import 'quick_bet_amount_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-5177174d-b3ac-44f9-89be-505cb4a6b44a-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 自定义快捷投注金额】】】
    【【【 AUTO_PARAGRAPH_TITLE 自定义快捷投注金额 视图页面 QuickBetAmountPage  】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 自定义快捷投注金额 视图页面 QuickBetAmountPage
    - QuickBetAmountPage
    ```
    ///头部
    _title(),
    ///单关投注
    _singleLevelBetting(),
    ///串关投注
    _matchBetting(),
    ///自定义金额栏
    _customAmountColumn(),
    ```
    】】】

 *
 */
class QuickBetAmountPage extends StatefulWidget {
  const QuickBetAmountPage({Key? key}) : super(key: key);

  @override
  State<QuickBetAmountPage> createState() => _QuickBetAmountPageState();
}

class _QuickBetAmountPageState extends State<QuickBetAmountPage> {
  final controller = Get.find<QuickBetAmountController>();
  final logic = Get.find<QuickBetAmountController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickBetAmountController>(
      builder: (controller) {
        return Scaffold(
          body: Container(
            color: context.isDarkMode
                ? ChangeSkinToneColorUtil.instance()
                    .getDarkBackgroundColor(noChange: true)
                : Colors.white,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      ///头部
                      _title(),

                      ///单关投注
                      _singleLevelBetting(),

                      ///串关投注
                      _matchBetting(),
                    ],
                  ),
                ),

                ///自定义金额栏
                _customAmountColumn(),

                Obx(() => MainTabController.to.isFireworksPaly.value &&
                        FireworksController.to.isFireworksActivityValid(
                            MainTabController.to.activityEntity,
                            FireworksController.to.serverNow)
                    ? FireworksAnimation(
                        id: MainTabController.to.fireworksId.value,
                        beginTime: MainTabController.to.beginTime.value,
                        endTime: MainTabController.to.endTime.value,
                        type: MainTabController.to.fireworksType.value,
                        number: MainTabController.to.fireworksNumber,
                        championName: MainTabController.to.championName.value,
                        championIcon: MainTabController.to.championIcon.value,
                      )
                    : Container()),
              ],
            ),
          ),
        );
      },
    );
  }

  ///头部
  Widget _title() {
    return QuickBetTitleWidget(
      isDark: context.isDarkMode,
      title: LocaleKeys.app_h5_filter_customized_amount.tr,
    );
  }

  ///单关投注
  Widget _singleLevelBetting() {
    return Column(
      children: [
        SinglelevelComboTitleWidget(
          isDark: context.isDarkMode,
          title: LocaleKeys.app_h5_filter_single.tr,
        ),
        logic.downloadData == false
            ? const NoAmountWidget()
            : SinglelevelComboItemWidget(
                isDark: context.isDarkMode,
                list: controller.singleList,
                onSelectSingleLevelBetting: (list, index) =>
                    controller.onSelectSingleLevelBetting(list, index),
                selectedMatchBetting: logic.selectedSingleLevelBetting,
                title: LocaleKeys.app_h5_filter_quick_bet.tr,
              ),
      ],
    );
  }

  ///串关投注
  Widget _matchBetting() {
    return Column(
      children: [
        SinglelevelComboTitleWidget(
          isDark: context.isDarkMode,
          title: LocaleKeys.app_h5_filter_multi.tr,
        ),
        logic.downloadData == false
            ? const NoAmountWidget()
            : SinglelevelComboItemWidget(
                isDark: context.isDarkMode,
                list: controller.seriesList,
                onSelectSingleLevelBetting: (list, index) =>
                    controller.onSelectMatchBetting(list, index),
                selectedMatchBetting: logic.selectedMatchBetting,
                title: LocaleKeys.app_h5_filter_quick_bet.tr,
              ),
      ],
    );
  }

  ///自定义金额栏
  Widget _customAmountColumn() {
    return CustomAmountWidget(
      isDark: context.isDarkMode,
      betAmount: logic.betAmount,
      onCloseVisibility: () => controller.onCloseVisibility(),
      textEditingController: controller.textEditingController,
      focusNode: controller.focusNode,
      onBackspace: () => controller.onBackspace(),
      onMaxInputText: () => controller.onMaxInputText(),
      onOK: () => controller.onOK(),
      onInsertText: (myText) => controller.onInsertText(myText),
    );
  }

  @override
  void dispose() {
    Get.delete<QuickBetAmountController>();
    super.dispose();
  }
}
