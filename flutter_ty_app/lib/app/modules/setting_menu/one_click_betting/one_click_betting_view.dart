import 'package:flutter/material.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/one_click_betting/widgets/one_click_Item_edit_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/one_click_betting/widgets/one_click_Item_widget.dart';
import 'package:flutter_ty_app/app/modules/setting_menu/one_click_betting/widgets/one_click_custom_Amount_widget.dart';
import 'package:flutter_ty_app/app/modules/shop_cart/shop_cart_controller.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/change_skin_tone_color_util.dart';
import '../../../widgets/fireworks/fireworks_animation.dart';
import '../../../widgets/fireworks/fireworks_controller.dart';
import '../../main_tab/main_tab_controller.dart';
import '../quick_bet_amount/widgets/quick_bet_title_widget.dart';
import 'one_click_betting_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-f8e965b2-b88c-4808-9861-fc1a918660f9-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 设置菜单 】】】
    【【【 AUTO_DOCUMENT_TITLE 一键投注】】】
    【【【 AUTO_PARAGRAPH_TITLE 一键投注 视图页面 OneClickBettingPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 一键投注 视图页面 OneClickBettingPage
    - OneClickBettingPage
    ```
    ///头部
    _title(),

    ///开关菜单
    _menu(),

    ```
    】】】
 *
 */
class OneClickBettingPage extends StatefulWidget {
  const OneClickBettingPage({Key? key}) : super(key: key);

  @override
  State<OneClickBettingPage> createState() => _OneClickBettingPageState();
}

class _OneClickBettingPageState extends State<OneClickBettingPage> {
  final controller = Get.find<OneClickBettingController>();
  final logic = Get.find<OneClickBettingController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneClickBettingController>(
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

                      ///开关菜单
                      _menu(),
                    ],
                  ),
                ),

                ///一键投注金额设置
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
      title: LocaleKeys.bet_one_click_bet.tr,
    );
  }

  ///菜单
  Widget _menu() {
    bool switchOn = logic.switchOn && !(ShopCartController.to.isParlayMode());
    return Column(
      children: [
        OneClickItemWidget(
          isDark: context.isDarkMode,
          onTap: () => controller.onOneClickBetting(),
          title: LocaleKeys.bet_one_click_bet.tr,
          switchOn: switchOn,
        ),
        if (switchOn == true)
          OneClickItemEditWidget(
            isDark: context.isDarkMode,
            onTap: () => controller.onCloseVisibility(),
            title: LocaleKeys.bet_record_bet_val.tr,
            amount: controller.toAmountSplit(
              logic.fastBetAmount.toStringAsFixed(2),
            ),
          ),
      ],
    );
  }

  ///一键投注金额设置
  Widget _customAmountColumn() {
    return OneClickCustomAmountWidget(
      isDark: context.isDarkMode,
      betAmount: controller.betAmount,
      onCloseVisibility: () => controller.onCloseVisibility(),
      textEditingController: controller.textEditingController,
      focusNode: controller.focusNode,
      onBackspace: () => controller.onBackspace(),
      onMaxInputText: () => controller.onMaxInputText(),
      onOK: () => controller.onOK(),
      onInsertText: (myText) => controller.onInsertText(myText),
      replaceText: (myText) => controller.replaceText(myText),
      min: logic.min,
      singleList: controller.singleList,
    );
  }

  @override
  void dispose() {
    Get.delete<OneClickBettingController>();
    super.dispose();
  }
}
