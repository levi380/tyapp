import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_setting_menu/widgets/close_widget.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_setting_menu/widgets/power_switch_button_widget.dart';
import 'package:flutter_ty_app/app/modules/zr/zr_setting_menu/widgets/voice_progress_bar_widget.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';


import '../../setting_menu/widgets/menu_switch_widget.dart';
import '../../setting_menu/widgets/menu_widget.dart';
import 'zr_setting_menu_controller.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 视图 ZrSettingMenuPage 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 视图 ZrSettingMenuPage
    - ZrSettingMenuPage
    - 包含-主题风格-语音语言-游戏语言-游戏音效-现场声音-现场视频-快速投注-等开关
    ```
    ///主题风格
    _themeStyle(),

    ///声音开关
    _soundSwitch(),

    ///语音语言
    _phoneticLanguage(),

    ///游戏语音
    _gameVoice(),

    ///游戏语音
    _gameSoundEffects(),

    ///现场声音
    _liveSound(),
    Container(
    height: 10.h,
    ),

    ///声音开关
    _videoSettings(),

    ///快速投注
    _quickBet(),

    ///关闭
    _close(),
    ```
    】】】
 *
 */
class ZrSettingMenuPage extends StatefulWidget {
  const ZrSettingMenuPage({Key? key}) : super(key: key);

  @override
  State<ZrSettingMenuPage> createState() => _ZrSettingMenuPageState();
}

class _ZrSettingMenuPageState extends State<ZrSettingMenuPage> {
  final controller = Get.find<ZrSettingMenuController>();
  final logic = Get.find<ZrSettingMenuController>().logic;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZrSettingMenuController>(
      builder: (controller) {
        return Container(
          color: logic.isDarkMode
              ? ZrState.bgColorDark
              : ZrState.bgColorLight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ///主题风格
                _themeStyle(),
                if (logic.isDarkMode) _pathPaperMode(),
                Container(
                  height: ZrState.settingSectionGap,
                ),

                ///声音开关
                _soundSwitch(),

                ///语音语言
                _phoneticLanguage(),

                ///游戏语音
                _gameVoice(),

                ///游戏语音
                _gameSoundEffects(),

                ///现场声音
                _liveSound(),
                Container(
                  height: ZrState.settingSectionGap,
                ),

                ///声音开关
                _videoSettings(),

                ///快速投注
                _quickBet(),

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
    return MenuSwitchWidget(
      title: LocaleKeys.footer_menu_theme.tr,
      isDark: logic.isDarkMode,
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

  ///路纸模式
  Widget _pathPaperMode() {
    return MenuSwitchWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_road_mode.tr,
      isDark: logic.isDarkMode,

      ///浅色
      switchA: LocaleKeys.zr_cp_settings_Menu_zr_light_color.tr,
      switchAParameter: controller.pathPaperMode,
      switchAOnTap: () => controller.onPathPaperMode(1),

      ///深色
      switchB: LocaleKeys.zr_cp_settings_Menu_zr_dark_color.tr,
      switchBParameter: controller.pathPaperMode,
      switchBOnTap: () => controller.onPathPaperMode(2),
      dividing: true,
      bigFontSize: false,
    );
  }

  ///声音开关
  Widget _soundSwitch() {
    return PowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_sound_switch.tr,
      isDark: logic.isDarkMode,
      isSwitch: logic.soundSwitch,
      onTap: () => controller.onSoundSwitch(),
      dividing: true,
    );
  }

  ///语音语言
  Widget _phoneticLanguage() {
    return MenuWidget(
      onTap: () => Get.bottomSheet(
        _bottomPhoneticLanguage(),
      ),
      title: LocaleKeys.zr_cp_settings_Menu_zr_speech_language.tr,
      isDark: logic.isDarkMode,
      imageUrl: '',
      subTitle: logic.phoneticLanguage,
      summary: '',
      dividing: true,
      bigFontSize: false,
    );
  }

  ///游戏语音
  Widget _gameVoice() {
    return VoiceProgressBarWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_game_voice.tr,
      isDark: logic.isDarkMode,
      volume: controller.gameVoice,
      viceChanged: (volume) => controller.onGameVoiceViceChanged(volume),
      dividing: true,
    );
  }

  ///游戏音效
  Widget _gameSoundEffects() {
    return VoiceProgressBarWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_sound_effect.tr,
      isDark: logic.isDarkMode,
      volume: controller.gameSoundEffects,
      viceChanged: (volume) => controller.onGameSoundEffectsViceChanged(volume),
      dividing: true,
    );
  }

  ///现场声音
  Widget _liveSound() {
    return VoiceProgressBarWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_live_audio.tr,
      isDark: logic.isDarkMode,
      volume: controller.liveSound,
      viceChanged: (volume) => controller.onLiveSoundViceChanged(volume),
      dividing: true,
    );
  }

  ///现场视频
  Widget _videoSettings() {
    return PowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_live_video.tr,
      isDark: logic.isDarkMode,
      isSwitch: logic.videoSettings,
      onTap: () => controller.onVideoSettings(),
      dividing: true,
    );
  }

  ///快速投注
  Widget _quickBet() {
    return PowerSwitchButtonWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_quick_bet.tr,
      isDark: logic.isDarkMode,
      isSwitch: logic.quickBet,
      onTap: () => controller.onQuickBet(),
      dividing: true,
    );
  }

  ///关闭
  Widget _close() {
    return CloseWidget(
      title: LocaleKeys.common_close.tr,
      isDark: logic.isDarkMode,
      onTap: () => controller.toClose(),
      bigFontSize: false,
    );
  }

  ///游戏音效菜单
  Widget _bottomPhoneticLanguage() {
    return Container(
      height: ZrState.settingBottomSheetHeight,
      color: Colors.grey[300],
      child: Column(
        children: [
          Container(
            height: ZrState.settingBottomSheetHeaderHeight,
            color:
            logic.isDarkMode ? ZrState.textColorPrimary : Colors.white,
            child: Container(
              margin: EdgeInsets.only(left: 14.w, right: 14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 0,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Text(
                        LocaleKeys.zr_cp_settings_Menu_zr_cancel.tr,
                        style: TextStyle(
                          color: logic.isDarkMode
                              ? ZrState.whiteAlpha09
                              : ZrState.textColorPrimary,
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.zr_cp_settings_Menu_zr_sound_effect.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: logic.isDarkMode
                              ? ZrState.whiteAlpha09
                              : ZrState.textColorPrimary,
                          fontSize: 18.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Text(
                        LocaleKeys.zr_cp_settings_Menu_zr_ok.tr,
                        style: TextStyle(
                          color: logic.isDarkMode
                              ? ZrState.whiteAlpha09
                              : ZrState.textColorPrimary,
                          fontSize: 16.sp,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: ZrState.settingBottomSheetBodyHeight,
            color: logic.isDarkMode
                ? ZrState.bgColorDark
                : ZrState.bgColorLight,
            child: CupertinoPicker(
              itemExtent: ZrState.settingPickerItemExtent,
              onSelectedItemChanged: (int index) =>
                  controller.onSelectedItemChanged(index),
              children: List.generate(logic.gameSoundEffectsList.length,
                  (index) {
                return Center(
                  child: Text(
                    logic.gameSoundEffectsList[index],
                    style: TextStyle(
                      color: logic.phoneticLanguage ==
                          logic.gameSoundEffectsList[index]
                          ? Colors.blue
                          : logic.isDarkMode
                              ? ZrState.whiteAlpha09
                              : ZrState.textColorPrimary,
                      fontSize: 18.sp,
                      fontFamily: 'PingFang SC',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ZrSettingMenuController>();
    super.dispose();
  }
}
