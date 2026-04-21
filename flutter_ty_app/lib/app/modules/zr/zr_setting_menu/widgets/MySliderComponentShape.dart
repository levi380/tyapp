import '../../../login/login_head_import.dart';
import '../zr_setting_menu_controller.dart';
import '../../states/zr_state.dart';

/**
 *
 *
    【【【 AUTO_DOCUMENT_UUID tyApp-fdd890e9-4ed9-4012-9685-8c670ec4ed37-sz 】】】
    【【【 AUTO_DOCUMENT_MENU 真人娱乐 】】】
    【【【 AUTO_DOCUMENT_TITLE 真人娱乐设置菜单】】】
    【【【 AUTO_PARAGRAPH_TITLE 真人娱乐设置菜单 列表带开关组件样式 MySliderComponentShape 】】】
    【【【 AUTO_PARAGRAPH_CONTENT
    - 真人娱乐设置菜单 列表带开关组件样式   MySliderComponentShape
    - MySliderComponentShape
    ```
    MySliderComponentShape()
    ```
    】】】
 *
 */

class MySliderComponentShape extends SliderComponentShape {
  final controller = Get.find<ZrSettingMenuController>();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(20, 20);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 7.w, height: 22.h),
        const Radius.circular(12),
      ),
      Paint()
        ..color = Get.isDarkMode
            ? ZrState.settingSliderActiveDark
            : ZrState.settingSliderActiveLight,
    );
  }
}
