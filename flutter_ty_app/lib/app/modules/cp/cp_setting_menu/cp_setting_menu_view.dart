import 'package:flutter/material.dart';

import 'package:flutter_ty_app/app/modules/cp/cp_setting_menu/widgets/amount_range_widget.dart';
import 'package:flutter_ty_app/app/modules/cp/cp_setting_menu/widgets/cp_power_switch_button_widget.dart';
import 'package:flutter_ty_app/app/modules/cp/cp_setting_menu/widgets/cp_switch_widget.dart';
import 'package:flutter_ty_app/app/modules/cp/states/cp_state.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../zr/zr_setting_menu/widgets/close_widget.dart';
import 'cp_setting_menu_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-865e55c5-ff96-400e-9c5b-fa97bce48a09-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 彩票投注 】】】
    【【【 AUTO_DOCUMENT_TITLE 彩票设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 彩票设置菜单 视图 CpSettingMenuPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 彩票设置菜单 视图 CpSettingMenuPage
    - CpSettingMenuPage
    - 包含-主题风格-音效-中奖提示-主题风格-游戏玩法投注金额区间
    ```
    ///主题风格
    _themeStyle(),

    ///音效
    _soundEffects(),

    ///中奖提示
    _winningTips(),

    ///冷热说明在点击时提示
    _hotAndColdTips(),

    ///遗留说明在点击时提示
    _legacyReminder(),

    ///立即投注确认弹窗
    _betConfirmation(),

    ///双面盘玩法投注金额区间
    _doubleSidedPlay(),

    ///特色游戏投注金额区间
    _featuredGames(),

    ///关闭
    _close(),
    ```
    】】】
 *
 */
class CpSettingMenuPage extends StatefulWidget {
  const CpSettingMenuPage({Key? key}) : super(key: key);

  @override
  State<CpSettingMenuPage> createState() => _CpSettingMenuPageState();
}

class _CpSettingMenuPageState extends State<CpSettingMenuPage> {
  final controller = Get.find<CpSettingMenuController>();
  final logic = Get.find<CpSettingMenuController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CpSettingMenuController>(
      builder: (controller) {
        return Container(
          color: controller.isDarkMode
              ? CpState.settingMenuBgColorDark
              : CpState.settingMenuBgColorLight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///主题风格
                _themeStyle(),

                ///音效
                _soundEffects(),

                ///中奖提示
                _winningTips(),

                ///冷热说明在点击时提示
                _hotAndColdTips(),

                ///遗留说明在点击时提示
                _legacyReminder(),

                ///立即投注确认弹窗
                _betConfirmation(),
                Container(
                  height: CpState.settingMenuBetConfirmBottomMargin,
                ),

                ///双面盘玩法投注金额区间
                _doubleSidedPlay(),

                ///特色游戏投注金额区间
                _featuredGames(),

                ///关闭
                _close(),
              ],
            ),
          ),
        );
      },
    );
  }

  ///主题风格
  Widget _themeStyle() {
    return CpSwitchWidget(
      title: LocaleKeys.footer_menu_theme.tr,
      isDark: controller.isDarkMode,
      switchA: LocaleKeys.footer_menu_daytime.tr,
      switchAParameter: logic.themeStyle,
      switchAOnTap: () => controller.onThemeStyle(1),
      switchB: LocaleKeys.footer_menu_night.tr,
      switchBParameter: logic.themeStyle,
      switchBOnTap: () => controller.onThemeStyle(2),
      dividing: true,
      bigFontSize: false,
    );
  }

  ///音效
  Widget _soundEffects() {
    return CpPowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_cp_sound_effects.tr,
      isDark: controller.isDarkMode,
      isSwitch: logic.countDownBeep,
      onTap: () => controller.onSoundEffects(),
      dividing: true,
    );
  }

  ///中奖提示
  Widget _winningTips() {
    return CpPowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_cp_winning_tips.tr,
      isDark: controller.isDarkMode,
      isSwitch: logic.winModal,
      onTap: () => controller.onWinningTips(),
      dividing: true,
    );
  }

  ///冷热说明在点击时提示
  Widget _hotAndColdTips() {
    return CpPowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_cp_hot_and_cold.tr,
      isDark: controller.isDarkMode,
      isSwitch: logic.coldHot,
      onTap: () => controller.onHotAndColdTips(),
      dividing: true,
    );
  }

  ///遗留说明在点击时提示
  Widget _legacyReminder() {
    return CpPowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_cp_legacy.tr,
      isDark: controller.isDarkMode,
      isSwitch: logic.missRemind,
      onTap: () => controller.onLegacyReminders(),
      dividing: true,
    );
  }

  ///立即投注确认弹窗
  Widget _betConfirmation() {
    return CpPowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_cp_popup.tr,
      isDark: controller.isDarkMode,
      isSwitch: logic.doubleBetConfirm,
      onTap: () => controller.onBetConfirmation(),
      dividing: true,
    );
  }

  ///双面盘玩法投注金额区间
  Widget _doubleSidedPlay() {
    return AmountRangeWidget(
      isDark: controller.isDarkMode,
      title: LocaleKeys.zr_cp_settings_Menu_cp_sided_betting.tr,
      xList: controller.doubleBetRangeList,
      id: logic.doubleSidedPlayId,
      onTap: (configId) => controller.onDoubleSidedPlay(configId),
    );
  }

  ///特色游戏投注金额区间
  Widget _featuredGames() {
    return AmountRangeWidget(
      isDark: controller.isDarkMode,
      title: LocaleKeys.zr_cp_settings_Menu_cp_special_games.tr,
      xList: controller.featureBetRangeList,
      id: logic.featuredGamesId,
      onTap: (configId) => controller.onFeaturedGames(configId),
    );
  }

  ///关闭
  Widget _close() {
    return CloseWidget(
      title: LocaleKeys.common_close.tr,
      isDark: controller.isDarkMode,
      onTap: () => controller.toClose(),
      bigFontSize: false,
    );
  }

  @override
  void dispose() {
    Get.delete<CpSettingMenuController>();
    super.dispose();
  }
}
