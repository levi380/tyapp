import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ty_app/app/modules/zr/states/zr_state.dart';



import '../../../../widgets/image_view.dart';
import 'MySliderComponentShape.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 音量拖拽组件 VoiceProgressBarWidget 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 音量拖拽组件   VoiceProgressBarWidget
    - VoiceProgressBarWidget
    ```
    VoiceProgressBarWidget(
      title: LocaleKeys.zr_cp_settings_Menu_zr_game_voice.tr,
      isDark: controller.isDarkMode,
      volume: controller.gameVoice,
      viceChanged: (volume) => controller.onGameVoiceViceChanged(volume),
      dividing: true,
    )
    ```
    】】】
 *
 */

class VoiceProgressBarWidget extends StatelessWidget {
  const VoiceProgressBarWidget({
    super.key,
    required this.title,
    required this.isDark,
    this.onTap,
    required this.dividing,
    required this.volume,
    required this.viceChanged,
  });

  final String title;
  final bool isDark;
  final VoidCallback? onTap;
  final bool dividing;
  final double volume;
  final void Function(dynamic) viceChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ZrState.titleBarHeight,
      color:
          isDark ? ZrState.cardBgDarkAlpha04 : Colors.white,
      child: Container(
        margin: EdgeInsets.only(
          left: ZrState.space15,
          right: ZrState.space15,
        ),
        decoration: dividing == true
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? ZrState.whiteAlpha008
                        : ZrState.bgColorLight,
                    width: 0.50.h,
                  ),
                ),
              )
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: TextStyle(
                  color: isDark
                      ? ZrState.whiteAlpha09
                      : ZrState.textColorPrimary,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ImageView(
                      isDark
                          ? ZrState.volumeIconDark
                          : ZrState.volumeIconLight,
                      width: 18.w,
                      height: 18.h,
                    ),
                    SizedBox(
                      width: ZrState.settingSliderWidth,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: MySliderComponentShape(),
                          trackHeight: ZrState.settingSliderTrackHeight,
                          valueIndicatorColor: isDark
                              ? ZrState.settingSliderActiveDark
                              : ZrState.settingSliderActiveLight,
                          valueIndicatorTextStyle:
                              const TextStyle(color: Colors.white),
                        ),
                        child: Slider(
                          value: volume,
                          activeColor: isDark
                              ? ZrState.settingSliderActiveDark
                              : ZrState.settingSliderActiveLight,
                          inactiveColor: isDark
                              ? ZrState.settingSliderInactiveDark
                              : ZrState.bgColorLight,
                          onChanged: (v) => viceChanged(v),
                          label: volume.toStringAsFixed(0),
                          divisions: 100,
                          max: 100,
                          min: 1,
                        ),
                      ),
                    ),
                    ImageView(
                      isDark
                          ? ZrState.volumeIconDarkMax
                          : ZrState.volumeIconLightMax,
                      width: 22.w,
                      height: 22.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
